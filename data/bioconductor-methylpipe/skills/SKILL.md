---
name: bioconductor-methylpipe
description: This tool analyzes base-pair resolution DNA methylation data using a memory-efficient framework for data management and comparative analysis. Use when user asks to process methylation calls from aligned files, manage large-scale datasets with TABIX indexing, profile methylation across genomic ranges, or identify differentially methylated regions.
homepage: https://bioconductor.org/packages/release/bioc/html/methylPipe.html
---

# bioconductor-methylpipe

name: bioconductor-methylpipe
description: Analysis of base-pair resolution DNA methylation data using the methylPipe R package. Use this skill to process methylation calls from aligned files (SAM/Bismark), manage large-scale methylation datasets using TABIX indexing, profile methylation across genomic ranges, and identify differentially methylated regions (DMRs).

## Overview
The `methylPipe` package provides a memory-efficient framework for managing and analyzing genome-wide DNA methylation data at base-pair resolution. It supports various sequence contexts (CG, CHG, CHH) and integrates with `GRanges` for region-specific analysis. Key features include TABIX-based data storage to minimize memory footprint and robust methods for differential methylation analysis.

## Core Classes
- **BSdata**: Stores methylation data for a single biological sample.
- **BSdataSet**: Combines multiple `BSdata` objects for comparative analysis.
- **GEcollection**: Stores methylation status for a collection of genomic regions (extends `RangedSummarizedExperiment`).
- **GElist**: A list of multiple `GEcollection` objects.

## Typical Workflow

### 1. Data Preparation and Loading
Methylation calls can be extracted from sorted SAM files (e.g., from Bismark) or text files.

```R
library(methylPipe)
library(BSgenome.Hsapiens.UCSC.hg18)

# Process SAM files to create methylation calls
meth.call(files_location="path/to/sam", output_folder=tempdir(), read.context="CpG")

# Prepare TABIX indexed files (requires tabix installed)
# BSprepare(files_location="meth_calls.txt", output_folder="output", tabix="/path/to/tabix")

# Create a BSdata object
# uncov_GR should be a GRanges object of regions not covered by sequencing
bs_sample <- BSdata(file="sample_tabix.txt.gz", uncov=uncov_GR, org=Hsapiens)
```

### 2. Comparative Dataset Management
Group samples into "C" (Control) and "E" (Experiment) for downstream analysis.

```R
# Combine samples into a set
bs_set <- BSdataSet(org=Hsapiens, group=c("C", "E"), 
                    Control1=bs_ctrl, Experiment1=bs_exp)

# Check sample similarity and descriptive stats
stats_res <- methstats(bs_set, chrom="chr20", mcClass='mCG')
```

### 3. Profiling Genomic Regions
Extract methylation levels for specific regions of interest (e.g., promoters, enhancers).

```R
# Map methylation data to specific GRanges
res_mC <- mapBSdata2GRanges(GenoRanges=my_regions, Sample=bs_sample, context='CG')

# Profile methylation in bins across regions
gec <- profileDNAmetBin(GenoRanges=my_regions, Sample=bs_sample, mcCLASS='mCG', nbins=3)

# Access binned data: binmC (absolute), binC (potential sites), binrC (relative mC/C)
binrC(gec)[1:5, ]
```

### 4. Differential Methylation Analysis
Identify Differentially Methylated Regions (DMRs) using non-parametric tests.

```R
# Find DMRs using a sliding window approach
# dmrSize: min number of mCs; dmrBp: max distance between mCs
dmrs <- findDMR(object=bs_set, ROI=my_regions, MCClass='mCG', dmrSize=6, dmrBp=800)

# Consolidate and filter DMRs
hyper_dmrs <- consolidateDMRs(DmrGR=dmrs, pvThr=0.05, GAP=100, type="hyper")
```

### 5. Visualization
Visualize methylation profiles alongside gene annotations.

```R
library(TxDb.Hsapiens.UCSC.hg18.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg18.knownGene

# Plot GElist or BSdata objects
plotMeth(my_gelist, colors=c("red", "blue"), transcriptDB=txdb, 
         chr="chr20", start=10000, end=20000, org=Hsapiens)
```

## Tips for Efficiency
- **Memory Management**: `methylPipe` uses TABIX indexing; data is referenced on disk and not fully loaded into memory until specific queries (like `mCsmoothing` or `mapBSdata2GRanges`) are made.
- **Parallel Processing**: Use the `Nproc` argument in functions like `meth.call`, `methstats`, and `findDMR` to utilize multiple cores.
- **Uncovered Regions**: Always provide the `uncov` GRanges to `BSdata` to distinguish between unmethylated cytosines and regions with zero sequencing coverage.

## Reference documentation
- [methylPipe](./references/methylPipe.md)