import time
import json
import subprocess

from config import *
from utils import *

class Bug:
  project: str
  bug_id: int
  project_dir: Path
  source_dir: Path
  test_dir: Path
  randoop_path: Path
  ant_version: str
  encoding: str
  failing_tests: List[str]
  class_paths : List[Path]

  def __init__(self, project, bug_id, set_ant=True):
    self.project = project
    self.bug_id = bug_id
    self.project_dir = D4J_BUGS_DIR / f"{project}{bug_id}b"
    # self.checkout()
    # self.load_build_info()
    # self.set_project_config(set_ant)
    # self.setup_class_paths()
    # Randoop test path: invoked only when it requried
    randoop_dir = RANDOOP_TEST_DIR / self.project / "randoop" / str(self.bug_id)
    randoop_path = randoop_dir / f"{self.project}-{self.bug_id}b-randoop.{self.bug_id}.tar.bz2"
    self.randoop_path = randoop_path
  
  def set_project_config(self, set_ant):
    if self.project == "Lang":
      self.ant_version = "1.8.4"
      self.encoding = "ISO-8859-1"
    else:
      self.ant_version = "1.10.12"
      self.encoding = "utf-8"

    # set proper ant version
    if set_ant:
      d4j_ant_path = D4J_HOME / "major/bin/ant"
      expected_ant_path = D4J_HOME / f"major/bin/ant.{self.ant_version}"
      
      ret = subprocess.run(f"{d4j_ant_path} -version", shell=True, stdout=subprocess.PIPE, text=True, check=True)
      if self.ant_version not in ret.stdout:
        print(f"[INFO] Switching Ant version to {self.ant_version} for project {self.project}")
      
        # Replace with the correct Ant version if necessary
        if d4j_ant_path.exists():
          d4j_ant_path.unlink()
        subprocess.run(f"cp -P {expected_ant_path} {d4j_ant_path}", shell=True)
        print(f"[INFO] Updated Ant to version {self.ant_version}")
  
  def load_build_info(self):
    with open(f"{self.project_dir}/defects4j.build.properties",'r') as f:
      for line in f.readlines():
        if line.startswith("d4j.dir.src.classes"):
          self.source_dir = self.project_dir / line.split("=")[1].strip()
        elif line.startswith("d4j.dir.src.tests"):
          self.test_dir = self.project_dir / line.split("=")[1].strip()
        elif line.startswith("d4j.tests.trigger"): 
          self.failing_tests = [test.strip() for test in line.split("=")[1].split(",")]
    
  def setup_class_paths(self):
    # Add source and test classes
    export_out = subprocess.run(f'{D4J} export -p cp.test -w {self.project_dir}', shell=True, capture_output=True, text=True, check=True)
    cp_exported = [Path(cp).resolve() for cp in export_out.stdout.split(":") if cp.strip()]
    
    # Add common dependencies specified by D4J
    common_lib_dir = D4J_HOME / f"framework/projects/{self.project}/lib"
    common_libs = [jar.absolute() for jar in common_lib_dir.rglob("*.jar")]
    common_libs += [
      D4J_HOME / "framework/projects/lib/junit-4.11.jar",
      D4J_HOME / "framework/projects/lib/cobertura-2.0.3.jar"
    ]
    if self.project == 'Mockito':
      project_lib_dir = self.project_dir / "lib"
      common_libs += [
        jar.resolve() for jar in project_lib_dir.rglob("*.jar")
      ]
    self.class_paths = list(set(cp_exported + common_libs))

  def __str__(self):
    return (
      f"bug_id: {self.project}-{self.bug_id}\n"
      f"project_dir: {self.project_dir}\n"
      # f"class_path: {':'.join(self.class_paths)}"
    )
    
  def checkout(self):
    d4j_ret = subprocess.run(f"{D4J} checkout -p {self.project} -v {self.bug_id}b -w {self.project_dir}",  capture_output=True, shell=True)
    git_ret = subprocess.run(f"git checkout -- .", shell=True, cwd=self.project_dir)
    if d4j_ret.returncode != 0 or git_ret.returncode != 0:
      raise RuntimeError(f"Failed to checkout in directory: {self.project_dir}")
    else:
      return True

  def setup_randoop_test(self):
    # Run randoop if the randoop test does not exists
    if not self.randoop_path.exists():
      try:
        print(f"{PROGRESS} Generating Randoop tests for {self.project}-{self.bug_id}")
        randoop_cmd = (
          f"{D4J_MOD_HOME}/framework/bin/run_randoop.pl "
          f"-p {self.project} -v {self.bug_id}b -n {self.bug_id} -o {RANDOOP_TEST_DIR} -b 420"
        )
        proc = subprocess.Popen(randoop_cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        proc.wait(timeout=600)
      except subprocess.TimeoutExpired:
        print(f"{TIMEOUT} Fail to run randoop for {self.project}-{self.bug_id}")
        terminate_child_processes(proc.pid)

  def compile(self):
    ret = subprocess.run(f"{D4J} compile", shell=True, cwd=self.project_dir, capture_output=True, text=True)
    if ret.returncode == 0:
      return True, ""
    else:
      return False, str(ret.stdout) + "\n" + str(ret.stderr)
    
  def run_test(self, timeout=3600):
    try:
      ret = subprocess.run(f"{D4J} test", shell=True, cwd=self.project_dir, capture_output=True, text=True, timeout=timeout)
      if "Failing tests: 0" in ret.stdout:
        return True, ""
      else:
        return False, str(ret.stdout) + "\n" + str(ret.stderr)
    except subprocess.TimeoutExpired as e:
      return False, str(e)
  
  def export_packages(self):
    # (Depricated) This code is not used for new tracer
    project_dir = self.project_dir  

    if (project_dir / "target" / "classes").exists():
      target_pattern = r".*/target/[^/]+/"
    elif (project_dir / "build" / "classes" / "main").exists():
      target_pattern = r".*/build/classes/[^/]+/"
    elif (project_dir / "build" / "classes").exists():
      target_pattern = r".*/build/[^/]+/"
    elif (project_dir / "build").exists() and (project_dir / "build-tests").exists():
      target_pattern = r".*/build[^/]*/"
    else:
      target_pattern = r".*/target/.*classes/"

    packages = []
    for class_path in project_dir.rglob("*.class"):
      class_path_str = str(class_path)  
      if re.search(target_pattern, class_path_str):
        pkg_str = re.sub(target_pattern, "", class_path_str)
        pkg_str = pkg_str.replace("/", ".").rstrip(".class")
        pkg_str = ".".join(pkg_str.split(".")[:-1])
        packages.append(pkg_str)

    packages = set(packages)

    with open(project_dir / "packages.lst", "w") as f:
      f.write("\n".join(packages))