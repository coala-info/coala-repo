---
name: bioconductor-pathifier
description: Pathifier calculates pathway deregulation scores for individual samples by measuring their deviation from a normal state along a principal curve. Use when user asks to infer pathway deregulation scores, quantify sample-specific pathway deviation, or transform gene expression data into pathway-level scores.
homepage: https://bioconductor.org/packages/release/bioc/html/pathifier.html
---

# bioconductor-pathifier

## Overview

Pathifier is an algorithm that infers Pathway Deregulation Scores (PDS) for individual samples. Unlike methods that look for differentially expressed genes across groups, Pathifier calculates how far a specific sample's expression pattern deviates from the "normal" state along a principal curve defined in the high-dimensional space of the pathway's genes. This allows for personalized analysis of cancer datasets, turning noisy gene-level data into biologically interpretable pathway-level information.

## Core Workflow

### 1. Data Preparation
To use Pathifier, you need:
- A gene expression matrix (rows = genes, columns = samples).
- A list of genes belonging to the pathways of interest (e.g., from KEGG or MSigDB).
- A logical vector or index identifying which samples are "normal" (controls).

### 2. Quantifying Deregulation
The primary function is `quantify_pathways_deregulation`.

```r
library(pathifier)

# Example using built-in Sheffer dataset
data(Sheffer)
data(KEGG)

# PDS calculation
# sheffer$data: expression matrix
# sheffer$allgenes: gene symbols for rows in data
# kegg$gs: list of pathways (each element is a vector of gene symbols)
# kegg$pathwaynames: names of the pathways
# sheffer$normals: logical vector (TRUE for normal samples)
PDS <- quantify_pathways_deregulation(
    data = sheffer$data, 
    allgenes = sheffer$allgenes, 
    pathways = kegg$gs, 
    pathwaynames = kegg$pathwaynames, 
    normals = sheffer$normals, 
    attempts = 100, # Number of starts for principal curve optimization
    min_exp = sheffer$minexp, 
    min_std = sheffer$minstd
)
```

### 3. Accessing Results
The output object contains several components, most importantly the scores:

```r
# Access scores for all pathways and samples
# Rows are pathways, columns are samples
scores <- PDS$scores

# Access scores for a specific pathway
mismatch_repair_scores <- PDS$scores$MISMATCH_REPAIR
```

## Analysis and Visualization

### Comparing Groups
Since PDS values typically range from 0 (normal-like) to 1 (highly deregulated), you can compare the distribution between normal and tumor samples.

```r
# Compare normal vs tumor scores for a specific pathway
pathway_name <- "MISMATCH_REPAIR"
normal_scores <- PDS$scores[[pathway_name]][sheffer$normals]
tumor_scores <- PDS$scores[[pathway_name]][!sheffer$normals]

boxplot(list(Normals = normal_scores, Tumors = tumor_scores), 
        main = pathway_name, 
        ylab = "Deregulation Score")
```

### Identifying Highly Deregulated Samples
You can filter samples that exceed a certain threshold of deregulation for a specific biological process.

```r
# Find samples with Autophagy deregulation > 0.8
high_dereg_samples <- sheffer$samples[PDS$scores$REGULATION_OF_AUTOPHAGY > 0.8]
```

## Usage Tips
- **Normal Samples**: The algorithm learns the "normal flow" from the provided normal samples. Ensure your reference normals are truly representative of the baseline state.
- **Gene Identifiers**: Ensure the gene symbols in your pathway list match the row names (or the `allgenes` vector) of your expression matrix.
- **Stochasticity**: The `attempts` parameter controls the robustness of the principal curve fit. Higher values increase reliability but also computation time.
- **Minimum Requirements**: Use `min_exp` and `min_std` to filter out genes with very low expression or variance, which can introduce noise into the pathway manifold.

## Reference documentation
- [Overview](./references/Overview.md)