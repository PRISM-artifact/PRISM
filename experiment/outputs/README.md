# Experiment Outputs (Zenodo Archive)

This directory is *not* included in the GitHub repository or Docker image due to its large size (~133 GB).  
To use the full set of experimental results, please download and extract the [Zenodo archive](https://doi.org/XXXX/YYYY) into this directory.  
This archive is primarily intended for those who wish to explore the raw outputs of each APCC tool.  
If your goal is **simply to regenerate the experimental results in our paper**, please refer to the CSV-formatted summary data we separately provide.

After extraction, this `outputs/` directory will contain the following structure:

## How to Use
1. Download the archive from the link above.
2. Extract it into this `outputs/` directory:
   ```
   tar -xvzf outputs.tar.gz
   ```
3. After extraction, this directory will contain subdirectories in the following format:
    ```
    outputs/
    ├── Chart1b/
    │   └── 642cd9b0/
    │       ├── correctness.txt
    │       ├── formatted.patch
    │       ├── patches/
    │       ├── patch_mthds.results
    │       ├── test_info.json
    │       ├── patchsim/
    │       ├── ods/
    │       ├── shibboleth/
    │       └── prism/
    ...
    ```

## Directory Structure and Contents

Each patch result is stored under a two-level directory path: `outputs/[project_id]/[patch_id]/`. Each resulting directory contains the following metadata:

- `correctness.txt`: Ground-truth label indicating whether the patch is correct or incorrect.
- `formatted.patch`: Syntactically normalized patch. This is used to represent all patches that are syntactically equivalent.
- `patches`: Contains all original benchmark patches that are syntactically equivalent to the current one.
- `patch_mthds.results`: Target method informations which are patched (it is used for running shibboleth).
- `test_info.json`: Test execution results for the patch using the provided developer test suite.

Each patch directory also includes outputs from the following APCC techniques:
### PatchSim
- `patchsim/result.json`: Main classification result.
- `patchsim/classify/result_{threshold}.txt`: Classification decisions at different similarity thresholds.

### ODS
- `ods/features_{project}_{bug_id}_FeatureAnalyzer.json`: Raw syntactic feature vectors.
- `ods/feature.json`: Subset of selected features used for classification.

### Shibboleth
- `shibboleth/score.csv`: Score vector produced by Shibboleth's static analysis and test impact assessment.

### PRISM
- `prism/trace-out/`: Dynamically collected execution traces from instrumented test runs. It is used for reinforcing PRISM's static analyzer.
- `prism/result.json`: Extracted semantic feature vectors for patch classification.
