---
name: bioconductor-spanorm
description: SpaNorm normalizes spatial molecular datasets by using generalized linear models and thin plate splines to account for spatial variation in library size. Use when user asks to normalize spatial transcriptomics data, identify spatially variable genes, or perform dimensionality reduction on spatial experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/SpaNorm.html
---


# bioconductor-spanorm

## Overview

SpaNorm is a Bioconductor package designed for the normalization of spatial molecular datasets (e.g., 10x Visium). Unlike standard single-cell normalization methods, SpaNorm accounts for the fact that library size often correlates with spatial biology. It uses generalized linear models (GLMs) and thin plate splines to decompose spatial variation into technical (library size associated) and biological (library size independent) components.

## Core Workflow

### 1. Data Preparation
SpaNorm works with `SpatialExperiment` or `Seurat` objects. It is recommended to filter lowly expressed genes before normalization.

```r
library(SpaNorm)
library(SpatialExperiment)

# Load data (example)
data(HumanDLPFC)

# Filter genes expressed in at least 10% of spots
keep = filterGenes(HumanDLPFC, prop = 0.1)
HumanDLPFC = HumanDLPFC[keep, ]
```

### 2. Normalization
The `SpaNorm()` function performs both model fitting and data adjustment. By default, it uses Percentile Adjusted Counts (PAC) and stores the result in the `logcounts` assay.

```r
# Basic normalization
set.seed(42)
HumanDLPFC = SpaNorm(HumanDLPFC)

# Parameters:
# sample.p: Proportion of cells to use for model fitting (default 0.25)
# df.tps: Degrees of freedom for spatial smoothing (default 6)
# verbose: Set to FALSE to suppress convergence output
```

### 3. Alternative Adjustment Methods
If a model has already been fit, you can compute alternative residuals without re-fitting the entire model by changing the `adj.method`.

```r
# Pearson residuals
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "pearson")

# Mean or Median biology (useful for low-signal genes)
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "meanbio")
HumanDLPFC = SpaNorm(HumanDLPFC, adj.method = "medbio")
```

### 4. Identifying Spatially Variable Genes (SVGs)
SpaNorm provides a specific framework for identifying SVGs by fitting a nested model and using an F-test.

```r
# Identify SVGs
HumanDLPFC = SpaNormSVG(HumanDLPFC)

# Retrieve top 10 SVGs
svgs = topSVGs(HumanDLPFC, n = 10)
```

### 5. Dimensionality Reduction (SpaNormPCA)
To avoid distortions caused by log-transforming counts, use `SpaNormPCA`, which approximates GLM-PCA using the null model from the SVG step.

```r
# Must run SpaNormSVG first
HumanDLPFC = SpaNormPCA(HumanDLPFC, ncomponents = 50, svg.fdr = 0.2)

# Results are stored in reducedDim(HumanDLPFC, "PCA")
```

## Usage with Seurat
SpaNorm supports Seurat objects (v5+). It automatically looks for spatial coordinates in `images$coordinates`, or metadata columns named `x`/`y` or `imagecol`/`imagerow`.

```r
# Run on Seurat object
seurat_obj <- SpaNorm(seurat_obj, assay = "counts", slot = "counts")
```

## Tips and Best Practices
- **Signal Enhancement**: For very lowly expressed marker genes, use `scale.factor` (e.g., `scale.factor = 4`) in the `SpaNorm()` call to make adjusted data more continuous and interpretable.
- **Model Reuse**: The model fit is stored in `metadata(obj)$SpaNorm`. SpaNorm will automatically reuse this fit unless parameters like `df.tps`, `batch`, or object dimensions change.
- **Visualization**: Use `plotSpatial(obj, colour = GENE_NAME, assay = "logcounts")` to visualize normalized expression and `plotCovariate(obj, covariate = "biology")` to inspect the learned spatial functions.

## Reference documentation
- [SpaNorm: Spatially aware library size normalisation](./references/SpaNorm.md)
- [SpaNorm Vignette Source](./references/SpaNorm.Rmd)