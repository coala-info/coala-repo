---
name: bioconductor-rnamodr.alkanilineseq
description: This package detects m7G, m3C, and Dihydrouridine RNA modifications by analyzing 5'-end accumulation from AlkAnilineSeq high-throughput sequencing data. Use when user asks to identify RNA modification sites, calculate modification scores from BAM files, or visualize modification patterns across transcripts and samples.
homepage: https://bioconductor.org/packages/release/bioc/html/RNAmodR.AlkAnilineSeq.html
---


# bioconductor-rnamodr.alkanilineseq

## Overview

The `RNAmodR.AlkAnilineSeq` package extends the `RNAmodR` framework to detect 7-methylguanosine (m7G), 3-methylcytidine (m3C), and Dihydrouridine (D) modifications. These modifications are detected via the AlkAnilineSeq protocol, which uses sodium borohydride and aniline treatment to induce strand breaks at modified sites. The package identifies these sites by analyzing the accumulation of 5'-ends at the N+1 position relative to the modification.

## Core Workflow

### 1. Data Preparation
You need three components:
- **Annotation**: A GFF3 file or `TxDb` object.
- **Sequences**: A FASTA file or `BSgenome` object.
- **Files**: A named list of BAM file paths. Replicates should be grouped under the same name and labeled as `treated`.

```r
library(RNAmodR.AlkAnilineSeq)
library(rtracklayer)

# Define resources
annotation <- GFF3File("path/to/annotation.gff3")
sequences <- "path/to/reference.fasta"

# Organize BAM files
files <- list(
  "wt" = c(treated = "wt_rep1.bam", treated = "wt_rep2.bam"),
  "mutant" = c(treated = "mut_rep1.bam", treated = "mut_rep2.bam")
)
```

### 2. Detecting Modifications
The analysis is triggered by creating a `ModSetAlkAnilineSeq` object. This process aggregates data and calculates scores (`scoreNC` and `scoreSR`).

```r
# Run the analysis
msaas <- ModSetAlkAnilineSeq(files, annotation = annotation, sequences = sequences)

# Inspect the results
msaas
```

### 3. Extracting Results
Use the `modifications()` function to retrieve a list of `GRanges` objects containing the detected modifications and their associated scores.

```r
# Get all detected modifications
mod_list <- modifications(msaas)

# Access specific metadata (e.g., scoreSR, mod type)
head(mod_list[["wt"]])
```

## Visualization

### Heatmaps for Comparison
Compare modification levels across different samples or conditions using `plotCompareByCoord`.

```r
# Plot heatmap for specific coordinates
# scoreSR (Stop Ratio) is the standard metric for AlkAnilineSeq
plotCompareByCoord(msaas, mod_list[[1]], score = "scoreSR", normalize = TRUE)
```

### Transcript-level Plots
Visualize the aggregate data along a specific transcript.

```r
# Plot data for a specific transcript ID
plotData(msaas, "transcript_id_1", from = 100, to = 200)

# Show raw sequence data alongside scores
plotData(msaas, "transcript_id_1", from = 100, to = 200, showSequenceData = TRUE)
```

## Tips for Success
- **Score Interpretation**: `scoreNC` is the default score, while `scoreSR` (Stop Ratio) represents the ratio of stops at a specific position.
- **Modification Identity**: The package distinguishes between m7G, m3C, and D based on the underlying reference nucleotide (G, C, or U/T) at the site of the 5'-end accumulation.
- **Parallelization**: The package uses `BiocParallel`. You can register a parallel backend (e.g., `MulticoreParam()`) before running `ModSetAlkAnilineSeq` to speed up processing of large datasets.
- **Filtering**: You can adjust detection thresholds (e.g., `minScoreNC`, `minScoreSR`) during the object construction phase to stringency.

## Reference documentation
- [RNAmodR: AlkAnilineSeq](./references/RNAmodR.AlkAnilineSeq.md)