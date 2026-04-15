---
name: bioconductor-qrqc
description: This tool performs fast quality control and visualization for high-throughput sequencing data in FASTQ and FASTA formats. Use when user asks to summarize base quality distributions, visualize GC content, analyze sequence length histograms, or detect contamination using k-mer entropy and Kullback-Leibler divergence.
homepage: https://bioconductor.org/packages/3.5/bioc/html/qrqc.html
---

# bioconductor-qrqc

name: bioconductor-qrqc
description: Quick Read Quality Control (qrqc) for FASTQ and FASTA files. Use this skill to perform fast quality checks on high-throughput sequencing data, including base quality distributions, sequence length histograms, GC content, k-mer entropy, and Kullback-Leibler divergence for contamination detection.

## Overview
The `qrqc` package provides a fast, C-backed interface for summarizing and visualizing the quality of sequencing reads. It is designed to handle large datasets efficiently by using random sampling (hashing) to estimate sequence and k-mer distributions. It integrates with `ggplot2` for highly customizable visualizations.

## Core Workflow

### 1. Loading Data
Use `readSeqFile` to process FASTQ or FASTA files. This function returns a `SequenceSummary` object (specifically `FASTQSummary` or `FASTASummary`).

```r
library(qrqc)

# Read a FASTQ file (default)
s.fastq <- readSeqFile("path/to/file.fastq")

# Read a FASTA file
s.fasta <- readSeqFile("path/to/file.fasta", type="fasta")

# Adjust sampling proportion (default is 0.1 or 10%)
s.sampled <- readSeqFile("file.fastq", hash.prop=0.05)

# Enable k-mer hashing (default k=6)
s.kmer <- readSeqFile("file.fastq", kmer=TRUE, k=6)
```

### 2. Quality and Base Visualization
`qrqc` provides specialized plotting functions that return `ggplot2` objects.

*   **Quality Plot:** `qualPlot(s.fastq)` - Shows 10%/90% quantiles (grey), quartiles (orange), median (blue dot), and mean (green dash).
*   **Base Distribution:** `basePlot(s.fastq, type="frequency")` or `type="proportion"`.
*   **Sequence Length:** `seqlenPlot(s.fastq)` - Histogram of read lengths.
*   **GC Content:** `gcPlot(s.fastq)` - GC percentage by position.

### 3. Contamination and k-mer Analysis
If `kmer=TRUE` was used during reading:

*   **Shannon Entropy:** `kmerEntropyPlot(s.fastq)` - Measures sequence complexity/randomness by position.
*   **K-L Divergence:** `kmerKLPlot(s.fastq)` - Identifies overrepresented k-mers by calculating Kullback-Leibler divergence between local and global k-mer distributions.

### 4. Comparative Analysis
You can pass a named list of summary objects to plotting functions to compare samples (e.g., before and after trimming).

```r
# Compare trimmed vs untrimmed
qualPlot(list("Trimmed"=s.trimmed, "Original"=s.raw))
```

## Customization and Data Access

### Accessor Functions
If you need the raw data for custom analysis, use these accessors to get data frames:
*   `getQual(obj)`: Quality statistics by position.
*   `getBase(obj)`: Base counts by position.
*   `getBaseProp(obj)`: Base proportions by position.
*   `getSeqlen(obj)`: Sequence length counts.
*   `getKmer(obj)`: K-mer frequencies.

### ggplot2 Integration
Since plots are `ggplot2` objects, you can extend them:
```r
# Add a horizontal line to GC plot
gcPlot(s.fastq) + geom_hline(yintercept=0.5, color="red") + theme_bw()

# Zoom into a specific position range
qualPlot(s.fastq) + scale_x_continuous(limits=c(0, 50))
```

## HTML Reports
Generate a comprehensive summary report in a directory:
```r
makeReport(s.fastq, outputDir="QC_Report")
```

## Reference documentation
- [Using the qrqc package to gather information about sequence qualities](./references/qrqc.md)