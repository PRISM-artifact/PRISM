import argparse
import time
import subprocess
import shutil
import re
import json
import csv

from pathlib import Path

from multiprocessing import Pool
from collections import defaultdict

from utils import *
from config import *
from bug import Bug
from patch import Patch

class PrismTarget():
  def __init__(self, patch):
    self.bug = patch.bug
    self.patch = patch
    self.result_dir = self.patch.hash_dir / "prism"
    self.cp_dir = self.patch.hash_dir / "cp"
    self.log_dir = self.result_dir / "logs"  
    self.infer_out_dir = self.result_dir / "infer-out"
    self.trace_out_dir = self.result_dir / "trace-out"
    self.org_out_dir = self.patch.hash_dir.parent / "org/prism/infer-out"
    self.specs_dir = self.result_dir / "specs"
    self.setup_base_dirs()

  def setup_base_dirs(self):
    self.log_dir.mkdir(parents=True, exist_ok=True)
    self.cp_dir.mkdir(parents=True, exist_ok=True)
    self.specs_dir.mkdir(parents=True, exist_ok=True)
  
  def get_analysis_time(self):
    with open(self.log_dir / "pre-analysis_time.txt", "r") as f:
      pre_time = float(f.read().strip())
    with open(self.log_dir / "main-analysis_time.txt", "r") as f:
      main_time = float(f.read().strip())
    return pre_time + main_time
      
  def capture(self, rerun=False):
    print(f"{PROGRESS}: capture {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
    if rerun and self.infer_out_dir.exists():
      shutil.rmtree(self.infer_out_dir)
    
    if self.infer_out_dir.exists():
      print(f"{SUCCESS} capture {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return True
    
    self.patch.apply()
    self.bug.run_test()
    start_time = time.time()

    # Collect the source and test source files
    export_src_cmd = f"{D4J} export -p dir.src.classes -w {self.bug.project_dir}"
    src_result = subprocess.run(export_src_cmd, shell=True, text=True, capture_output=True)
    src_dir = self.bug.project_dir / src_result.stdout.strip()

    export_test_cmd = f"{D4J} export -p dir.src.tests -w {self.bug.project_dir}"
    test_result = subprocess.run(export_test_cmd, shell=True, text=True, capture_output=True)
    test_dir = self.bug.project_dir / test_result.stdout.strip()

    java_files = set(src_dir.rglob("*.java")) | set(test_dir.rglob("*.java"))

    # Remove problematic source files for Mockito
    if self.bug.project == "Mockito":
      erroneous = {
        src_dir / "org/mockito/internal/matchers/LocalizedMatcher.java",
        test_dir / "org/mockitoutil/ExtraMatchers.java"
      }
      err_group1 = [11, 13, 23, 26, 27, 31, 33, 34]
      if self.bug.bug_id in err_group1:
        erroneous |= {
          test_dir / "org/mockito/internal/creation/MethodInterceptorFilterTest.java"
        }
      java_files -= erroneous

    # Write the list of Java files to a file
    java_files_str = "\n".join(str(f) for f in java_files)
    with open(f"{self.bug.project_dir}/java_files", "w") as f:
      f.write(java_files_str)

    # Capture the project using infer
    for version in ["1.8", "1.7", "1.6", "1.5", "1.4"]:
      cp_str = ":".join(map(str, self.bug.class_paths))
      build_cmd = f"javac -encoding {self.bug.encoding} -source {version} -cp {cp_str} @{self.bug.project_dir}/java_files -d {self.cp_dir}"
      capture_cmd = f"{INFER} capture --results-dir {self.infer_out_dir} -- {build_cmd}"
      print(f"{PROGRESS}: Capturing project with command: {capture_cmd}")
      
      ret = subprocess.run(capture_cmd, shell=True, cwd=self.bug.project_dir, capture_output=True)
      if not self.infer_out_dir.exists() or ret.returncode != 0:
        with open(self.log_dir / "capture_error.log", "w") as f:
          f.write(f"Failed capture for Java {version}\n")
          f.write(f"Command: {capture_cmd}\n")
          f.write(f"Output: {ret.stdout}\n")
          f.write(f"Error: {ret.stderr}\n")
        continue
      else:
        capture_time = time.time() - start_time
        with open(self.log_dir / "capture_time.txt", "w") as f:
          f.write(str(capture_time))
        print(f"{SUCCESS} capture {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
        return True
    
    if self.infer_out_dir.exists():
      shutil.rmtree(self.infer_out_dir)
    return False
  
  def run_tracer(self, rerun=False):
    print(f"{PROGRESS}: extract trace of {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
    if rerun and self.trace_out_dir.exists():
      shutil.rmtree(self.trace_out_dir)

    start_time = time.time()

    # Run all tests to extract stack trace info
    jvm_opts = "-Xms128m -Xmx128m" if self.bug.project == "Lang" and self.bug.bug_id == 43 else ""
    class_paths_opt = ":".join([str(cp) for cp in self.bug.class_paths])
    test_methods = [t.replace('::', '#') for t in self.bug.failing_tests]
    test_classes = list(set([re.sub('::.*', '', m.strip()) 
                                  for m in self.bug.failing_tests]))
          
    if self.trace_out_dir.exists() and \
      all(any(f.stat().st_size > 0 for f in (self.trace_out_dir / tc).glob("*.csv")) for tc in test_classes):
      print(f"{SUCCESS} extract trace of {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return True
    
    self.patch.apply()
    self.bug.run_test()
    # self.bug.export_packages()
    for test_class in test_classes:
      test_methods_within_class = [t for t in test_methods if t.startswith(test_class)]
      cmd = (
        #f"java {jvm_opts} -javaagent:{TRACER_JAR_PATH}=\".,{test_class},true\" "
        f"java {jvm_opts} -javaagent:{TRACER_JAR_PATH}=\".,{test_class}\" "
        f"-cp {self.cp_dir}:{class_paths_opt} "
        f"org.junit.runner.JUnitCore {test_class}"
      )
      print(f"{cmd}")
      try:
        subprocess.call(cmd, shell=True, cwd=self.bug.project_dir, timeout=30)
      except subprocess.TimeoutExpired:
        test_methods_within_class = [t for t in test_methods if t.startswith(test_class)]
        print(f"{TIMEOUT} Rerun tracer only with the failing tests")
        cmd = (
          f"java {jvm_opts} -javaagent:{TRACER_JAR_PATH}=\".,{test_class}\" "
          f"-cp {JUNIT_JAR_PATH}:{self.cp_dir}:{class_paths_opt} "
          f"{JUNIT_CORE_CLASS} {','.join(test_methods_within_class)}"
        )
        print(f"{cmd}")
        try:
          subprocess.call(cmd, shell=True, cwd=self.bug.project_dir)
        except:
          print(f"{TIMEOUT} Fail to extract trace of {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
          return False
        
    temp_out_dir = self.bug.project_dir / "trace-out"
    succeed = all(any(temp_out_dir.rglob(f"{tc}/*.csv")) for tc in test_classes)

    if succeed:
      if self.trace_out_dir.exists():
        shutil.rmtree(self.trace_out_dir)
      shutil.move(temp_out_dir, self.trace_out_dir)
      with open(self.log_dir / "trace_time.txt", "w") as f:
        trace_time = time.time() - start_time
        f.write(str(trace_time))
      print(f"{SUCCESS} extract trace of {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return True
    else:
      print(f"{FAIL} Fail to extract trace of {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return False

  def pre_analyze(self):
    print(f"{PROGRESS}: pre-analysis {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")

    start_time = time.time()
    self.patch.apply()
    test_opt = " ".join([f"--test-methods {mthd}" for mthd in self.bug.failing_tests])
    analysis_opt = "--preproc-org" if self.patch.hash_dir.name == "org" else "--preproc-patch"
    #preproc original program
    cmd = f"{INFER} aprval --spec-checker-only {analysis_opt} --patch-dir {self.patch.patch_path} --results-dir {self.infer_out_dir} --results-org {self.org_out_dir} {test_opt}"
    print(cmd)

    ret = subprocess.run(cmd, shell=True, cwd=self.bug.project_dir)
    if ret.returncode != 0:
      print(f"{FAIL} pre-analyze {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return False
    else:
      with open(self.log_dir / "pre-analysis_time.txt", "w") as f:
        f.write(str(time.time() - start_time))
      print(f"{SUCCESS} pre-analyze {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return True

  def main_analyze(self, debug=False):
    print(f"{PROGRESS}: main-analysis {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
    start_time = time.time()
    self.patch.apply()
    debug_opt = "--scheduler restart -g" if debug else ""
    test_opt = " ".join([f"--test-methods {mthd}" for mthd in self.bug.failing_tests])
    analysis_opt = "--spec-inference" if self.patch.hash_dir.name == "org" else "--spec-validate"
    cmd = (
      f"{INFER} {debug_opt} aprval --spec-checker-only {analysis_opt} --patch-dir {self.patch.patch_path} --results-dir {self.infer_out_dir} --results-org {self.org_out_dir} {test_opt}"
    )
    print(cmd)
    ret = subprocess.run(cmd, shell=True, cwd=self.bug.project_dir, timeout=PRISM_BUDGET)
    if ret.returncode != 0:
      print(f"{FAIL} main-analyze {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return False
    else:  
      with open(self.log_dir / "main-analysis_time.txt", "w") as f:
        f.write(str(time.time() - start_time))
      log_file = self.infer_out_dir / "logs"
      log_file.unlink()
      print(f"{SUCCESS} main-analyze {self.bug.project}-{self.bug.bug_id}({self.patch.hash_dir.name})")
      return True

def run_prism(p_org:PrismTarget, p_patch:PrismTarget, rerun=False, debug=False):
  # Pre analysis the pre-and-post patch project
  result_file = p_patch.result_dir / "result.json"
  if result_file.is_file() and not rerun:
    with open(result_file, "r") as f:
      result = json.load(f)
    return result["features"], result["analysis_time"]
  
  # Pre analysis
  ret_pre_org = p_org.pre_analyze()
  ret_pre_patch = p_patch.pre_analyze()
  
  # Analysis org program and obtain required info
  ret_main_org = p_org.main_analyze(debug)
  # Copy analysis result for incremental analysis
  aprval_org_summaries = p_org.infer_out_dir / "aprval-results"
  target_dir = p_patch.infer_out_dir / "aprval-results"
  if target_dir.exists():
      shutil.rmtree(target_dir)  
  shutil.move(aprval_org_summaries, target_dir)
  # Copy resulting logs for debugging
  aprval_org_specs = p_org.infer_out_dir / "aprval-debug"
  for file in aprval_org_specs.iterdir():
    if file.is_file():
      shutil.copy2(file, p_patch.specs_dir / file.name)
      file.unlink()
      
  # Aanalysis patch program 
  result = {}
  ret_main_patch = p_patch.main_analyze(debug)
  # Copy resulting logs and feature
  aprval_patch_specs = p_patch.infer_out_dir / "aprval-debug"
  for file in aprval_patch_specs.iterdir():
    if file.is_file():
      shutil.copy2(file, p_patch.specs_dir / file.name)
      file.unlink()
  with open(p_patch.bug.project_dir / "result.json", "r") as f:
    features = json.load(f)
  # Store result
  time_org, time_patch = p_org.get_analysis_time(), p_patch.get_analysis_time()
  result["features"] = features
  result["analysis_time"] = time_org + time_patch
  
  with open(result_file, "w") as f:
    json.dump(result, f, indent=4)
  
  return features, time_org + time_patch

def process_job(args):
  bug_key, patch_list = args
  print(f"{PROGRESS} process {bug_key} with {len(patch_list)} patches...")
  
  project, bugid = bug_key.split("-")
  bug = Bug(project, int(bugid), set_ant=False)
  results = {}

  for patch_path in patch_list:
    vector = {}
    
    patch = Patch(bug, patch_path)
    extractor = PrismTarget(patch)
    result_file = extractor.result_dir / "result.json"
    if result_file.is_file():
      with open(result_file, "r") as f:
        result = json.load(f)
        vector = {key: int(value) for key, value in result["features"].items()}

    feature_id = patch.patch_id
    vector["id"] = feature_id
    vector["label"] = 1 if patch.check_correctness() == "incorrect" else 0
    results[feature_id] = vector

  print(f"{SUCCESS} end process {bug_key} with {len(patch_list)} patches!")
  return results
if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patch", type=Path, help="patch file path")
  parser.add_argument("--org", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--rerun", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--debug", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--mode", choices=["capture", "trace", "pre", "main", "csv"], required=True)
  parser.add_argument("--patches", type=Path, help="patch file path")
  args = parser.parse_args()

  if args.patch != None:
    # Pipeline for runnning analyer with one patch
    project = args.patch.name.split("-")[0]
    bugid = args.patch.name.split("-")[1]
    if not check_valid_d4j(project, bugid):
      parser.error(f"Error: {project}-{bugid} is not a valid d4j benchmark")
    bug = Bug(project, bugid)
    print(bug)
    patch = Patch(bug, args.patch, is_org=args.org)
    print(patch)
    rerun=args.rerun
    if args.mode == "capture":
      ret = PrismTarget(patch).capture(rerun)
      print(ret)
    elif args.mode == "trace":
      ret = PrismTarget(patch).run_tracer(rerun)
      print(ret)
    elif args.mode == "pre":
      ret = PrismTarget(patch).pre_analyze()
    elif args.mode == "main":
      ret = PrismTarget(patch).main_analyze(args.debug)
  elif args.patches != None:
    if args.mode == "csv":
      #pipeline for generating csv files from list of patches
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
      with Pool(processes=16) as pool:
        async_result = pool.map_async(process_job, task_args)
        results =async_result.get()
        all_results.extend(results)
      
      unique_features = {}
      for result in all_results:
        unique_features.update(result)
        
      output_csv_path = CSV_DIR / "training_prism.csv"
      print(f"{PROGRESS}: construct prism training data from {len(unique_features)} patches...")
      # Sort field names
      fieldnames = ["id", "label"] + sorted(
        {key for features in unique_features.values() for key in features.keys() if key not in {"id", "label"}}
      )
        
      for features in unique_features.values():
        for key in fieldnames:
          if key not in features:
            features[key] = 0
            
      with open(output_csv_path, "w", newline="") as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(unique_features.values())

      print(f"{SUCCESS}Features saved to {output_csv_path}")