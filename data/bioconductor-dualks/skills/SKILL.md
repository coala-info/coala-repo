---
name: bioconductor-dualks
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/bioc/html/dualKS.html
---

# bioconductor-dualks

name: bioconductor-dualks
description: Perform multi-class classification and discriminant analysis of gene expression data using the Kolmogorov-Smirnov (KS) rank-sum statistic. Use this skill when you need to identify gene signatures that characterize specific biological classes or when you need to assign new samples to classes based on enrichment of these signatures.

## Overview

The `dualKS` package implements a dual application of the Kolmogorov-Smirnov algorithm. It first identifies genes whose expression is significantly biased (upregulated or downregulated) within specific classes (Discriminant Analysis). It then uses these class-specific signatures to classify new samples by measuring the enrichment of those signatures within the ranked gene list of the sample (Classification). This approach is intuitive, handles multiple classes simultaneously, and produces parsimonious gene signatures.

## Core Workflow

### 1. Data Preparation
The package typically works with `ExpressionSet` objects. Ensure your data is normalized. For one-color data, focusing on upregulated genes is often preferred due to noise in low-expression values.

```R
library(dualKS)
# Load your ExpressionSet (eset)
# Check class labels in phenoData
pData(eset)
```

### 2. Training (Discriminant Analysis)
Use `dksTrain` to calculate the KS scores for each gene across all classes.

```R
# type can be "up", "down", or "both"
# class specifies the column index in pData or a factor
tr <- dksTrain(eset, class=1, type="up")

# Optional: Use weights to prioritize highly expressed genes
tr_weighted <- dksTrain(eset, class=1, type="up", weights=TRUE)
```

### 3. Signature Selection
Extract a specific number of top-discriminating genes per class to create a classifier.

```R
# n is the number of genes per class
cl <- dksSelectGenes(tr, n=100)
```

### 4. Classification
Apply the classifier to a dataset (training set for consistency check or a new test set).

```R
# Use rescale=TRUE if you have multiple samples and want to normalize scores
pr <- dksClassify(eset, cl, rescale=TRUE)

# View results
summary(pr, actual=pData(eset)[,1])
show(pr)
```

## Advanced Features

### Weighting and Ratios
*   **Weights:** To avoid signatures dominated by low-expression/low-variance genes, use `weights=TRUE` in `dksTrain`. This weights genes by the log10 of their mean relative rank.
*   **Ratios:** For bidirectional analysis ("both"), it is often better to convert data to ratios (e.g., relative to a "normal" control) and work in log2 space.

### Significance Testing
Use permutation testing to estimate the p-values of the KS scores. This fits a gamma distribution to the results of randomly permuted class labels.

```R
# samples should be 1000-10000 for production
pvalue.f <- dksPerm(eset, 1, type="up", samples=500)
p_values <- pvalue.f(pr@predictedScore)
```

### Custom Signatures
If you already have gene sets (e.g., from literature), you can build a manual classifier:

```R
# sig.up: vector of gene IDs; cls: factor of corresponding classes
classifier <- dksCustomClass(upgenes=sig.up, upclass=cls)
pr.cust <- dksClassify(eset, classifier)
```

## Visualization and Accessors
*   **Plotting:** `plot(pr, actual=class_vector)` generates a multi-panel visualization showing how samples rank for each class signature.
*   **Running Sums:** Use `KS(expression_vector, signature_genes)` to get the running sum data for manual plotting of the KS statistic curve.
*   **Data Extraction:** Access results via slots: `pr@predictedClass` and `pr@scoreMatrix`.

## Reference documentation
- [Using dualKS](./references/dualKS.md)