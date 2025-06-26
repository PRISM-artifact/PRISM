import argparse
import shutil
import json
import subprocess

from collections import defaultdict
from typing import List, Tuple, Union, Dict
from multiprocessing import Pool
from tabulate import tabulate

from config import *
from utils import *
from ranking import *

RQ1_RESULT_DIR = Path(f"../rq1_results").resolve()
classifiers_to_run = ["org", "patchsim", "ods", "shibboleth", "prism"]

###################################
# sub-modules for data extraction #
###################################
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

def rank_bug_with_apcc(args):
  project, bug_id, patch_dir, apr_name = args
  for clf in classifiers_to_run:
    out_dir = RQ1_RESULT_DIR / apr_name / project / str(bug_id)
    out_file = out_dir / f"{clf}.txt"
    if out_file.exists():
      print(f"{SUCCESS}: Evaluation for {clf} with {apr_name} on {project}-{bug_id} already done")
      continue
    out_dir.mkdir(parents=True, exist_ok=True)
    try:
      result = run_apcc(project, bug_id, patch_dir, clf)
    except Exception as e:
      # If failed to run, return the original rank
      print(f"Evaluation failed for {clf} on project {project}, bug {bug_id}: {e}")
      result = run_apcc(project, bug_id, patch_dir, "org")
    with open(out_file, "w") as f:
      f.write(result)

def rank_apr_with_apcc(apr_dir):
  patches_dir = Path(apr_dir)
  apr_name = apr_dir.name
  tasks = []

  for project_dir in patches_dir.iterdir():
    if project_dir.is_dir():
      project_name = project_dir.name
      for bug_dir in project_dir.iterdir():
        if bug_dir.is_dir():
          bug_id = int(bug_dir.name)
          tasks.append((project_name, bug_id, bug_dir, apr_name))
  with Pool(processes=24) as pool:
    pool.map(rank_bug_with_apcc, tasks)

######################################
# sub-modules for data summarization #
######################################
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
  num_to_last = correct_indices[-1] if correct_indices else 0
  num_correct = len(correct_indices)
  num_incorrect = cnt-num_correct
  top1 = 1 if 1 in correct_indices else 0
  top5 = 1 if any(index <= 5 for index in correct_indices) else 0
  top_inf = 1 if len(correct_indices) > 0 else 0

  return (top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect)

def eval_bug_with_apcc(apr, project, bug_id):
  base_dir = RQ1_RESULT_DIR / apr / project / bug_id
  results = {}
  for clf in classifiers_to_run:
    target_result = base_dir / f"{clf}.txt"
    target_result = parse_ranking_data(target_result)
    results[clf] = target_result
  return results

def eval_apr_with_apcc(apr_dir):
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
          res_dict = eval_bug_with_apcc(apr_name, project_name, bug_id)
          for clf, (top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect) in res_dict.items():
            results[clf]["top-1"] += top1
            results[clf]["top-5"] += top5
            results[clf]["top-inf"] += top_inf
            results[clf]["#P-F"] += num_to_first 
            results[clf]["#P-L"] += num_to_last 
            results[clf]["#C"] += num_correct
            results[clf]["#I"] += num_incorrect
            bug_details[clf].append((project_name, bug_id, top1, top5, top_inf, num_to_first, num_to_last, num_correct, num_incorrect))
  return results, bug_details

if __name__ == '__main__':
  benchmark_path = BENCHMARKS_DIR / "rq1"
  # Extract ranking info using APCC
  for apr_dir in benchmark_path.iterdir():
    if apr_dir.is_dir():
      print(f"\nProcessing APR directory: {apr_dir.name}")
      rank_apr_with_apcc(apr_dir)
  
  # Extract summurized csv for table construction
  overall_aggregated = defaultdict(dict)  # {classifier: {apr_name: aggregated_result, ...}, ...}
  for apr_dir in benchmark_path.iterdir():
    if apr_dir.is_dir():
      aggregated_results, bug_details = eval_apr_with_apcc(apr_dir)
      apr_base_dir = RQ1_RESULT_DIR / apr_dir.name
      apr_base_dir.mkdir(parents=True, exist_ok=True)
      
      # summarize ranking per each APR with APCC
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
        overall_aggregated[clf][apr_dir.name] = result

  # summarize the total result
  for clf, apr_results in overall_aggregated.items():
    out_file = RQ1_RESULT_DIR / f"{clf}.csv"
    with open(out_file, "w", newline='') as f:
      writer = csv.writer(f)

      header = ["APR", "top-1(Δ)", "top-5(Δ)", "top-inf(Δ)", "#C(Δ)", "#I(Δ)", "#P-F(Δ)", "#P-L(Δ)"]
      writer.writerow(header)

      for apr, result in apr_results.items():
        org_result = overall_aggregated["org"][apr]  # 기준 값
        def delta(val):
          d = result[val] - org_result[val]
          return f"{'+' if d > 0 else ''}{d}"

        row = [
          apr,
          f'{result["top-1"]} ({delta("top-1")})',
          f'{result["top-5"]} ({delta("top-5")})',
          f'{result["top-inf"]} ({delta("top-inf")})',
          f'{result["#C"]} ({delta("#C")})',
          f'{result["#I"]} ({delta("#I")})',
          f'{result["#P-F"]} ({delta("#P-F")})',
          f'{result["#P-L"]} ({delta("#P-L")})',
        ]
        writer.writerow(row)
  
  # Print total table
  classifiers = ["patchsim", "ods", "shibboleth", "prism"]
  org_data = overall_aggregated["org"]

  all_metrics = ["top-1", "top-5", "top-inf", "#C", "#I", "#P-F", "#P-L"]
  table_rows = []

  for apr in sorted(org_data.keys()):
      first_row = True
      for clf in classifiers:
          if apr not in overall_aggregated[clf]:
              continue
          result = overall_aggregated[clf][apr]
          org = org_data[apr]

          def fmt(val):
              diff = result[val] - org[val]
              delta = f" ({'+' if diff > 0 else ''}{diff})" if diff != 0 else ""
              return f"{result[val]}{delta}"

          row = [
              apr if first_row else "",
              clf,
          ] + [fmt(m) for m in all_metrics]
          table_rows.append(row)
          first_row = False
      table_rows.append(["-----"] * (2 + len(all_metrics)))

  total_rows = []
  for idx, clf in enumerate(classifiers):
      result_sum = {m: 0 for m in all_metrics}
      org_sum = {m: 0 for m in all_metrics}

      for apr in org_data:
          if apr in overall_aggregated[clf]:
              for m in all_metrics:
                  result_sum[m] += overall_aggregated[clf][apr][m]
                  org_sum[m] += org_data[apr][m]

      def fmt_total(val):
          d = result_sum[val] - org_sum[val]
          delta = f" ({'+' if d > 0 else ''}{d})" if d != 0 else ""
          return f"{result_sum[val]}{delta}"

      total_rows.append([
          "TOTAL" if idx == 0 else "",
          clf,
      ] + [fmt_total(m) for m in all_metrics])

  table_rows.extend(total_rows)

  headers = ["APR", "APCC"] + [f"{m} (Δ)" for m in all_metrics]
  print(tabulate(table_rows, headers=headers, tablefmt="github"))