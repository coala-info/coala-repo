---
name: bioconductor-iasva
description: IA-SVA identifies hidden heterogeneity and surrogate variables in high-dimensional data like single-cell RNA-Seq by iteratively accounting for known factors. Use when user asks to detect hidden factors, identify rare cell populations, find marker genes associated with surrogate variables, or perform sensitivity analysis for R-squared thresholds.
homepage: https://bioconductor.org/packages/release/bioc/html/iasva.html
---


# bioconductor-iasva

## Overview

The `iasva` package implements Iteratively Adjusted Surrogate Variable Analysis (IA-SVA). It is specifically designed to identify hidden heterogeneity in high-dimensional data, such as single-cell RNA-Seq (scRNA-Seq). Unlike standard SVA or PCA, IA-SVA iteratively identifies surrogate variables (SVs) that are associated with variation not explained by known factors, making it highly effective at finding rare cell populations or subtle biological signals that are often masked by technical noise or dominant library size effects.

## Core Workflow

### 1. Data Preparation
IA-SVA typically operates on a count matrix (genes as rows, samples/cells as columns) or a `SummarizedExperiment` object.

```r
library(iasva)
library(SummarizedExperiment)

# counts: matrix of read counts
# anns: metadata/annotations
lcounts <- log(counts + 1)
```

### 2. Defining Known Factors
It is critical to define a model matrix containing known variables you want to account for. In scRNA-Seq, "Geometric Library Size" is a common known factor.

```r
# Calculate geometric library size
geo_lib_size <- colSums(log(counts + 1))

# Create model matrix (intercept is usually handled by iasva internally or via mod[,-1])
patient_id <- anns$Patient_ID
mod <- model.matrix(~patient_id + geo_lib_size)
```

### 3. Running IA-SVA
Use the `iasva()` function to detect hidden factors. For large datasets, use `fast_iasva()`.

```r
# Using SummarizedExperiment
summ_exp <- SummarizedExperiment(assays = list(counts = counts))

# Run IA-SVA to find 5 hidden factors
iasva.res <- iasva(summ_exp, 
                   known.factors = mod[, -1], 
                   num.sv = 5, 
                   verbose = FALSE, 
                   permute = FALSE)

# Extract Surrogate Variables
iasva.sv <- iasva.res$sv
```

### 4. Identifying Marker Genes
Once SVs are detected, identify the genes driving that specific heterogeneity.

```r
# Find markers for the first SV
# Default: p-value < 0.05, R-squared > 0.3
marker.counts <- find_markers(summ_exp, as.matrix(iasva.sv[, 1]))
```

### 5. Parameter Tuning
The `study_R2()` function helps determine the optimal R-squared threshold for marker selection by visualizing the trade-off between the number of genes and cluster quality (silhouette score).

```r
study_res <- study_R2(summ_exp, iasva.sv)
```

## Key Functions

- `iasva()`: The primary function for detecting surrogate variables.
- `fast_iasva()`: A faster implementation for large-scale datasets.
- `find_markers()`: Identifies genes significantly associated with detected SVs.
- `study_R2()`: Conducts a sensitivity analysis for the R-squared threshold.

## Tips for Success

- **Library Size**: Always check the correlation between your first PC and the geometric library size. If it is high (>0.9), include library size as a known factor in your model.
- **Visualization**: Use `pairs(iasva.sv)` to visualize how different SVs separate cell populations.
- **Downstream Analysis**: Use the marker genes identified by `find_markers()` as input for tSNE or UMAP to achieve cleaner separation of hidden cell types compared to using all genes.

## Reference documentation

- [Detecting hidden heterogeneity in single cell RNA-Seq data](./references/detecting_hidden_heterogeneity_iasvaV0.95.md)