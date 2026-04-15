---
name: bioconductor-iyer517
description: This package provides access to the Iyer genomic time series dataset for analyzing the transcriptional response of human fibroblasts to serum. Use when user asks to load the Iyer517 ExpressionSet, access cDNA-chip expression data, visualize gene expression heatmaps, or analyze cluster trajectories from the Iyer et al. (1999) study.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Iyer517.html
---

# bioconductor-iyer517

name: bioconductor-iyer517
description: Analysis of the Iyer genomic time series dataset (transcriptional response of fibroblasts to serum). Use this skill to load the Iyer517 ExpressionSet, access cDNA-chip expression data, explore experimental metadata (time points, cycloheximide treatment), and replicate cluster-based visualization and trajectory analysis from the Science 1999 paper.

# bioconductor-iyer517

## Overview
The `Iyer517` package provides access to a subset of the cDNA microarray data reported by Iyer, Eisen et al. (1999). The dataset tracks the transcriptional response of human fibroblasts to serum over a time series. It includes 517 genes across 19 samples, categorized by sampling time and the presence or absence of cycloheximide (a protein synthesis inhibitor).

## Data Loading and Inspection
The primary data object is an `ExpressionSet` named `Iyer517`.

```r
library(Iyer517)
data(Iyer517)

# View summary of the ExpressionSet
show(Iyer517)

# Access expression matrix (517 features x 19 samples)
exp_matrix <- exprs(Iyer517)

# Access phenotype data (time.hrs and cycloheximide status)
pData(Iyer517)
```

## Experimental Structure
The 19 samples are organized as follows:
- **Samples 1-13**: Time series in the **absence** of cycloheximide (0h to 24h, plus unsynchronized cells).
- **Samples 14-19**: Time series in the **presence** of cycloheximide.
- **UNSYN/UNSYNC**: Samples from cells in exponential replication.

## Common Workflows

### Replicating Figure 2 (Heatmap)
To visualize the expression changes over the first 13 time points (no cycloheximide):

```r
# Define color scheme and cap values for visualization
chg <- seq(.1, 8, .01)
mycol <- rgb(chg/8, 1-chg/8, 0)
CEX <- exprs(Iyer517)
CEX[CEX > 8] <- 8

# Plot heatmap for the first 13 columns
image(t(log10(CEX[517:1, 1:13])), col=mycol, xlim=c(0, 3), axes=FALSE,
      xlab="Hours post exposure to serum")
axis(1, at=(1:13)/13, lab=c("0",".25",".5","1","2","4","6","8","12","16","20","24","u"), cex=.3)
```

### Analyzing Cluster Trajectories
The 517 genes are pre-ordered to reflect clusters (A through J) identified in the original study. You can calculate and plot the mean trajectory for specific gene blocks:

```r
# Example: Mean trajectory for Cluster A (Genes 1-100)
cluster_A_mean <- apply(exprs(Iyer517)[1:100, 1:13], 2, mean)
plot(cluster_A_mean, type="b", log="y", main="Cluster A", ylab="Fold Change")

# Cluster indices for reference:
# Cluster A: 1:100
# Cluster B: 101:242
# Cluster I: 483:499
# Cluster J: 500:517
```

### Using Annotated Data
The package includes an annotated version of the dataset with Gene Ontology (GO) tags and LocusID information.

```r
data(IyerAnnotated)
# View annotation table
head(IyerAnnotated)

# Columns include: Iclust (Cluster ID), GB (GenBank), locusid, and GO tags (GO1-GO5)
```

## Reference documentation
- [Iyer517](./references/Iyer517.md)