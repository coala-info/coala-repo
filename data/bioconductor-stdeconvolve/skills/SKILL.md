---
name: bioconductor-stdeconvolve
description: STdeconvolve performs unsupervised deconvolution of multi-cellular spatial transcriptomics data to recover cell-type profiles and their spatial proportions without external references. Use when user asks to deconvolve spatial transcriptomics pixels, estimate cell-type proportions in 10X Visium or Slide-seq data, or identify latent cell-type gene expression profiles without a single-cell reference.
homepage: https://bioconductor.org/packages/3.16/bioc/html/STdeconvolve.html
---


# bioconductor-stdeconvolve

name: bioconductor-stdeconvolve
description: Unsupervised deconvolution of multi-cellular pixel-resolution spatial transcriptomics (ST) data. Use this skill to recover latent cell-type transcriptomic profiles (beta) and their proportional representation (theta) within ST pixels without the need for external single-cell references. Suitable for analyzing datasets from platforms like 10X Visium or Slide-seq.

# bioconductor-stdeconvolve

## Overview

STdeconvolve is an unsupervised machine learning approach that applies Latent Dirichlet Allocation (LDA) to spatial transcriptomics data. It treats each pixel as a mixture of K latent cell types, discovering both the gene expression profiles of these cell types and their spatial proportions.

## Core Workflow

### 1. Data Preparation and Preprocessing

Load your counts matrix (genes x pixels) and spatial coordinates. Use `cleanCounts` to filter out low-quality pixels and genes.

```r
library(STdeconvolve)

# Example with built-in data
data(mOB)
pos <- mOB$pos
cd <- mOB$counts

# Filter pixels and genes
counts <- cleanCounts(counts = cd,
                      min.lib.size = 100,
                      min.reads = 1,
                      min.detected = 1)
```

### 2. Feature Selection

Identify overdispersed genes to focus the LDA model on the most informative features.

```r
corpus <- restrictCorpus(counts,
                         removeAbove = 1.0, # Remove genes in > 100% of pixels
                         removeBelow = 0.05, # Remove genes in < 5% of pixels
                         alpha = 0.05,
                         plot = TRUE)
```

### 3. Model Fitting and Selection

Fit LDA models across a range of K (number of cell types). Select the optimal model based on perplexity or the `alpha` parameter (prefer `alpha < 1` for sparse, distinct cell-type distributions).

```r
# Input must be an integer matrix of pixels x genes
ldas <- fitLDA(t(as.matrix(corpus)), 
               Ks = seq(2, 10), 
               plot = TRUE)

# Select model with minimum perplexity
optLDA <- optimalModel(models = ldas, opt = "min")
```

### 4. Extracting Results

Extract the `theta` (pixel proportions) and `beta` (cell-type expression profiles) matrices.

```r
results <- getBetaTheta(optLDA,
                        perc.filt = 0.05, # Filter low-proportion cell types
                        betaScale = 1000) # Scale expression profiles

deconProp <- results$theta
deconGexp <- results$beta
```

### 5. Visualization

Visualize the spatial distribution of all cell types using scatterpie plots or individual topics.

```r
# Visualize all cell types
vizAllTopics(deconProp, pos, r = 0.4)

# Visualize a specific cell type (e.g., topic "5")
vizTopic(theta = deconProp, pos = pos, topic = "5", high = "red")
```

## Annotation Strategies

Since STdeconvolve is unsupervised, you must annotate the resulting cell types using one of two strategies:

### Strategy 1: Transcriptional Correlation
Compare the `beta` matrix (deconvolved profiles) or `theta` matrix (proportions) against a known reference using Pearson correlation.

```r
corMtx <- getCorrMtx(m1 = as.matrix(deconGexp), 
                     m2 = t(as.matrix(referenceGexp)), 
                     type = "b")

correlationPlot(corMtx)
```

### Strategy 2: Gene Set Enrichment Analysis (GSEA)
Use marker gene lists to identify significantly enriched cell types in the deconvolved profiles.

```r
annotations <- annotateCellTypesGSEA(beta = deconGexp,
                                     gset = markerGeneList,
                                     qval = 0.05)

# View top predictions
annotations$predictions
```

## Working with SpatialExperiment

If using `SpatialExperiment` or `TENxVisiumData`:

```r
library(SpatialExperiment)
se <- TENxVisiumData::MouseBrainCoronal()

# Extract counts and coordinates
cd <- assay(se, "counts")
pos <- spatialCoords(se)
colnames(pos) <- c("y", "x")
```

## Reference documentation

- [STdeconvolve Vignette](./references/vignette.Rmd)
- [STdeconvolve Vignette (Markdown)](./references/vignette.md)