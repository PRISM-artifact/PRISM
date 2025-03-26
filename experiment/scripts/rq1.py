import argparse
import shutil
import json
import subprocess

from collections import defaultdict
from typing import List, Tuple, Union, Dict

from config import *
from utils import *
from ranking import *

def run_apcc(project, bug_id, patch_dir, classifier_type):
  if classifier_type == "patchsim":
    ranker = PatchSimRanker(project, bug_id, patch_dir)
  elif classifier_type == "ods":
    ranker = ODSRanker(project, bug_id, patch_dir)
  elif classifier_type == "shibboleth":
    ranker = ShibbolethRanker(project, bug_id, patch_dir)
  elif classifier_type == "prism":
    ranker = PrismRanker(project, bug_id, patch_dir)
  elif classifier_type == "org":
    ranker = Ranker(project, bug_id, patch_dir)
  ranker.rank()
  print("-----------------------------------------------")
  print(f"Ranking {classifier_type} with {patch_dir}")
  print(ranker)
  print("-----------------------------------------------")
  ranking_str = str(ranker)
  return ranking_str

def rank_bug_with_apcc(project, bug_id, patch_dir, classifier_choice):
  baseline_result = run_apcc(project, bug_id, patch_dir, "org")
  results = defaultdict()
  if classifier_choice == "all":
    classifiers_to_run = ["org", "patchsim", "ods", "shibboleth", "prism"]
  else:
    classifiers_to_run = [classifier_choice]
  for clf in classifiers_to_run:
    try:
      if clf == "org":
        result = baseline_result
      else:
        result = run_apcc(project, bug_id, patch_dir, clf)
    except Exception as e:
      print(f"Evaluation failed for {clf} on project {project}, bug {bug_id}: {e}")
      result = baseline_result
    results[clf] = result
    
  return results

def rank_apr_with_apcc(apr_dir, classifier_choice):
  patches_dir = Path(apr_dir)
  apr_name = apr_dir.name
  for project_dir in patches_dir.iterdir():
    if project_dir.is_dir():
      project_name = project_dir.name
      for bug_dir in project_dir.iterdir():
        if bug_dir.is_dir():
          bug_id = int(bug_dir.name)
          res_dict = rank_bug_with_apcc(project_name, bug_id, bug_dir, classifier_choice)
          for clf, rank_str in res_dict.items():
            out_dir = Path(f"./rq1_results") / apr_name / project_name / str(bug_id)
            out_dir.mkdir(parents=True, exist_ok=True)
            out_file = out_dir / f"{clf}.txt"
            with open(out_file, "w") as f:
              f.write(rank_str)

def parse_ranking_data(result_file):
  correct_indices = []
  cnt = 0
  with open(result_file, 'r') as file:
    for line in file:
      parts = line.strip().split(": ")
      if len(parts) < 2:
        continue
        
      result = parts[1].split(" ")[-1].strip("()")
      cnt += 1
      if result == "correct":
        correct_indices.append(cnt)

  num_to_first = correct_indices[0] if correct_indices else 0
  print(result_file, correct_indices, num_to_first)
  num_to_last = correct_indices[-1] if correct_indices else 0
  num_correct = len(correct_indices)
  num_incorrect = cnt-num_correct
  top1 = 1 if 1 in correct_indices else 0
  top5 = 1 if any(index <= 5 for index in correct_indices) else 0
  top_inf = 1 if len(correct_indices) > 0 else 0

  return (top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect)

def eval_bug_with_apcc(apr, project, bug_id, classifier_choice):
  base_dir = Path(f"./rq1_results") / apr / project / bug_id
  results = {}
  
  if classifier_choice == "all":
    classifiers_to_run = ["org", "patchsim", "ods", "shibboleth", "prism"]
  elif classifier_choice == "org":
    classifiers_to_run = ["org"]
  else:
    classifiers_to_run = ["org", classifier_choice]
  for clf in classifiers_to_run:
    target_result = base_dir / f"{clf}.txt"
    target_result = parse_ranking_data(target_result)
    results[clf] = target_result
  print(results)
  return results

def eval_apr_with_apcc(apr_dir, classifier_choice):
  patches_dir = Path(apr_dir)
  apr_name = apr_dir.name    
  results = defaultdict(lambda: defaultdict(int))
  bug_details = defaultdict(list)
  for project_dir in patches_dir.iterdir():
    if project_dir.is_dir():
      project_name = project_dir.name
      for bug_dir in project_dir.iterdir():
        if bug_dir.is_dir():
          bug_id = bug_dir.name
          res_dict = eval_bug_with_apcc(apr_name, project_name, bug_id, classifier_choice)
          for clf, (top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect) in res_dict.items():
            print(clf, project_name, bug_id, top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect)
            results[clf]["top-1"] += top1
            results[clf]["top-5"] += top5
            results[clf]["top-inf"] += top_inf
            results[clf]["#P-F"] += num_to_first 
            results[clf]["#P-L"] += num_to_last 
            results[clf]["#C"] += num_correct
            results[clf]["#I"] += num_incorrect
            bug_details[clf].append((project_name, bug_id, top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect))
  return results, bug_details

def process_benchmark_directory(benchmark_dir, classifier_choice, mode):
  benchmark_path = Path(benchmark_dir)
  overall_aggregated = defaultdict(dict)  # {classifier: {apr_name: aggregated_result, ...}, ...}
  for apr_dir in benchmark_path.iterdir():
    if apr_dir.is_dir():
      print(f"\nProcessing APR directory: {apr_dir.name}")
      if mode == "run":
        rank_apr_with_apcc(apr_dir, classifier_choice)
      elif mode == "eval":
        aggregated_results, bug_details = eval_apr_with_apcc(apr_dir, classifier_choice)
        apr_base_dir = Path(f"./rq1_results") / apr_dir.name
        apr_base_dir.mkdir(parents=True, exist_ok=True)
        
        # 1. APR 단위 집계 CSV 파일 (예: org_apr.csv)
        for clf, result in aggregated_results.items():
          out_file = apr_base_dir / f"{clf}.csv"
          with open(out_file, "w", newline='') as f:
            writer = csv.writer(f)
            header = ["top-1", "top-5", "top-inf", "#P-F", "#P-L", "#C", "#I"]
            writer.writerow(header)
            writer.writerow([
                result["top-1"], result["top-5"], result["top-inf"],
                result["#P-F"], result["#P-L"], result["#C"], result["#I"]
            ])
          # 누적 APR별 결과를 benchmark CSV에 쓸 수 있도록 저장
          overall_aggregated[clf][apr_dir.name] = result
        
        # 2. bug id–레벨 CSV 파일 (예: org.csv)
        for clf, bug_rows in bug_details.items():
          bug_out_file = apr_base_dir / f"{clf}_bug.csv"
          with open(bug_out_file, "w", newline='') as f:
            writer = csv.writer(f)
            header = ["Project", "Bug ID", "top-1", "top-5", "top-inf", "#P-F", "#P-L", "#C", "#I"]
            writer.writerow(header)
            for row in bug_rows:
                writer.writerow(row)
    
    if mode == "eval":
      benchmark_output_dir = Path("./rq1_results")
      for clf, apr_results in overall_aggregated.items():
        out_file = benchmark_output_dir / f"{clf}.csv"
        with open(out_file, "w", newline='') as f:
          writer = csv.writer(f)
          header = ["APR", "top-1", "top-5", "top-inf", "#P-F", "#P-L", "#C", "#I"]
          writer.writerow(header)
          for apr, result in apr_results.items():
            writer.writerow([
              apr, result["top-1"], result["top-5"], result["top-inf"],
              result["#P-F"], result["#P-L"], result["#C"], result["#I"]
            ])

 
if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patches", type=Path, help="apr result direcotry")
  parser.add_argument("--apcc", type=str, choices=["org", "patchsim", "ods", "shibboleth", "prism", "all"], help="Target instance for ranking", default="all")
  parser.add_argument("--mode", choices=["run", "eval"])
  args = parser.parse_args()
  process_benchmark_directory(args.patches, args.apcc, args.mode)