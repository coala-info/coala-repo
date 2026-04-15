---
name: bioconductor-kebabs
description: This tool performs kernel-based analysis of biological sequences using Support Vector Machines for classification and regression. Use when user asks to compute sequence kernels, train SVM models on DNA or protein sequences, perform cross-validation, or generate prediction profiles for biological interpretation.
homepage: https://bioconductor.org/packages/release/bioc/html/kebabs.html
---

# bioconductor-kebabs

name: bioconductor-kebabs
description: Kernel-based analysis of biological sequences (DNA, RNA, amino acids) using Support Vector Machines (SVM). Use this skill to compute sequence kernels (spectrum, mismatch, gappy pair, motif), generate kernel matrices or explicit feature representations, and perform SVM training, prediction, cross-validation, and biological interpretation (feature weights and prediction profiles) for sequence data.

# bioconductor-kebabs

## Overview
The `kebabs` package implements a powerful framework for sequence analysis using kernel methods. It transforms biological sequences into high-dimensional feature vectors via various kernels, which are then used with SVMs for classification or regression. Key advantages include efficient C++ implementations of kernels, unified interfaces for multiple SVM backends (`kernlab`, `e1071`, `LiblineaR`), and tools for biological interpretation like prediction profiles.

## Core Workflow

### 1. Data Preparation
Sequences should be in `Biostrings` formats (`DNAStringSet`, `RNAStringSet`, or `AAStringSet`).

```r
library(kebabs)
data(TFBS) # Example DNA data: enhancerFB (sequences), yFB (labels)
```

### 2. Defining a Kernel
Choose a kernel based on the biological problem:
*   **Spectrum Kernel**: Counts fixed-length k-mers.
    `k2 <- spectrumKernel(k=2)`
*   **Mismatch Kernel**: Allows up to *m* mismatches in k-mers.
    `m3m1 <- mismatchKernel(k=3, m=1)`
*   **Gappy Pair Kernel**: Pairs of k-mers separated by a gap of max length *m*.
    `g1m3 <- gappyPairKernel(k=1, m=3)`
*   **Motif Kernel**: Uses a specific collection of motifs.
    `mot <- motifKernel(motifs=c("A[CG]T", "C.G"))`

### 3. SVM Training (`kbsvm`)
The `kbsvm` function provides a unified interface. Specify the package (`pkg`) and SVM type (`svm`).

```r
# Binary classification using LiblineaR
model <- kbsvm(x = enhancerFB[train], y = yFB[train],
               kernel = g1m3, pkg = "LiblineaR", 
               svm = "C-svc", cost = 10)
```

### 4. Prediction and Evaluation
```r
pred <- predict(model, enhancerFB[test])
eval <- evaluatePrediction(pred, yFB[test], allLabels=c(1, -1))
```

## Advanced Features

### Position-Dependent Kernels
If sequences are aligned, use position information:
*   **Position-Specific**: `distWeight = 1` (only matches at same index).
*   **Distance-Weighted**: Use `linWeight`, `expWeight`, or `gaussWeight` to allow matches in a neighborhood.

```r
# Position-specific spectrum kernel
psK <- spectrumKernel(k=3, distWeight=1)
```

### Annotation-Specific Kernels
Incorporate structural information (e.g., Exon/Intron, Secondary Structure) using `annSpec=TRUE`. Annotation must be assigned via `annotationMetadata`.

### Model Selection and Grid Search
Pass vectors to parameters to trigger grid search.

```r
# Grid search over cost and k
model <- kbsvm(x = enhancerFB, y = yFB, 
               kernel = spectrumKernel(k=2:4),
               cost = c(1, 10, 100), cross = 5)
res <- modelSelResult(model)
plot(res)
```

## Biological Interpretation

### Feature Weights
Retrieve the importance of specific k-mers/patterns.
```r
w <- getFeatureWeights(model)
```

### Prediction Profiles
Visualize which parts of a specific sequence contributed most to the SVM decision.
```r
# Generate profiles during prediction
pred <- predict(model, enhancerFB[test], predProfiles=TRUE)
plot(getPredictionProfile(pred), sel=1)
```

## Tips for Efficiency
*   **Large Datasets**: Use `pkg="LiblineaR"` for fast linear SVMs.
*   **Memory**: Use `getExRep(..., sparse=TRUE)` for high-dimensional kernels (large *k* or gappy pairs).
*   **Precomputation**: Compute the kernel matrix once with `getKernelMatrix()` if running multiple SVM variants.

## Reference documentation
- [KeBABS User Manual](./references/kebabs.md)