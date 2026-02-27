---
name: bioconductor-r3cseq
description: The r3Cseq package identifies long-range genomic interactions from 3C-seq data by analyzing read counts around a specific viewpoint. Use when user asks to analyze 3C-seq data, identify significant genomic interactions, normalize restriction fragment counts, or visualize interaction landscapes near a viewpoint.
homepage: https://bioconductor.org/packages/release/bioc/html/r3Cseq.html
---


# bioconductor-r3cseq

## Overview

The `r3Cseq` package is designed for the discovery of long-range genomic interactions from 3C-seq data. It supports experimental designs with or without controls, as well as replicates. The workflow typically involves defining a "viewpoint" (the genomic element of interest), mapping reads to restriction fragments, normalizing data, and identifying statistically significant interaction regions.

## Core Workflow

### 1. Object Initialization
Create an `r3Cseq` object by specifying the organism, viewpoint coordinates (or primers), and restriction enzyme.

```r
library(r3Cseq)

# Initialize for mm9, HindIII digestion, with a control
my3Cseq.obj <- new("r3Cseq",
                   organismName='mm9',
                   isControlInvolved=TRUE,
                   viewpoint_chromosome='chr10',
                   viewpoint_primer_forward='TCTTTGTTTGATGGCATCTGTT',
                   viewpoint_primer_reverse='AAAGGGGAGGAGAAGGAGGT',
                   expLabel="Fetal_Liver",
                   contrLabel="Fetal_Brain",
                   restrictionEnzyme='HindIII')
```

### 2. Loading Data
Input data must be in BAM format. Ensure chromosome identifiers match the BSgenome format (e.g., "chr1").

```r
# For single experiments
# expRawData(my3Cseq.obj) <- exp.GRanges
# contrRawData(my3Cseq.obj) <- contr.GRanges

# For replicates, use r3CseqInBatch class and getBatchRawReads()
```

### 3. Quantification and Normalization
Count reads mapped to restriction fragments (or fixed windows) and calculate Reads Per Million (RPM).

```r
# Count reads per restriction fragment
getReadCountPerRestrictionFragment(my3Cseq.obj)

# Or count per window (e.g., 20kb)
# getReadCountPerWindow(my3Cseq.obj, windowSize=20000)

# Normalize
calculateRPM(my3Cseq.obj)
```

### 4. Identifying Interactions
Perform statistical analysis to find significant interactions based on a False Discovery Rate (FDR) threshold.

```r
# Identify interactions
getInteractions(my3Cseq.obj, fdr=0.05)

# Extract results as GRanges
exp_interactions <- expInteractionRegions(my3Cseq.obj)
contr_interactions <- contrInteractionRegions(my3Cseq.obj)
```

### 5. Visualization
The package provides several plotting functions to inspect the interaction landscape.

```r
# Genome-wide overview
plotOverviewInteractions(my3Cseq.obj)

# Zoomed view near the viewpoint
plotInteractionsNearViewpoint(my3Cseq.obj)

# Specific chromosome view
plotInteractionsPerChromosome(my3Cseq.obj, "chr10")

# Domainogram (computationally intensive)
plotDomainogramNearViewpoint(my3Cseq.obj, view="both")
```

### 6. Annotation and Export
Associate interactions with genes or export for genome browsers.

```r
# Get genes near interaction signals
detected_genes <- getExpInteractionsInRefseq(my3Cseq.obj)

# Export to bedGraph for UCSC Genome Browser
export3Cseq2bedGraph(my3Cseq.obj)

# Generate a comprehensive PDF report
generate3CseqReport(my3Cseq.obj)
```

## Key Considerations
- **Genome Support**: Requires appropriate `BSgenome` masked packages (e.g., `BSgenome.Mmusculus.UCSC.mm9.masked`).
- **BAM Naming**: Avoid special characters in BAM filenames; use underscores instead of hyphens or dots.
- **Replicates**: For experiments with replicates, use the `r3CseqInBatch` class and corresponding `Batch` functions (e.g., `getBatchInteractions`).
- **Viewpoint Trimming**: 3C-seq reads are composite; ensure reads were trimmed to remove viewpoint sequences before mapping to the reference genome.

## Reference documentation
- [r3Cseq: discovery of long-range genomic interactions](./references/r3Cseq.md)
- [r3Cseq Vignette (RMarkdown)](./references/r3Cseq.Rmd)