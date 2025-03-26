import os
import subprocess
import shutil
import hashlib
import re
import psutil
import numpy as np

from collections import Counter
from colorama import Fore, Style 

from pathlib import Path

from config import *

def check_valid_d4j(project, bug_id):
  with open("./d4j.benchmarks.lst", "r") as f:
    for line in f:
      if f"{project} {bug_id}" in line:
        return True
  return False

def set_java_version(version):
  java_home = f"/home/dowon/.jenv/versions/{version}"  # jenv 디렉토리 경로
  os.environ["JAVA_HOME"] = java_home
  os.environ["PATH"] = f"{java_home}/bin:" + os.environ["PATH"]
  print(f"{SUCCESS} Java version set to {version} manually.")
    
def copy_files_to_temp_dir(target_files, base_dir, temp_dir):
  for file in target_files:
    file_path = Path(base_dir) / file
    temp_file = Path(temp_dir) / file
    temp_dir_path = temp_file.parent 
    temp_dir_path.mkdir(parents=True, exist_ok=True)
    shutil.copy(file_path, temp_file)

def print_header(msg, color=""):
  print(f"{color}****** {msg} ******{Style.RESET_ALL}")

def print_file(file_path):
  with file_path.open("r") as file:
    print(file.read())

def format_java_code(input_file):
  ret = subprocess.run(
    f"{GOOGLE_JAVA_FORMAT} -i {input_file}", shell=True, text=True, capture_output=True 
  )
    
  if ret.returncode != 0:
    print(f"Error: Google Java Formatter failed with return code {ret.returncode}")
    print(f"Error message: {ret.stderr}")
    return ret.returncode

  return 0

def clean_java_code(code):
  # Remove comments
  code = re.sub(r'//.*$', '', code, flags=re.MULTILINE)
  code = re.sub(r'/\*.*?\*/', '', code, flags=re.DOTALL)
  
  # Remove unnecessary parentheses in simple expressions
  code = re.sub(r'\(\s*([a-zA-Z0-9._]+)\s*\)', r'\1', code)
  code = re.sub(r'\(\s*(\d+)\s*\)', r'\1', code)

  # Remove empty line
  return "\n".join(line for line in code.splitlines() if line.strip())
  

def java_format(file_path):
  # Step 1: Format the file using google-java formatter
  if format_java_code(file_path) != 0:
    return 1
    
  # Step 2: Remove comments and unnecessary parentheses
  try:
    with open(file_path, 'r') as file:
      code = file.read()
    
    cleaned_code = clean_java_code(code)
    
    # Step 3: Write cleaned code back to the original file
    with open(file_path, 'w') as file:
      file.write(cleaned_code)
  except Exception as e:
    return 2  # Return error on exception
  
  return 0  # Return success

def format_files_in_directory(directory):
  directory_path = Path(directory)
  errs = []
  
  for file_path in directory_path.rglob("*.java"):
    result = java_format(file_path)
    if result != 0:
      errs((result, file_path.name))
  
  return errs


def generate_unique_hash(text, output_directory):
  normalized_input = "".join(text.split())
  original_hash = hashlib.sha256(normalized_input.encode('utf-8')).hexdigest()[:8]
  unique_hash = original_hash
  counter = 0
  
  
  while True:
    hash_dir = Path(output_directory) / unique_hash
    hash_file = hash_dir / FORMATTED_PATCH
    
    if hash_file.exists():
      # If the hash_file already exists, check if the input text is equal
      with hash_file.open("r") as f:
        existing_text = "".join(f.read().split())
          
      if normalized_input == existing_text:
        return unique_hash

      # If the two contents are different (collision), create new hash
      counter += 1
      new_text = normalized_input + str(counter)
      unique_hash = hashlib.sha256(new_text.encode('utf-8')).hexdigest()[:8]
    else:
      break 
    
  return unique_hash

def terminate_child_processes(parent_pid: int):  
  try:
    parent = psutil.Process(parent_pid)
    for child in parent.children(recursive=True):
      print(f"{KILLING} Child PID: {child.pid}, CMD: {' '.join(child.cmdline())}")
      child.kill()
    print(f"{KILLING} Parent PID: {parent.pid}, CMD: {' '.join(parent.cmdline())}")
    parent.kill()
  except psutil.NoSuchProcess:
    print(f"{INFO} No process with PID {parent_pid} found.")
    

def detect_outliers(df, n, features):
    """
    데이터프레임 `df`에서 `features` 컬럼을 기준으로 이상치를 탐지하여,
    `n`개 이상의 이상치를 가진 데이터의 인덱스를 반환
    """
    outlier_indices = []

    # 각 feature에 대해 IQR 기반 이상치 탐지
    for col in features:
        Q1 = np.percentile(df[col], 25)
        Q3 = np.percentile(df[col], 75)
        IQR = Q3 - Q1
        outlier_step = 1.5 * IQR

        # 이상치 판별
        outlier_list_col = df[(df[col] < Q1 - outlier_step) | (df[col] > Q3 + outlier_step)].index
        outlier_indices.extend(outlier_list_col)

    # `n`개 이상의 feature에서 이상치로 판별된 행만 제거
    outlier_indices = Counter(outlier_indices)
    multiple_outliers = [k for k, v in outlier_indices.items() if v > n]

    return multiple_outliers
  
