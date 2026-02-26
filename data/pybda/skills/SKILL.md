---
name: pybda
description: PyBDA processes massive biological datasets using Apache Spark and Snakemake to perform parallelized analytical workflows. Use when user asks to perform large-scale dimension reduction, run K-means clustering on big data, or execute distributed machine learning pipelines.
homepage: https://github.com/cbg-ethz/pybda
---


# pybda

## Overview

PyBDA (Python Big Data Analytics) is a specialized tool for processing massive biological data sets that exceed the capacity of standard single-node tools. It integrates Apache Spark's DataFrame API for parallelized computation and Snakemake for workflow orchestration. The tool builds a Directed Acyclic Graph (DAG) of tasks—such as PCA followed by K-means clustering—ensuring that complex pipelines are executed efficiently and can be resumed automatically if a specific step fails.

## Command Line Usage

The primary interface for PyBDA is the `run` command, which requires a configuration file and an execution mode.

### Basic Syntax
`pybda run [config_file] [mode]`

*   **config_file**: A text-based configuration file defining data paths, Spark parameters, and the analytical methods to be used.
*   **mode**: Typically `local` for single-machine testing or cluster-specific identifiers for distributed execution.

### Core Analytical Methods
PyBDA supports sequential execution of the following modules:
*   **Dimension Reduction**: Supports methods like PCA (Principal Component Analysis).
*   **Clustering**: Supports K-means with the ability to test multiple center counts (e.g., `n_centers: 50, 100, 150`) in a single run.
*   **Regression/Machine Learning**: Supports Random Forest models for classification or regression tasks.

## Configuration Best Practices

Since PyBDA relies on a configuration file to define the pipeline, ensure the following parameters are correctly specified:

*   **Data Input**: Provide paths for the main data file (`infile`), metadata columns (`meta`), and feature columns (`features`). Data should typically be in TSV format.
*   **Spark Optimization**: Use the `sparkparams` field to allocate resources. For large datasets, explicitly set `--driver-memory` and `--executor-memory` to prevent Out-of-Memory (OOM) errors.
*   **Pipeline Resumption**: Because PyBDA uses Snakemake, if a job fails, you can re-run the same command. The tool will detect existing output files and only execute the missing or failed components of the DAG.
*   **Debugging**: Set `debug: true` in the configuration to receive verbose output regarding the Spark session and Snakemake job scheduling.

## Expert Tips

*   **Feature Selection**: Use the `features` and `meta` TSV files to strictly define which columns Spark should treat as variables versus identifiers. This reduces the memory footprint during the PCA and Clustering phases.
*   **Scaling Centers**: When performing K-means, you can provide a comma-separated list of centers. PyBDA will parallelize the evaluation of these different cluster granularities.
*   **Spark Submit**: Ensure the `spark` parameter in your config points to the correct `spark-submit` executable in your environment or container.

## Reference documentation
- [PyBDA GitHub Repository](./references/github_com_cbg-ethz_pybda.md)
- [PyBDA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pybda_overview.md)