import time
import json
import subprocess
import shutil
import tempfile
import re 
import traceback

from config import *
from utils import *
from bug import Bug

class Patch:
  bug: Bug
  patch_path : Path
  patch_infos : List[Tuple[Path, int]]
  modified_files : List[Path]
  execution_time : float
  hash_dir: Path
  build_time : float
  patch_id : str

  def __init__(self, bug, patch_path, is_org=False):
    self.bug = bug
    self.execution_time = 0.0
    self.build_time = 0.0
    self.patch_path = Path(patch_path).resolve()
    # self.patch_infos = self.get_patch_infos()
    # self.modified_files = [info[0] for info in self.patch_infos]  
    if is_org:
      self.hash_dir = RESULTS_DIR / f"{self.bug.project}{self.bug.bug_id}b/org"
    else:
      self.hash_dir = RESULTS_DIR / f"{self.bug.project}{self.bug.bug_id}b/temp"
      self.build()
    self.patch_id = f"{self.bug.project}-{self.bug.bug_id}-{self.hash_dir.name}"

  def __str__(self):
    return (
      f"{self.bug}\n"
      f"patch: {self.patch_path or "Original Source"}\n"
      f"Modified Files:\n  " + "\n -".join(str(file) for file in self.modified_files) + "\n"
      f"Hash_dir: {self.hash_dir}\n"
      f"Build Time: {self.build_time}"
    )
  
  def get_patch_infos(self) -> List[Tuple[Path, int]]:
    # Store the (Modified file, first patched line) info
    patch_infos = []
    current_file = None
    current_line_no = None
    file_pattern = re.compile(r"^---\s+(?:[^/]+/)?(/?.+?)(?:\t.*)?$")
    hunk_pattern = re.compile(r"^@@.*\+(\d+).*@@")

    with open(self.patch_path, "r", encoding=self.bug.encoding) as f:
      for line in f:
        # Detect modified file
        if file_match := file_pattern.match(line):
          current_file = Path(file_match.group(1).strip())
          current_line_no = None
          continue
        
        # When detect hunk header, init start line of hunk
        if hunk_match := hunk_pattern.match(line):
          current_line_no = int(hunk_match.group(1))
          continue
        
        # Look for the first change line (+ or -) in the hunk
        if current_file and current_line_no is not None:
          if line.startswith("+") and not line.startswith("+++") or line.startswith("-"):
            patch_infos.append((current_file, current_line_no))
            current_file = None
          else:  # Context line
            current_line_no += 1  # Increment for context lines

    return patch_infos  
  
  def apply(self):
    self.bug.checkout()
    if self.hash_dir.name != "org":
      cmd = f"patch -p1 --binary < {self.patch_path}"
      ret = subprocess.run(cmd, shell=True, cwd=self.bug.project_dir, stdout=subprocess.PIPE)
      if ret.returncode != 0:
        raise RuntimeError(f"Failed to apply {self.patch_path} to {self.bug.project_dir}")
      return ret.returncode
    else:
      return 0

  def build(self):
    # Generate unique hash and create base (unique hash) directory
    start_time = time.time()
    out_dir = RESULTS_DIR / f"{self.bug.project}{self.bug.bug_id}b"

    # If the hash info already exsist use the stored info
    for file_path in out_dir.rglob(self.patch_path.name):
      if file_path.is_file():
        self.hash_dir = file_path.parent.parent
        self.build_time = time.time() - start_time
        return 
    try:
      print(f"{PROGRESS} Build patch :{self.patch_path}")
      with tempfile.TemporaryDirectory() as temp_dir1, tempfile.TemporaryDirectory() as temp_dir2:
        target_dir = D4J_BUGS_DIR / self.bug.project_dir
        # copy original file and apply formatter
        self.bug.checkout()
        copy_files_to_temp_dir(self.modified_files, target_dir, temp_dir1)
        ret_org = format_files_in_directory(temp_dir1)        
        # copy patch file and apply formatter
        self.apply()
        copy_files_to_temp_dir(self.modified_files, target_dir, temp_dir2)
        ret_patch = format_files_in_directory(temp_dir2)
        if ret_org or ret_patch:
          # If fail to apply formatter, diff original files
          print(f"{ERROR}: format error {self.patch_path} {ret_org} {ret_patch}")
          self.bug.checkout()
          copy_files_to_temp_dir(self.modified_files, target_dir, temp_dir1)
          self.apply()
          copy_files_to_temp_dir(self.modified_files, target_dir, temp_dir2)

        # Execute diff and generate hash
        # diff_command = f"diff -rwu {temp_dir1} {temp_dir2} | sed 's|{temp_dir1}|ORIGINAL_PATH|g' | sed 's|{temp_dir2}|MODIFIED_PATH|g' | sed -E '/^(---|\+\+\+)/ s/\t.*//'"
        diff_command = (
          f"diff -rwu {temp_dir1} {temp_dir2} | "
          f"sed 's|{temp_dir1}|ORIGINAL_PATH|g' | "
          f"sed 's|{temp_dir2}|MODIFIED_PATH|g' | "
          f"sed -E '/^(---|\\+\\+\\+)/ s/\\t.*//'"
        )
        ret = subprocess.run(diff_command, shell=True, capture_output=True, text=True)
        
        if ret.returncode in [0, 1]:
          diff_output = ret.stdout
          diff_hash = generate_unique_hash(diff_output, out_dir)
          hash_dir = out_dir / Path(diff_hash)
          hash_dir.mkdir(parents=True, exist_ok=True)
          with (hash_dir / FORMATTED_PATCH).open("w") as f:
            f.write(diff_output)
          self.hash_dir = hash_dir
          self.build_time = time.time() - start_time
        else:
          print(f"{ERROR}: diff error {ret.stdout} {ret.stderr}")
        patches_dir = hash_dir / PATCHES_DIR
        patches_dir.mkdir(exist_ok=True)
        patch_dst_path = patches_dir / self.patch_path.name
        if not patch_dst_path.exists():
          shutil.copy(self.patch_path, patch_dst_path)
        # Revert changes in the project directory
        self.bug.checkout()
    except Exception as e:
      err_trace = traceback.format_exc() 
      print(f"{ERROR}: build error {self.patch_path}\nExn:{e}\nTrace:{err_trace}")

  def run_test(self, rerun=False):
    self.apply()
    # If the hash info already exsist use the stored info
    test_info_path = self.hash_dir / Path(TEST_INFO)
    if test_info_path.exists() and not rerun:
      with open(test_info_path, "r") as f:
        test_info = json.load(f)
    else:
      # Check the patch is compilable
      start_time = time.time()
      is_compile, compile_log = self.bug.compile()

      # If the patch is compilable, run test
      if is_compile:
        test_result, test_log = self.bug.run_test()
      else:
        test_result = False
        test_log = compile_log
        
      end_time = time.time()
      test_info = {
        "is_compile": is_compile,
        "is_pass": test_result,
        "execution_time": end_time - start_time,
        "err_log": test_log
      }
      with open(test_info_path, "w") as f:
        json.dump(test_info, f, indent=4)

    # self.bug.checkout()
    return (test_info["is_compile"], test_info["is_pass"], test_info["err_log"])
  
  def check_correctness(self, rerun=False):
    correctness_path = self.hash_dir / Path(LABEL_INFO)
    if correctness_path.exists() and not rerun:
      with open(correctness_path, "r") as f:
        correctness = f.read().strip()
    else:
      patch_id = self.patch_path.name
      if "-d4j-" in patch_id:
        # If the patch is developers' patch, correct patch
        correctness = "correct"
      else:
        correctness = "incorrect" if "incorrect" in self.patch_path.name else "correct"
      '''
      else:
        # If the patch fails to pass the testcases, label it as incorrect
        _, is_pass, _ = self.run_test()
        if is_pass:
          # If the patch modifies different files with the developers', label it as incorrect
          dev_patch_file = Path(f"{self.bug.project}-{self.bug.bug_id}-patch0-d4j-correct-D4J.patch")
          dev_patch_path = DEV_PATCH_DIR / self.bug.project / dev_patch_file
          dev_patch = Patch(self.bug, dev_patch_path)
          if not set(dev_patch.modified_files) == set(self.modified_files):
            print("[INFO]: Labeled as incorrect by different file modification")
            correctness = "incorrect" 
          else:
            # Manual labeling
            print_header(f"Correct Patch ({dev_patch.hash_dir})", color=Fore.GREEN)
            print_file(dev_patch_path)                
            print_header(patch_id)
            print_file(self.patch_path)
            
            r = input(f"Type \'O\' if the patch is correct: ")
            if r == "O" or r == "o":
              correctness = "correct"
            else:
              correctness = "incorrect"
        else:
          correctness = "incorrect"
      '''
    with open(correctness_path, "w") as f:
      f.write(correctness)

    return correctness

  def renaming(self):
    correctness_path = self.hash_dir / Path(LABEL_INFO)
    patch_path_org = self.patch_path
    save_path_org = self.hash_dir / "patches" / patch_path_org.name

    # Check the labeled data
    if not correctness_path.exists():
      print(f"[ERROR]: {self.bug.project}-{self.bug.bug_id}({self.hash_dir}) is not labeled")
      return
    
    correctness_org = patch_path_org.name.rstrip(".patch").split("-")[4]
    with open(correctness_path, "r") as f:
      label = f.read().strip()
    
    if label == correctness_org:
      print(f"[INFO]: No changes needed for {self.patch_path}")
      return
    
    # relabel based on the labeling data
    new_filename = patch_path_org.name.replace(correctness_org, label)
    new_patch_path = patch_path_org.with_name(new_filename)
    new_save_path = save_path_org.with_name(new_filename)
    try:
      patch_path_org.rename(new_patch_path)
      save_path_org.rename(new_save_path)
      print(f"[INFO]: {self.patch_path} is relabeled ({correctness_org} => {label})")
      self.patch_path = new_patch_path
    except OSError as e:
      print(f"[ERROR]: Failed to rename files. Reason: {e}")
      return