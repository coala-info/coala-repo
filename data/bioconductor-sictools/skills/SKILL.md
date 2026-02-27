---
name: bioconductor-sictools
description: bioconductor-sictools detects SNV and Indel differences between two BAM files using pairwise comparison of allele frequencies. Use when user asks to identify sequence variants between paired samples, calculate Fisher exact test p-values for genomic differences, or compare allele frequency vectors using Euclidean distance.
homepage: https://bioconductor.org/packages/release/bioc/html/SICtools.html
---


# bioconductor-sictools

name: bioconductor-sictools
description: Detect SNV and Indel differences between two BAM files (e.g., tumor vs. matched normal) using pairwise comparison of allele frequencies. Use when Claude needs to identify sequence variants between paired samples by calculating Fisher exact test p-values and Euclidean distances for specific genomic regions.

# bioconductor-sictools

## Overview

SICtools is designed to identify Single Nucleotide Variant (SNV) and Insertion/Deletion (Indel) differences between two closely related BAM files. Instead of calling variants separately and overlapping them, it performs a pairwise comparison at each base position within a specified region. It uses two metrics to infer differences:
1. **Fisher's Exact Test (p-value):** Measures the statistical significance of the difference in allele counts.
2. **Euclidean Distance (d-value):** Measures the distance between the allele frequency vectors of the two samples.

## Core Workflow

### 1. Data Preparation
Ensure both BAM files were aligned using the same version of the same aligner and the same reference genome. The reference FASTA file must also be available.

```r
library(SICtools)

bam1 <- "path/to/sample1.bam"
bam2 <- "path/to/sample2.bam"
refFsa <- "path/to/reference.fasta"
```

### 2. Detecting SNV Differences
Use `snpDiff()` to compare base counts (A, T, G, C) at each position.

```r
# Define region: chr04:962501-1026983
snp_results <- snpDiff(bam1, bam2, refFsa, 
                       regChr = "chr04", 
                       regStart = 962501, 
                       regEnd = 1026983,
                       pValueCutOff = 0.05, 
                       baseDistCutOff = 0.1,
                       nCores = 1)
```

### 3. Detecting Indel Differences
Use `indelDiff()` to compare indel allele counts. It considers the reference allele and up to two alternative indel genotypes.

```r
indel_results <- indelDiff(bam1, bam2, refFsa, 
                           regChr = "chr07", 
                           regStart = 828514, 
                           regEnd = 828914,
                           pValueCutOff = 0.05, 
                           gtDistCutOff = 0.1)
```

## Parameter Tuning

*   **Quality Filtering:** Use `minBaseQuality` (default 13) and `minMapQuality` (default 0) to filter out low-quality reads.
*   **Significance Thresholds:** 
    *   For germline samples, the defaults (`pValueCutOff = 0.05`, `baseDistCutOff = 0.1`) are usually sufficient.
    *   For somatic samples (tumor/normal), consider a higher `pValueCutOff` and lower `baseDistCutOff` to capture sub-clonal or low-frequency variants.
*   **Parallelization:** For large regions, set `nCores` > 1 to speed up the calculation.

## Interpreting and Filtering Results

The output is a `data.frame` containing allele counts for both samples, the p-value, and the d-value.

### Sorting Candidates
To find the most significant differences, sort the results by p-value (ascending) and d-value (descending):

```r
# Sort SNV results
significant_snps <- snp_results[order(snp_results$p.value, -snp_results$d.value), ]

# View top candidates
head(significant_snps)
```

### Visualization
A common diagnostic is to plot `-log10(p.value)` against `d.value`. Candidates in the top-right corner represent the most distinct variants between the two samples.

```r
plot(-log10(snp_results$p.value), snp_results$d.value, 
     xlab = "-log10(p-value)", ylab = "Euclidean Distance (d-value)",
     main = "SNV Differences", col = "brown")
```

## Reference documentation

- [Using the SICtools Package](./references/SICtools.md)