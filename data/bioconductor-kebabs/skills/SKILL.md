---
name: bioconductor-kebabs
description: "The package provides functionality for kernel-based analysis of DNA, RNA, and amino acid sequences via SVM-based methods. As core functionality, kebabs implements following sequence kernels: spectrum kernel, mismatch kernel, gappy pair kernel, and motif kernel. Apart from an efficient implementation of standard position-independent functionality, the kernels are extended in a novel way to take the position of patterns into account for the similarity measure. Because of the flexibility of the kernel formulation, other kernels like the weighted degree kernel or the shifted weighted degree kernel with constant weighting of positions are included as special cases. An annotation-specific variant of the kernels uses annotation information placed along the sequence together with the patterns in the sequence. The package allows for the generation of a kernel matrix or an explicit feature representation in dense or sparse format for all available kernels which can be used with methods implemented in other R packages. With focus on SVM-based methods, kebabs provides a framework which simplifies the usage of existing SVM implementations in kernlab, e1071, and LiblineaR. Binary and multi-class classification as well as regression tasks can be used in a unified way without having to deal with the different functions, parameters, and formats of the selected SVM. As support for choosing hyperparameters, the package provides cross validation - including grouped cross validation, grid search and model selection functions. For easier biological interpretation of the results, the package computes feature weights for all SVMs and prediction profiles which show the contribution of individual sequence positions to the prediction result and indicate the relevance of sequence sections for the learning result and the underlying biological functions."
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