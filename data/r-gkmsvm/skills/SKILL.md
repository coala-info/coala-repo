---
name: r-gkmsvm
description: This tool provides a gapped k-mer Support Vector Machine for DNA sequence classification and functional genomic analysis. Use when user asks to train SVM models on genomic sequences, calculate gkm-kernel matrices, predict regulatory activity for new sequences, or score the impact of genetic variants.
homepage: https://cran.r-project.org/web/packages/gkmsvm/index.html
---


# r-gkmsvm

name: r-gkmsvm
description: Gapped-Kmer Support Vector Machine (gkmSVM) for DNA sequence classification and functional genomic analysis. Use this skill when you need to train SVM models on genomic sequences, calculate gkm-kernel matrices, predict regulatory activity for new sequences, or score the impact of genetic variants (SNVs).

## Overview

The `gkmSVM` package provides tools for predicting the functional activity of DNA sequences. It uses a gapped k-mer string kernel to calculate similarity between sequences, which is then used with Support Vector Machines (SVM) to classify sequences (e.g., enhancers vs. random genomic backgrounds). It is particularly effective for identifying short regulatory motifs and scoring the impact of single nucleotide variants (SNVs).

## Installation

```R
install.packages("gkmSVM")
# Note: Many functions require BioConductor dependencies
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("rtracklayer", "GenomicRanges", "BSgenome", "Biostrings"))
```

## Core Workflow

### 1. Data Preparation
The package works with FASTA files. You typically need a positive set (e.g., ChIP-seq peaks) and a negative set (e.g., random genomic sequences or non-functional regions).

```R
library(gkmSVM)

# Generate genomic subsets if starting from coordinates (requires BSgenome)
# genSVMGenomicRegions(posfile, negfile, bedfile, outname)
```

### 2. Kernel Matrix Calculation
Calculate the similarity matrix between sequences. This is the most computationally intensive step.

```R
# Calculate gkm-kernel matrix
gkmsvm_kernel(posfile = "pos.fa", negfile = "neg.fa", outfile = "kernel.txt")
```

### 3. Model Training
Train the SVM model using the calculated kernel.

```R
# Train the model
gkmsvm_train(kernelfile = "kernel.txt", posfile = "pos.fa", negfile = "neg.fa", prefix = "model")
# This generates model_svmtrain.out
```

### 4. Prediction and Scoring
Apply the trained model to new sequences or score specific variants.

```R
# Classify new sequences
gkmsvm_classify(seqfile = "test.fa", modelprefix = "model", outfile = "preds.txt")

# Score SNVs (DeltaSVM)
# Requires a file with: chr, pos, ref, alt
gkmsvm_deltaSVM(fastafile = "variants.fa", modelprefix = "model", outfile = "delta_scores.txt")
```

## Key Functions

- `gkmsvm_kernel`: Computes the gapped k-mer kernel matrix. Parameters `L` (word length) and `K` (number of informative non-gap positions) are critical.
- `gkmsvm_train`: Fits the SVM model. Uses `kernlab` internally.
- `gkmsvm_classify`: Scores sequences in a FASTA file using a trained model.
- `gkmsvm_deltaSVM`: Specifically designed to calculate the change in SVM score between reference and alternative alleles.

## Tips
- **Memory Management**: For large datasets, the kernel matrix can become very large. Consider using `L=11` and `K=7` as standard starting parameters.
- **Parallelization**: The package utilizes Rcpp for performance, but kernel calculation on very large sets is time-consuming.
- **File Paths**: Most functions write results directly to disk rather than returning large objects to the R environment to save memory.

## Reference documentation
- [gkmSVM Home Page](./references/home_page.md)