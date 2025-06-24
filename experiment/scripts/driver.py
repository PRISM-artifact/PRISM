import argparse
import json 
import traceback

from datetime import datetime
from pathlib import Path
from collections import defaultdict
from multiprocessing import Pool, Manager

from utils import *
from config import *
from bug import *
from patch import *
from patchsim import *
from prism import *
from ods import *
from shibboleth import *

def process_job(args):
  bug_key, patch_list, rerun, job = args
  print(f"{PROGRESS} process {bug_key} with {len(patch_list)} patches...")
  
  project, bugid = bug_key.split("-")
  bug = Bug(project, int(bugid))
  results = defaultdict(lambda: {"patches": []})

  # Main procedure
  org_flag = True
  for patch_path in patch_list:
    patch = Patch(bug, patch_path)
    hash_key = f"{project}-{bugid}({patch.hash_dir.name})"
    results[hash_key]["patches"].append(patch_path)

    if job == "compile":
      # Compile only the target bug 
      is_compile, log = patch.bug.compile()
      results[hash_key].update({"is_compile": is_compile, "log": log})
      break
    elif job == "test":
      is_compile, is_pass, log = patch.run_test(rerun)      
      results[hash_key].update({"is_compile": is_compile, "is_pass": is_pass, "log": log})
    elif job == "patchsim":
      target = PatchSim(patch)
      label, execution_time, err_log = target.run(rerun)
      results[hash_key].update({"patchsim_result": label, "patchsim_time": execution_time, "err_log": err_log})
    elif job == "ods-extract":
      features = FeatureExtractor(patch).run(rerun)
      results[hash_key]["syn_features"] = features
    elif job == "shibboleth-extract":
      try:
        target = Shibboleth(patch)
        target.setup_input_files()
        result = target.extract_score(rerun)
      except Exception as e:
        result = {}
      results[hash_key]["result"] = result
    elif job == "prism-capture":
      if org_flag:
        org = Patch(bug, patch_path, is_org=True)
        ret_org = PrismTarget(org).capture(rerun)
        results[f"{project}-{bugid}(org)"].update({"capture result": ret_org})
        org_flag = False
      target = PrismTarget(patch)
      capture_result = target.capture(rerun)
      results[hash_key].update({"capture result": capture_result})
    elif job == "prism-trace":
      if org_flag:
        org = Patch(bug, patch_path, is_org=True)
        ret_org = PrismTarget(org).run_tracer(rerun)
        results[f"{project}-{bugid}(org)"].update({"capture result": ret_org})
        org_flag = False
      target = PrismTarget(patch)
      tracer_result = target.run_tracer(rerun)
      results[hash_key].update({"tracer result": tracer_result})
    elif job == "prism-run":
      try:
        org = Patch(bug, patch_path, is_org=True)
        p_org = PrismTarget(org)
        p_patch = PrismTarget(patch)
        features, analysis_time = run_prism(p_org, p_patch, rerun)
        results[hash_key].update({"features": features, "analysis_time": analysis_time, "err_logs": ""})
      except Exception as e:
        err_trace = traceback.format_exc() 
        results[hash_key].update({"features": dict(), "analysis_time": 0.0, "err_logs": err_trace})

  # Logging
  logs = []
  for hash_key, data in results.items():
    patches = "\n - ".join(patch.name for patch in data["patches"])
    log = (
      f"----{hash_key}----\n"
      f" * Patches({len(data['patches'])}):{patches}"
    )
    for key, value in data.items():
      if key != "patches":
        log += f"\n * {key}={json.dumps(value)}"
    logs.append(log)
  
  print(f"{SUCCESS} end process {bug_key} with {len(patch_list)} patches!")
  return "\n".join(logs)

if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patches", type=Path, required=True, help="patches file path")
  parser.add_argument("--rerun", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--mode", choices=MODES.keys(), default="build")
  parser.add_argument("--core", type=int, default=8)
  args = parser.parse_args()
  
  job = args.mode
  rerun = args.rerun
  patches = list(args.patches.rglob("*.patch"))
  num_core = args.core
  
  # Bug => patch_path list
  tasks1 = defaultdict(list)
  tasks2 = defaultdict(list)
  for patch_path in patches:
    project = patch_path.name.split("-")[0]
    bugid = int(patch_path.name.split("-")[1])
    if not check_valid_d4j(project, bugid):
      continue
    bug_key = f"{project}-{bugid}"
    if project == "Lang":
      tasks2[bug_key].append(patch_path)
    else:
      tasks1[bug_key].append(patch_path)
  
  # Logging Start
  current_time = datetime.now().strftime("%Y/%m/%d-%H:%M:%S")
  with open(LOG_DIR / f"{job}.log", "a") as f:
    f.write(f"\n--- LOGGING START: {current_time} ---\n")
  
  total_patches = sum(len(patch_list) for patch_list in tasks1.values()) + \
                  sum(len(patch_list) for patch_list in tasks2.values())
  # Main task
  all_results = []
  for task_idx, tasks in enumerate([tasks1, tasks2], start=1):
    patch_num = sum(len(patch_list) for patch_list in tasks.values())
    print(f"{PROGRESS} Processing task group {task_idx} with {patch_num} patches...")
    if job in ["label", "rename"] or num_core == 1:
      # Jobs which require user interaction
      for bug_key, patch_list in tasks.items():
        result = process_job((bug_key, patch_list, rerun, job))
        all_results.append(result)
    else:
      # Build the first item to handle shared resource setup
      bug_key, patch_list = next(iter(tasks.items()))
      print(f"{PROGRESS} Change ant version for task {task_idx}...")
      result = process_job((bug_key, patch_list, False, "compile")) 

      task_args = [(bug_key, patch_list, rerun, job) for bug_key, patch_list in tasks.items()]
              
      with Pool(processes=num_core) as pool:
        async_result = pool.map_async(process_job, task_args)
        results =async_result.get()
        all_results.extend(results)

    # Write logs
    with open(LOG_DIR / f"{job}.log", "a") as f:
      f.write("\n".join(all_results))
      all_results.clear()