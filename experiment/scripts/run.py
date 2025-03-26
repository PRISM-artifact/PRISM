import argparse

from pathlib import Path

from config import *
from utils import *
from bug import *
from patch import *
from patchsim import *
from ods import *
from shibboleth import *
from prism import *

if __name__ == '__main__':    
  parser = argparse.ArgumentParser()
  parser.add_argument("--patch", type=Path, help="patch file path")
  parser.add_argument("--rerun", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--is_org", action=argparse.BooleanOptionalAction, default=False)
  parser.add_argument("--mode", choices=MODES.keys())
  args = parser.parse_args()
  
  project = args.patch.name.split("-")[0]
  bugid = int(args.patch.name.split("-")[1])

  if not check_valid_d4j(project, bugid):
    parser.error(f"Error: {project}-{bugid} is not a valid d4j benchmark")
  if not args.patch.is_file():
    parser.error(f"Error: The patch file '{args.patch}' does not exist")

  bug = Bug(project, bugid)
  print(bug)
  patch = Patch(bug, args.patch, is_org=args.is_org)
  print(patch)
  rerun=args.rerun

  if args.mode == "compile":
    ret = patch.bug.compile()
    print(ret)
  elif args.mode == "test":
    ret = patch.run_test(rerun)
    print(ret)
  elif args.mode == "patchsim":
    ret = PatchSim(patch).run(rerun)
    print(ret)
  elif args.mode == "ods-extract":
    ret = FeatureExtractor(patch).run(rerun)
    print(ret)
  elif args.mode == "shibboleth-extract":
    target = Shibboleth(patch)
    target.setup_input_files()
    ret = target.extract_score(rerun)
    print(ret)
  elif args.mode == "prism-capture":
    ret = PrismTarget(patch).capture(rerun)
    print(ret)
  elif args.mode == "prism-trace":
    ret = PrismTarget(patch).run_tracer(rerun)
    print(ret)
  elif args.mode == "prism-pre":
    org = Patch(bug, args.patch, is_org=True)
    ret1 = PrismTarget(org).pre_analyze()
    ret2 = PrismTarget(patch).pre_analyze()
    print(ret1, ret2)
  elif args.mode == "prism-run":
    org = Patch(bug, args.patch, is_org=True)
    p_org = PrismTarget(org)
    p_patch = PrismTarget(patch)
    ret = run_prism(p_org, p_patch, rerun)
    print(ret)
  else:
    # Fix erroneous bench
    ret_patchsim = PatchSim(patch).run(rerun)
    print("PatchSim :", ret_patchsim)
    ret_ods = FeatureExtractor(patch).run(rerun)
    print("ODS :", ret_ods)
    ret_capture = PrismTarget(patch).capture(rerun)
    print("Capture :", ret_capture)
    ret_trace = PrismTarget(patch).run_tracer(rerun)
    print("Tracer :", ret_trace)
    org = Patch(bug, args.patch, is_org=True)
    p_org = PrismTarget(org)
    p_patch = PrismTarget(patch)
    ret_prism = run_prism(p_org, p_patch, rerun)
    print("PRISM :", ret_prism)
    target = Shibboleth(patch)
    target.setup_input_files()
    ret_shb = target.extract_score()
    print("Shibboleth :", ret_shb)