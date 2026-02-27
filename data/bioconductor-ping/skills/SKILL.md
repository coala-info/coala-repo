---
name: bioconductor-ping
description: PING performs probabilistic inference to identify nucleosome positions from high-throughput sequencing data. Use when user asks to infer nucleosome positions, segment genomic regions for nucleosome analysis, or post-process nucleosome predictions from MNase or sonicated data.
homepage: https://bioconductor.org/packages/3.5/bioc/html/PING.html
---


# bioconductor-ping

## Overview

PING (Probabilistic Inference for Nucleosome Positioning) is a Bioconductor package designed to infer nucleosome positions from high-throughput sequencing data. It extends the PICS algorithm by using a specialized prior for nucleosome spatial positioning, different model selection criteria, and automated post-processing to handle atypical fragment lengths or overlapping predictions.

## Typical Workflow

### 1. Data Input and Formatting
PING requires data in a `GRanges` object. You can convert BAM files using the `PICS` package helper or read BED files.

```r
library(PING)
library(PICS)

# For Paired-End (PE) data
yeastBam <- system.file("extdata/yeastChrI.bam", package = "PING")
gr <- bam2gr(bamFile = yeastBam, PE = TRUE)

# For Single-End (SE) data
path <- system.file("extdata", package = "PING")
dataIP <- read.table(file.path(path, "GSM351492_R4_chr1.bed"), header = TRUE)
gr <- as(dataIP, "GRanges")
```

### 2. Genome Segmentation
The genome must be segmented into candidate regions with sufficient read density before running the probabilistic model.

```r
# For Single-End: minReads=NULL estimates threshold automatically
seg <- segmentPING(gr, minReads = NULL, maxLregion = 1200, jitter = TRUE)

# For Paired-End: Set PE = TRUE
# islandDepth, min_cut, and max_cut control candidate selection for PE
segPE <- segmentPING(grI, PE = TRUE)
```

### 3. Parameter Estimation
The `PING` function performs the actual inference. Use the `parallel` package to speed up computation on multiple cores.

```r
library(parallel)
# dataType defaults to "MNase"; use "sonicated" if applicable
pingRes <- PING(seg, nCores = 2, dataType = "MNase")
```

### 4. Post-processing
Refine predictions to correct for atypical fragment lengths (delta), large sigma values, or boundary issues where nucleosomes in adjacent regions might be duplicates.

```r
# Ensure dataType matches the PING step
PS <- postPING(pingRes, seg, dataType = "MNase")
```

### 5. Export and Visualization
Convert results to `RangedData` for export to BED format or use built-in plotting tools.

```r
# Exporting
library(rtracklayer)
rdBed <- makeRangedDataOutput(PS, type = "bed") # Uses predicted delta
rdFix <- makeRangedDataOutput(PS, type = "fixed") # Fixed 147bp size
export(rdBed, "nuc_predictions.bed")

# Visualization
# Shows coverage, forward/reverse reads, and nucleosome scores
plotSummary(PS, pingRes, gr, chr = "chr1", from = 149000, to = 153000)
```

## Key Parameters and Tips
- **dataType**: Crucial parameter in `PING()` and `postPING()`. Set to `"sonicated"` if the DNA was fragmented via sonication rather than MNase digestion.
- **minReads**: In `segmentPING`, setting this too low increases computation time; setting it too high may miss real nucleosomes. `NULL` is a safe starting point for automatic estimation.
- **Mappability**: For higher accuracy, PING can use mappability profiles to account for non-uniquely alignable genomic regions.
- **Scores**: Nucleosomes are assigned a score; `plotSummary` filters out those below 0.05 by default.

## Reference documentation

- [Using PING with Paired-End sequencing data](./references/PING-PE.md)
- [PING: Probabilistic Inference for Nucleosome Positioning](./references/PING.md)