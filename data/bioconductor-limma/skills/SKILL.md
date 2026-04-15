---
name: bioconductor-limma
description: This tool performs differential expression analysis using linear models and empirical Bayes methods for gene expression data. Use when user asks to perform linear modeling on transcriptomic or proteomic data, design complex experimental matrices, or calculate moderated t-statistics to identify differentially expressed genes.
homepage: https://bioconductor.org/packages/release/bioc/html/limma.html
---

# bioconductor-limma

name: bioconductor-limma
description: Expert guidance for using the Bioconductor R package 'limma' for differential expression analysis. Use this skill when performing linear modeling on gene expression data (RNA-seq, microarrays, qPCR, or proteomics), designing complex experimental matrices (factorial, time-course, or technical replicates), and calculating moderated t-statistics using empirical Bayes methods.

# bioconductor-limma

## Overview
`limma` (Linear Models for Microarray Data) is a premier Bioconductor package for analyzing gene expression data. It uses linear models to assess differential expression in multi-factor experiments. Its core strength lies in "borrowing" information across genes via empirical Bayes methods, which stabilizes the analysis even when the number of samples/arrays is small. While originally designed for microarrays, it is now a standard tool for RNA-seq (via the `voom` transformation) and other quantitative expression technologies.

## Core Workflow

### 1. Data Preparation
Load the library and prepare your expression matrix (rows = genes, columns = samples).
```R
library(limma)
# For RNA-seq, start with a DGEList from edgeR
# dge <- calcNormFactors(dge)
# v <- voom(dge, design, plot=TRUE) 
```

### 2. Defining the Design Matrix
The design matrix describes the experimental setup.
```R
# Group-means parametrization (recommended for clarity)
groups <- factor(c("WT", "WT", "Mu", "Mu"))
design <- model.matrix(~0 + groups)
colnames(design) <- levels(groups)
```

### 3. Fitting the Linear Model
Fit the model to the data (or the `voom` object).
```R
fit <- lmFit(object, design)
```

### 4. Defining Contrasts
Specify the specific comparisons you want to make.
```R
contrast.matrix <- makeContrasts(
  Mu_vs_WT = Mu - WT,
  levels = design
)
fit2 <- contrasts.fit(fit, contrast.matrix)
```

### 5. Empirical Bayes Smoothing
Compute moderated t-statistics, log-odds of differential expression, and p-values.
```R
fit2 <- eBayes(fit2)
# Use trend=TRUE if there is a mean-variance relationship not handled by voom
# Use robust=TRUE to protect against outlier genes
```

### 6. Extracting Results
```R
# Get top 10 differentially expressed genes for a specific contrast
topTable(fit2, coef="Mu_vs_WT", adjust="BH")

# Summary of results across all genes
results <- decideTests(fit2)
summary(results)
```

## Advanced Features

### Handling Technical Replicates
If you have multiple samples from the same biological unit (e.g., same patient), use `duplicateCorrelation`.
```R
corfit <- duplicateCorrelation(object, design, block=targets$Subject)
fit <- lmFit(object, design, block=targets$Subject, correlation=corfit$consensus)
```

### Factorial Designs (Interaction)
To find genes that respond differently to a treatment in a mutant vs. wild-type:
```R
# Contrast: (Mu.Stim - Mu.Untreat) - (WT.Stim - WT.Untreat)
cont.matrix <- makeContrasts(
  Interaction = (Mu.S - Mu.U) - (WT.S - WT.U),
  levels = design
)
```

### Time Course Analysis
For many time points, use regression splines:
```R
library(splines)
X <- ns(targets$Time, df=3)
design <- model.matrix(~Group * X)
fit <- lmFit(object, design)
# Test for any difference in trends between groups
topTable(fit, coef=5:7) 
```

## Tips for Success
- **Log-scale**: Ensure input data is on the log2 scale (except for `voom`, which takes raw counts).
- **Filtering**: Filter out lowly expressed genes before analysis to improve power and multiple testing correction.
- **Design Matrices**: If unsure, use the "Group-means" approach (no intercept) and `makeContrasts` for maximum flexibility.
- **Multiple Testing**: Always use the `adjust="BH"` (Benjamini-Hochberg) argument in `topTable` to control the False Discovery Rate (FDR).

## Reference documentation
- [A brief introduction to limma](./references/intro.md)
- [limma User's Guide](./references/usersguide.md)