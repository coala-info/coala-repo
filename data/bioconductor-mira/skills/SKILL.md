---
name: bioconductor-mira
description: This tool aggregates DNA methylation data across genomic region sets to infer regulatory activity based on methylation profiles. Use when user asks to aggregate methylation data across regions, generate methylation profiles, or calculate MIRA scores to predict transcription factor activity.
homepage: https://bioconductor.org/packages/release/bioc/html/MIRA.html
---

# bioconductor-mira

name: bioconductor-mira
description: Infer regulatory activity from DNA methylation data using Methylation-based Inference of Regulatory Activity (MIRA). Use this skill to aggregate single-nucleotide resolution methylation data (RRBS/WGBS) across genomic region sets (ChIP-seq peaks, DHSs) to generate methylation profiles and MIRA scores for predicting transcription factor activity.

# bioconductor-mira

## Overview
MIRA (Methylation-based Inference of Regulatory Activity) is a Bioconductor package that aggregates DNA methylation data across sets of genomic regions to infer regulatory activity. It operates on the principle that active genomic regions (where transcription factors bind) exhibit lower DNA methylation levels, creating a "dip" in the methylation profile. By quantifying the shape of this dip, MIRA provides a score representing the regulatory activity of specific biological annotations across different samples.

## Core Workflow

### 1. Data Preparation
MIRA requires two main inputs:
- **Methylation Data (BSDT):** A `data.table` (Bisulfite Data Table) per sample containing `chr`, `start`, and `methylProp` (0-1). Use `BSreadBiSeq` for Biseqmethcalling files or `SummarizedExperimentToDataTable` for other formats.
- **Region Sets:** A `GRanges` or `GRangesList` object containing regions sharing a biological feature (e.g., Nrf1 binding sites).

```r
library(MIRA)
library(data.table)
library(GenomicRanges)

# Load methylation data
bsdt <- fread("sample.bed")
setNames(bsdt, c("chr", "start", "methylCount", "coverage"))
# Add methylProp column if missing
bsdt[, methylProp := methylCount / coverage]

# Load and format region sets
regions <- fread("regions.bed")
gr <- GRanges(seqnames = regions$V1, ranges = IRanges(regions$V2, regions$V3))
```

### 2. Region Expansion
MIRA scores depend on the contrast between the region center and its surroundings. Regions must be resized (typically to 1000-5000bp) to capture the "shoulders" of the methylation dip.

```r
# Resize regions to 4000bp centered on the original site
gr_expanded <- resize(gr, width = 4000, fix = "center")
```

### 3. Aggregation (Profile Generation)
The `aggregateMethyl` function divides regions into bins and calculates the mean methylation per bin across all regions in the set.

```r
# Aggregate into 21 bins (odd number recommended for symmetry)
binned_data <- aggregateMethyl(BSDT = bsdt, GRList = gr_expanded, binNum = 21)
```

### 4. Scoring and Visualization
The `calcMIRAScore` function quantifies the dip. Higher scores indicate deeper dips and higher inferred regulatory activity.

```r
# Calculate MIRA score
score <- calcMIRAScore(binned_data, 
                       regionSetIDColName = "featureID", 
                       sampleIDColName = "sampleName")

# Plot the profile
plotMIRAProfiles(binned_data)
```

## Key Functions
- `BSreadBiSeq()`: Reads methylation calls from Biseqmethcalling.
- `SummarizedExperimentToDataTable()`: Converts `BSseq` or `BiSeq` objects to MIRA-compatible `data.table`.
- `addMethPropCol()`: Adds the required `methylProp` column to a list of BSDTs.
- `aggregateMethyl()`: The core engine for binning and aggregating methylation data.
- `calcMIRAScore()`: Calculates the MIRA score (default is log-ratio of shoulders to center).
- `plotMIRAProfiles()`: Generates ggplot2 visualizations of the aggregated methylation dips.
- `plotMIRAScores()`: Visualizes scores across samples and features.

## Practical Tips
- **Bin Selection:** Use an odd number of bins (e.g., 11, 21) to ensure a clear center bin.
- **Region Sizing:** If the dip in `plotMIRAProfiles` is too narrow or doesn't reach the edges, increase the `resize` width. If the dip is too small to see, decrease the width.
- **Normalization:** For better comparison of shapes across samples with different global methylation levels, normalize by subtracting the minimum methylation value: `dt[, methylProp := methylProp - min(methylProp), by = .(featureID, sampleName)]`.
- **Parallelization:** Use `lapply` or `mclapply` over a list of BSDTs to process multiple samples simultaneously.

## Reference documentation
- [Applying MIRA to a Biological Question](./references/BiologicalApplication.md)
- [Getting Started with Methylation-based Inference of Regulatory Activity](./references/GettingStarted.md)