---
name: bioconductor-rgadem
description: rGADEM implements a genetic algorithm to discover de novo motifs in large-scale genomic datasets such as ChIP-seq peaks. Use when user asks to find motifs in genomic sequences, run the GADEM algorithm, or identify binding sites from peak data.
homepage: https://bioconductor.org/packages/release/bioc/html/rGADEM.html
---


# bioconductor-rgadem

## Overview

rGADEM is an R implementation of the GADEM (Genetic Algorithm for Motif Discovery) algorithm. It is designed to efficiently find motifs in large-scale genomic datasets. It combines a genetic algorithm with a dynamic programming approach for local alignment (Smith-Waterman) to identify motifs without requiring prior knowledge of the binding sites. It is particularly effective for processing ChIP-seq data where the input consists of several hundred to thousands of peak sequences.

## Workflow and Usage

### 1. Data Preparation
rGADEM requires input sequences in the form of a `RangedData` object (older versions) or more commonly a `GRanges` object from the `GenomicRanges` package, along with a `BSgenome` object representing the reference genome.

```r
library(rGADEM)
library(BSgenome.Hsapiens.UCSC.hg19) # Example genome

# Load your peaks (e.g., from a BED file)
# peaks <- read.table("peaks.bed", header=F)
# range <- GRanges(seqnames=peaks[,1], ranges=IRanges(peaks[,2], peaks[,3]))
```

### 2. Running Motif Discovery
The primary function is `GADEM()`. It takes the genomic ranges and the genome object as primary arguments.

```r
# Basic execution
gadem <- GADEM(range, genome = Hsapiens, verbose = 1)
```

**Key Parameters:**
- `range`: A `GRanges` object containing the coordinates of the sequences to analyze.
- `genome`: A `BSgenome` object for the relevant organism.
- `pValue`: P-value cutoff for declaring a binding site (default is 0.0002).
- `nmotifs`: The maximum number of motifs to seek (default is 25).
- `minKeys`: Minimum number of occurrences for a motif to be considered.

### 3. Inspecting Results
The `GADEM` function returns an object of class `gadem`. You can extract discovered motifs and their positions.

```r
# Summary of discovered motifs
summary(gadem)

# Get the list of motifs
motifs <- gadem@motifList

# Access the first motif's consensus sequence and PWM
first_motif <- motifs[[1]]
print(first_motif@consensus)
print(first_motif@pwm)
```

### 4. Visualizing Motifs
You can view the sequence logos for the discovered motifs.

```r
# Plot the first motif
plot(motifs[[1]])
```

### 5. Exporting Results
Results can be converted to standard formats or exported for downstream analysis.

```r
# Get individual occurrences (binding sites) for a motif
occurrences <- motifs[[1]]@alignList
```

## Tips for Success
- **Sequence Length**: GADEM performs best when sequences are centered on peak summits and are of consistent length (e.g., 100-200bp).
- **Background Model**: The algorithm internally calculates a background model based on the provided genome. Ensure the `BSgenome` version matches the coordinates of your `GRanges`.
- **Memory**: For very large datasets, consider subsetting to the top 500-1000 peaks ranked by signal intensity to speed up discovery without losing significant biological signal.

## Reference documentation
- [rGADEM Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/rGADEM.html)