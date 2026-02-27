---
name: bioconductor-rtnduals
description: This tool identifies dual regulons and analyzes co-regulation patterns between pairs of regulators to determine if they cooperate or compete for shared target genes. Use when user asks to infer dual regulons, analyze regulatory patterns between pairs of transcription factors or miRNAs, or determine the nature of co-regulation for shared targets.
homepage: https://bioconductor.org/packages/release/bioc/html/RTNduals.html
---


# bioconductor-rtnduals

name: bioconductor-rtnduals
description: Analysis of co-regulation and inference of dual regulons using the RTNduals R package. Use this skill to identify regulatory patterns between pairs of regulators (TFs, miRNAs, etc.) and determine if they cooperate or compete in regulating shared target genes.

# bioconductor-rtnduals

## Overview

RTNduals is an extension of the RTN (Reconstruction of Transcriptional Networks) package designed to identify "dual regulons." It analyzes triplets consisting of two regulators and a shared target gene to determine the nature of their co-regulation. The package distinguishes between:
- **Cooperation**: Regulators influence shared targets in the same direction (co-activation or co-repression).
- **Competition**: Regulators influence shared targets in opposite directions.

The workflow integrates mutual information (MI) for target assignment, correlation analysis for regulatory direction, and Fisher's exact tests for overlap significance.

## Workflow and Core Functions

### 1. Data Preparation and TNI Construction
The process begins with a `TNI-class` object (from the RTN package). You need an expression matrix (genes in rows, samples in columns) and a vector of regulator IDs.

```R
library(RTNduals)
library(RTN)

# Example using internal RTN data
data("tniData", package = "RTN")
rtni <- tni.constructor(expData = tniData$expData, 
                        regulatoryElements = c("IRF8","IRF1","PRDM1"), 
                        rowAnnotation = tniData$rowAnnotation)
```

### 2. Network Inference (RTN Steps)
Before dual analysis, the transcriptional network must be inferred and filtered.

```R
# Permutation analysis for MI significance
rtni <- tni.permutation(rtni, nPermutations = 1000)

# Bootstrap analysis for network stability
rtni <- tni.bootstrap(rtni, nBootstrap = 100)

# Data Processing Inequality (DPI) filtering to remove indirect interactions
rtni <- tni.dpi.filter(rtni, eps = NA)
```

### 3. Dual Regulon Inference
Convert the `TNI` object to an `MBR` (Multi-level Binary Regulon) object and run the association analysis.

```R
# Preprocess TNI to MBR
rmbr <- tni2mbrPreprocess(rtni)

# Run association analysis to identify dual regulons
rmbr <- mbrAssociation(rmbr)
```

### 4. Extracting Results
Use `mbrGet` to retrieve summary statistics and specific overlap/correlation data.

```R
# Check summary of tested vs predicted duals
mbrGet(rmbr, what = "summary")

# Get overlap significance (Fisher's test results)
overlap <- mbrGet(rmbr, what = "dualsOverlap")

# Get correlation analysis (direction of co-regulation)
correlation <- mbrGet(rmbr, what = "dualsCorrelation")
```

## Tips for Success
- **Regulator Types**: RTNduals is flexible; you can mix different types of regulators (e.g., TF-miRNA) as long as their expression data is present in the input matrix.
- **Computational Intensity**: Permutation (`nPermutations`) and Bootstrap (`nBootstrap`) steps are resource-intensive. For final publications, use at least 1000 permutations and 100 bootstraps.
- **DPI Filtering**: Always apply `tni.dpi.filter` before dual analysis to ensure that the shared targets identified are likely direct targets of both regulators.

## Reference documentation

- [RTNduals: analysis of co-regulation and inference of dual regulons](./references/RTNduals.md)