---
name: bioconductor-pbcmc
description: The pbcmc package provides a permutation-based framework to assess the statistical reliability and confidence of gene expression-based molecular classifiers like PAM50. Use when user asks to classify breast cancer subtypes, perform permutation tests for molecular classification, identify ambiguous or unassigned subjects in gene expression data, or generate clinical reports for subtype assignments.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pbcmc.html
---

# bioconductor-pbcmc

## Overview

The `pbcmc` package (Permutation-Based Confidence for Molecular Classification) provides a framework for assessing the reliability of gene expression-based classifiers. While standard classifiers like PAM50 assign a subtype based on the highest correlation, `pbcmc` uses gene label permutations to determine if that correlation is statistically significant. This helps identify "Not Assigned" (NA) or "Ambiguous" (Amb) subjects where classification is weak or multiple subtypes are equally likely.

## Core Workflow

The package uses an S4 class hierarchy based on `MolecularPermutationClassifier`. The primary implementation is the `PAM50` class.

### 1. Data Preparation

You can load standard Bioconductor datasets or provide your own expression matrix and annotation.

```R
library(pbcmc)
library(BiocParallel)

# Option A: Load from Bioconductor breast cancer datasets
# Supports: "upp", "nki", "vdx", "mainz", "transbig", "unt"
object <- loadBCDataset(Class=PAM50, libname="nki", verbose=TRUE)

# Option B: Manual creation
# Requires: exprs (genes in rows), annotation (probe, NCBI.gene.symbol, EntrezGene.ID)
object <- PAM50(exprs=my_matrix, annotation=my_anno_df, targets=my_clinical_df)
```

### 2. Classification and Permutation

The workflow follows a strict sequence: `filtrate` -> `classify` -> `permutate`.

```R
# 1. Filter to the 50 genes required by PAM50
object <- filtrate(object, verbose=TRUE)

# 2. Standard PAM50 classification
# std options: "none", "scale", "robust", "median" (recommended for populations)
object <- classify(object, std="median", verbose=TRUE)

# 3. Run permutation test for confidence
# nPerm: 10000 recommended for publication
# pCutoff: Alpha level (e.g., 0.01)
# corCutoff: Difference threshold to resolve ambiguity (default 0.1)
object <- permutate(object, nPerm=1000, pCutoff=0.01, where="fdr", 
                    corCutoff=0.1, BPPARAM=bpparam())
```

### 3. Interpreting Results

After permutation, the object contains both the original PAM50 assignment and the new permutation-based subtype.

```R
# View summary table comparing original vs. permuted classes
summary(object)

# Access specific slots
classification_results <- classification(object)
permutation_stats <- permutation(object)
```

## Reporting

The package generates visual reports to assist in clinical interpretation.

```R
# Generate a report for a single subject (returns a grid object)
# Shows correlations, p-values, and null distribution boxplots
subjectReport(object, subject=1)

# Generate a multi-page PDF for the entire dataset
databaseReport(object, output="reports.pdf")
```

## Implementation Tips

*   **Parallelization**: Permutation is computationally intensive. Always use `BPPARAM=bpparam()` to utilize multiple cores. On Windows, use `SnowParam()`; on Linux/Mac, use `MulticoreParam()`.
*   **Single Samples**: For a single patient proﬁle, set `std="none"` in the `classify` function, as normalization requires a population distribution.
*   **Memory Management**: If memory is limited, set `keep=FALSE` in `permutate()` to avoid storing the entire null distribution, though this will disable boxplots in `subjectReport`.
*   **Custom Signatures**: While PAM50 is the default, the S4 class `MolecularPermutationClassifier` can be extended for other signatures by implementing the required methods.

## Reference documentation

- [pbcmc: Permutation-Based Confidence for Molecular Classification](./references/pbcmc-vignette.md)