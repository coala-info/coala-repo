---
name: bioconductor-microbiomeexplorer
description: The microbiomeExplorer package provides a suite of tools for exploring, visualizing, and performing statistical analysis on microbiome data. Use when user asks to load and filter microbiome datasets, perform alpha and beta diversity analyses, visualize taxonomic abundance, or conduct differential abundance testing.
homepage: https://bioconductor.org/packages/release/bioc/html/microbiomeExplorer.html
---


# bioconductor-microbiomeexplorer

## Overview
The `microbiomeExplorer` package provides a suite of tools for exploring and visualizing microbiome data, primarily from 16S rRNA experiments. It utilizes `MRexperiment` objects (from the `metagenomeSeq` package) to store counts, phenotype data, and feature (taxonomy) information. The package supports a complete workflow from data ingestion and QC to advanced statistical testing and report generation.

## Core Workflow

### 1. Data Loading and Preparation
The package works best with `MRexperiment` objects. You can also import BIOM files or raw count matrices with associated phenotype and feature data.

```r
library(microbiomeExplorer)
library(metagenomeSeq)

# Load example data
data("mouseData", package = "metagenomeSeq")

# Initial filtering: min presence in samples, min features, min reads
meData <- filterMEData(mouseData, minpresence = 1, minfeats = 2, minreads = 2)
```

### 2. Quality Control and Filtering
Visualize sample distributions to identify outliers or low-quality sequencing runs.

```r
# QC Plot: Features vs Reads
makeQCPlot(meData, col_by = "diet", filter_feat = 100, filter_read = 500)

# Sample Barplot
plotlySampleBarplot(meData, col_by = "diet")

# Apply stricter filters based on QC
meData <- filterMEData(meData, minpresence = 1, minfeats = 100, minreads = 500)
```

### 3. Normalization and Transformation
Normalize data to account for library size differences. Common methods include "Proportion" or "CSS" (Cumulative Sum Scaling).

```r
meData <- normalizeData(meData, norm_method = "Proportion")
```

### 4. Feature Aggregation
Analyses are typically performed at a specific taxonomic rank (e.g., Phylum, Genus).

```r
# Aggregate counts to Genus level
aggDat <- aggFeatures(meData, level = "genus")
```

### 5. Intra-Sample Analysis (Alpha Diversity)
Examine composition within samples.

```r
# Relative Abundance Barplot
plotAbundance(aggDat, level = "genus", x_var = "diet", ind = 1:10)

# Alpha Diversity (Shannon, Simpson, etc.)
plotAlpha(aggDat, level = "genus", index = "shannon", x_var = "diet")

# Specific Feature Abundance
plotSingleFeature(aggDat, x_var = "diet", feature = "Bacteroides", log = TRUE)
```

### 6. Inter-Sample Analysis (Beta Diversity)
Compare microbial communities between samples.

```r
# Compute distance matrix (e.g., Bray-Curtis)
distMat <- computeDistMat(aggDat, "bray")

# Calculate and plot PCA/PCoA
pcaVals <- calculatePCAs(distMat, c("PC1", "PC2"))
plotBeta(aggDat, dist_method = "bray", pcas = pcaVals, col_by = "diet")

# Heatmap of top 50 features by variance
plotHeatmap(aggDat, sort_by = "Variance", nfeat = 50, col_by = "diet")
```

### 7. Differential Abundance Testing
Identify features that differ significantly between groups. Supported methods: `DESeq2`, `Kruskal-Wallis`, `limma`, or `zero-inflated log normal`.

```r
diffResults <- runDiffTest(aggDat, 
                           level = "genus", 
                           phenotype = "diet", 
                           phenolevels = c("BK", "Western"), 
                           method = "DESeq2")
```

### 8. Longitudinal Analysis
Track feature changes over time or across ordered categories.

```r
plotLongFeature(aggDat, 
                x_var = "date", 
                id_var = "mouseID", 
                feature = "Prevotella", 
                log = TRUE)
```

## Tips and Best Practices
- **Taxonomy Roll-down**: Use `rollDownFeatures` to handle missing taxonomy levels by propagating the last known higher-level rank (e.g., "unknown_Firmicutes").
- **Interactive UI**: While this skill focuses on R code, you can launch the interactive Shiny interface using `runMicrobiomeExplorer()`.
- **Normalization**: Always normalize before performing diversity or abundance plotting, though `runDiffTest` often handles normalization internally if required.
- **Large Datasets**: For datasets with >5000 samples, avoid `plotHeatmap` as rendering may be slow.

## Reference documentation
- [Using Microbiome Explorer application to analyze amplicon sequencing data](./references/exploreMouseData.md)