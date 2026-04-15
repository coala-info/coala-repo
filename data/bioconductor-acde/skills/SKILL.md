---
name: bioconductor-acde
description: This tool performs multivariate identification of differentially expressed genes in microarray or RNA-Seq data using artificial components and False Discovery Rate estimation. Use when user asks to identify up-regulated and down-regulated genes, perform single time point analysis, or conduct time course differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/acde.html
---

# bioconductor-acde

name: bioconductor-acde
description: Multivariate identification of differentially expressed genes using artificial components and False Discovery Rate (FDR) estimation. Use this skill when analyzing microarray or RNA-Seq data to identify up-regulated and down-regulated genes, particularly when "Biological Scenario 2" (only a small proportion of genes are active) is assumed. Supports single time point and time course analysis.

## Overview

The `acde` package provides a multivariate inferential method for detecting differentially expressed genes. It uses "artificial components" (similar to Principal Components) that have exact interpretations: $\psi_1$ captures overall expression levels (size), and $\psi_2$ captures differential expression between conditions. The package is specifically designed to avoid the pitfalls of row-standardization, which can mistakenly identify non-expressed genes as differentially expressed.

## Typical Workflow

### 1. Data Preparation
Data should be a matrix $Z$ (genes in rows, replicates in columns). A design vector is required where `1` indicates treatment/condition and `2` indicates control.

```R
library(acde)
# Example data: 1000 genes, 10 replicates (5 treatment, 5 control)
data_matrix <- matrix(rnorm(10000), ncol=10)
design_vec <- c(rep(1, 5), rep(2, 5))
```

### 2. Single Time Point Analysis (`stp`)
Use `stp` to identify differentially expressed genes at a specific moment.

```R
# Basic analysis
res_stp <- stp(data_matrix, design_vec, alpha = 0.05)

# View summary results
print(res_stp)

# Plot FDR curve and Artificial Components plane
plot(res_stp)
```

**Key Parameters:**
- `alpha`: Desired FDR level (default 0.05).
- `BCa`: Set to `TRUE` to compute a bias-corrected and accelerated upper confidence bound for the FDR (computationally intensive).
- `B`: Number of bootstrap/permutation iterations (default 100).

### 3. Time Course Analysis (`tc`)
Use `tc` when data is collected across multiple time points. It requires a list of matrices and a list of design vectors.

```R
# data_list: list(tp1 = matrix1, tp2 = matrix2, ...)
# design_list: list(tp1 = vec1, tp2 = vec2, ...)
res_tc <- tc(data_list, design_list)

# Summary shows inertia ratios and group conformations
summary(res_tc)
plot(res_tc)
```

**Analysis Approaches:**
- **Active vs. Supplementary:** Identifies the "active" time point (highest inertia ratio) and projects other time points onto that basis.
- **Groups Conformation:** Performs independent `stp` analysis at every time point.

### 4. Interpreting Results
- **Artificial Plane:** In the `plot(res_stp)` output, the x-axis ($\psi_1$) represents overall expression. The y-axis ($\psi_2$) represents differential expression.
- **Up-regulated:** Genes with large positive $\psi_2$ (higher in treatment).
- **Down-regulated:** Genes with large negative $\psi_2$ (higher in control).
- **Inertia Ratio:** Indicates the amount of information about differential expression captured. A higher ratio suggests a more relevant time point for analysis.

## Advanced Usage

### Assessing Biological Scenario 2
Before full analysis, use `ac` to check if the data fits the package's assumptions (most genes near origin, few far right).

```R
components <- ac(data_matrix, design_vec)
plot(components)
```

### Parallel Computation
Since `stp` and `tc` use the `boot` package, you can pass parallel arguments:
```R
res <- stp(data_matrix, design_vec, parallel = "multicore", ncpus = 4)
```

## Reference documentation

- [Identification of Differentially Expressed Genes with Artificial Components – the acde Package](./references/acde.md)