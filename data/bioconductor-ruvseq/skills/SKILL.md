---
name: bioconductor-ruvseq
description: This tool removes unwanted variation and batch effects from RNA-Seq data using control genes, replicates, or residuals. Use when user asks to normalize read counts, remove technical noise, or estimate hidden factors of variation for differential expression analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/RUVSeq.html
---

# bioconductor-ruvseq

name: bioconductor-ruvseq
description: Normalization of RNA-Seq data to remove unwanted variation (batch effects, technical noise, or other nuisance effects) using the RUVSeq package. Use this skill when performing differential expression analysis where hidden factors or batch effects are suspected, or when exploratory plots (PCA/RLE) show sample clustering driven by non-biological factors.

# bioconductor-ruvseq

## Overview

RUVSeq (Remove Unwanted Variation from RNA-Seq data) provides methods to estimate and remove factors of unwanted variation from RNA-Seq read counts. It operates within a Generalized Linear Model (GLM) framework, regressing counts on both known covariates of interest (e.g., treatment) and unknown factors of unwanted variation (e.g., batch effects).

The package provides three main methods to estimate these factors ($W$):
1.  **RUVg**: Uses negative control genes (genes with constant expression across samples).
2.  **RUVs**: Uses replicate samples (technical or biological replicates where the covariate of interest is constant).
3.  **RUVr**: Uses residuals from a first-pass GLM regression.

## Core Workflow

### 1. Data Preparation and EDA
RUVSeq works with `matrix` objects or `SeqExpressionSet` objects (from the `EDASeq` package).

```r
library(RUVSeq)
library(EDASeq)

# Create a SeqExpressionSet
# counts: matrix of raw integer counts
# x: factor representing the experimental condition
set <- newSeqExpressionSet(as.matrix(counts),
                           phenoData = data.frame(x, row.names=colnames(counts)))

# Exploratory Data Analysis (EDA)
# Relative Log Expression (RLE) plot
plotRLE(set, outline=FALSE, col=as.numeric(x))
# Principal Component Analysis (PCA) plot
plotPCA(set, col=as.numeric(x))
```

### 2. Estimating Unwanted Variation

#### Method A: RUVg (Control Genes)
Use this when you have a set of negative control genes (e.g., ERCC spike-ins, housekeeping genes, or "in-silico" empirical controls).

```r
# spikes: vector of row names for control genes
# k: number of factors of unwanted variation to estimate
set1 <- RUVg(set, spikes, k=1)

# Access estimated factors in phenoData
factors <- pData(set1) # Contains W_1, W_2, etc.
```

#### Method B: RUVs (Replicate Samples)
Use this when you have replicates (e.g., multiple samples of the same treatment).

```r
# Create a groups matrix where each row contains indices of replicates
# makeGroups is a helper for this
differences <- makeGroups(x)

# genes: genes to use for estimation (often all genes)
set_s <- RUVs(set, genes, k=1, differences)
```

#### Method C: RUVr (Residuals)
Use this after a first-pass DE analysis to capture variation not explained by the model.

```r
# 1. Run first-pass GLM (e.g., with edgeR) to get residuals
# 2. res: matrix of deviance residuals
set_r <- RUVr(set, genes, k=1, res)
```

### 3. Differential Expression Analysis
**Important:** Do not use the normalized counts returned by RUVSeq for differential expression testing. Instead, include the estimated factors ($W$) as covariates in your DE model (edgeR or DESeq2) using the original raw counts.

#### Using edgeR
```r
library(edgeR)
# Add W_1 to the design matrix
design <- model.matrix(~x + W_1, data=pData(set1))
y <- DGEList(counts=counts(set1), group=x)
y <- calcNormFactors(y, method="upperquartile")
y <- estimateGLMCommonDisp(y, design)
y <- estimateGLMTagwiseDisp(y, design)
fit <- glmFit(y, design)
lrt <- glmLRT(fit, coef=2) # Test for effect of x
```

#### Using DESeq2
```r
library(DESeq2)
dds <- DESeqDataSetFromMatrix(countData = counts(set1),
                              colData = pData(set1),
                              design = ~ W_1 + x)
dds <- DESeq(dds)
res <- results(dds)
```

## Tips and Best Practices

*   **Choosing k**: The number of factors ($k$) is a tuning parameter. Start with $k=1$ and increase it if PCA/RLE plots still show unwanted structure. Be careful not to over-fit, which can remove biological signal.
*   **Normalized Counts**: The `normCounts(set)` function returns counts adjusted for $W$. These are excellent for visualization (PCA, Heatmaps) but should not be used for statistical testing.
*   **Empirical Controls**: If no spike-ins exist, run a standard DE analysis first and use the least significantly changed genes (e.g., bottom 5,000 by p-value) as "empirical" controls for `RUVg`.
*   **Upper-Quartile Normalization**: It is often recommended to perform upper-quartile (UQ) normalization (via `EDASeq::betweenLaneNormalization`) before running RUVSeq methods.

## Reference documentation

- [RUVSeq: Remove Unwanted Variation from RNA-Seq Data](./references/RUVSeq.md)
- [RUVSeq Vignette (Rmd)](./references/RUVSeq.Rmd)