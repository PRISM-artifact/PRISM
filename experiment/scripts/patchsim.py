import random
import shutil
import json
import time
import traceback
import subprocess

from config import *
from utils import *

def sampling_covering_tests(coverage_path, num_sample=20, is_randoop=False, is_shuffle=False):
  # Extracts a list of tests that cover the target code section based on a coverage file
  covering_tests = set()
  try:
    with open(coverage_path, "r") as file:
      current_test = None
      for line in file:
        line = line.strip()
        if "---covered" in line and current_test:
          # Add the previously identified test if "covered" is found
          covering_tests.add(current_test)
        elif "---" in line:
          # Extract and normalize test method format
          current_test = "::".join(line.replace("---", "").split(":"))
  except FileNotFoundError:
    print(f"{ERROR}: File not found - {coverage_path}")

  if is_randoop:
    filtered_tests = sorted([test for test in covering_tests if test.startswith("RegressionTest")])
  else:
    filtered_tests = sorted([test for test in covering_tests if not test.startswith("RegressionTest")])

  if is_shuffle:
    random.shuffle(filtered_tests)  
  return filtered_tests[:num_sample]

def extract_trace(trace_org_path, trace_out_path, start, end):
  extracted_lines = []
  with open(trace_org_path, "r") as f:
    for line in f:
      if line.startswith("---"):
        try:
          line_num = int(line.split(":")[1].strip())
          if start <= line_num <= end:
            extracted_lines.append(line)
        except (IndexError, ValueError):
          continue

  with open(trace_out_path, "w") as f:
      f.writelines(extracted_lines)

class PatchSim:
  def __init__(self, patch):
    self.bug = patch.bug
    self.patch = patch
    self.result_dir = self.patch.hash_dir / "patchsim"
    self.result_dir.mkdir(exist_ok=True)
    self.result_file = self.result_dir / "result.json"
    self.coverage_log = self.result_dir / "execution.log"
    self.tracer_dir = self.result_dir / "tracer" 
    self.trace_log = self.result_dir / "traces.tar.bz2" 
    self.trace_log_dir = self.result_dir / "traces" 
    self.parse_out_dir = self.result_dir / "parsed"
    self.classify_dir = self.result_dir / "classify"
    self.setup_base_dir()

  def setup_base_dir(self):
    self.tracer_dir.mkdir(parents=True, exist_ok=True)
    self.result_dir.mkdir(exist_ok=True)
    self.trace_log_dir.mkdir(exist_ok=True)
    self.parse_out_dir.mkdir(exist_ok=True)
    self.classify_dir.mkdir(exist_ok=True)

  def setup_test_cover_info(self, run_randoop=False):
    # Get the covered method informations 
    if self.coverage_log.is_file():
      return

    def exec_test_instrument(test_dir, log_path, project_name):
      subprocess.run(f"make TestCaseInstr ARGS=\"{test_dir} {log_path} {project_name}\"", shell=True, cwd=PATCHSIM_HOME)
      
    # Insert print statements to each randoop tests to monitor test execution
    randoop_instr_path = self.result_dir / f"{self.bug.project}-{self.bug.bug_id}b-randoop.instr.tar.bz2"
    if not randoop_instr_path.is_file():
      if run_randoop:
        self.bug.setup_randoop_test()
      randoop_test_dir = self.result_dir / "randoop_tests_instr"
      randoop_test_dir.mkdir(exist_ok=True)
      subprocess.run(f"tar xvf {self.bug.randoop_path} -C {randoop_test_dir}", shell=True)
      exec_test_instrument(randoop_test_dir, self.coverage_log, "Randoop")
      subprocess.run(f"tar -c ./* | bzip2 > ../{randoop_instr_path.name}", shell=True, cwd=randoop_test_dir)
    
    # Insert print statements to each d4j test to monitor test execution
    d4j_instr_path = self.result_dir / "d4j_tests_instr"
    print(f"{PROGRESS} Instrument d4j test")
    if d4j_instr_path.exists():
      shutil.rmtree(self.bug.test_dir)
      shutil.copytree(d4j_instr_path, self.bug.test_dir)
    else:
      exec_test_instrument(self.bug.test_dir, self.coverage_log, self.bug.project)
      shutil.copytree(self.bug.test_dir, d4j_instr_path)

    # Insert print statements into original code to monitor method execution
    instr_code_dir = self.result_dir / "sources_instr"
    instr_code_dir.mkdir(exist_ok=True)
    for patch_info in self.patch.patch_infos:
      source_org_path = self.bug.project_dir / patch_info[0]
      source_instr_path = instr_code_dir / patch_info[0]
      line_no = patch_info[1]

      if source_instr_path.is_file():
        source_org_path.unlink()
        shutil.copy(source_instr_path, source_org_path)
      else:
        subprocess.run(f"make MthdInstr ARGS=\"{source_org_path.resolve()} {self.coverage_log} {line_no}\"", shell=True, cwd=PATCHSIM_HOME)
        source_instr_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy(source_org_path, source_instr_path)

    # Execute the randoop tests to obtain covered method names
    subprocess.run(f"{D4J_MOD} test -s {randoop_instr_path.absolute()} -w {self.bug.project_dir}", shell=True)
    # Move instrumented d4j test and get covered method names
    subprocess.run(f"{D4J_MOD} compile -w {self.bug.project_dir}", shell=True)
    subprocess.run(f"{D4J_MOD} test -n -r -w {self.bug.project_dir}", shell=True)
    # Revert original code
    self.bug.checkout()

  def get_patch_info(self):
    source_file, patched_line = self.patch.patch_infos[0]
    source_file = self.bug.project_dir / source_file
    patch_info_file = self.result_dir / "patch_info.txt"
    if not patch_info_file.is_file():
      subprocess.run(f"make PatchInfo ARGS=\"{source_file} {patch_info_file} {patched_line}\"", shell=True, cwd=PATCHSIM_HOME)

    with open(patch_info_file, "r") as f:
      lines=f.readlines()
    patched_class=lines[-1].strip()
    patched_mthd, mthd_sig, start_line, end_line=lines[0].strip().split('\t')
    return patched_class, patched_mthd, mthd_sig, int(start_line), int(end_line)

  def setup_tracer(self):
    # Write custum tracer in Tracer.java
    tracer_source_path = self.tracer_dir / "Tracer.java"
    if not tracer_source_path.is_file():
      patched_cls, _, _, _, _ = self.get_patch_info()
      with open(BTRACE_TEMPLATE, "r") as f:
        tracer_code = f.read().replace("__CLASS__NAME__", patched_cls)
      with open(tracer_source_path, "w") as f:
        f.write(tracer_code)

    tracer_path = self.tracer_dir / "Tracer.class"
    if not tracer_path.is_file():
      compile_cmd = f"./btracec -d {self.tracer_dir} {tracer_source_path}"
      subprocess.run(compile_cmd, cwd=BTRACE_HOME, shell=True)

  def run_tracer(self):
    # Get covered test based on coverage info
    randoop_tests = sampling_covering_tests(self.coverage_log, is_randoop=True)
    d4j_tests = sampling_covering_tests(self.coverage_log) + self.bug.failing_tests

    tracer = self.tracer_dir / "Tracer.class"
    (_, _, _, start_line, end_line) = self.get_patch_info()      

    def execute_and_extract(test_set, trace_dir, trace_out_dir, is_randoop=False):
      trace_dir.mkdir(parents=True, exist_ok=True)
      trace_out_dir.mkdir(parents=True, exist_ok=True)

      no_build=False if is_randoop else True
      for test in test_set:
        prefix = "Randoop." if is_randoop else ""
        raw_out_file = trace_dir / f"{prefix}{'__'.join(test.split('::'))}"
        target_out_file = trace_out_dir / f"{prefix}{'__'.join(test.split('::'))}"
        jvmargs = (
          f"-Djvmargs=-javaagent:{BTRACE_JAR}=noserver,debug=true,scriptOutputFile={raw_out_file},script={tracer}"
        )

        if not raw_out_file.is_file():
          build_opt = f"-n " if no_build else ""
          suite_opt = f"-s {self.bug.randoop_path}" if is_randoop else ""
          test_cmd = (
            f"{D4J_MOD} test {build_opt}"
            f"{suite_opt} "
            f"-t {test} "
            f"-w {self.bug.project_dir} -a {jvmargs}"
          )
          no_build=True
          print(f"{INFO} {raw_out_file} does not exist. Running test...")
          print(f"[CMD]: {test_cmd}")
          try:
            proc = subprocess.Popen(test_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            retcode = proc.wait(timeout=90)
            if retcode == 0:
              print(f"{SUCCESS} Test {test} completed successfully.")
            else:
              print(f"{ERROR} Test {test} failed with return code {retcode}.")
          except Exception as e:
            print(f"{TIMEOUT} Test {test} occurs timeout")
            terminate_child_processes(proc.pid)
        if raw_out_file.is_file():
          extract_trace(raw_out_file, target_out_file, start_line, end_line)
        else:
          print(f"{WARNING} Test {test} output missing, skipping extraction")

    if self.trace_log.is_file():
      print(f"{INFO} Trace of {self.patch.patch_path.name}({self.patch.hash_dir.name}) already exists, extracting...")
      subprocess.run(f"tar -xvf {self.trace_log.name}", shell=True, cwd=self.result_dir)
    else:
      print(f"{INFO} Creating trace archive of {self.patch.patch_path.name}({self.patch.hash_dir.name})...")
        # Run test with buggy code
      self.bug.checkout()
      subprocess.run(f"{D4J_MOD} compile -w {self.bug.project_dir}", shell=True)
      execute_and_extract(d4j_tests, self.trace_log_dir / "buggy", self.trace_log_dir / "buggy_e")
      execute_and_extract(randoop_tests, self.trace_log_dir / "buggy", self.trace_log_dir / "buggy_e", is_randoop=True)

      # Run test with patch code
      self.patch.apply()
      subprocess.run(f"{D4J_MOD} compile -w {self.bug.project_dir}", shell=True)
      execute_and_extract(d4j_tests, self.trace_log_dir / "patched", self.trace_log_dir / "patched_e")
      execute_and_extract(randoop_tests, self.trace_log_dir / "patched", self.trace_log_dir / "patched_e", is_randoop=True)
      subprocess.run(f"tar -cvjf {self.trace_log.name} traces", shell=True, cwd=self.result_dir)
    self.bug.checkout()
  
  def parse_trace(self):
    print(f"{INFO} parsing trace {self.patch.patch_path.name}({self.patch.hash_dir.name})....")
    if (self.parse_out_dir / "LCS_array").is_file():
      return
    failing_tests_str = ",".join(self.bug.failing_tests)
    print(f"make parse ARGS=\"'{failing_tests_str}' '{self.trace_log_dir}' '{self.patch.patch_path}' '{self.parse_out_dir}'\"")
    subprocess.run(f"make parse ARGS=\"'{failing_tests_str}' '{self.trace_log_dir}' '{self.patch.patch_path}' '{self.parse_out_dir}'\"", shell=True, timeout=3600, capture_output=True, cwd=PATCHSIM_HOME)
  
  def classify(self, threshold=0.25):
    subprocess.run(f"java classifier {self.parse_out_dir} {threshold} > {self.classify_dir / f"result_{threshold}.txt"}", shell=True, cwd=PATCHSIM_HOME)

  def run(self, rerun=False):
    print(f"{PROGRESS} running PatchSim: {self.patch.patch_path.name}({self.patch.hash_dir.name})....")
    start_time = time.time()

    result = {
      "label": "unknown",
      "execution_time": 0,
      "error": None
    }
    if rerun and self.result_dir.exists():
      # result_file.unlink()
      shutil.rmtree(self.result_dir)

    if not self.result_file.is_file():
      try:
        start_time = time.time()
        self.setup_base_dir()
        self.setup_test_cover_info()
        self.setup_tracer()
        self.run_tracer()
        self.parse_trace()
        self.classify()
        with open(self.classify_dir / "result_0.25.txt", "r") as f:
          result["label"] = f.readlines()[-1].strip()
          result["execution_time"] = time.time() - start_time
        
        with open(self.result_file, "w") as f:
          json.dump(result, f, indent=4)
        # Test patchsim with various threshold
        for threshold in range(0, 101):
          self.classify(threshold / 100)
      except Exception as e:
        result["error"] = traceback.format_exc()
        result["execution_time"] = time.time() - start_time
    else:
      with open(self.result_file, "r") as f:
        result = json.load(f)
      
    shutil.rmtree(self.trace_log_dir)
    return result["label"], result["execution_time"], result["error"]
