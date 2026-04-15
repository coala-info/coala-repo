---
name: bioconductor-impulsede2
description: ImpulseDE2 identifies differentially expressed genes in longitudinal next-generation sequencing data using an impulse model to capture transient and permanent regulatory responses. Use when user asks to perform case-only or case-control time-course analysis, identify transiently regulated genes, or visualize temporal expression trajectories.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ImpulseDE2.html
---

# bioconductor-impulsede2

## Overview

ImpulseDE2 is a specialized tool for longitudinal (time-course) next-generation sequencing data. It uses a negative binomial noise model and constrains mean expression trajectories using an "impulse" model. It is particularly effective at capturing transient regulatory responses that traditional linear models might miss.

Key capabilities:
* **Case-only analysis**: Identifies genes that change over time within a single condition.
* **Case-control analysis**: Identifies genes whose temporal trajectories differ between two conditions.
* **Batch correction**: Handles multiple confounding variables and library depth normalization.
* **Transient detection**: Specifically classifies genes as transiently or permanently regulated.

## Core Workflow

### 1. Data Preparation
You need two primary inputs:
* `matCountData`: A matrix of raw integer counts (genes in rows, samples in columns).
* `dfAnnotation`: A data frame with sample metadata. It must contain:
    * `Sample`: Sample IDs matching column names of `matCountData`.
    * `Condition`: "case" or "control".
    * `Time`: Numeric time points.
    * `Batch`: (Optional) Confounding factors.

### 2. Running the Analysis
The primary wrapper function is `runImpulseDE2()`.

```r
library(ImpulseDE2)

# Case-only analysis
objectImpulseDE2 <- runImpulseDE2(
  matCountData    = count_matrix, 
  dfAnnotation    = annotation_df,
  boolCaseCtrl    = FALSE,
  vecConfounders  = NULL, # e.g., c("Batch") if applicable
  scaNProc        = 1
)

# Case-control analysis
objectImpulseDE2 <- runImpulseDE2(
  matCountData    = count_matrix, 
  dfAnnotation    = annotation_df,
  boolCaseCtrl    = TRUE,
  vecConfounders  = c("Batch"),
  scaNProc        = 4
)
```

### 3. Identifying Transient Regulation
To distinguish between "impulse" (transient) and "sigmoid" (permanent/monotonous) shapes, set `boolIdentifyTransients = TRUE`.

```r
objectImpulseDE2 <- runImpulseDE2(
  matCountData           = count_matrix, 
  dfAnnotation           = annotation_df,
  boolCaseCtrl           = FALSE,
  boolIdentifyTransients = TRUE
)
```

### 4. Accessing Results
Results are stored in the `dfImpulseDE2Results` slot of the returned object.

```r
results <- objectImpulseDE2$dfImpulseDE2Results
# Key columns: p, padj, loglik_full, isTransient, isMonotonous
head(results[order(results$padj), ])
```

## Visualization

### Gene-wise Trajectories
Plot the fits for specific genes or the top hits.

```r
lsgplots <- plotGenes(
  vecGeneIDs       = c("GENE1", "GENE2"), # Or NULL for top IDs
  scaNTopIDs       = 10,
  objectImpulseDE2 = objectImpulseDE2,
  boolCaseCtrl     = FALSE
)
print(lsgplots[[1]])
```

### Heatmaps
Visualize global expression patterns grouped by regulation type.

```r
library(ComplexHeatmap)
lsHeatmaps <- plotHeatmap(
  objectImpulseDE2       = objectImpulseDE2,
  strCondition           = "case",
  boolIdentifyTransients = TRUE,
  scaQThres              = 0.01
)
draw(lsHeatmaps$complexHeatmapRaw)
```

## Tips for Success
* **Parallelization**: Use `scaNProc` to speed up execution on large datasets.
* **Normalization**: ImpulseDE2 handles library size internally. If you have pre-calculated factors, use `vecSizeFactorsExternal`.
* **Dispersions**: If the internal DESeq2-based dispersion estimation fails due to complex batch structures, provide `vecDispersionsExternal`.
* **Model Fits**: Use `computeModelFits(objectImpulseDE2)` to extract the coordinate values of the fitted impulse curves for downstream custom plotting.

## Reference documentation
- [ImpulseDE2 Tutorial](./references/ImpulseDE2_Tutorial.Rmd)
- [ImpulseDE2 Tutorial](./references/ImpulseDE2_Tutorial.md)