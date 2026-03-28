---
name: mrpast
description: mrpast is a population genetics tool that infers demographic history from genomic data by leveraging Ancestral Recombination Graphs. Use when user asks to estimate population sizes, divergence times, or migration rates, simulate tree sequences, process coalescence counts, or perform maximum likelihood estimation for demographic parameters.
homepage: https://aprilweilab.github.io/
---


# mrpast

## Overview
mrpast is a population genetics tool used to infer demographic history from genomic data. By leveraging Ancestral Recombination Graphs (ARGs), it allows researchers to estimate parameters such as population sizes, divergence times, and migration rates. The tool follows a structured pipeline: simulating data to verify models, processing tree sequences to extract coalescence counts, and numerically solving for the most likely demographic parameters.

## Installation and Setup
mrpast requires Python 3.8+ and can be installed via standard package managers:
- **PyPI**: `pip install mrpast`
- **Bioconda**: `conda install -c bioconda mrpast`

For performance-critical tasks, building from source with native CPU optimization is recommended:
`MRPAST_ENABLE_NATIVE=1 pip install .`

## Core Workflow
The standard mrpast pipeline consists of three primary subcommands executed in sequence.

### 1. Simulation
Use `mrpast simulate` to generate tree sequences (.trees files) based on a demographic model. This is typically used to verify that a specific model can be recovered accurately before applying it to real data.
- **Basic Pattern**: `mrpast simulate --replicates [N] --seq-len [BP] --debug-demo [model.yaml] [prefix]`
- **Tip**: Use `--debug-demo` to print the demographic events to the console to ensure the model is interpreted correctly.

### 2. Processing
Use `mrpast process` to extract coalescence information from the tree sequences generated in the previous step or from inferred ARGs.
- **Basic Pattern**: `mrpast process --jobs [threads] --replicates [N] --bootstrap coalcounts [model.yaml] [prefix]`
- **Key Options**:
    - `--jobs`: Parallelize processing across multiple CPU cores.
    - `--bootstrap`: Generates bootstrap samples (default 100) to improve the stability of the likelihood function.
    - `--suffix`: Appends a unique identifier to output files to manage different trial runs.

### 3. Solving
Use `mrpast solve` to perform maximum likelihood estimation (MLE) to find the demographic parameters that best fit the processed data.
- **Basic Pattern**: `mrpast solve [processed_data_prefix]`

## Model Management
mrpast uses a specific YAML format for demographic models. If you are working with older models (pre-August 2025), you must convert them to the new format to ensure compatibility.
- **Conversion Command**: `mrpast init --from-old-mrpast old_model.yaml > new_model.yaml`

## Expert Tips
- **Discretization**: When processing, pay attention to time discretization settings. If the demographic events are very recent or very ancient, you may need to adjust the time windows to capture enough coalescence events.
- **Native Compilation**: If the `solve` step is slow, reinstalling with `MRPAST_ENABLE_NATIVE=1` can significantly speed up the underlying numerical solver.
- **Verification**: Always run the `simulate -> process -> solve` loop on a known model first to establish a baseline for parameter recovery accuracy before moving to empirical data.



## Subcommands

| Command | Description |
|---------|-------------|
| arginfer | Infer ARG trees from VCF files. |
| mrpast confidence | Solve for all bootstrapped samples instead of using GIM (theoretical). |
| mrpast init | Initialize a mrpast model. |
| mrpast model | Builds and manipulates demographic models. |
| mrpast process | Process MRPAST model and ARG files. |
| mrpast select | Selects the best model based on AIC from multiple solver outputs. |
| mrpast sim2vcf | Convert .trees files to VCF format. |
| mrpast simulate | Simulate demographic histories using mr.py. |
| mrpast_polarize | Polarize VCF file based on ancestral FASTA file. |
| mrpast_show | Show results from mrpast solver. |
| mrpast_simulate | Simulate demographic histories using mrpaste. |
| mrpast_solve | The solver input JSON files. The output filenames will be derived from the input filenames. |
| solve | Solve problems using the mrpast solver. |

## Reference documentation
- [github_com_aprilweilab_mrpast_blob_main_README.md](./references/github_com_aprilweilab_mrpast_blob_main_README.md)
- [anaconda_org_channels_bioconda_packages_mrpast_overview.md](./references/anaconda_org_channels_bioconda_packages_mrpast_overview.md)