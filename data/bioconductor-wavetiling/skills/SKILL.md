---
name: bioconductor-wavetiling
description: bioconductor-wavetiling performs wavelet-based functional data analysis for transcriptome profiling using genomic tiling arrays. Use when user asks to identify transcriptionally active regions, detect differentially expressed regions, or fit wavelet-based models to tiling array data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/waveTiling.html
---

# bioconductor-wavetiling

name: bioconductor-wavetiling
description: Wavelet-based transcriptome analysis for tiling arrays. Use this skill to perform functional data analysis on genomic tiling array data, including data preparation, model fitting using wavelets, inference for differential expression, and visualization of transcriptionally active regions.

## Overview

The `waveTiling` package provides a wavelet-based functional model for analyzing tiling array transcriptome data. It is designed to handle complex experimental designs (e.g., time-course, multiple groups) and identifies transcriptionally active regions (TARs) or differentially expressed regions (DERs) without relying on predefined gene annotations. It uses wavelet decomposition to model the expression signal across genomic positions, allowing for multi-resolution analysis.

## Core Workflow

### 1. Data Preparation
Data must be converted to a `WaveTilingFeatureSet` and annotated with phenotypic information.

```R
library(waveTiling)
library(waveTilingData)
library(pd.atdschip.tiling) # Array-specific annotation
data(leafdev)

# Convert and add group/replicate info
leafdev <- as(leafdev, "WaveTilingFeatureSet")
leafdev <- addPheno(leafdev, noGroups=6, 
                    groupNames=c("day8","day9","day10","day11","day12","day13"), 
                    replics=rep(3,6))
```

### 2. Filtering and Normalization
Filter probes that map to multiple locations and perform background correction/normalization.

```R
library(BSgenome.Athaliana.TAIR.TAIR9)
# Filter redundant probes
mapFilter <- filterOverlap(leafdev, remap=TRUE, BSgenomeObject=Athaliana, 
                           chrId=1:5, strand="both", MM=FALSE)

# Background correction and quantile normalization
leafdevBQ <- bgCorrQn(leafdev, useMapFilter=mapFilter)
```

### 3. Model Fitting (`wfm.fit`)
Fit the wavelet-based functional model (WFM) chromosome-wise and strand-wise.

```R
leafdevFit <- wfm.fit(leafdevBQ, 
                      filter.overlap=mapFilter, 
                      design="time", 
                      n.levels=10, 
                      chromosome=1, 
                      strand="forward", 
                      minPos=22000000, 
                      maxPos=24000000)
```
- `design`: "time", "group", or "custom".
- `n.levels`: Number of wavelet decomposition levels (usually 10).
- `var.eps`: "marg" for marginal maximum likelihood estimation of variances.

### 4. Statistical Inference (`wfm.inference`)
Identify significant regions based on thresholds (`delta`).

```R
# delta[1] is for mean transcript discovery, delta[2] for differential expression
delta <- log(1.2, 2)
leafdevInf <- wfm.inference(leafdevFit, contrasts="compare", delta=c("median", delta))
```
- `contrasts`: "compare" (pairwise), "effects" (time effects), or "means".

### 5. Result Extraction
Extract genomic ranges for significant regions and map them to genes if a `TxDb` object is available.

```R
# Get IRanges of significant regions
sigRegions <- getGenomicRegions(leafdevInf)

# Get annotated genes
library(TxDb.Athaliana.BioMart.plantsmart22)
sigGenes <- getSigGenes(fit=leafdevFit, inf=leafdevInf, 
                        biomartObj=TxDb.Athaliana.BioMart.plantsmart22)

# Get non-annotated regions (potential novel transcripts)
nonAnno <- getNonAnnotatedRegions(fit=leafdevFit, inf=leafdevInf, 
                                  biomartObj=TxDb.Athaliana.BioMart.plantsmart22)
```

## Visualization
Use `plotWfm` to visualize expression data, fitted models, and significant regions alongside gene models.

```R
plotWfm(fit=leafdevFit, inf=leafdevInf, 
        biomartObj=TxDb.Athaliana.BioMart.plantsmart22,
        minPos=startPos, maxPos=endPos, 
        two.strand=TRUE, plotData=TRUE)
```

## Tips and Best Practices
- **Memory Management**: Tiling array data is large. Process data chromosome-by-chromosome or in specific genomic windows using `minPos` and `maxPos` in `wfm.fit`.
- **Custom Designs**: For complex experiments, provide a custom design matrix to `wfm.fit(design="custom", design.matrix=...)` and a contrast matrix to `wfm.inference`.
- **Delta Selection**: The `delta` threshold is critical. Using `"median"` for the first element is a common heuristic for background filtering in transcript discovery.

## Reference documentation
- [The waveTiling package](./references/waveTiling-vignette.md)