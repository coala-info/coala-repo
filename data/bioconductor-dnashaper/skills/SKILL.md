---
name: bioconductor-dnashaper
description: This tool predicts, visualizes, and encodes DNA structural features such as minor groove width and helix twist from nucleotide sequences or genomic intervals. Use when user asks to predict DNA shape features, analyze the impact of CpG methylation on DNA structure, visualize ensemble shape profiles, or encode sequence and shape features for machine learning models.
homepage: https://bioconductor.org/packages/release/bioc/html/DNAshapeR.html
---


# bioconductor-dnashaper

name: bioconductor-dnashaper
description: Predict, visualize, and encode DNA shape features (MGW, Roll, ProT, HelT, etc.) from nucleotide sequences or genomic intervals. Use this skill when you need to analyze DNA structural properties, predict the impact of CpG methylation on DNA shape, or encode sequence/shape features for machine learning models in R.

# bioconductor-dnashaper

## Overview
DNAshapeR is a high-throughput R package for predicting DNA structural features (shape) from genomic data. It uses a pentamer-based sliding window approach to estimate features like Minor Groove Width (MGW), Propeller Twist (ProT), Roll, and Helix Twist (HelT). It supports standard sequences, methylated DNA, and genomic intervals, providing tools for both visualization and feature encoding for statistical learning.

## Core Workflows

### 1. Predicting DNA Shape
The primary function is `getShape()`, which processes FASTA files.

```r
library(DNAshapeR)

# From a FASTA file
fn <- "path/to/sequence.fa"
pred <- getShape(fn)

# Access specific features (returns a list of matrices)
mgw_values <- pred$MGW
roll_values <- pred$Roll
```

### 2. Working with Genomic Intervals
You can predict shape directly from genomic coordinates by first extracting sequences using a reference genome (BSgenome).

```r
library(GenomicRanges)
library(BSgenome.Hsapiens.UCSC.hg19)

# Define intervals
gr <- GRanges(seqnames = "chr1", ranges = IRanges(start = 100, width = 50))

# Extract FASTA and predict
getFasta(gr, Hsapiens, width = 50, filename = "tmp.fa")
pred <- getShape("tmp.fa")
```

### 3. Predicting Methylated DNA Shape
DNAshapeR can account for CpG methylation using the `methylate = TRUE` flag.

*   **Option A:** Use a FASTA with 'M' (methylated C on leading) and 'g' (methylated C on lagging).
*   **Option B:** Provide a separate position file.

```r
# Using a position file
pred_methy <- getShape(fasta_file, methylate = TRUE, methylatedPosFile = pos_file)
```

### 4. Visualization
DNAshapeR provides three main visualization types:
*   **Metashape plots:** `plotShape(pred$MGW)` (Ensemble average profile).
*   **Heatmaps:** `heatShape(pred$ProT, n_bins)` (Requires `fields` package).
*   **Browser tracks:** `trackShape(fn, pred)` (For single sequences).

### 5. Feature Encoding for Machine Learning
Convert sequences and shape predictions into feature vectors for models (e.g., `caret`).

```r
# Define feature types: k-mer, n-shape, n-MGW, n-ProT, n-Roll, n-HelT
# 1-shape = first order; 2-shape = second order (product terms)
featureType <- c("1-mer", "1-shape")
featureVector <- encodeSeqShape(fasta_file, pred, featureType)

# Combine with experimental data (e.g., binding affinity)
df <- data.frame(affinity = y_values, featureVector)
```

## Tips and Best Practices
*   **Feature Matrix Structure:** `getShape` returns a list where each element is a matrix. Rows correspond to sequences in the FASTA, and columns correspond to nucleotide positions.
*   **NA Values:** Shape predictions for the ends of sequences often contain `NA` because the pentamer window requires context.
*   **Memory Management:** For very large genomic datasets, process in chunks or use `getFasta` to limit the window size around regions of interest.
*   **Feature Combinations:** When encoding for ML, combining 1-mer (sequence) with 1-shape (structure) often improves protein-DNA binding models compared to sequence alone.

## Reference documentation
- [DNAshapeR](./references/DNAshapeR.md)