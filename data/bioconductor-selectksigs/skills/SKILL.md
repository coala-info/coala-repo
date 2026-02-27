---
name: bioconductor-selectksigs
description: This package provides a statistical framework for determining the optimal number of mutational signatures in a genomic dataset using cross-validation and perplexity calculations. Use when user asks to identify the number of mutational signatures, perform cross-validation for signature selection, or calculate perplexity for mutation feature models.
homepage: https://bioconductor.org/packages/release/bioc/html/selectKSigs.html
---


# bioconductor-selectksigs

## Overview
The `selectKSigs` package provides a robust statistical framework for determining the number of mutational signatures (K) in a genomic dataset. It builds upon the `pmsignature` (Probabilistic Mutational Signature) framework, which uses an independent model to represent mutation features (substitution types, flanking bases, and transcription direction). The package implements a cross-validation approach and calculates perplexity to identify the K value that best fits the data without overfitting.

## Installation
Install the package via BiocManager:
```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("selectKSigs")
```

## Workflow

### 1. Data Preparation
`selectKSigs` typically works with mutation data in the Mutation Position Format (Sample, Chromosome, Position, Ref, Alt). You can use `HiLDA` or `pmsignature` functions to read these files.

```r
library(selectKSigs)
library(HiLDA)

# Example: Reading a Mutation Position file
# numBases: total flanking bases + central base (e.g., 3 or 5)
# trDir: include transcription direction
inputFile <- "path/to/your/mutations.txt"
G <- hildaReadMPFile(inputFile, numBases = 5, trDir = TRUE)
```

### 2. Selecting the Number of Signatures (K)
The core function is `cv_PMSignature()`. It performs cross-validation across a range of K values.

```r
set.seed(123) # For reproducibility
# Kfold: Number of cross-validation folds (e.g., 3 or 10)
# nRep: Number of replications for each K
# Klimit: The maximum number of signatures to test
results <- cv_PMSignature(G, Kfold = 3, nRep = 3, Klimit = 7)

# View the results table containing perplexity/error measures
print(results)
```

### 3. Visualizing and Interpreting Results
The optimal K is generally the value that minimizes the perplexity or cross-validation error.

```r
library(ggplot2)
library(tidyr)
library(dplyr)

# Prepare data for plotting
results$Kvalue <- seq_len(nrow(results)) + 1
results_df <- gather(results, Method, value, -Kvalue)

# Plotting the measures
ggplot(results_df, aes(x = Kvalue, y = value, color = Method)) +
  geom_point() +
  geom_line() +
  facet_wrap(~ Method, scales = "free") +
  theme_bw() +
  labs(title = "Selection of K", x = "Number of Signatures", y = "Measure Value")
```

## Tips and Best Practices
- **K Range**: Start with a `Klimit` slightly higher than what you expect (e.g., if you expect 3-4 signatures, set `Klimit = 7`).
- **Replications**: Increase `nRep` (e.g., to 5 or 10) for more stable estimates, though this increases computation time.
- **Input Format**: Ensure your input data follows the 5-column Mutation Position Format. If using `pmsignature` objects directly, ensure they are compatible with the `G` object structure expected by `cv_PMSignature`.
- **Model Context**: Remember that this package uses the "independent model" (Shiraishi model), which treats each feature (flanking bases, etc.) as independent, making it more computationally efficient for high-dimensional feature sets than the standard NMF-based "full model."

## Reference documentation
- [selectKSigs: a package for selecting the number of mutational signatures](./references/selectKSigs.Rmd)
- [selectKSigs: a package for selecting the number of mutational signatures](./references/selectKSigs.md)