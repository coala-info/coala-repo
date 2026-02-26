---
name: amide
description: AMIDES is a machine learning framework that detects malicious events and rule evasions by training classifiers on historical benign data and known SIEM rules. Use when user asks to detect attacks that evade static rules, identify malicious variants, or perform rule attribution and ranking.
homepage: https://github.com/fkie-cad/amides
---


# amide

## Overview

AMIDES (Adaptive Misuse Detection System) is a machine learning framework designed to enhance traditional SIEM systems by detecting attacks that evade static rule matching. It functions by training binary classifiers on historical benign events and known SIEM rules to identify malicious variants. The system consists of two primary components: a misuse classification module that identifies malicious events and a rule attribution module that ranks which SIEM rules the event was likely designed to bypass.

## Environment Setup

AMIDES is optimized for Linux environments with Python 3.10+ and Docker.

### Docker Quickstart (Recommended)
Use the provided automation scripts to build and enter the environment without manual dependency management.

1. Build the image: `./build_image.sh`
2. Start the environment: `./start_env.sh`
3. Run the full suite of paper experiments: `./run_experiments.sh`

### Local Installation
If running outside of Docker, ensure you have at least 8GB of RAM and 2GB of disk space.

1. Install the package: `pip install .`
2. Install `jq` for processing JSON experiment data.
3. Ensure Python 3.10 is the active interpreter.

## Working with Datasets

AMIDES utilizes specific data structures for training and validation located in the `data/` directory.

### Benign Data (SOCBED)
Located in `data/socbed/`, these datasets are used to establish a baseline of normal activity:
- `windows/process_creation`: CommandLine fields from Sysmon.
- `proxy_web`: Full URLs from web proxy logs.
- `windows/registry`: TargetObject and Details from registry events.
- `windows/powershell`: ScriptBlockText from PowerShell operational logs.

### Malicious Data (Sigma)
Located in `data/sigma/`, these include converted Sigma rules and event samples:
- **Matches**: Events that trigger standard rules (filename pattern: `_Match_`).
- **Evasions**: Adapted commands that achieve the same goal but bypass the rule (filename pattern: `_Evasion_`).

## Execution and Evaluation

### Running Experiments
The primary entry point for validating the system is the `run_experiments.sh` script. This script automates:
1. Feature extraction from benign and malicious datasets.
2. Training the misuse classification and rule attribution models.
3. Validating performance against evasion samples.

### Analyzing Results
After running experiments, navigate to `amides/plots` to find visualizations and performance metrics. These assets help assess the model's classification accuracy and the effectiveness of the rule attribution ranking.

## Maintenance and Cleanup

To manage the Docker environment and local artifacts:
- Remove experiment containers: `./remove_containers.sh`
- Remove the AMIDES Docker image: `./remove_image.sh`
- Clean up temporary experiment data: `./cleanup.sh`

## Reference documentation
- [AMIDES Main Repository](./references/github_com_fkie-cad_amides.md)
- [AMIDES Source Structure](./references/github_com_fkie-cad_amides_tree_main_amides.md)