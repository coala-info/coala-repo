---
name: bioconductor-opossom
description: This package provides a pipeline for analyzing large-scale transcriptomic data using Self-Organizing Maps to create visual expression portraits and functional annotations. Use when user asks to cluster genes into 2D grids, identify molecular subtypes, perform functional data mining, or generate sample similarity heatmaps.
homepage: https://bioconductor.org/packages/release/bioc/html/oposSOM.html
---


# bioconductor-opossom

## Overview

The `oposSOM` package provides a holistic pipeline for analyzing large-scale transcriptomic data. Instead of focusing solely on individual genes, it uses Self-Organizing Maps (SOM) to cluster genes with similar expression profiles into a 2D grid. This results in "expression portraits"—visual fingerprints that allow for intuitive identification of molecular subtypes, outlier detection, and functional data mining.

## Typical Workflow

### 1. Environment Initialization
The analysis must start with `opossom.new()`. This function creates an environment object that stores data, parameters, and results.

```r
library(oposSOM)

# Initialize with a dataset name and SOM grid dimension (e.g., 20x20)
env <- opossom.new(list(dataset.name = "MyAnalysis", 
                        dim.1stLvlSom = 20))
```

### 2. Data Input
The package accepts a numerical matrix (genes as rows, samples as columns) or a Biobase `ExpressionSet`. Data should be log-transformed before input.

```r
# Option A: Numerical Matrix
# env$indata <- my_matrix 

# Option B: ExpressionSet
# env$indata <- my_eset
```

### 3. Grouping and Coloring
Assigning groups and colors improves the interpretability of the portraits and downstream similarity analyses.

```r
env$group.labels <- c("Group1", "Group1", "Group2", "Group2")
env$group.colors <- c("red", "red", "blue", "blue")
```

### 4. Running the Pipeline
The `opossom.run()` function executes the entire analysis, including SOM training, spot detection, and functional annotation.

```r
opossom.run(env)
```

## Key Parameters

- `dim.1stLvlSom`: The size of the square SOM grid. Use `"auto"` for a recommended size based on feature/sample count.
- `database.dataset`: For gene annotation via biomaRt (e.g., `"hsapiens_gene_ensembl"`). Use `"auto"` for automatic detection.
- `feature.centralization`: Boolean (default `TRUE`). Centers gene expression levels.
- `sample.quantile.normalization`: Boolean (default `TRUE`). Normalizes distributions across samples.

## Interpreting Results

The pipeline generates a structured results folder containing:
- **Summary.html**: The primary entry point for browsing results.
- **Expression Portraits**: 2D heatmaps where "spots" represent clusters of co-expressed genes.
- **Sample Similarity**: Clustered pairwise correlation matrices and ICA plots.
- **Gene Set Analysis**: Enrichment results for identified modules (GO terms, pathways).
- **CSV Spreadsheets**: Detailed gene lists and statistics for every module.

## SOM Size Recommendations
- **Small (<100 samples, <10k genes)**: 20x20 to 30x30.
- **Medium (100-500 samples, 10k-50k genes)**: 35x35 to 45x45.
- **Large (>500 samples)**: 50x50 or larger.

## Reference documentation

- [The oposSOM Package](./references/Vignette.md)