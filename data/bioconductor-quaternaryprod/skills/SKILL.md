---
name: bioconductor-quaternaryprod
description: This tool performs statistical analysis of signed causal graphs to evaluate how well biological networks predict gene expression changes using the Quaternary Dot Product Scoring Statistic. Use when user asks to compute p-values for regulators in biological networks, perform causal reasoning on gene expression data, or calculate the probability mass function for network scores.
homepage: https://bioconductor.org/packages/release/bioc/html/QuaternaryProd.html
---


# bioconductor-quaternaryprod

name: bioconductor-quaternaryprod
description: Statistical analysis of signed causal graphs for gene regulation using the Quaternary Dot Product Scoring Statistic. Use this skill to compute p-values for regulators in biological networks (like STRINGdb) based on gene expression data, handling ambiguities and signed relations (+, -, regulated, or no effect).

# bioconductor-quaternaryprod

## Overview

The `QuaternaryProd` package implements the Quaternary Dot Product Scoring Statistic, a goodness-of-fit test for evaluating how well a signed and directed causal network predicts observed gene expression changes. It improves upon ternary statistics by accounting for "ambiguous" or "regulated" (r) edges where the direction of regulation is unknown or conflicting.

## Core Workflow

### 1. Basic Statistic Calculations
If you have the counts for a specific regulator's predictions versus observations, use the following functions:

```r
library(QuaternaryProd)

# Define margins: q (predicted) and n (observed)
# p = positive (+), m = minus (-), z = zero (0), r = regulated/ambiguous
qp <- 20; qm <- 20; qz <- 20; qr <- 0
np <- 20; nm <- 20; nz <- 20

# Compute p-value for a specific score
pval <- QP_Pvalue(score = 5, q_p = qp, q_m = qm, q_z = qz, q_r = qr, n_p = np, n_m = nm, n_z = nz)

# Optimized function for significant p-values (returns -1 if not significant)
sig_pval <- QP_SigPvalue(score = 5, q_p = qp, q_m = qm, q_z = qz, q_r = qr, 
                         n_p = np, n_m = nm, n_z = nz, significance.level = 0.05)

# Get the full probability mass function
pmf <- QP_Pmf(q_p = qp, q_m = qm, q_z = qz, q_r = qr, n_p = np, n_m = nm, n_z = nz)
```

### 2. Running Causal Reasoning on Networks
The package provides a high-level function to test all regulators in a network (defaulting to STRINGdb Homo sapiens) against experimental data.

#### Prepare Gene Expression Data
Input data must be a data frame with three specific columns:
- `entrez`: Entrez IDs.
- `pvalue`: Significance of the gene expression change.
- `fc`: Fold change values.

```r
# Example cleanup
names(my_data) <- c("entrez", "pvalue", "fc")
my_data <- my_data[!duplicated(my_data$entrez), ]
```

#### Execute Analysis
Use `RunCRE_HSAStringDB` to perform the analysis. You can choose between "Quaternary", "Ternary", or "Enrichment" methods.

```r
results <- RunCRE_HSAStringDB(my_data, 
                              method = "Quaternary", 
                              fc.thresh = log2(1.3), 
                              pval.thresh = 0.05,
                              only.significant.pvalues = TRUE,
                              significance.level = 0.05)

# View top regulators
head(results[, c("symbol", "regulation", "pvalue")])
```

## Key Functions
- `QP_Pvalue`: Calculates the p-value for a given score.
- `QP_SigPvalue`: Faster p-value calculation when only interested in values below a threshold.
- `QP_Pmf`: Returns the entire probability mass function for the distribution.
- `QP_Support`: Returns the domain (possible scores) of the distribution.
- `RunCRE_HSAStringDB`: Automated pipeline for STRINGdb causal network analysis.

## Tips for Interpretation
- **Score Calculation**: The score $S = n_{pp} + n_{mm} + n_{rp} + n_{rm} - (n_{mp} + n_{pm})$. It rewards correct directionality and penalizes contradictions.
- **Ambiguities**: The "r" (regulated) category is used when a regulator is known to affect a target, but the sign is unknown or both (+) and (-) relations exist in the network.
- **Performance**: When processing large networks, always set `only.significant.pvalues = TRUE` to significantly reduce computation time.

## Reference documentation
- [QuaternaryProdVignette](./references/QuaternaryProdVignette.md)