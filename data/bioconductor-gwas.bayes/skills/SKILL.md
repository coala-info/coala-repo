---
name: bioconductor-gwas.bayes
description: This tool performs Bayesian iterative procedures for the statistical analysis of Gaussian genome-wide association study data. Use when user asks to identify causal SNPs, perform fine-mapping in related individuals, or control for population structure and kinship using BICOSS and GINA.
homepage: https://bioconductor.org/packages/release/bioc/html/GWAS.BAYES.html
---

# bioconductor-gwas.bayes

name: bioconductor-gwas.bayes
description: Statistical analysis of Gaussian GWAS data using Bayesian iterative procedures (BICOSS and GINA). Use this skill when performing genome-wide association studies to identify causal SNPs while controlling for population structure and kinship.

# bioconductor-gwas.bayes

## Overview
The `GWAS.BAYES` package provides advanced Bayesian methods for analyzing Gaussian Genome-Wide Association Study (GWAS) data. It features two primary iterative procedures—BICOSS (Bayesian Iterative Conditional Stochastic Search) and GINA (Genome-wide Iterative fine-mapping for Related Individuals)—designed to increase the recall of true causal SNPs and reduce false discoveries compared to standard Single Marker Analysis (SMA).

## Core Functions

### BICOSS
Performs a two-step Bayesian procedure using linear mixed models.
- **Usage**: `BICOSS(Y, SNPs, kinship, FDR_Nominal = 0.05, P3D = TRUE, maxiterations = 400, runs_til_stop = 40)`
- **Key Parameter**: `P3D = TRUE` (Population Parameters Previously Determined) significantly speeds up computation by using spectral decomposition techniques.

### GINA
A faster and often more accurate alternative to BICOSS for fine-mapping in related individuals.
- **Usage**: `GINA(Y, SNPs, kinship, FDR_Nominal = 0.05, maxiterations = 400, runs_til_stop = 40)`
- **Advantage**: Generally provides quicker analysis and better precision/recall for causal SNPs than BICOSS.

## Typical Workflow

1.  **Data Preparation**:
    - **Phenotypes (`Y`)**: A numeric vector or $n \times 1$ matrix. Only single phenotype analysis is supported.
    - **Genotypes (`SNPs`)**: A numeric matrix where rows are individuals and columns are SNPs.
    - **Kinship (`kinship`)**: An $n \times n$ positive semi-definite numeric matrix quantifying relationships between observations.

2.  **Model Execution**:
    ```r
    library(GWAS.BAYES)
    
    # Using GINA (Recommended for speed/accuracy)
    results <- GINA(Y = my_phenotypes, 
                    SNPs = my_snp_matrix, 
                    kinship = my_kinship_matrix, 
                    FDR_Nominal = 0.05)
    ```

3.  **Interpreting Results**:
    The functions return a named list. The primary output is `best_model`, which contains the **indices** of the columns in the `SNPs` matrix identified as significant.
    ```r
    # Access identified SNP indices
    significant_indices <- results$best_model
    
    # Get SNP names if available
    significant_snp_names <- colnames(my_snp_matrix)[significant_indices]
    ```

## Tips and Best Practices
- **Gaussian Assumption**: Both methods assume the errors of the fitted model follow a Gaussian distribution.
- **Computational Efficiency**: For large datasets, use `BICOSS` with `P3D = TRUE`. If performance is still a concern, prefer `GINA`.
- **Convergence**: If the algorithm does not find a stable model, consider increasing `maxiterations` (default 400) or `runs_til_stop` (default 40).
- **Memory**: Ensure the kinship matrix is numeric and positive semi-definite to avoid errors during spectral decomposition.

## Reference documentation
- [BICOSS in the GWAS.BAYES Package](./references/Vignette_BICOSS.md)
- [GINA in the GWAS.BAYES Package](./references/Vignette_GINA.md)