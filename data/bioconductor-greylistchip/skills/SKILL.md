---
name: bioconductor-greylistchip
description: This tool identifies and generates sample-specific grey lists of anomalous signal regions from ChIP-seq input libraries to filter out artifacts. Use when user asks to identify problematic genomic regions in control samples, generate a grey list for ChIP-seq analysis, or mask high-signal artifacts to improve peak calling accuracy.
homepage: https://bioconductor.org/packages/release/bioc/html/GreyListChIP.html
---

# bioconductor-greylistchip

name: bioconductor-greylistchip
description: Identify and generate "grey lists" of anomalous signal regions in ChIP-seq input/control libraries. Use this skill when you need to filter out sample-specific artifacts, improve peak calling accuracy, or estimate insert sizes more reliably by masking high-signal regions in genomic data.

# bioconductor-greylistchip

## Overview

The `GreyListChIP` package identifies regions of anomalous signal in ChIP-seq input (control) samples. Unlike universal "blacklists," these "grey lists" are sample-specific and capture regions where high signal in the input would otherwise lead to spurious peak calls. The process involves tiling the genome, counting reads per tile, fitting a negative binomial distribution to the counts, and thresholding to define problematic regions.

## Core Workflow

### 1. Initialization and Karyotype Loading
A `GreyList` object requires a karyotype (chromosome names and lengths). This can be provided via a file or a `BSgenome` object.

```r
library(GreyListChIP)

# Option A: From a karyotype file (tab-separated: chr name, length)
gl <- new("GreyList", karyoFile="path/to/karyotype.txt")

# Option B: From a BSgenome object
library(BSgenome.Hsapiens.UCSC.hg19)
gl <- new("GreyList", genome=BSgenome.Hsapiens.UCSC.hg19)
```

### 2. Counting Reads
Count reads from a BAM file across the genomic tiles.

```r
gl <- countReads(gl, "input_sample.bam")
```

### 3. Calculating Thresholds
Fit the read counts to a negative binomial distribution to determine the cutoff for "anomalous" signal.
*   `p`: The p-value threshold (default 0.99).
*   `reps`: Number of subsampling iterations.
*   `sampleSize`: Number of tiles to sample per iteration.

```r
gl <- calcThreshold(gl, reps=100, sampleSize=30000, p=0.99)
```

### 4. Generating the Grey List
Identify the regions exceeding the threshold and merge nearby regions.
*   `maxGap`: Maximum distance between regions to be merged.

```r
gl <- makeGreyList(gl, maxGap=16384)
```

### 5. Exporting Results
Export the identified regions to a BED file for use with other tools (e.g., `bedtools` or `Rsamtools`).

```r
export(gl, con="myGreyList.bed")
```

## Simplified One-Step Approach
If using a standard `BSgenome` object and default parameters, the process can be streamlined:

```r
library(BSgenome.Hsapiens.UCSC.hg19)
gl <- greyListBS(BSgenome.Hsapiens.UCSC.hg19, "input_sample.bam")
export(gl, con="myGreyList.bed")
```

## Tips and Interpretation
*   **Coverage**: Typically, a p-value of 0.99 results in approximately 1% of the genome being flagged. If coverage is significantly higher, consider increasing the stringency (higher `p`).
*   **Input Only**: Grey lists should be generated from **Input/Control** libraries, not the ChIP libraries themselves.
*   **Karyotype Matching**: Ensure the chromosome names in your karyotype file or `BSgenome` object exactly match the headers in your BAM file.
*   **Pre-built Data**: You can explore a sample object using `data(greyList)`.

## Reference documentation
- [Generating Grey Lists from Input Libraries](./references/GreyList-demo.md)