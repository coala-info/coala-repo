---
name: bioconductor-intad
description: The InTAD package integrates transcriptomic and epigenomic data within the context of 3D genome organization to identify correlations between gene expression and distal regulatory signals. Use when user asks to identify functional enhancers within TADs, correlate gene expression with chromatin signals, or analyze regulatory interactions via chromatin loops.
homepage: https://bioconductor.org/packages/release/bioc/html/InTAD.html
---


# bioconductor-intad

## Overview

The `InTAD` package facilitates the integration of transcriptomic (RNA-seq) and epigenomic (e.g., ChIP-seq, ATAC-seq) data within the context of 3D genome organization. It identifies correlations between gene expression and distal regulatory signals located within the same TAD or connected via chromatin loops. This approach helps prioritize functional enhancers that regulate target genes across genomic distances.

## Core Workflow

### 1. Data Preparation and Object Creation
The analysis requires four main components: signal intensities (enhancers), signal coordinates, gene expression counts, and gene coordinates.

```R
library(InTAD)

# Create the InTADSig object
# enh: data.frame of signals (samples in columns)
# enhGR: GRanges of signal locations
# expr: data.frame of gene expression (samples in columns)
# geneGR: GRanges of gene locations (must have gene_id, gene_name)
# pheno: (Optional) data.frame of sample metadata
inTadSig <- newSigInTAD(enh, enhGR, expr, geneGR, pheno)
```

### 2. Pre-processing and Filtering
Filter out low-expressed genes to improve statistical power.

```R
# checkExprDistr = TRUE uses mclust to find an optimal expression cutoff
inTadSig <- filterGeneExpr(inTadSig, checkExprDistr = TRUE, min.expr = 1.0)
```

### 3. Spatial Integration (TADs or Loops)
You can associate signals and genes using either TAD boundaries or specific chromatin loops.

**Option A: Using TADs**
```R
# tadGR: GRanges object of TAD boundaries
inTadSig <- combineInTAD(inTadSig, tadGR)

# Perform correlation analysis within TADs
corData <- findCorrelation(inTadSig, method = "pearson", plot.proportions = TRUE)
```

**Option B: Using Chromatin Loops**
```R
# loopsDf: data.frame with 6 columns (chr1, x1, x2, chr2, y1, y2)
inTadSig <- combineWithLoops(inTadSig, loopsDf)

# Perform correlation analysis for loop-connected pairs
loopCor <- findCorFromLoops(inTadSig, method = "spearman")
```

### 4. Visualization
Visualize specific signal-gene pairs or broader genomic regions.

```R
# Scatter plot for a specific signal and gene
# cID is the peak/signal ID; "GABRA5" is the gene name
plotCorrelation(inTadSig, signalID = cID, geneName = "GABRA5", 
                colByPhenotype = "Subgroup")

# Regional plot showing correlations across a genomic window
plotCorAcrossRef(inTadSig, corData, 
                 targetRegion = GRanges("chr15:25000000-28000000"),
                 tads = tadGR, showCorVals = TRUE)
```

## Key Functions and Parameters

- `newSigInTAD`: Constructor for the main S4 object. Ensure sample names match between expression and signal matrices.
- `combineInTAD`: Links signals to genes. By default, it connects genes outside TADs to the closest TAD to avoid missing data due to boundary variance.
- `findCorrelation`: Computes correlation coefficients. Use `method = "spearman"` for non-linear relationships or `method = "pearson"` for linear ones.
- `plotCorAcrossRef`: Supports `symmetric = TRUE` to create a heatmap-style view similar to Hi-C contact maps.

## Tips for Success
- **Coordinate Consistency**: Ensure all GRanges objects (signals, genes, TADs) use the same genome build (e.g., hg19 or hg38).
- **Gene Metadata**: The gene GRanges object must contain `gene_id` and `gene_name` in the metadata columns.
- **Parallelization**: `newSigInTAD` and other functions support parallel processing via `BiocParallel` if configured in the R session.

## Reference documentation
- [Correlation of epigenetic signals and genes in TADs](./references/InTAD.md)