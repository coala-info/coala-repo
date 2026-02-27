---
name: bioconductor-cocoa
description: COCOA annotates epigenetic variation by identifying which reference region sets are most associated with sample-to-sample variation. Use when user asks to quantify associations between epigenetic data and phenotypes, interpret principal components using genomic region sets, or perform coordinate covariation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/COCOA.html
---


# bioconductor-cocoa

## Overview

COCOA (Coordinate Covariation Analysis) is a Bioconductor package designed to annotate epigenetic variation among samples using reference region sets (e.g., transcription factor binding sites, histone modifications). It transforms high-dimensional epigenetic data into biologically interpretable results by identifying which functional categories of genomic regions are most associated with sample-to-sample variation.

## Core Workflow

The COCOA workflow generally follows three main steps:
1. **Quantify Association**: Calculate Feature Contribution Scores (FCS) for each genomic feature (e.g., CpG site or ATAC peak) relative to a target variable.
2. **Score Region Sets**: Aggregate these FCS values across predefined region sets to identify which sets are most associated with the variation.
3. **Statistical Validation**: (Optional) Use permutation tests and gamma distribution fitting to estimate p-values.

### 1. Data Preparation
COCOA requires a matrix of epigenetic signals and a corresponding `GRanges` object for coordinates.

```r
library(COCOA)
# genomicSignal: rows = features, cols = samples
# signalCoord: GRanges object matching rows of genomicSignal
# GRList: GRangesList of reference region sets (e.g., from LOLA or BED files)
```

### 2. Supervised Analysis
Use this when you have a specific phenotype (e.g., disease status, ER status) to link to epigenetic changes.

```r
# 1. Define target variable (must be a data.frame)
targetVarDF <- brcaMetadata[, "ER_status", drop=FALSE]

# 2. Run COCOA (quantifies correlation and scores region sets in one step)
rsScores <- runCOCOA(genomicSignal=brcaMethylData,
                     signalCoord=brcaMCoord,
                     GRList=myGRList,
                     signalCol="ER_status",
                     targetVar=targetVarDF,
                     variationMetric="cor")
```

### 3. Unsupervised Analysis
Use this to find the biological meaning of major axes of variation (e.g., Principal Components).

```r
# 1. Perform PCA
pca <- prcomp(t(brcaMethylData))
pcScores <- pca$x[, 1:4] # Target the first 4 PCs

# 2. Run COCOA using PC scores as target variables
rsScores <- runCOCOA(genomicSignal=brcaMethylData,
                     signalCoord=brcaMCoord,
                     GRList=myGRList,
                     signalCol=paste0("PC", 1:4),
                     targetVar=pcScores,
                     variationMetric="cor")
```

### 4. Significance Testing (Permutations)
To account for region set size and noise, use `runCOCOAPerm`.

```r
permResults <- runCOCOAPerm(genomicSignal=brcaMethylData,
                            signalCoord=brcaMCoord,
                            GRList=myGRList,
                            rsScores=realRSScores,
                            targetVar=targetVarDF,
                            nPerm=100,
                            variationMetric="cor")
```

## Visualization and Interpretation

COCOA provides several functions to validate and visualize top-ranked region sets:

- **`plotAnnoScoreDist`**: Visualizes the distribution of region set scores, highlighting specific groups (e.g., "ER-related").
- **`rsScoreHeatmap`**: Compares region set rankings across multiple target variables (e.g., multiple PCs).
- **`getMetaRegionProfile`**: Creates a "meta-region" plot to see if the variation is specific to the region set or shared with the surrounding genome (look for a peak in the center).
- **`signalAlongAxis`**: Generates a heatmap of the raw epigenetic signal for features within a region set, ordered by the target variable.
- **`regionQuantileByTargetVar`**: Shows which individual regions within a set contribute most to the overall score.

## Tips for Success
- **Region Set Databases**: Use large databases (hundreds or thousands of sets) for better context. LOLA Core is a common source.
- **Coordinate Matching**: Ensure your `signalCoord` and `GRList` use the same genome build (e.g., hg19 vs hg38). Use `liftOver` if necessary.
- **Missing Data**: For DNA methylation, use `use="pairwise.complete.obs"` in correlation steps if NAs are present.
- **Gamma Approximation**: When running permutations, fitting a gamma distribution (`getGammaPVal`) allows for p-value estimation with fewer permutations (e.g., 300-500).

## Reference documentation
- [Introduction to Coordinate Covariation Analysis](./references/IntroToCOCOA.Rmd)
- [Introduction to Coordinate Covariation Analysis](./references/IntroToCOCOA.md)