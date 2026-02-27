---
name: bioconductor-sagenhaft
description: This tool provides a complete pipeline for the analysis of Serial Analysis of Gene Expression (SAGE) data. Use when user asks to extract SAGE tags from sequence files, perform sequence error correction using EM algorithms, or compare SAGE libraries for differential expression.
homepage: https://bioconductor.org/packages/release/bioc/html/sagenhaft.html
---


# bioconductor-sagenhaft

name: bioconductor-sagenhaft
description: Analysis of Gene Expression (SAGE) data using the sagenhaft package. Use this skill to extract SAGE tags from sequence files (Phred/ABI), perform sequence error correction using EM algorithms, and compare SAGE libraries for differential expression using Fisher's Exact or Binomial tests.

## Overview
The `sagenhaft` package provides tools for the complete pipeline of SAGE (Serial Analysis of Gene Expression) data analysis. It handles the extraction of ditags and tags from raw sequencing files, implements a statistical model to correct for sequencing errors based on base-calling quality scores, and facilitates the comparison of gene expression levels between different libraries.

## Core Workflow

### 1. Data Extraction and Loading
SAGE data can be extracted directly from zipped sequence files or read from pre-processed `.sage` files.

```r
library(sagenhaft)

# Extract tags from a zip file of chromatograms/sequence files
# taglength: 10 (SAGE) or 17 (LongSAGE)
# min/max ditag length: 20-24 for SAGE, 32-38 for LongSAGE
lib_data <- extract.lib.from.zip("data.zip", taglength = 10, 
                                 min.ditag.length = 20, 
                                 max.ditag.length = 24)

# Alternatively, read an existing SAGE library file
lib_data <- read.sage.library("library.sage")
```

### 2. Error Correction
The package uses an Expectation-Maximization (EM) algorithm to adjust tag counts based on sequencing error probabilities.

```r
# Estimate errors and apply EM algorithm
lib_data <- estimate.errors.mean(lib_data)
lib_data <- em.estimate.error.given(lib_data)
```

### 3. Comparing Libraries
To identify differentially expressed genes, compare two libraries. The package uses a vectorized binomial exact test (approximating Fisher's Exact test) for efficiency.

```r
# Compare two library objects
lib_comparison <- compare.lib.pair(lib1, lib2)

# Visualize the comparison (M-A plot)
plot(lib_comparison)

# View results
# Fields include: tag, A.adjusted, count1.adjusted, count2.adjusted, M.adjusted, tests.adjusted
head(lib_comparison$data)
```

## Key Functions and Data Structures

### Library Objects
A SAGE library object typically contains:
- `tags`: A dataframe with tag sequences, raw counts, and adjusted counts.
- `seqs`: Information on individual sequences, including quality scores (`q1` to `q10` or `q17`).
- `nseq`: Total number of sequences.
- `ntag`: Number of unique tags.

### Statistical Comparison
- `compare.lib.pair`: Computes M-values (log-fold change) and A-values (average expression).
- `M-value calculation`: `log2(nA + 0.5) - log2(nB + 0.5)` (with library size normalization).
- `A-value calculation`: Average log-abundance.
- `FDR`: Benjamini-Hochberg correction is typically applied to the resulting p-values.

## Tips for Analysis
- **Quality Filtering**: The package automatically removes duplicate ditags to reduce PCR bias and filters out tags with low average sequencing quality (default threshold is 10).
- **Sequence Neighbors**: Use `compute.sequence.neighbors` to identify tags that differ by only one base, which is critical for the error correction model.
- **Large Datasets**: For typical libraries (20k-100k tags), the binomial approximation used in `compare.lib.pair` is significantly faster than Fisher's Exact test while maintaining high accuracy.

## Reference documentation
- [Introduction to SAGEnhaft](./references/SAGEnhaft.md)