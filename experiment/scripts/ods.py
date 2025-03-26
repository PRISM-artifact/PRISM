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

class FeatureExtractor:
  def __init__(self, patch):
    self.bug = patch.bug
    self.patch = patch
    self.bug_key = f"{self.bug.project}_{self.bug.bug_id}"
    self.result_dir = patch.hash_dir / "ods"
    self.source_dir = self.result_dir / SOURCES_DIR
    self.raw_feature_file = self.result_dir / f"features_{self.bug_key}_FeatureAnalyzer.json"
    self.feature_file = self.result_dir / "feature.json"
    
  def setup_source_code(self):
    for modified_file in self.patch.modified_files:
      class_name = modified_file.stem
      source_base = self.source_dir / self.bug_key / class_name
      source_base.mkdir(parents=True, exist_ok=True)

      # copy original code
      self.bug.checkout()
      org_path = source_base / f"{self.bug_key}_{class_name}_s.java"
      shutil.copy(self.bug.project_dir / modified_file, org_path)
      # copy patch code
      self.patch.apply()
      patch_path = source_base / f"{self.bug_key}_{class_name}_t.java"
      shutil.copy(self.bug.project_dir / modified_file, patch_path)
    self.bug.checkout()
  
  def run_coming(self):
    if not self.raw_feature_file.is_file():
      cmd = (
        f"java -classpath {COMING_JAR} {COMING_CORE_CLASS} -input files -mode features "
        f"-location {self.source_dir} -output {self.result_dir}"
      )
      print(cmd)
      subprocess.run(cmd, shell=True, cwd=COMING_HOME)

  def extract_features(self): 
    result = {}
    with open(self.raw_feature_file, "r") as f:
      raw_data = json.load(f)

    for file_info in raw_data.get("files", []):
      for features in file_info.get("features", []):
        for key, value in features.items():
          # Extract context features
          if key.startswith("S"):
            if value in ["true", "false"]:
              result[key] = result.get(key, 0) or int(value == "true")
            elif value.strip():
              key = f"{key}_{value}"
              result[key] = result.get(key, 0) or 1

        # Extract code features
        for sub_feature in features.values():
          if isinstance(sub_feature, dict):
            for key, value in sub_feature.items():
              if key.startswith("P4J"):
                result[key] = result.get(key, 0) or int(value)

        # Extract pattern features
        for key, value in features.get("repairPatterns", {}).items():
          result[key] = result.get(key, 0) or int(value > 0)

    with open(self.feature_file, "w") as f:
      json.dump(result, f, indent=4)

    return result
  
  def run(self, rerun=False):
    if self.feature_file.is_file() and rerun:
      shutil.rmtree(self.result_dir)
    
    if self.feature_file.is_file():
      with open(self.feature_file, "r") as f:
        return json.load(f)     
    try:    
      print(f"{PROGRESS}: Extract ods features from {self.patch.patch_path.name}({self.patch.hash_dir.name})...")
      self.setup_source_code()
      self.run_coming()
      return self.extract_features()
    except Exception as e:
      print(f"{ERROR} Fail to extract ods feature from {self.patch.patch_path.name}({self.patch.hash_dir.name})...")
      print(traceback.format_exc()) 
      with open(self.feature_file, "w") as f:
        json.dump({}, f, indent=4)
      return {}

def process_job(args):
  bug_key, patch_list = args
  print(f"{PROGRESS} process {bug_key} with {len(patch_list)} patches...")
  
  project, bugid = bug_key.split("-")
  bug = Bug(project, int(bugid), set_ant=False)
  results = {}

  for patch_path in patch_list:
    patch = Patch(bug, patch_path)
    extractor = FeatureExtractor(patch)
    features = extractor.run()

    feature_id = patch_path.name
    features["id"] = feature_id
    features["label"] = 1 if patch.check_correctness() == "incorrect" else 0
    results[feature_id] = features

  print(f"{SUCCESS} end process {bug_key} with {len(patch_list)} patches!")
  return results

if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patches", type=Path, required=True, help="patch file path")
  args = parser.parse_args()
  #pipeline for one benchmark
  tasks1 = defaultdict(list)
  tasks2 = defaultdict(list)
  for patch_path in list(args.patches.rglob("*.patch")):
    project = patch_path.name.split("-")[0]
    bugid = int(patch_path.name.split("-")[1])
    if not check_valid_d4j(project, bugid):
      continue
    bug_key = f"{project}-{bugid}"
    if project == "Lang":
      tasks2[bug_key].append(patch_path)
    else:
      tasks1[bug_key].append(patch_path)
  
  all_results = []
  for task_idx, tasks in enumerate([tasks1, tasks2], start=1):
    patch_num = sum(len(patch_list) for patch_list in tasks.values())
    print(f"{PROGRESS} Processing task group {task_idx} with {patch_num} patches...")
    # Build the first item to handle shared resource setup
    bug_key, patch_list = next(iter(tasks.items()))
    print(f"{PROGRESS} Change ant version for task {task_idx}...")
    project, bugid = bug_key.split("-")
    bug = Bug(project, int(bugid), set_ant=False)
    bug.compile()

    task_args = [(bug_key, patch_list) for bug_key, patch_list in tasks.items()]
            
    with Pool(processes=32) as pool:
      async_result = pool.map_async(process_job, task_args)
      results =async_result.get()
      all_results.extend(results)
  
  unique_features = {}
  for result in all_results:
    unique_features.update(result)
    
  output_csv_path = CSV_DIR / "training_ods.csv"
  print(f"{PROGRESS}: construct ods training data from {len(unique_features)} patches...")
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


  
