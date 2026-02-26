---
name: bioconductor-intact
description: The INTACT package integrates transcriptome-wide association study z-scores with gene-level colocalization probabilities to identify biologically relevant genes for complex traits. Use when user asks to integrate TWAS and colocalization data, perform gene set enrichment analysis with INTACT-GSE, or jointly analyze multiple molecular gene products using Multi-INTACT.
homepage: https://bioconductor.org/packages/release/bioc/html/INTACT.html
---


# bioconductor-intact

## Overview
The `INTACT` package provides a probabilistic framework to integrate transcriptome-wide association study (TWAS) z-scores with gene-level colocalization probabilities (GLCP). This integration helps identify genes likely to be biologically relevant to a complex trait. The package also includes `INTACT-GSE` for gene set enrichment analysis and `Multi-INTACT` for jointly analyzing multiple molecular gene products (e.g., RNA and protein levels).

## Installation
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("INTACT")
library(INTACT)
```

## Core Workflows

### 1. Integrating TWAS and Colocalization
The primary function `intact()` combines TWAS z-scores and colocalization probabilities to produce posterior probabilities of causality.

```R
# Basic usage with z-scores
rst <- INTACT::intact(GLCP_vec = simdat$GLCP, 
                      z_vec = simdat$TWAS_z)

# Using different prior functions (linear, expit, step, hybrid)
rst_expit <- INTACT::intact(GLCP_vec = simdat$GLCP,
                            z_vec = simdat$TWAS_z,
                            prior_fun = INTACT::expit,
                            t = 0.05, D = 0.1)
```
- **Arguments**:
  - `GLCP_vec`: Vector of gene-level colocalization probabilities.
  - `z_vec`: Vector of TWAS scan z-scores.
  - `twas_BFs`: (Optional) Numeric vector of TWAS Bayes factors if z-scores are unavailable.
  - `prior_fun`: Function for the prior (default is `linear`).
  - `t`: Truncation threshold (default 0.05 for most; 0.5 for `step`).
  - `D`: Curvature shrinkage parameter for `expit` and `hybrid`.

### 2. Bayesian FDR Control
To identify significant genes while controlling the False Discovery Rate:
```R
# alpha is the target control level (e.g., 0.05)
fdr_results <- fdr_rst(rst, alpha = 0.05)
# Returns a data frame with 'posterior' and 'sig' (Boolean)
```

### 3. Gene Set Enrichment Analysis (INTACT-GSE)
Perform enrichment analysis using the integrated probabilistic evidence.

```R
# gene_data must have columns: "gene", "GLCP", and "TWAS_z"
# gene_sets must be a named list of character vectors (gene IDs)
gse_results <- INTACT::intactGSE(gene_data = simdat, 
                                 gene_sets = gene_set_list)
```
- **Standard Error Methods**: Specify via `se_method` using `NDS` (default), `profile_likelihood`, or `bootstrap`.
- **Output**: Returns a data frame with estimates, z-scores, p-values, and a `CONVERGED` flag.

### 4. Multi-INTACT (Multiple Gene Products)
Used when analyzing two molecular products (e.g., mRNA and Protein) simultaneously.

**Step A: Estimate Chi-square statistics from summary data**
If individual-level data is unavailable, approximate the multivariate Wald statistic:
```R
chi_sq <- INTACT::chisq_sumstat(z_vec = z_sumstats,
                                w = cbind(protwt_sumstats, exprwt_sumstats),
                                R = ld_sumstats)
```

**Step B: Run Multi-INTACT**
```R
# df must contain GLCP_1, GLCP_2, z_1, z_2, and chisq
multi_rst <- INTACT::multi_intact(df = multi_simdat)

# To see specific model posteriors (expression-only, protein-only, etc.)
multi_rst_full <- INTACT::multi_intact(df = multi_simdat, 
                                       return_model_posteriors = TRUE)
```
- **GPPC**: Gene Probability of Putative Causality (causal through at least one product).
- **GPRP**: Gene Product Relevance Probability (evidence for a specific product's direct effect).

## Tips and Interpretation
- **Convergence**: In `intactGSE`, if `CONVERGED == 0`, the data was likely uninformative for that specific gene set. This does not necessarily mean there is no enrichment.
- **Prior Selection**: The `step` prior is useful for binary-like thresholds, while `expit` and `hybrid` allow for more nuanced modeling of the relationship between colocalization and causality.
- **Data Alignment**: Ensure that vectors for `GLCP_vec` and `z_vec` (or rows in `gene_data`) are in the same gene order.

## Reference documentation
- [INTACT](./references/INTACT.md)