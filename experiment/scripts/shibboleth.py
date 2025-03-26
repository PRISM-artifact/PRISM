import argparse
import shutil
import json
import subprocess
import csv
import traceback

from multiprocessing import Pool
from collections import defaultdict

from config import *
from utils import *
from bug import Bug
from patch import Patch

class Shibboleth():
  def __init__(self, patch):
    self.bug = patch.bug
    self.patch = patch
    self.result_dir = patch.hash_dir / "shibboleth"
    self.sources_dir = self.result_dir / "patch-files"
    self.classes_dir = self.result_dir / "patch-classes"
    self.input_file = self.result_dir / "input-file.csv"
    self.score_file = self.result_dir / "score.csv"
    self.setup_base_dirs()
  
  def setup_base_dirs(self):
    self.sources_dir.mkdir(parents=True, exist_ok=True)
    self.classes_dir.mkdir(parents=True, exist_ok=True)

  def setup_input_files(self):
    # copy patch-files
    self.patch.apply()
    for patch_source in self.patch.modified_files:
      patch_source_path = self.bug.project_dir / patch_source
      target_source_path = self.sources_dir / patch_source.name
      print(f"{PROGRESS} copy {patch_source_path} => {target_source_path}")
      shutil.copy(patch_source_path, target_source_path)

    # copy patch-classes
    self.bug.run_test()
    export_src_classes = subprocess.run(
      f'{D4J} export -p dir.src.classes -w {self.bug.project_dir}', 
      shell=True, capture_output=True, text=True, check=True
    )
    src_classes_dir = self.bug.project_dir / export_src_classes.stdout.strip()
    export_classes = subprocess.run(
      f'{D4J} export -p dir.bin.classes -w {self.bug.project_dir}', 
      shell=True, capture_output=True, text=True, check=True
    )
    bin_classes_dir = self.bug.project_dir / export_classes.stdout.strip()
    target_classes = []
    for patch_source in self.patch.modified_files:
      patch_source_path = self.bug.project_dir / patch_source
      relative_path = patch_source_path.relative_to(src_classes_dir)
      patch_class_file = bin_classes_dir / relative_path.with_suffix(".class")
      target_class_file = self.classes_dir / patch_class_file.name
      target_classes.append(str(target_class_file))
      print(f"{PROGRESS} copy {patch_class_file} => {self.classes_dir}")
      if not patch_class_file.is_file():
        # Some target classes files are included in test class
        export_classes = subprocess.run(
          f'{D4J} export -p dir.bin.tests -w {self.bug.project_dir}', 
          shell=True, capture_output=True, text=True, check=True
        )
        bin_classes_dir = self.bug.project_dir / export_classes.stdout.strip()
        patch_class_file = bin_classes_dir / relative_path.with_suffix(".class")
      shutil.copy(patch_class_file, target_class_file)
    
    # gen input-file.csv
    mthd_infos = []
    with open(self.patch.hash_dir / "prism/infer-out/patch_mthds.results", "r") as f:
      for input_text in f.readlines():
        input_text = input_text.strip()
        if not input_text:
          continue

        class_mthd_str, param_str = input_text.rsplit("/", 1)
        class_mthd_str = class_mthd_str.replace("/", ".")
        param_str = ",".join(
          "boolean" if param.strip() == "_Bool" else param.strip().rstrip("*") 
          for param in param_str.split(",") if param_str
        )
        mthd_infos.append(f"{class_mthd_str}({param_str})")
      
    with open(self.input_file, "w") as f:
      f.write(
        f"{self.patch.patch_id},,"
        f"\"{';'.join(mthd_infos)}\","
        f"{';'.join(target_classes)},"
        f"{self.patch.check_correctness().upper()}"
      )

  def extract_score(self, rerun=False):
    if self.score_file.is_file() and rerun:
      self.score_file.unlink()
    
    if self.score_file.is_file(): 
      with open(self.score_file, "r") as f:
        values = f.read().strip().split(",") 
        vector = {
          "ts": float(values[0]),
          "scs": float(values[1]),
          "bc": float(values[2])
        }
      return vector

    self.bug.checkout()
    vector = {
      "ts": 0.0,
      "scs": 0.0,
      "bc": 0.0
    }
    # Setup required java-files
    source_dir_org = self.bug.project_dir / "patched-source-files/original"
    source_dir_org.mkdir(parents=True, exist_ok=True)
    for patch_source in self.patch.modified_files:
      patch_source_path = self.bug.project_dir / patch_source
      target_source_path = source_dir_org / patch_source.name
      shutil.copy(patch_source_path, target_source_path)
    source_dir_target = self.bug.project_dir / f"patched-source-files/{self.patch.patch_id}"
    source_dir_target.mkdir(parents=True, exist_ok=True)
    shutil.copytree(self.sources_dir, source_dir_target, dirs_exist_ok=True)
    # Setup input csv files
    shutil.copy(self.input_file, self.bug.project_dir / self.input_file.name)
    
    # Compile the project and run shibboleth
    self.bug.run_test()
    export_classes = subprocess.run(
      f'{D4J} export -p dir.bin.classes -w {self.bug.project_dir}', 
      shell=True, capture_output=True, text=True, check=True
    )
    build_opt = self.bug.project_dir / export_classes.stdout.strip()
    export_tests = subprocess.run(
      f'{D4J} export -p dir.bin.tests -w {self.bug.project_dir}', 
      shell=True, capture_output=True, text=True, check=True
    )
    test_opt = self.bug.project_dir / export_tests.stdout.strip()
    cp_opt = ":".join(map(str, self.bug.class_paths))
    cmd = (
      f"java -cp {SHIBBOLETH_JAR} {SHIBBOLETH_EXTRACTOR} -b {build_opt} -u {test_opt} -l {cp_opt}"
    )
    print(cmd)
    ret = subprocess.run(cmd, shell=True, capture_output=True, text=True, cwd=self.bug.project_dir)
    out_file = self.bug.project_dir / "score.csv"
    if out_file.is_file():
      with open(out_file, "r") as f:
        values = f.read().strip().split(",") 
        vector = {
          "ts": float(values[0]),
          "scs": float(values[1]),
          "bc": float(values[2])
        }
      shutil.move(out_file, self.score_file)
      return vector
    else:
      print(ret.stdout)
      print(ret.stderr)
      return vector

def process_job(args):
  bug_key, patch_list = args
  print(f"{PROGRESS} process {bug_key} with {len(patch_list)} patches...")
  
  project, bugid = bug_key.split("-")
  bug = Bug(project, int(bugid), set_ant=False)
  results = {}

  for patch_path in patch_list:
    patch = Patch(bug, patch_path)
    extractor = Shibboleth(patch)
    try:
      vector = extractor.extract_score()
    except Exception as e:
      vector = {
        "ts": 0.0,
        "scs": 0.0,
        "bc": 0.0
      }
    feature_id = patch.patch_id
    vector["id"] = feature_id
    vector["label"] = 1 if patch.check_correctness() == "incorrect" else 0
    results[feature_id] = vector

  print(f"{SUCCESS} end process {bug_key} with {len(patch_list)} patches!")
  return results

if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patches", type=Path, required=True, help="patch file path")
  args = parser.parse_args()
  #pipeline for one benchmark
  tasks = defaultdict(list)
  for patch_path in list(args.patches.rglob("*.patch")):
    project = patch_path.name.split("-")[0]
    bugid = int(patch_path.name.split("-")[1])
    if not check_valid_d4j(project, bugid):
      continue
    bug_key = f"{project}-{bugid}"
    tasks[bug_key].append(patch_path)
  
  all_results = []
  task_args = [(bug_key, patch_list) for bug_key, patch_list in tasks.items()]
  with Pool(processes=32) as pool:
    async_result = pool.map_async(process_job, task_args)
    results =async_result.get()
    all_results.extend(results)
  
  feature_vecs = {}
  for result in all_results:
    feature_vecs.update(result)
    
  output_csv_path = CSV_DIR / "training_shibboleth.csv"
  print(f"{PROGRESS}: construct shibboleth training data from {len(feature_vecs)} patches...")
  fieldnames = ["id", "label", "ts", "scs", "bc"]

  with open(output_csv_path, "w", newline="") as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
    writer.writeheader()
    writer.writerows(feature_vecs.values())

  print(f"{SUCCESS}Features saved to {output_csv_path}")

