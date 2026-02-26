---
name: bioconductor-intomics
description: bioconductor-intomics infers regulatory networks by integrating multi-omics data and biological prior knowledge using Bayesian networks and MCMC. Use when user asks to integrate gene expression, DNA methylation, and copy number variation data, infer regulatory relationships, or estimate empirical biological knowledge.
homepage: https://bioconductor.org/packages/3.17/bioc/html/IntOMICS.html
---


# bioconductor-intomics

name: bioconductor-intomics
description: Infer regulatory networks by integrating multi-omics data (Gene Expression, DNA Methylation, Copy Number Variation) and biological prior knowledge using Bayesian networks and MCMC. Use this skill when analyzing multi-modal biological datasets to identify regulatory relationships and estimate empirical biological knowledge.

## Overview

IntOMICS is a Bayesian network framework designed to integrate multiple omics modalities—specifically Gene Expression (GE), DNA Methylation (METH), and Copy Number Variation (CNV). It uses an automatically tuned MCMC algorithm to estimate model parameters and "empirical biological knowledge" (empB), which complements existing biological priors. The resulting networks provide insights into the flow of genetic information, where nodes represent different molecular features and edges represent regulatory influences.

## Typical Workflow

### 1. Data Preparation
Input data should be organized into a `MultiAssayExperiment` or a named `list`.
*   **GE**: Gene expression matrix (samples x features).
*   **CNV**: Copy number variation matrix (optional).
*   **METH**: DNA methylation beta-values matrix (optional).
*   **PK**: Data frame of known interactions (columns: `src_entrez`, `dest_entrez`, `edge_type` ["present" or "missing"]).
*   **TFtargs**: Logical matrix of Transcription Factor (columns) and target (rows) interactions.
*   **layers_def**: Data frame defining the hierarchy (GE is typically layer 2, CNV/METH are layer 1).

### 2. Preprocessing with `omics_module`
This function filters methylation probes (if `lm_METH = TRUE`), defines the biological prior matrix, and computes BGe scores for parent set configurations.

```r
OMICS_mod_res <- omics_module(
  omics = omics_data,
  PK = PK_df,
  layers_def = layers_def_df,
  TFtargs = TFtarg_mat,
  annot = meth_annotation_list,
  gene_annot = gene_id_conversion_table,
  lm_METH = TRUE,
  r_squared_thres = 0.3
)
```

### 3. MCMC Simulation with `bn_module`
Infers the network structure. Note: This is computationally intensive. For production, use higher `burn_in` and `thin` values.

```r
# Recommended for production: burn_in = 100000, thin = 500
BN_mod_res <- bn_module(
  burn_in = 5000, 
  thin = 50,
  OMICS_mod_res = OMICS_mod_res,
  minseglen = 50
)
```

### 4. Diagnostics and Edge Weighting
Evaluate MCMC convergence and extract edge frequencies.

```r
# Check convergence
trace_plots(mcmc_res = BN_mod_res, burn_in = 1000, thin = 50)

# Calculate weights
res_weighted <- edge_weights(
  mcmc_res = BN_mod_res,
  burn_in = 1000,
  thin = 50,
  edge_freq_thres = 0.5 # Filter for reliable edges
)
```

### 5. Visualization
Generate the final network structure.

```r
weighted_net_res <- weighted_net(
  cpdag_weights = res_weighted,
  gene_annot = gene_annot,
  PK = PK,
  OMICS_mod_res = OMICS_mod_res,
  gene_ID = "gene_symbol",
  B_prior_mat_weighted = B_prior_mat_weighted(BN_mod_res)
)

ggraph_weighted_net(weighted_net_res)
```

## Key Functions and Parameters

*   `omics_module()`: Essential first step. Use `woPKGE_belief` (default 0.5) to set the strength of belief for interactions without prior knowledge.
*   `bn_module()`: The core MCMC engine. Returns an object containing estimated beta (hyperparameter), empirical prior matrix, and CPDAGs.
*   `edge_weights()`: Converts MCMC samples into edge frequencies. Use `edge_freq_thres` to control network sparsity.
*   `emp_b_heatmap()`: Visualizes the difference between the initial biological prior and the empirical knowledge learned from the data.
*   `dens_edge_weights()`: Plots the distribution of edge weights to help determine an appropriate threshold.

## Tips for Success

1.  **Sample Alignment**: Ensure samples are in the exact same order across all input matrices (GE, CNV, METH).
2.  **Prior Knowledge**: While IntOMICS can run without it, providing a `PK` data frame significantly improves the biological relevance of the inferred network.
3.  **MCMC Convergence**: Always inspect `trace_plots`. If the beta values or edge frequencies are not stable, increase the `burn_in` and `thin` parameters.
4.  **Node Naming**: In visualizations, GE nodes are typically uppercase, CNV nodes are lowercase, and METH nodes use probe IDs.

## Reference documentation
- [IntOMICS tutorial](./references/IntOMICS_vignette.md)