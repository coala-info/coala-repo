---
name: bioconductor-nucleosim
description: This tool generates synthetic nucleosome maps and sequencing reads for benchmarking nucleosome positioning algorithms. Use when user asks to simulate well-positioned or fuzzy nucleosomes, generate synthetic NGS paired-end reads, or create tiling array hybridization data.
homepage: https://bioconductor.org/packages/release/bioc/html/nucleoSim.html
---


# bioconductor-nucleosim

name: bioconductor-nucleosim
description: Generate synthetic nucleosome maps and samples for NGS or Tiling Array experiments. Use when you need to simulate well-positioned or fuzzy nucleosomes, introduce noise (deletions/variance), or create paired-end read data for benchmarking nucleosome positioning algorithms.

# bioconductor-nucleosim

## Overview

The `nucleoSim` package is designed to simulate nucleosome positioning data. It allows for the creation of highly customizable synthetic maps that emulate real-world experimental conditions, including "noise" such as fuzzy nucleosomes (high variance in position) and missing nucleosomes (random deletions). It supports two primary output types:
1.  **Synthetic Nucleosome Maps**: Complete sequences covering nucleosome regions.
2.  **Synthetic Nucleosome Samples**: Forward and reverse paired-end reads emulating Next-Generation Sequencing (NGS) or Tiling Array hybridization ratios.

## Core Workflows

### 1. Generating Synthetic Nucleosome Maps
Use `syntheticNucMapFromDist()` to create a genome section covered by nucleosomes.

```r
library(nucleoSim)

# Define parameters
wp.num <- 20      # Well-positioned nucleosomes
wp.del <- 5       # Number to delete (noise)
fuz.num <- 5      # Fuzzy nucleosomes
distr <- "Normal" # Distribution type ("Normal" or "Uniform")

# Generate map
nucMap <- syntheticNucMapFromDist(
    wp.num = wp.num, 
    wp.del = wp.del, 
    fuz.num = fuz.num,
    wp.var = 30, 
    fuz.var = 50, 
    lin.len = 20, # Linker length
    rnd.seed = 123
)

# Access results
nucMap$wp.starts  # Start positions of well-positioned nucleosomes
nucMap$syn.reads  # IRanges object containing all synthetic sequences
```

### 2. Simulating NGS Paired-End Reads
Use `syntheticNucReadsFromDist()` to generate forward and reverse reads with a specific read length and genomic offset.

```r
nucSample <- syntheticNucReadsFromDist(
    wp.num = 30, 
    fuz.num = 10, 
    read.len = 45, 
    offset = 10000, # Genomic coordinate offset
    distr = "Uniform"
)

# Access read data for downstream analysis
head(nucSample$dataIP) # Data frame with chr, start, end, strand, and ID
```

Alternatively, convert an existing map to a sample:
```r
nucSampleFromMap <- syntheticNucReadsFromMap(nucMap, read.len = 45, offset = 500)
```

### 3. Simulating Tiling Array Data
Set `as.ratio = TRUE` in `syntheticNucMapFromDist()` to generate hybridization ratios compared to a random control map.

```r
tilingData <- syntheticNucMapFromDist(as.ratio = TRUE, wp.num = 10, fuz.num = 2)
tilingData$syn.ratio # Rle object containing the calculated ratios
```

## Visualization
The package provides a `plot` method for `syntheticNucMap` objects. It displays the central position of nucleosomes on the x-axis and the coverage (number of reads/sequences) on the y-axis.

```r
plot(nucMap, xlab = "Genomic Position", ylab = "Coverage")
```

## Key Parameters
- `wp.var` / `fuz.var`: Controls the "fuzziness." Higher values increase the variance of sequence start positions.
- `max.cover`: The maximum number of sequences/reads associated with a single nucleosome.
- `nuc.len`: Default is 147bp (standard nucleosome size).
- `lin.len`: Length of the DNA linker between nucleosomes.
- `distr`: The distribution used for start positions (typically "Normal" for biological positioning or "Uniform").

## Reference documentation

- [Generate synthetic nucleosome maps](./references/nucleoSim.md)
- [nucleoSim Vignette Source](./references/nucleoSim.Rmd)