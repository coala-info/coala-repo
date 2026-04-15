---
name: bioconductor-sva
description: This tool identifies and removes batch effects and latent sources of variation from high-throughput biological data. Use when user asks to remove batch effects with ComBat, estimate surrogate variables with SVA, or adjust RNA-seq count data for known artifacts.
homepage: https://bioconductor.org/packages/release/bioc/html/sva.html
---

# bioconductor-sva

name: bioconductor-sva
description: Use when Claude needs to remove batch effects and unwanted variation from high-throughput biological data (gene expression, RNA-seq, methylation) using the sva R package. This skill covers identifying surrogate variables (SVA), adjusting for known batches (ComBat), and handling RNA-seq count data (ComBat-seq).

# bioconductor-sva

## Overview
The `sva` package is designed to identify and remove artifacts in high-throughput experiments. It provides two primary approaches:
1.  **Surrogate Variable Analysis (SVA):** Estimates latent factors (surrogate variables) from the data when sources of variation are unknown or unmeasured.
2.  **ComBat:** Directly adjusts for known batch effects using an empirical Bayesian framework.

## Core Workflow: Surrogate Variable Analysis (SVA)
Use SVA when you suspect hidden batch effects or latent variables (e.g., lab conditions, technician effects) but do not have a specific batch ID.

1.  **Prepare Model Matrices:**
    *   `mod`: Full model including the variable of interest (e.g., cancer vs. control).
    *   `mod0`: Null model including only adjustment variables (or just an intercept `~1`).
2.  **Estimate Number of Surrogate Variables:**
    `n.sv <- num.sv(edata, mod, method="leek")`
3.  **Estimate Surrogate Variables:**
    `svobj <- sva(edata, mod, mod0, n.sv=n.sv)`
4.  **Downstream Analysis:**
    Include `svobj$sv` as covariates in your linear model (e.g., using `limma` or `f.pvalue`).

## Core Workflow: ComBat (Known Batches)
Use ComBat when you have a known batch variable (e.g., "Batch1", "Batch2").

1.  **Standard ComBat (Microarray/Normalized Data):**
    `combat_data <- ComBat(dat=edata, batch=batch, mod=mod)`
    *   `batch`: A vector identifying the batch for each sample.
    *   `mod`: Model matrix for the variable of interest (to protect its signal).
2.  **ComBat-seq (RNA-seq Counts):**
    Specifically for raw integer counts. It preserves the integer nature of the data.
    `adjusted_counts <- ComBat_seq(counts, batch=batch, group=group)`

## Specialized Functions
*   **svaseq:** A version of SVA specifically for sequencing count data, typically using a `log(counts + 1)` transformation internally.
*   **fsva (Frozen SVA):** Used in prediction settings. It allows you to estimate surrogate variables on a training set and apply them to a test set to avoid test-set bias.
*   **Supervised SVA:** If negative control probes (genes known not to be differentially expressed) are available, pass them to `sva` or `svaseq` using the `controls` argument to improve surrogate variable estimation.

## Tips for Success
*   **Data Format:** Input data should be a matrix with features (genes) in rows and samples in columns.
*   **Variance Filtering:** For very large datasets (>100,000 features), use the `vfilter` argument in `num.sv` and `sva` to speed up computation (e.g., `vfilter=2000`).
*   **Reference Batch:** In `ComBat`, you can use `ref.batch` to specify a high-quality batch that other batches should be adjusted toward.
*   **Mean-only Adjustment:** Use `mean.only=TRUE` in `ComBat` if you only want to correct the shift in means and not the variance (useful if biological variance differs between batches).

## Reference documentation
- [The SVA package for removing batch effects and other unwanted variation in high-throughput experiments](./references/sva.md)