---
name: bioconductor-absseq
description: "bioconductor-absseq performs differential expression analysis of RNA-Seq data by modeling absolute expression differences with a Negative Binomial distribution. Use when user asks to perform pairwise comparisons, conduct linear modeling for complex experimental designs, or apply variance stabilization for PCA using the ABSSeq R package."
homepage: https://bioconductor.org/packages/release/bioc/html/ABSSeq.html
---


# bioconductor-absseq

name: bioconductor-absseq
description: Differential expression analysis of RNA-Seq data using absolute expression differences. Use this skill when performing pairwise comparisons, linear modeling for complex experimental designs, or variance stabilization for PCA using the ABSSeq R package.

## Overview
ABSSeq is a Bioconductor package designed for RNA-Seq analysis by modeling absolute counts differences between conditions. It assumes that sum counts differences follow a Negative Binomial distribution. Key features include fold-change moderation (via the `aFold` approach), robust normalization methods, and integration with `limma` for complex experimental designs. It is particularly effective at borrowing information across genes to smooth dispersions and providing accurate gene rankings.

## Core Workflow: Pairwise Comparison

The standard workflow involves creating an `ABDataSet` object, normalizing, estimating parameters, and calling differential expression (DE).

```R
library(ABSSeq)

# 1. Data Preparation
# counts: matrix of raw counts; groups: factor defining conditions
obj <- ABSDataSet(counts, factor(groups))

# 2. Normalization (Default: qtotal)
# Options: "qtotal", "total", "geometric", "quantile", "TMM", "user"
obj <- normalFactors(obj)

# 3. Parameter Estimation and DE Calling (Combined)
obj <- ABSSeq(obj)

# 4. Retrieve Results
# Returns: rawFC, lowFC (expression adjusted), foldChange (moderated), pvalue, adj.pvalue
res <- results(obj)
head(res)
```

## Advanced DE Analysis with aFold
The `aFold` method uses a polynomial function to model uncertainty and provides more reliable fold-change estimations for ranking and visualization.

```R
# Enable aFold during the main call
obj <- ABSSeq(obj, useaFold = TRUE)
res <- results(obj, c("Amean", "Bmean", "foldChange", "pvalue", "adj.pvalue"))
```

## Complex Experimental Designs
For designs with multiple factors or covariates, use `ABSSeqlm`, which interfaces with `limma`.

```R
# Create design matrix
design <- model.matrix(~0 + groups)

# Run linear model comparison
# condA and condB specify the columns in the design matrix to compare
res <- ABSSeqlm(obj, design, condA = "group1", condB = "group2")

# For ANOVA across multiple conditions
res_anova <- ABSSeqlm(obj, design, condA = c("group1", "group2", "group3"))
```

## Variance Stabilization and PCA
ABSSeq can stabilize variance across expression levels, which is useful for exploratory data analysis like PCA.

```R
# Normalize counts
cda <- counts(obj, norm = TRUE)

# Generate stabilized counts (returns a list)
# cond is a factor of groups (can be a single group for unsupervised stabilization)
sds <- genAFold(cda, cond)

# Use the 4th element (expression level adjusted counts) for PCA
ldat <- log2(sds[[4]])
pca_res <- prcomp(t(ldat), scale = FALSE)
```

## Key Functions and Parameters
- `ABDataSet(counts, groups, paired = FALSE)`: Constructor. Set `paired = TRUE` for matched samples (e.g., tumor/normal).
- `normMethod(obj) <- "geometric"`: Change normalization method manually.
- `callParameterwithoutReplicates(obj)`: Specialized estimation for datasets lacking biological replicates.
- `plotDifftoBase(obj)`: Diagnostic plot showing absolute log2 fold-change against expression level.
- `results(obj, columns)`: Extract specific data. Common columns: `absD` (absolute difference), `Amean`, `Bmean`, `foldChange`, `pvalue`.

## Reference documentation
- [ABSSeq](./references/ABSSeq.md)