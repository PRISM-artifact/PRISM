import argparse
import shutil
import json
import subprocess

from collections import defaultdict
from typing import List, Tuple, Union, Dict

from config import *
from utils import *
from bug import Bug
from patch import Patch

from classify import PatchSimClassifier, ODSClassifier
from shibboleth import Shibboleth
from classify import *

Score = Union[int, float, Tuple[float, float, float]]

def get_base_rank(patch):
  return int(patch.patch_path.name.split("-")[2].lstrip("patch"))

class Ranker():
  label_info: Dict[str, str]
  ranking_info: List[Tuple[Score, str]]
  
  def __init__(self, target_project: str, target_bug_id: int, patches_path: Path):
    self.bug = Bug(target_project, target_bug_id, set_ant=False)
    self.patches = []
    self.ranking = []
    self.label_info = defaultdict(list)
    for patch_path in list(patches_path.rglob("*.patch")):
      project = patch_path.name.split("-")[0]
      bug_id = int(patch_path.name.split("-")[1])
      if project != target_project or bug_id != target_bug_id:
        raise Exception(f"{ERROR}: {patch_path.name} is not a patch for {target_project}-{target_bug_id}")
      patch = Patch(self.bug, patch_path)
      self.label_info[patch.patch_id] = patch.check_correctness()
      self.patches.append(patch)

  def get_ranking_score(self, patch):
    return (0, get_base_rank(patch))

  def rank(self):
    # Prune out if given patch is labeled as overfitted
    rankings = [(self.get_ranking_score(patch), patch.patch_id) for patch in self.patches]
    rankings.sort(key=lambda x:x[0])
    self.ranking = [(score, patch_id) for ((pred, score), patch_id) in rankings if pred == 0]
    return self.ranking
  
  def rank2(self):
    # Switch rank if given patch is labeled as overfitted
    rankings = [(self.get_ranking_score(patch), patch.patch_id) for patch in self.patches]
    rankings.sort(key=lambda x:x[0])
    self.ranking = [(score, patch_id) for ((_, score), patch_id) in rankings]
    return self.ranking
  
  def __str__(self):
    return "\n".join(f"{x[0]}: {x[1]} ({self.label_info[x[1]]})" for x in self.ranking)
  
class PatchSimRanker(Ranker):
  def __init__(self, target_project: str, target_bug_id: int, patches_path: Path):
    super().__init__(target_project, target_bug_id, patches_path)
  
  def get_ranking_score(self, patch):
    base_rank = get_base_rank(patch)
    pred = PatchSimClassifier(patch).classify()
    group = 1 if pred == 1 else 0
    return (group, base_rank)

class ODSRanker(Ranker):
  def __init__(self, target_project: str, target_bug_id: int, patches_path: Path, use_prob=False):
    super().__init__(target_project, target_bug_id, patches_path)
  
  def get_ranking_score(self, patch):
    base_rank = get_base_rank(patch)
    pred = ODSClassifier(patch).classify()
    group = pred
    return (group, base_rank)

class ShibbolethRanker(Ranker):
  def __init__(self, target_project: str, target_bug_id: int, patches_path: Path):
    super().__init__(target_project, target_bug_id, patches_path)
      
  def get_ranking_score(self, patch):
    target = Shibboleth(patch)
    if not target.score_file.is_file():
      score = (0.0, 0.0, 0.0)
    else: 
      with open(target.score_file, "r") as f:
        results = f.read().strip().split(",")
        score = (-float(results[2]), -float(results[0]), -float(results[1]))
    return (0, score)
  
class PrismRanker(Ranker):
  def __init__(self, target_project: str, target_bug_id: int, patches_path: Path):
    super().__init__(target_project, target_bug_id, patches_path)
  
  def get_ranking_score(self, patch):
    base_rank = get_base_rank(patch)
    pred = PrismClassifier(patch).classify()
    group = 1 if pred == 1 else 0
    return (group, base_rank)
  
if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("-p", required=True, type=str, choices=["Chart", "Closure", "Lang",  "Math", "Time", "Mockito"], help="Target D4J1.2 project")
  parser.add_argument("-v", type=int, required=True, help="Corresponding bug id of target project")
  parser.add_argument("--patches", type=Path, help="patch files directory")
  parser.add_argument("--apcc", type=str, choices=["patchsim", "ods", "shibboleth", "all"], help="Target instance for ranking", default="all")
  args = parser.parse_args()
  
  if args.apcc == "all":
    org = Ranker(args.p, args.v, args.patches)
    r_org = org.rank()
    print_header("Rank Org")
    print(org)
    patchsim = PatchSimRanker(args.p, args.v, args.patches)
    r_patchsim = patchsim.rank()
    print_header("Rank Patchsim")
    print(patchsim)
    ods = ODSRanker(args.p, args.v, args.patches)
    r_ods = ods.rank()
    print_header("Rank ODS")
    print(ods)
    ods = ODSRanker(args.p, args.v, args.patches, use_prob=True)
    r_ods = ods.rank()
    print_header("Rank ODS2")
    print(ods)
    shibboleth = ShibbolethRanker(args.p, args.v, args.patches)
    r_shibboleth = shibboleth.rank()
    print_header("Rank Shibboleth")
    print(shibboleth)
    prism = PrismRanker(args.p, args.v, args.patches)
    r_patchsim = prism.rank()
    print_header("Rank Prism")
    print(prism)
  elif args.apcc == "shibboleth":
    shibboleth = ShibbolethRanker(args.p, args.v, args.patches)
    r_shibboleth = shibboleth.rank()
    print_header("Rank Shibboleth")
    print(shibboleth)
  
