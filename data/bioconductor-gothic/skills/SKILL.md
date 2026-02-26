---
name: bioconductor-gothic
description: This tool identifies significant chromatin interactions in Hi-C data using a cumulative binomial test to model spurious ligations. Use when user asks to detect genomic interactions, process Hi-C sequencing data, filter artifacts, or calculate p-values for chromatin contacts at specific resolutions.
homepage: https://bioconductor.org/packages/release/bioc/html/GOTHiC.html
---


# bioconductor-gothic

name: bioconductor-gothic
description: Statistical analysis of Hi-C data using a binomial test to identify significant chromatin interactions. Use this skill when you need to process Hi-C sequencing data (from Bowtie or HiCUP), filter artifacts, and calculate p-values/q-values for genomic interactions at specific resolutions.

## Overview

GOTHiC (Genome Organisation Through HiC) is an R package that implements a cumulative binomial test to detect significant interactions in Hi-C experiments. It models the probability of spurious ligations based on the relative coverage of interacting genomic loci, effectively correcting for common Hi-C biases (restriction site density, GC content, mappability) without requiring explicit modeling of each bias.

## Core Workflow

### 1. Data Preparation and Pairing
If starting from raw aligned reads (e.g., Bowtie output), use `pairReads` to create a paired-end object.

```r
library(GOTHiC)
# Pair aligned reads from two files
paired <- pairReads(
  file1 = "path/to/reads_1.txt", 
  file2 = "path/to/reads_2.txt", 
  sampleName = "my_sample", 
  DUPLICATETHRESHOLD = 1, 
  fileType = "Table"
)
```

### 2. Mapping to Restriction Fragments
Map the paired reads to specific restriction fragments based on the genome and enzyme used.

```r
mapped <- mapReadsToRestrictionSites(
  paired, 
  sampleName = "my_sample",
  BSgenomeName = "BSgenome.Hsapiens.UCSC.hg19",
  genome = BSgenome.Hsapiens.UCSC.hg19,
  restrictionSite = "A^AGCTT", 
  enzyme = "HindIII"
)
```

### 3. Identifying Significant Interactions
The primary analysis is performed using `GOTHiC` (for general paired reads) or `GOTHiChicup` (for HiCUP output). These functions perform filtering and the binomial test in one step.

```r
# Using GOTHiC on paired files
results <- GOTHiC(
  file1 = "reads_1.txt", 
  file2 = "reads_2.txt", 
  res = 1000000,              # Resolution in bp (e.g., 1Mb)
  genome = BSgenome.Hsapiens.UCSC.hg19,
  restrictionSite = "A^AGCTT",
  enzyme = "HindIII",
  cistrans = "all",           # "all", "cis", or "trans"
  filterdist = 10000          # Filter reads closer than 10kb
)

# Using GOTHiChicup on HiCUP summary files
results_hicup <- GOTHiChicup(
  fileName = "hicup_output.summary", 
  restrictionFile = "digest_file.txt",
  res = 1000000
)
```

## Interpreting Results

The output is a `data.frame` containing:
- **Genomic Coordinates**: Chromosome and start positions for both interacting bins (chr1, start1, chr2, start2).
- **Read Count**: Observed number of read-pairs (`readCount`).
- **Probability**: Expected frequency of random interaction (`probability`).
- **p-value/q-value**: Statistical significance (q-value is Benjamini-Hochberg corrected).
- **Obs/Exp Ratio**: The ratio of observed reads to expected reads, representing interaction strength.

## Quality Control

- **P-value Distribution**: A good Hi-C experiment should show a clear peak near 0 in the p-value distribution. A uniform distribution (0 to 1) suggests poor signal-to-noise ratio.
- **Filtering**: Ensure `filterdist` is set (default 10kb) to remove self-ligations and incomplete digestions.
- **Duplicate Threshold**: Use `DUPLICATETHRESHOLD = 1` to remove PCR duplicates unless they were already removed by a pipeline like HiCUP.

## Reference documentation

- [GOTHiC - Genome Organisation Through HiC](./references/package_vignettes.md)