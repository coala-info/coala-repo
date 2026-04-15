---
name: bioconductor-tsrchitect
description: This tool analyzes transcription start site profiling data to identify and characterize transcription start regions. Use when user asks to identify transcription start regions, calculate promoter shape metrics, or associate transcription start regions with genomic annotations.
homepage: https://bioconductor.org/packages/3.8/bioc/html/TSRchitect.html
---

# bioconductor-tsrchitect

name: bioconductor-tsrchitect
description: Analysis of high-throughput transcription start site (TSS) profiling data (CAGE, RAMPAGE, PEAT, STRIPE-seq). Use this skill to identify transcription start regions (TSRs), calculate promoter shape metrics (SI, mSI), and associate TSRs with gene annotations in R.

# bioconductor-tsrchitect

## Overview
TSRchitect is an R/Bioconductor package designed for the identification and analysis of Transcription Start Regions (TSRs) from various TSS profiling technologies. It supports both single-end (CAGE, TSS-seq) and paired-end (RAMPAGE, PEAT, STRIPE-seq) data. The package provides a structured S4 workflow to convert raw alignments into TSS coordinates, cluster them into TSRs, and quantify promoter characteristics like width, Shape Index (SI), and torque.

## Core Workflow

### 1. Initialization and Data Loading
The workflow centers around the `tssObject`. Data can be imported from BAM or BED files.

```R
library(TSRchitect)

# Initialize tssObject from BAM files
# sampleNames and replicateIDs must correspond to the alphabetical order of files in inputDir
tssObj <- loadTSSobj(
  experimentTitle = "My_TSS_Experiment",
  inputDir = "path/to/bamFiles",
  isPairedBAM = TRUE,
  sampleNames = c("ctrl-r1", "ctrl-r2", "test-r1", "test-r2"),
  replicateIDs = c(1, 1, 2, 2)
)
```

### 2. TSS Processing
Convert alignments to TSS coordinates and calculate tag abundances.

```R
# Extract TSS from alignments
tssObj <- inputToTSS(experimentName = tssObj)

# Calculate abundance (can be run in parallel)
tssObj <- processTSS(
  experimentName = tssObj, 
  n.cores = 4, 
  tssSet = "all", 
  writeTable = FALSE
)
```

### 3. TSR Identification
Cluster TSSs into regions (TSRs) based on distance and abundance thresholds.

```R
# Identify TSRs for individual replicates
tssObj <- determineTSR(
  experimentName = tssObj, 
  tsrSetType = "replicates", 
  tssSet = "all", 
  tagCountThreshold = 25, 
  clustDist = 20
)

# Merge replicates into samples and identify merged TSRs
tssObj <- mergeSampleData(experimentName = tssObj)
tssObj <- determineTSR(
  experimentName = tssObj, 
  tsrSetType = "merged", 
  tssSet = "all", 
  tagCountThreshold = 40, 
  clustDist = 20
)
```

### 4. Annotation and Analysis
Associate identified TSRs with genomic features (GFF3/GTF).

```R
# Import annotation (External file or via AnnotationHub)
tssObj <- importAnnotationExternal(
  experimentName = tssObj, 
  fileType = "gff3", 
  annotFile = "path/to/annotation.gff3"
)

# Associate TSRs with transcripts/genes
tssObj <- addAnnotationToTSR(
  experimentName = tssObj, 
  tsrSetType = "merged", 
  tsrSet = 1, 
  upstreamDist = 1000, 
  downstreamDist = 200, 
  feature = "transcript", 
  featureColumnID = "ID"
)
```

## Key Metrics and Accessors

- **Shape Index (SI)**: Measures promoter "peakedness" (max 2.0).
- **Modified Shape Index (mSI)**: Scaled metric (0 to 1) where 1 is a single unique TSS.
- **Torque (tsrTrq)**: Balance of the TSR based on tag distribution.
- **Accessing Data**: Use `getTSRdata(tssObj, slotType="merged", slot=1)` to retrieve a data frame of results.

## Tips for Success
- **File Ordering**: `loadTSSobj` maps `sampleNames` to files based on alphabetical order. Verify with `getFileNames(tssObj)`.
- **Parallelization**: Use the `n.cores` argument in `processTSS` and `determineTSR` for large datasets.
- **Clustering**: The `clustDist` parameter (default 20bp) is the most sensitive variable for defining promoter boundaries.
- **Output**: Set `writeTable = TRUE` in processing functions to automatically save text-based reports to the working directory.

## Reference documentation
- [TSRchitect Introduction](./references/TSRchitect.Rmd)
- [TSRchitect Vignette](./references/TSRchitect.md)
- [TSRchitect User's Guide](./references/TSRchitectUsersGuide.md)
- [CAGE and RAMPAGE Analysis Patterns](./references/vignette_3.md)