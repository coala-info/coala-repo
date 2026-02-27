---
name: bioconductor-sevenc
description: This tool predicts chromatin looping interactions by combining ChIP-seq data with CTCF motif information and genomic features. Use when user asks to predict chromatin loops, identify interactions between regulatory elements and genes, or calculate ChIP-seq signal correlations between genomic anchors.
homepage: https://bioconductor.org/packages/release/bioc/html/sevenC.html
---


# bioconductor-sevenc

name: bioconductor-sevenc
description: Predict chromatin looping interactions using ChIP-seq data and CTCF motif information. Use this skill when you need to identify potential physical interactions between distal regulatory elements (like enhancers) and target genes based on protein binding signals, motif orientation, and genomic distance.

## Overview

The `sevenC` package implements a computational method to predict chromatin loops. It leverages the observation that proteins involved in looping (like CTCF) often show correlated ChIP-seq signals at both anchor points. By combining ChIP-seq coverage correlation with sequence features (motif similarity, distance, and orientation), `sevenC` provides a logistic regression framework to predict interactions without requiring expensive Hi-C or ChIA-PET experiments.

## Core Workflow

### 1. Prepare Motif Anchors
The process starts with CTCF motif locations as `GRanges`. The package provides pre-computed motifs for hg19, but custom motifs can be used.

```r
library(sevenC)
# Load example motifs (hg19 CTCF on chr22)
motifs <- motif.hg19.CTCF.chr22
```

### 2. Add ChIP-seq Signals
ChIP-seq data (typically in bigWig format) is mapped to the motif regions. This adds a `chip` metadata column containing signal vectors.

```r
bigWigFile <- "path/to/your/chipseq.bigWig"
# Add coverage in a 1000bp window around motifs
motifs <- addCovToGR(motifs, bigWigFile)
```
*Note: On Windows, bigWig reading is not supported via rtracklayer; ChIP signals must be provided as a NumericList manually.*

### 3. Generate Candidate Pairs
Create pairs of motifs within a specific distance (default 1Mb) and annotate them with genomic features.

```r
# Creates a GInteractions object with distance and orientation
gi <- prepareCisPairs(motifs, maxDist = 10^6)
```

### 4. Compute Correlation and Predict
Calculate the Pearson correlation of ChIP-seq signals between anchors and apply the prediction model.

```r
# Compute correlation of signals
gi <- addCovCor(gi)

# Predict loops using the default pre-trained model
loops <- predLoops(gi)
```

## Advanced Usage

### Custom Model Training
If experimental loop data (e.g., Hi-C) is available, you can train a cell-type-specific model.

```r
# 1. Load known loops (e.g., Rao et al. format)
knownLoops <- parseLoopsRao("hic_loops.txt")

# 2. Label candidates
gi <- addInteractionSupport(gi, knownLoops)

# 3. Fit logistic regression
fit <- glm(loop ~ cor_chip + dist + strandOrientation, 
           data = mcols(gi), family = binomial())

# 4. Predict with custom parameters
gi <- predLoops(gi, 
                formula = loop ~ cor_chip + dist + strandOrientation, 
                betas = coef(fit), 
                cutoff = NULL)
```

### Downstream Analysis
The output is a `GInteractions` object, compatible with the `InteractionSet` and `GenomicInteractions` packages.

*   **Linking Regions:** Use `linkOverlaps()` to find loops connecting specific enhancers to promoters.
*   **Exporting:** Use `export.bedpe(loops, "output.bedpe", score = "pred")` for visualization in genome browsers like Juicebox or IGV.

## Key Functions
- `addCovToGR()`: Extracts ChIP-seq signal from bigWig files to GRanges.
- `prepareCisPairs()`: Wrapper to create candidate pairs and add distance/orientation.
- `addCovCor()`: Calculates signal correlation between interaction anchors.
- `predLoops()`: Predicts interactions using a logistic regression model.
- `parseLoopsRao()`: Utility to read Hi-C loop files from the Rao et al. format.

## Reference documentation
- [Prediction of chromatin looping interactions with sevenC](./references/sevenC.Rmd)
- [sevenC Package Manual](./references/sevenC.md)