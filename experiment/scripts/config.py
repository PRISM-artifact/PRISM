import os

from typing import List, Tuple
from pathlib import Path
from colorama import Fore, Style 

D4J_HOME = Path(os.getenv("D4J_HOME")).resolve()
D4J = D4J_HOME / "framework/bin/defects4j"
JAVA17 = "/usr/lib/jvm/java-17-openjdk-amd64/bin/java"

# Runtime options
MODES = {
    "compile": "Compile the project",
    "test": "Run tests",
    "patchsim": "Run PATCHSIM",
    "ods-extract": "Run ODS to extract syntactic features",
    "shibboleth-extract": "Run Shibboleth to extract features",
    "prism-capture": "Infer capture for prism analysis",
    "prism-trace": "Extract trace info for prism analysis",
    "prism-run": "Run prism and extract semantic featrues"
}

# Main directory and files
SCRIPT_DIR = Path(__file__).parent.resolve()
EXPERIMENT_DIR = (SCRIPT_DIR / "..").resolve()
LOG_DIR = SCRIPT_DIR / "logs"
BENCHMARKS_DIR = (SCRIPT_DIR / "../benchmarks").resolve()
TRAINING_DIR = BENCHMARKS_DIR / "rq2"
D4J_BUGS_DIR = (SCRIPT_DIR / "../d4j_projects").resolve()
D4J_BUGS_DIR.mkdir(parents=True, exist_ok=True)
TOOLS_HOME = (SCRIPT_DIR / "../tools").resolve()
RESULTS_DIR = (SCRIPT_DIR / "../outputs").resolve()

RESOURECES_DIR = EXPERIMENT_DIR / "resources"
RANDOOP_TEST_DIR = (RESOURECES_DIR / "randoop_tests").resolve()
DEV_PATCH_DIR = BENCHMARKS_DIR / "rq2/d4j_patches/Correct/d4j"

FORMATTED_PATCH = "formatted.patch"
PATCHES_DIR = "patches"
TEST_INFO = "test_info.json"
LABEL_INFO = "correctness.txt"

FORMATTER = TOOLS_HOME / "google-java-format-1.25.2-all-deps.jar"
GOOGLE_JAVA_FORMAT = f"{JAVA17} -jar {FORMATTER}"

# Learning Models
CSV_DIR = RESOURECES_DIR / "csv"
MODELS_DIR = RESOURECES_DIR / "models"
PRISM_MODEL_DIR = RESOURECES_DIR / "formula"

# PRISM 
INFER_HOME = (SCRIPT_DIR / "../../analyzer").resolve()
INFER = INFER_HOME / "infer/bin/infer"
COMPONENT_DIR = (INFER_HOME / "../components").resolve()
TRACER_JAR_PATH = COMPONENT_DIR / "tracer/target/sprint.tracer-1.0-SNAPSHOT-all.jar"
JUNIT_JAR_PATH = COMPONENT_DIR / "verifier/target/sprint.verifier-1.0.0.jar"
JUNIT_CORE_CLASS = "sprint.verifier.junit.JUnitRunner"
PRISM_BUDGET = 1200

# PatchSim
D4J_MOD_HOME = Path(os.getenv("D4J_MOD_HOME")).resolve()
D4J_MOD = D4J_MOD_HOME / "framework/bin/defects4j"
PATCHSIM_HOME = TOOLS_HOME / "PatchSim/tool/source"
BTRACE_HOME = PATCHSIM_HOME / "lib/btrace"
BTRACE_TEMPLATE = BTRACE_HOME / "Tracer_template.java"
BTRACE_JAR = BTRACE_HOME / "btrace-agent.jar"

# ODS
SOURCES_DIR = "sources"
COMING_HOME = TOOLS_HOME / "coming" 
COMING_JAR = COMING_HOME / "target/coming-0-SNAPSHOT-jar-with-dependencies.jar"
COMING_CORE_CLASS = "fr.inria.coming.main.ComingMain"

# Shibboleth 
SHIBBOLETH_JAR = TOOLS_HOME / "shibboleth-maven-plugin-1.0-SNAPSHOT.jar"
SHIBBOLETH_EXTRACTOR = "edu.iastate.shibboleth.cli.Extractor"
SHIBBOLETH_RANKER = "edu.iastate.shibboleth.cli.Ranker"
SHIBBOLETH_CLASSIFIER = "edu.iastate.shibboleth.cli.Classifier"

# Logging
INFO = "[INFO]"
ERROR = f"{Fore.RED}[ERROR]{Style.RESET_ALL}"
FAIL = f"{Fore.YELLOW}[FAIL]{Style.RESET_ALL}"
WARNING = f"{Fore.MAGENTA}[WARNING]{Style.RESET_ALL}"
SUCCESS = f"{Fore.CYAN}[SUCCESS]{Style.RESET_ALL}"
TIMEOUT = f"{Fore.LIGHTMAGENTA_EX}[TIMEOUT]{Style.RESET_ALL}"
PROGRESS = f"{Fore.LIGHTWHITE_EX}[PROGRESS]{Style.RESET_ALL}"
KILLING = f"{Fore.LIGHTRED_EX}[KILLING]{Style.RESET_ALL}"
