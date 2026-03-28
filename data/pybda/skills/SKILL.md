---
name: pybda
description: PyBDA scales bioinformatics workflows and machine learning pipelines to high-performance computing environments using Apache Spark and Snakemake. Use when user asks to execute distributed dimensionality reduction, perform parallelized clustering on high-dimensional biological datasets, or run scalable machine learning regressions.
homepage: https://github.com/cbg-ethz/pybda
---

# pybda

## Overview

PyBDA (Python Big Data Analytics) is a specialized framework designed to scale bioinformatics workflows to high-performance computing (HPC) environments. By leveraging Apache Spark for parallel data processing and Snakemake for workflow orchestration, it allows researchers to execute complex machine learning pipelines—such as dimensionality reduction followed by clustering—across distributed nodes without manual parallelization. It is particularly effective for high-dimensional biological datasets where traditional single-node tools fail due to memory or processing constraints.

## Usage Instructions

### Core Command Line Interface

The primary entry point for the tool is the `run` command, which requires a configuration file and an execution mode.

```bash
pybda run <config_file> <mode>
```

*   **config_file**: Path to the file defining your data sources, methods, and parameters.
*   **mode**: Typically `local` for testing or a cluster-specific executor for HPC environments.

### Pipeline Configuration Parameters

Instead of manual scripting, pybda relies on specific keys defined in your configuration. Ensure the following parameters are correctly mapped:

*   **Data Input**: Use `infile` for the primary dataset (e.g., .tsv) and `predict` for the target dataset.
*   **Column Mapping**: Define `meta` for columns containing metadata and `features` for the actual data columns to be analyzed.
*   **Dimensionality Reduction**: Set `dimension_reduction` (e.g., `pca`) and specify `n_components`.
*   **Clustering**: Set `clustering` (e.g., `kmeans`) and provide a list of `n_centers` to test.
*   **Machine Learning**: Specify `regression` (e.g., `forest`), the `family` (e.g., `binomial`), and the `response` column.

### Spark Optimization

Since pybda runs on Apache Spark, resource allocation is critical for "Big Data" tasks. Use the `sparkparams` section to pass native Spark flags:

*   `--driver-memory`: Increase this if the master node is collecting large results.
*   `--executor-memory`: Increase this to handle high-dimensional feature matrices across worker nodes.

### Workflow Management

*   **Resuming Jobs**: Because pybda uses Snakemake to build a Directed Acyclic Graph (DAG), if a pipeline fails (e.g., due to a cluster timeout), simply re-run the same command. The tool will detect existing results and resume from the failed step.
*   **Debugging**: Enable the `debug` flag in your configuration to output verbose logs from the Spark driver, which is essential for identifying data partitioning issues or memory leaks.

## Expert Tips

*   **Feature Selection**: Always use the `features` column file to exclude non-numeric or irrelevant metadata before running PCA or K-Means to prevent Spark from attempting to vectorize string data.
*   **Scaling Centers**: When running K-Means, you can provide a comma-separated list of centers (e.g., 50, 100, 150). PyBDA will parallelize the computation of these different center counts.
*   **Environment**: For biological data, installing via Bioconda is the preferred method to ensure all C-dependencies for Spark and Snakemake are correctly linked.



## Subcommands

| Command | Description |
|---------|-------------|
| pybda clustering | Do a clustering fit from a CONFIG in a SPARK session. |
| pybda dimension-reduction | Computes a dimension reduction from a CONFIG in a SPARK session. |
| pybda regression | Fit a regression model from a CONFIG in a SPARK session. |
| pybda run | Execute all tasks defined in a CONFIG in a SPARK session. |
| pybda_sample | Subsample a data set down to a specified fraction from a CONFIG in a SPARK session. |

## Reference documentation

- [github_com_cbg-ethz_pybda_blob_master_README.md](./references/github_com_cbg-ethz_pybda_blob_master_README.md)
- [pybda_readthedocs_io_en_latest_usage.html.md](./references/pybda_readthedocs_io_en_latest_usage.html.md)