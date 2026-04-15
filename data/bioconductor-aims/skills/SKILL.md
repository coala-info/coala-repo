---
name: bioconductor-aims
description: This tool assigns breast cancer molecular subtypes to gene expression data using an absolute assignment method. Use when user asks to classify breast cancer samples into intrinsic subtypes, assign Basal, Her2, LumA, LumB, or Normal labels, or perform subtyping on single samples without gene-centering.
homepage: https://bioconductor.org/packages/release/bioc/html/AIMS.html
---

# bioconductor-aims

name: bioconductor-aims
description: Absolute Assignment of Breast Cancer Intrinsic Molecular Subtype (AIMS). Use this skill to assign breast cancer molecular subtypes (Basal, Her2, LumA, LumB, and Normal) to gene expression data. This method is unique because it works on a per-sample basis (absolute assignment) and does not require gene-centering or a reference cohort, making it robust against batch effects and dataset composition.

## Overview

AIMS (Absolute Intrinsic Molecular Subtyping) provides a stable way to classify breast cancer samples into the five "intrinsic" subtypes. Unlike the PAM50 method which often requires a large cohort for gene-centering, AIMS uses a Naive Bayes classifier based on simple "greater-than" rules between gene pairs. This allows for the classification of even a single patient sample without needing to normalize it against other samples.

## Core Workflow

### 1. Data Preparation
AIMS requires a numerical matrix of gene expression values.
- **Values**: Must be positive-only (not gene-centered). For two-color arrays, use only the tumor channel (e.g., Cy5).
- **Identifiers**: Genes must be identified by **Entrez IDs**.
- **Structure**: Rows are genes, columns are samples.

### 2. Assigning Subtypes
The primary function is `applyAIMS`. It handles both single samples and large datasets.

```r
library(AIMS)

# D: matrix of expression values (rows=genes, cols=samples)
# EntrezID: character vector of Entrez IDs corresponding to rows of D
results <- applyAIMS(D, EntrezID)
```

### 3. Interpreting Results
The function returns a list containing:
- `cl`: The assigned molecular subtypes (Basal, Her2, LumA, LumB, Normal).
- `prob`: The posterior probabilities for the assigned class.
- `all.probs`: A matrix containing probabilities for all five subtypes for each sample.
- `rules.matrix`: The raw binary rules applied to the data.

```r
# View classifications
head(results$cl)

# View confidence scores
head(results$prob)

# Summary of subtypes in a cohort
table(results$cl)
```

## Practical Example: Single Sample vs Dataset

AIMS is designed to be consistent regardless of whether you process one sample or many.

```r
# For a single sample (ensure drop=FALSE to maintain matrix structure)
single_sample <- D[, 1, drop = FALSE]
single_res <- applyAIMS(single_sample, EntrezID)

# For a full dataset
all_res <- applyAIMS(D, EntrezID)
```

## Tips for Success
- **Entrez IDs**: If your data uses Gene Symbols or Probe IDs, use annotation packages (like `org.Hs.eg.db` or platform-specific `.db` packages) to convert them to Entrez IDs before running AIMS.
- **Duplicates**: `applyAIMS` automatically handles duplicated Entrez IDs; you do not need to collapse them manually.
- **Normalization**: While AIMS is robust, ensure your data is on a standard scale (like log2) but **never** gene-centered (mean-subtracted).

## Reference documentation
- [AIMS: Absolute Assignment of Breast Cancer Intrinsic Molecular Subtype](./references/AIMS.md)