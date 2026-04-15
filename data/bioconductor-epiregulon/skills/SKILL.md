---
name: bioconductor-epiregulon
description: This tool constructs gene regulatory networks and infers transcription factor activity by integrating single-cell RNA-seq and ATAC-seq data. Use when user asks to identify peak-to-gene links, construct regulons using ChIP-seq or motif data, prune regulatory networks, or calculate single-cell transcription factor activity scores.
homepage: https://bioconductor.org/packages/release/bioc/html/epiregulon.html
---

# bioconductor-epiregulon

name: bioconductor-epiregulon
description: Comprehensive gene regulatory network (GRN) construction and transcription factor (TF) activity inference from single-cell multi-omics data (scRNA-seq and scATAC-seq). Use when Claude needs to: (1) Integrate scRNA-seq and scATAC-seq data to identify peak-to-gene links, (2) Construct "regulons" using bulk TF ChIP-seq or motif data, (3) Prune and weight regulatory networks, or (4) Calculate single-cell TF activity scores.

# bioconductor-epiregulon

## Overview

The `epiregulon` package constructs gene regulatory networks (GRNs) and infers transcription factor (TF) activity at the single-cell level. It integrates scATAC-seq (chromatin accessibility) and scRNA-seq (gene expression) data, incorporating public bulk TF ChIP-seq data (from ChIP-Atlas/ENCODE) or motif information to define "regulons"—sets of target genes regulated by specific TFs through identified regulatory elements.

## Installation

Install via Bioconductor:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("epiregulon")
library(epiregulon)
```

## Core Workflow

### 1. Data Preparation
The package requires three main components, typically stored in `SingleCellExperiment` or `MultiAssayExperiment` objects:
- **Peak Matrix**: scATAC-seq chromatin accessibility.
- **Expression Matrix**: scRNA-seq gene expression.
- **Reduced Dimensions**: Dimensionality reduction (e.g., LSI or UMAP) for cell aggregation.

### 2. Retrieve TF Binding Information
Retrieve binding sites (GRangesList) for TFs. ChIP-seq is recommended over motifs for better accuracy.

```r
# For ChIP-seq (default)
grl <- getTFMotifInfo(genome = "hg38")

# For Motifs
grl.motif <- getTFMotifInfo(genome = "hg38", mode = "motif", peaks = rowRanges(PeakMatrix))
```

### 3. Link Peaks to Genes (P2G)
Identify regulatory elements (RE) near target genes (TG) based on correlation.

```r
# Optional: Optimize metacell aggregation size
cellNum <- optimizeMetacellNumber(peakMatrix = PeakMatrix, expMatrix = GeneExpressionMatrix, reducedDim = reducedDimMatrix)

# Calculate links
p2g <- calculateP2G(peakMatrix = PeakMatrix, expMatrix = GeneExpressionMatrix, reducedDim = reducedDimMatrix, cellNum = cellNum)
```

### 4. Construct and Prune Regulons
Map TFs to the peak-to-gene links and filter the network for statistical significance.

```r
# Overlap peaks with TF binding sites
overlap <- addTFMotifInfo(grl = grl, p2g = p2g, peakMatrix = PeakMatrix)

# Generate initial regulon object
regulon <- getRegulon(p2g = p2g, overlap = overlap)

# Prune the network (Highly Recommended)
# Uses binomial or chi-square tests to ensure TF, RE, and TG are not independently expressed
pruned.regulon <- pruneRegulon(expMatrix = GeneExpressionMatrix, peakMatrix = PeakMatrix, regulon = regulon, test = "chi.sq", clusters = GeneExpressionMatrix$Clusters)
```

### 5. Weighting and Annotation
Estimate the strength of regulation and optionally add log fold change (logFC) data.

```r
# Add weights (methods: "wilcox", "corr", or "mi")
regulon.w <- addWeights(regulon = pruned.regulon, expMatrix = GeneExpressionMatrix, peakMatrix = PeakMatrix, clusters = GeneExpressionMatrix$Clusters, method = "wilcox")

# Optional: Add logFC for specific conditions
regulon.w <- addLogFC(regulon = regulon.w, clusters = GeneExpressionMatrix$Condition, expMatrix = GeneExpressionMatrix, logFC_condition = "Treatment", logFC_ref = "Control")
```

### 6. Calculate TF Activity
Compute the final activity scores for each TF in every cell.

```r
tf_activity <- calculateActivity(expMatrix = GeneExpressionMatrix, regulon = regulon.w, mode = "weight", method = "weightedMean")
```

## Key Functions Reference

- `getTFMotifInfo`: Fetches TF binding site data for hg19, hg38, or mm10.
- `calculateP2G`: Links ATAC peaks to RNA genes within a window (default ±250kb).
- `pruneRegulon`: Removes noise by testing the independence of TF-RE-TG triplets.
- `addWeights`: Assigns regulatory potential to each edge in the network.
- `calculateActivity`: Generates a TF-by-cell matrix of activity scores.

## Reference documentation

- [Epiregulon tutorial with MultiAssayExperiment](./references/multiome.mae.md)