---
name: bioconductor-dresscheck
description: This tool provides datasets and code to explore and reproduce the Dressman et al. ovarian cancer study and its subsequent reproducibility critique. Use when user asks to access corrected RMA expression data, analyze batch effects by array run date, or reconstruct survival curves based on pathway activation scores.
homepage: https://bioconductor.org/packages/release/data/experiment/html/dressCheck.html
---

# bioconductor-dresscheck

name: bioconductor-dresscheck
description: A skill for using the Bioconductor package dressCheck to explore and reproduce the Dressman et al. (2007) ovarian cancer study. Use this skill when you need to access the "corrected RMA" expression data, survival data, and batch information used in the Baggerly-Dressman reproducibility dispute.

# bioconductor-dresscheck

## Overview

The `dressCheck` package is a Bioconductor experimental data package containing datasets and code for reproducing (and critiquing) the analysis of pathway activation and platinum responsiveness in ovarian cancer originally published by Dressman et al. (JCO 2007). It specifically addresses issues of sample mislabeling and batch effects identified by Baggerly, Coombes, and Neeley (BCN).

## Loading the Data

The package provides several key datasets, primarily focused on the 119 samples from the original study.

```r
library(dressCheck)

# Load the main expression and phenotype data
data(ovca) 
# This typically loads an ExpressionSet or similar structure 
# containing the "corrected RMA" values.

# Accessing sample metadata (including batch/run dates)
pData(ovca)
```

## Key Workflows

### 1. Identifying Batch Effects
The package allows users to examine how gene expression (e.g., RPS11) and survival distributions vary by array run date.

```r
# Example: Checking expression of a specific gene against run dates
# Run dates are extracted from CEL files and included in the metadata
boxplot(exprs(ovca)["RPS11",] ~ pData(ovca)$date)
```

### 2. Survival Analysis by Pathway Activation
The package is used to reconstruct Kaplan-Meier survival curves based on pathway activation scores (like Src or E2F3).

```r
# Reconstructing Figure 1(c) - Src pathway in platinum non-responders
# Note: Scoring coefficients are derived via SVD on Bild (2006) cell-line data
# non_responders <- ovca[, ovca$resp == "NR"]
# plot(survfit(Surv(time, status) ~ src_score > median(src_score), data = pData(non_responders)))
```

### 3. Adjusting for Confounding
The package supports modeling survival while adjusting for date-related confounding using quadratic models of run dates.

```r
# Example of a Cox model adjusted for batch (run date)
# coxph(Surv(time, status) ~ pathway_score + poly(run_date, 2), data = pData(ovca))
```

## Usage Tips
- **Sample Labeling**: Be aware that the "corrected RMA" archive originally had incorrect ID labeling for most samples. `dressCheck` uses the relabeled version established by BCN.
- **Pathway Scores**: The package does not include the original scoring coefficients (as they weren't published), but it provides the data to derive them using Singular Value Decomposition (SVD) on the Bild (2006) cell-line data.
- **Reproducibility**: Use the `short.Rnw` (or `short.R`) script found within the package installation directory to see the exact 11 lines of code used to generate the validation figures.

## Reference documentation

- [Reproducibility of Dressman JCO 2007](./references/short.md)