---
name: bioconductor-rnamodr.ribomethseq
description: This package detects 2'-O methylations in RNA by analyzing read end frequencies from RiboMethSeq data within the RNAmodR framework. Use when user asks to detect 2'-O methylations, calculate RiboMethSeq scores, or visualize methylation sites and performance metrics.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAmodR.RiboMethSeq.html
---

# bioconductor-rnamodr.ribomethseq

## Overview

The `RNAmodR.RiboMethSeq` package extends the `RNAmodR` framework to specifically handle RiboMethSeq data. It detects 2'-O methylations by analyzing the frequency of read ends; since these modifications protect the phosphodiester bond from alkaline cleavage, a drop in read end frequency at a specific position indicates a methylation. The package calculates several standard metrics, including `scoreRMS`, `scoreA`, `scoreB`, and `scoreMean`.

## Core Workflow

### 1. Data Preparation
You need three components to start the analysis:
- **Annotation**: A GFF3 file or `TxDb` object.
- **Sequences**: A FASTA file or `BSgenome` object.
- **Files**: A named list of BAM file paths. Replicates should be grouped.

```r
library(RNAmodR.RiboMethSeq)
library(rtracklayer)

annotation <- GFF3File("path/to/annotation.gff3")
sequences <- "path/to/sequences.fasta"
files <- list("Sample1" = c(treated = "sample1_rep1.bam", treated = "sample1_rep2.bam"),
              "Sample2" = c(treated = "sample2_rep1.bam"))
```

### 2. Analyzing Data
The primary entry point is the `ModSetRiboMethSeq` constructor. This function processes the BAM files, aggregates read end data, and calculates RiboMethSeq scores.

```r
msrms <- ModSetRiboMethSeq(files, annotation = annotation, sequences = sequences)
```

### 3. Inspecting Results
The resulting object contains the detected modifications and the settings used for the analysis.
- `ranges(msrms)`: Get the genomic coordinates of the transcripts.
- `modifications(msrms)`: Extract the identified 2'-O methylation sites.
- `settings(msrms)`: View or modify the detection thresholds (e.g., `minScoreRMS`, `minScoreMean`).

### 4. Visualization
The package provides specialized plotting functions to compare samples or inspect specific sites.

**Compare multiple samples at specific coordinates:**
```r
# coord is a GRanges object of positions to check
plotCompareByCoord(msrms, coord, alias = data.frame(tx_id = "1", name = "5.8S rRNA"))
```

**Visualize raw data and scores for a single site:**
```r
# showSequenceData = TRUE adds the underlying read end counts
plotDataByCoord(msrms, singleCoord, showSequenceData = TRUE)
```

**Performance Assessment:**
Use a Receiver Operating Characteristic (ROC) plot if you have a set of known "gold standard" positions to validate against.
```r
plotROC(msrms, known_coord)
```

## Adjusting Sensitivity
If the default detection is too strict or too lenient, update the settings and re-run the modification search:

```r
# Update a specific threshold
settings(msrms) <- list(minScoreMean = 0.7)

# Force update the modification calls based on new settings
msrms <- modify(msrms, force = TRUE)
```

## Tips for Success
- **Transcript IDs**: Ensure the `Parent` field in your coordinate GRanges matches the transcript IDs in your annotation object.
- **Parallelization**: The package uses `BiocParallel`. You can register a parallel backend (e.g., `MulticoreParam()`) before running `ModSetRiboMethSeq` to speed up processing of large BAM files.
- **Score Selection**: `scoreRMS` is the default and generally recommended, but `scoreA` and `scoreB` are provided for compatibility with different RiboMethSeq scoring conventions.

## Reference documentation
- [RNAmodR: RiboMethSeq](./references/RNAmodR.RiboMethSeq.md)