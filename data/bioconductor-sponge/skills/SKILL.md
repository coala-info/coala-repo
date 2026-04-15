---
name: bioconductor-sponge
description: SPONGE is a bioinformatics framework for inferring genome-wide competing endogenous RNA interaction networks by calculating sensitivity correlation between gene pairs. Use when user asks to infer ceRNA networks, filter gene-miRNA interactions, compute multiple miRNA sensitivity correlation, or calculate sample-specific spongEffects enrichment scores.
homepage: https://bioconductor.org/packages/release/bioc/html/SPONGE.html
---

# bioconductor-sponge

## Overview

SPONGE is a bioinformatics framework designed to solve the computationally intensive task of inferring genome-wide ceRNA interaction networks. It addresses the combinatorial effect of multiple miRNAs on gene pairs by calculating a "sensitivity correlation" (mscor), which represents the difference between gene-gene correlation and partial correlation given shared miRNA regulators. The package also includes `spongEffects`, which allows for the calculation of sample-specific enrichment scores for ceRNA modules, enabling downstream machine learning tasks like tumor subtype classification even in datasets lacking miRNA expression.

## Core Workflow

### 1. Data Preparation
SPONGE requires paired gene and miRNA expression matrices where columns are features and rows are samples.
```r
library(SPONGE)
# gene_expr and mir_expr should have matching row (sample) names
```

### 2. Filtering Gene-miRNA Interactions
Identify putative miRNA regulators for each gene using regularized regression (elastic net).
```r
# mir_predicted_targets is an optional matrix of prior knowledge (e.g., TargetScan)
genes_miRNA_candidates <- sponge_gene_miRNA_interaction_filter(
    gene_expr = gene_expr,
    mir_expr = mir_expr,
    mir_predicted_targets = targetscan_symbol)
```

### 3. Computing ceRNA Interactions
Calculate the multiple miRNA sensitivity correlation (mscor) for gene pairs sharing regulators.
```r
ceRNA_interactions <- sponge(
    gene_expr = gene_expr,
    mir_expr = mir_expr,
    mir_interactions = genes_miRNA_candidates)
```

### 4. Null Model and Significance
Build a null model to account for gene-gene correlation and sample size, then compute empirical p-values.
```r
# Build null model (use 1e6 for production)
mscor_null_model <- sponge_build_null_model(
    number_of_datasets = 100, 
    number_of_samples = nrow(gene_expr))

# Compute p-values
ceRNA_interactions_sign <- sponge_compute_p_values(
    sponge_result = ceRNA_interactions,
    null_model = mscor_null_model)
```

### 5. Network Analysis
Extract significant interactions and analyze node centralities.
```r
# Filter by FDR
ceRNA_net <- ceRNA_interactions_sign[ceRNA_interactions_sign$p.adj < 0.01, ]

# Compute centralities (degree, eigenvector, betweenness)
centralities <- sponge_node_centralities(ceRNA_net)

# Visualize
sponge_plot_network(ceRNA_net, genes_miRNA_candidates)
```

## spongEffects Workflow

Use `spongEffects` to transform a ceRNA network into sample-specific scores.

1.  **Define Modules**: Identify central nodes (seeds) and their first neighbors in the ceRNA network.
2.  **Enrichment**: Calculate scores (OE, ssGSEA, or GSVA) per sample.
```r
# Define modules based on central nodes
modules <- define_modules(
    network = filtered_net, 
    central.modules = central_genes, 
    remove.central = FALSE)

# Calculate enrichment scores (spongEffects)
scores <- enrichment_modules(
    Expr.matrix = gene_expr, 
    modules = modules, 
    method = "OE")
```
3.  **Classification**: Use scores as features for `calibrate_model` (Random Forest) to predict phenotypes or subtypes.

## Performance Tips

*   **Parallelization**: SPONGE uses the `foreach` backend. Register a parallel provider like `doParallel` to speed up computation.
    ```r
    library(doParallel)
    cl <- makeCluster(parallel::detectCores())
    registerDoParallel(cl)
    # Run SPONGE functions...
    stopCluster(cl)
    ```
*   **Memory**: For very large datasets, use the `bigmemory` package. SPONGE functions accept `bigmemory` description objects to share data across workers without duplication.

## Reference documentation

- [Sparse Partial correlation ON Gene Expression with SPONGE](./references/SPONGE.md)
- [spongEffects: Patient-specific ceRNA module scores](./references/spongEffects.md)