---
name: faststructure
description: fastStructure infers population structure and ancestry proportions from large-scale SNP genotype data using a variational Bayesian framework. Use when user asks to infer population clusters, perform cross-validation for model selection, or generate Distruct-style visualization plots.
homepage: https://github.com/rajanil/fastStructure
---


# faststructure

## Overview

fastStructure is a specialized tool for population genetics designed to infer population structure from large-scale SNP data. It serves as a computationally efficient alternative to the MCMC-based STRUCTURE software by utilizing a variational Bayesian inference framework. This skill enables the execution of the core inference algorithm, cross-validation for model selection, and the generation of visualization plots. It is particularly effective for datasets where traditional MCMC methods are too slow to converge.

## Core CLI Usage

The primary interface for the tool is `structure.py`. Note that the tool is natively written for Python 2.x environments.

### Basic Inference
To run the algorithm for a specific number of populations (K):
`python structure.py -K <int> --input=<prefix> --output=<prefix>`

*   **Input Prefix**: Do not include file extensions (e.g., use `my_data` if your files are `my_data.bed`, `my_data.bim`, and `my_data.fam`).
*   **Output Files**: Generates `<output>.<K>.meanQ` (admixture proportions) and `<output>.<K>.meanP` (allele frequencies).

### Model Selection and Cross-Validation
To determine the appropriate value of K, run the tool across a range of K values and use cross-validation:
`python structure.py -K <int> --input=<prefix> --output=<prefix> --cv=<folds>`

After running multiple K values, use the utility script to identify the best model:
`python chooseK.py --input=<output_prefix>`

### Visualization
To generate a Distruct-style plot of the results:
`python distruct.py -K <int> --input=<output_prefix> --output=<image_file>`

## Parameters and Best Practices

### Input Formats
*   **PLINK BED (Default)**: Requires `.bed`, `.bim`, and `.fam` files. Use `--format=bed`.
*   **Structure Format**: Use `--format=str`.

### Prior Selection
*   **Simple Prior**: Default. Suitable for most standard population structure analyses.
*   **Logistic Prior**: Use `--prior=logistic`. Recommended for detecting subtle population structure or when the simple prior fails to capture known geographic or phenotypic clusters.

### Convergence and Reproducibility
*   **Tolerance**: Adjust the convergence criterion with `--tol=<float>` (default is 10e-6). Smaller values increase accuracy but extend runtime.
*   **Seeds**: For reproducible results across runs, manually specify the random seed: `--seed=<int>`.

## Expert Tips
*   **Environment Setup**: fastStructure depends on the GNU Scientific Library (GSL). Ensure `LD_LIBRARY_PATH` includes the path to your GSL installation (typically `/usr/local/lib`) before execution to avoid shared object errors.
*   **Large Datasets**: When working with extremely large SNP sets, ensure the input files are in binary PLINK format (`.bed`) rather than text-based Structure format to significantly reduce memory overhead and parsing time.
*   **Interpreting chooseK**: The `chooseK.py` script provides two metrics: the K that maximizes marginal likelihood and the K that explains the structure in the data. Often, these values differ; the "structure-explaining" K is usually more parsimonious.

## Reference documentation
- [fastStructure Main Documentation](./references/github_com_rajanil_fastStructure.md)
- [Bioconda fastStructure Overview](./references/anaconda_org_channels_bioconda_packages_faststructure_overview.md)