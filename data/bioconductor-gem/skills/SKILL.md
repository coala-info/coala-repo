---
name: bioconductor-gem
description: This tool performs fast Epigenome-Wide Association Studies to analyze associations between genetics, environmental factors, and DNA methylation. Use when user asks to perform methQTL analysis, identify environmental effects on methylation, or study GxE interactions.
homepage: https://bioconductor.org/packages/release/bioc/html/GEM.html
---


# bioconductor-gem

name: bioconductor-gem
description: Perform fast Epigenome-Wide Association Studies (EWAS) to analyze the interplay between Gene (G), Environment (E), and Methylation (M). Use this skill when analyzing methylation quantitative trait loci (methQTL), environmental effects on DNA methylation, or GxE interactions using matrix-based iterative correlation.

## Overview

The `GEM` package is a high-performance R toolset designed for large-scale association studies. It leverages matrix operations (extending the "Matrix eQTL" approach) to efficiently handle high-dimensional genomic and epigenomic data. It is particularly useful for identifying how genotype and environmental factors independently or synergistically influence DNA methylation levels.

## Core Functions

The package revolves around three primary modeling functions:

1.  `GEM_Emodel`: Studies the association between an environmental factor and methylation (M ~ E + covariates).
2.  `GEM_Gmodel`: Studies methylation quantitative trait loci (methQTL) (M ~ G + covariates).
3.  `GEM_GxEmodel`: Studies the interaction between genotype and environment on methylation (M ~ G x E + covariates).

## Workflow and Data Preparation

### 1. Data Format Requirements
All input files should be tab-delimited text files where:
*   **Rows**: Represent features (CpG probes, SNPs, or environmental measures).
*   **Columns**: Represent samples.
*   **Consistency**: Column order must be identical across all input files (methylation, genotype, and covariates).

### 2. Running the Models

#### Environmental Model (Emodel)
Use this to find CpGs associated with a specific environmental factor (e.g., gestational age, smoking).
```r
library(GEM)

# Define file paths
env_file <- "env.txt"
cov_file <- "cov.txt"
meth_file <- "methylation.txt"

# Run analysis
GEM_Emodel(env_file, cov_file, meth_file, 
           pvalueThreshold = 1.0, 
           result_file_name = "Emodel_results.txt", 
           qqplot_file_name = "Emodel_qq.jpg", 
           savePlot = TRUE)
```

#### Genotype Model (Gmodel)
Use this for methQTL analysis to find SNPs that influence methylation levels.
```r
snp_file <- "snp.txt"

GEM_Gmodel(snp_file, cov_file, meth_file, 
           pvalueThreshold = 1e-05, 
           result_file_name = "Gmodel_results.txt")
```

#### Interaction Model (GxEmodel)
Use this to identify GxE interactions. Note: The `gxe.txt` file should contain covariates with the environmental factor of interest as the **last row**.
```r
gxe_cov_file <- "gxe.txt" # Environmental factor must be the last row

GEM_GxEmodel(snp_file, gxe_cov_file, meth_file, 
             pvalueThreshold = 1.0, 
             result_file_name = "GxE_results.txt", 
             topKplot = 1)
```

## Tips for Success

*   **GUI Access**: For users preferring a graphical interface, call `GEM_GUI()` to launch the interactive tool for model selection and execution.
*   **Genotype Encoding**: Ensure SNPs are encoded numerically (e.g., 1, 2, 3 for AA, AB, BB).
*   **Memory Efficiency**: GEM is optimized for standard laptops; however, for very large datasets, ensure the input text files are properly formatted to avoid parsing errors.
*   **Visualizations**: The package can automatically generate QQ-plots for Emodels and interaction plots for GxEmodels to help validate significant hits.

## Reference documentation

- [GEM User Guide](./references/user_guide.md)