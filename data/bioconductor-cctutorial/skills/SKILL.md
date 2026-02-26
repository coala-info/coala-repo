---
name: bioconductor-cctutorial
description: This package provides documented workflows and data for the primary statistical analysis of ChIP-chip tiling array experiments. Use when user asks to import NimbleGen pair data, normalize intensities, smooth signals, identify ChIP-enriched regions, or relate peaks to genomic annotations.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/ccTutorial.html
---


# bioconductor-cctutorial

name: bioconductor-cctutorial
description: Analysis of ChIP-chip data using Bioconductor. Use this skill to perform primary statistical analysis of ChIP-chip data, including data import (NimbleGen pair format), quality assessment, normalization, smoothing, and identification of ChIP-enriched regions (peaks). It also supports integrative analysis with genome annotation (biomaRt) and gene set enrichment (topGO).

# bioconductor-cctutorial

## Overview
The `ccTutorial` package provides the data and documented workflows for analyzing ChIP-chip experiments (specifically H3K4me3 modifications in mouse tissues) using Bioconductor. It serves as a template for processing tiling array data, moving from raw intensity files to biological insights.

## Core Workflow

### 1. Data Import
The package handles NimbleGen `.pair` files. Data is typically organized by array type.

```R
library(ccTutorial)
library(Ringo)

# Locate raw data in the package
pairDir <- system.file("PairData", package="ccTutorial")

# Read raw intensities into RGList objects
# Requires a 'spottypes.txt' file and a targets file (e.g., 'files_array1.txt')
RGs <- lapply(sprintf("files_array%d.txt", 1:4), 
              readNimblegen, "spottypes.txt", path=pairDir)
```

### 2. Mapping and Annotation
Reporters must be mapped to genomic coordinates. The package includes a pre-built `probeAnno` object for the mm9 assembly.

```R
data("probeAnno")
data("mm9genes") # Ensembl-based gene annotation
```

### 3. Preprocessing and Normalization
Standard preprocessing involves calculating log2 ratios (Cy5/Cy3) and applying Tukey's biweight scaling.

```R
# Preprocess and convert to ExpressionSet
MAs <- lapply(RGs, function(thisRG) 
  preprocess(thisRG[thisRG$genes$Status=="Probe",], 
             method="nimblegen", returnMAList=TRUE))
MA <- do.call(rbind, MAs)
X <- asExprSet(MA)
```

### 4. Smoothing
To reduce noise and account for DNA fragment size, apply a sliding window median (e.g., 900bp).

```R
smoothX <- computeRunningMedians(X, probeAnno=probeAnno, 
                                 modColumn="Tissue", 
                                 winHalfSize=450, min.probes=5)
```

### 5. Finding ChIP-enriched Regions (Peaks)
Enrichment thresholds are determined using a mixture modeling approach on the null distribution of smoothed reporter levels.

```R
# Calculate threshold (e.g., 99% quantile of the null distribution)
y0 <- apply(exprs(smoothX), 2, upperBoundNull, prob=0.99)

# Identify regions (chers)
chersX <- findChersOnSmoothed(smoothX, probeAnno=probeAnno, 
                              thresholds=y0, allChr=chromosomeNames(probeAnno), 
                              distCutOff=450, minProbesInRow=5)

# Relate regions to genes
chersX <- relateChers(chersX, mm9genes, upstream=5000)
chersXD <- as.data.frame(chersX)
```

### 6. Visualization
Visualize intensities and smoothed signals along genomic coordinates.

```R
# Plot specific region
plot(X, probeAnno, chrom="2", xlim=c(113.87e6, 113.88e6), 
     ylim=c(-3,5), gff=mm9genes)
```

## Integrative Analysis
- **Gene Ontology**: Use `topGO` with the `sigGOTable` function to find over-represented terms among genes associated with ChIP-enriched regions.
- **Expression Integration**: Compare ChIP enrichment status with mRNA abundance data (e.g., `barreraExpressionX`) using boxplots and Wilcoxon rank sum tests.

## Reference documentation
- [Analyzing ChIP-chip Data Using Bioconductor](./references/ccTutorial.md)
- [Supplement: Analyzing ChIP-chip data using Bioconductor](./references/ccTutorialSupplement.md)