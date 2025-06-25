# Tools

This directory contains external tools and binaries used in the experiments.  
All tools are either open-sourced or derived from prior research artifacts.

## Included Components

- **google-java-format-1.25.2-all-deps.jar**  
  A formatter tool used to normalize all benchmark patches into a consistent code style.

- **PatchSim**  
  Cloned from [Ultimanecat/DefectRepairing](https://github.com/Ultimanecat/DefectRepairing).  
  Originally provided by the artifact for the paper *"Identifying Patch Correctness in Test-Based Program Repair"* (ICSE 2018).

- **coming**  
  Cloned from [SpoonLabs/coming](https://github.com/SpoonLabs/coming).  
  This version is compatible with the syntactic feature extraction used in the paper *"Automated Classification of Overfitting Patches With Statically Extracted Code Features"* (TSE 2022).  
  **Note:** This is not the latest version of `coming`. It is an earlier revision used in the ODS paper's original evaluation to ensure compatibility.

- **shibboleth-maven-plugin-1.0-SNAPSHOT.jar**  
  Provided by the [artifact](https://github.com/ali-ghanbari/shibboleth) for the paper *"Patch Correctness Assessment in Automated Program Repair Based on the Impact of Patches on Production and Test Code"* (ISSTA 2022).

---

Each component is for compatibility and reproducibility.  
Please refer to the respective original projects for license and further documentation.
