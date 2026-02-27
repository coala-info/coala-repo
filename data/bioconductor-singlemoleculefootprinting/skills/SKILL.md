---
name: bioconductor-singlemoleculefootprinting
description: This package analyzes Single Molecule Footprinting data to map molecular occupancy from aligned BAM files. Use when user asks to perform quality control on bait capture, call methylation at single-molecule resolution, sort molecules based on transcription factor binding sites, or perform unsupervised footprint detection.
homepage: https://bioconductor.org/packages/release/bioc/html/SingleMoleculeFootprinting.html
---


# bioconductor-singlemoleculefootprinting

## Overview

The `SingleMoleculeFootprinting` package provides a comprehensive toolkit for analyzing Single Molecule Footprinting (SMF) data. It enables users to move from aligned BAM files to high-resolution maps of molecular occupancy. The package supports both single-enzyme and double-enzyme SMF protocols. Key capabilities include quality control (bait capture and conversion rate), methylation calling at single-molecule resolution, unsupervised footprint detection via *FootprintCharter*, and supervised sorting of molecules based on known Transcription Factor Binding Sites (TFBS).

## Core Workflow

### 1. Setup and Input
The package uses `QuasR` pointer files (tab-delimited files with `FileName` and `SampleName`). Experiment types are inferred from the `SampleName` substring:
* `_NO_`: Single enzyme SMF (DGCHN & NWCGW contexts).
* `_DE_`: Double enzyme SMF (GCH + HCG contexts).
* `_SS_`: No enzyme (endogenous mCpG only, CG context).

```r
library(SingleMoleculeFootprinting)
library(GenomicRanges)

# Define region and sample
Qinput <- "path/to/sampleSheet.txt"
roi <- GRanges("chr6", IRanges(88106000, 88106500))
```

### 2. Quality Control
* **Bait Capture Efficiency**: Ratio of reads in baits vs total.
* **Conversion Rate**: Percentage of converted cytosines in non-SMF contexts (expected ~95%).

```r
# Bait efficiency
BaitCapture(sampleSheet = Qinput, genome = BSgenome.Mmusculus.UCSC.mm10, baits = BaitRegions)

# Conversion rate (slow, recommended for one chromosome)
ConversionRate(sampleSheet = Qinput, genome = BSgenome.Mmusculus.UCSC.mm10, chr = "chr19")
```

### 3. Methylation Calling
`CallContextMethylation` is the primary function for extracting methylation. Set `returnSM = TRUE` to get the single-molecule matrix.

```r
Methylation <- CallContextMethylation(
  sampleSheet = Qinput,
  sample = "MySample_DE_",
  genome = BSgenome.Mmusculus.UCSC.mm10,
  RegionOfInterest = roi,
  coverage = 20,
  returnSM = TRUE
)
# Methylation[[1]] is a GRanges of bulk methylation
# Methylation[[2]] is a list of sparse single-molecule matrices
```

### 4. Single Molecule Sorting (Supervised)
Classify reads based on occupancy at specific TFBS.
* **Single TF**: Uses 3 bins (upstream, motif, downstream).
* **TF Cluster**: Uses $n+2$ bins for $n$ motifs.

```r
# Sort by TF cluster
SortedReads <- SortReadsByTFCluster(
  MethSM = Methylation[[2]]$MySample_DE_, 
  TFBSs = TFBSs_GRanges
)

# Quantify states
StateQuantification(SortedReads = SortedReads, states = TFPairStates())
```

### 5. FootprintCharter (Unsupervised)
Detect footprints without prior motif knowledge using k-medoids partitioning.

```r
FC_results <- FootprintCharter(
  MethSM = Methylation[[2]]$MySample_DE_,
  RegionOfInterest = roi,
  k = 16, # Number of partitions
  TF.length = c(5, 75),
  nucleosome.length = c(120, 1000)
)
# Access detected footprints
head(FC_results$footprints.df)
```

### 6. Visualization
* **Bulk Signal**: `PlotAvgSMF` plots 1 - average methylation.
* **Single Molecule Heatmap**: `PlotSM` displays binary methylation patterns.

```r
# Plot average signal with TFBS annotation
PlotAvgSMF(MethGR = Methylation[[1]], RegionOfInterest = roi, TFBSs = TFBSs_GRanges)

# Plot sorted single molecules
PlotSM(
  MethSM = Methylation[[2]], 
  RegionOfInterest = roi, 
  SortedReads = SortedReads, 
  sorting.strategy = "classical"
)
```

## Tips for Large Scale Analysis
* **Genome-wide Sorting**: Use `Create_MethylationCallingWindows` to group nearby TFBS into larger windows (e.g., 1Mb) to reduce overhead.
* **Parallelization**: Many functions (e.g., `BaitCapture`, `CollectCompositeData`) accept a `clObj` or `cores` argument.
* **Masking SNPs**: In hybrid strains (e.g., BL6xCast), use `MaskSNPs` to remove cytosines disrupted by genetic variants to avoid SMF artifacts.

## Reference documentation
- [FootprintCharter](./references/FootprintCharter.md)
- [SingleMoleculeFootprinting Vignette](./references/SingleMoleculeFootprinting.Rmd)
- [Methylation Calling and QCs](./references/methylation_calling_and_QCs.md)
- [Single Molecule Sorting by TF](./references/single_molecule_sorting_by_TF.md)