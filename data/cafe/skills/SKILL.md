---
name: cafe
description: CAFE (Computational Analysis of gene Family Evolution) is a statistical tool designed to analyze changes in gene family size across a phylogenetic tree.
homepage: https://hahnlab.github.io/CAFE/
---

# cafe

## Overview
CAFE (Computational Analysis of gene Family Evolution) is a statistical tool designed to analyze changes in gene family size across a phylogenetic tree. It uses a birth-death model to estimate the rates of gene gain and loss (lambda) and identifies gene families that have undergone significant expansion or contraction. This is essential for understanding the genomic basis of phenotypic evolution and adaptation.

## Core Commands and CLI Patterns
CAFE typically processes data through a sequence of commands. While newer versions (CAFE 5) are available via Bioconda, the command structure generally follows these functional patterns:

### Data Input and Preparation
- **Loading Trees**: Use the `tree` command with the `-i` flag to load a phylogenetic tree from a file.
- **Loading Family Data**: Use the `load` command to import gene family count data. CAFE supports `.csv` files for comma-separated values.
- **Filtering**: Use the `max_size` parameter within the `load` command to exclude gene families with sizes exceeding a specific threshold, preventing outliers from biasing the model.
- **Log Specification**: Use the `-l` parameter to define a log file path for capturing execution details.

### Analysis and Estimation
- **Lambda Estimation**: Use the `lambda` command to calculate the birth-death rates. 
- **Likelihood Scoring**: Use the `-score` parameter with the `lambda` command to log the calculated log-likelihood for a specific set of lambda values.
- **Error Modeling**: Use the `errormodel` command to account for assembly and annotation errors that might otherwise be mistaken for true gene gains or losses.

### Execution Control and Output
- **Reproducibility**: Use the `seed` command to set a specific random seed, ensuring that stochastic processes in the analysis can be replicated.
- **Reporting**: Use the `report` command to generate results. Adding the `json` flag allows for outputting data in JSON format, which is ideal for programmatic parsing.

## Expert Tips and Best Practices
- **Tree Requirements**: Ensure your input tree is ultrametric. CAFE 4.2 and later versions will issue a warning if the tree is not ultrametric to within 0.01% of the maximum root-to-leaf length.
- **Performance**: For large datasets, CAFE can utilize the Intel compiler and MKL library if available on the system to accelerate calculations.
- **Version Compatibility**: If using CAFE 4.2.1, ensure branch lengths are not identical to avoid potential memory leaks, and verify that all species in your family file are present in the tree file to prevent crashes.
- **Installation**: The most efficient way to deploy CAFE is via Bioconda using `conda install bioconda::cafe`.

## Reference documentation
- [CAFE Overview](./references/anaconda_org_channels_bioconda_packages_cafe_overview.md)
- [CAFE Manual and Tutorial](./references/hahnlab_github_io_CAFE_manual.html.md)
- [Downloading and Installing CAFE](./references/hahnlab_github_io_CAFE_download.html.md)