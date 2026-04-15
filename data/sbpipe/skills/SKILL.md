---
name: sbpipe
description: sbpipe automates the execution and analysis of simulation and parameter estimation pipelines for mathematical models in systems biology. Use when user asks to run stochastic simulations, perform parameter estimation repeats, or execute modeling workflows on local multicores and clusters.
homepage: http://sbpipe.readthedocs.io
metadata:
  docker_image: "quay.io/biocontainers/sbpipe:4.21.0--py_0"
---

# sbpipe

## Overview

The `sbpipe` tool streamlines the workflow for mathematical modellers by providing a consistent framework for repeating simulation and estimation sequences. It bridges the gap between model definition and robust data analysis by automating the execution of models and the subsequent extraction of statistical information. This skill provides guidance on configuring and executing these pipelines to ensure reproducible results in systems biology projects.

## Core Functionality

- **Model Support**: Native support for COPASI (.cps) and Python models. Other languages can be integrated using Python as a wrapper.
- **Simulation Pipelines**: Automate multiple runs of a model to explore stochastic behavior or parameter sensitivity.
- **Parameter Estimation**: Repeat estimation tasks to assess the global minimum and parameter identifiability.
- **Resource Management**: Built-in support for local multicore execution and cluster schedulers (SGE, LSF).

## CLI Usage and Best Practices

### Installation
The recommended way to install `sbpipe` is via bioconda:
```bash
conda install -c bioconda sbpipe
```

### Common Workflow Patterns
1. **Initialization**: Ensure your model file (e.g., a COPASI `.cps` file) is configured with the necessary tasks (Time Course or Parameter Estimation) before running through `sbpipe`.
2. **Configuration**: `sbpipe` typically relies on configuration files to define the number of repeats, the simulator to use, and the output directory.
3. **Execution**: Run the pipeline using the `sbpipe` command followed by the specific pipeline type and configuration file.
4. **Analysis**: Use the companion R package `sbpiper` for advanced data analysis and visualization of the generated results.

### Expert Tips
- **Cluster Execution**: When moving from a local machine to a cluster, update the configuration to specify the scheduler (SGE or LSF) to take advantage of parallelization without changing the model logic.
- **Snakemake Integration**: For complex workflows involving multiple preprocessing or post-processing steps, use `sbpipe_snake` to wrap `sbpipe` calls within a Snakemake pipeline.
- **Python Wrappers**: If using a non-native model, create a simple Python script that accepts parameters as input and writes results to a CSV file; `sbpipe` can then treat this script as a standard model component.

## Reference documentation

- [SBpipe Documentation Overview](./references/sbpipe_readthedocs_io_en_latest.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_sbpipe_overview.md)