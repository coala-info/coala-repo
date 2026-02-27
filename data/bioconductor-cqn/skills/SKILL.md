---
name: bioconductor-cqn
description: This tool performs Conditional Quantile Normalization to remove GC-content and gene length biases from RNA-seq count data. Use when user asks to normalize RNA-seq data for systematic biases, generate offsets for edgeR or DESeq2, or visualize the effects of GC-content and gene length on expression.
homepage: https://bioconductor.org/packages/release/bioc/html/cqn.html
---


# bioconductor-cqn

name: bioconductor-cqn
description: Conditional Quantile Normalization (CQN) for RNA-seq data. Use this skill to remove systematic biases such as GC-content and gene length effects from RNA-seq count data, and to generate offsets for differential expression analysis in edgeR or DESeq2.

# bioconductor-cqn

## Overview

The `cqn` package implements Conditional Quantile Normalization, a method designed to correct for systematic biases in RNA-seq data, specifically GC-content and gene length effects. Unlike standard RPKM/FPKM which assume a linear relationship, CQN uses non-parametric smooth functions (splines) to model these biases. It produces normalized expression values and, more importantly, offsets that can be integrated into GLM-based differential expression tools like `edgeR`.

## Core Workflow

### 1. Data Preparation
CQN requires four primary inputs with matching row/column orders:
- `counts`: A matrix of raw reads (rows = genes, columns = samples).
- `x`: A covariate to normalize for (typically GC-content).
- `lengths`: A vector of gene/region lengths.
- `sizeFactors`: A vector of sequencing depths (library sizes).

```r
library(cqn)

# Example check for alignment
stopifnot(all(rownames(counts) == names(lengths)))
stopifnot(all(colnames(counts) == names(sizeFactors)))
```

### 2. Running Normalization
The `cqn()` function fits the model: `log2(RPM) = s(x) + s(log2(length))`.

```r
cqn.res <- cqn(counts, 
               x = gc_content, 
               lengths = gene_lengths, 
               sizeFactors = lib_sizes, 
               verbose = TRUE)
```

### 3. Visualizing Bias Correction
Use `cqnplot()` to inspect the systematic effects of GC-content (`n=1`) and length (`n=2`).

```r
par(mfrow=c(1,2))
cqnplot(cqn.res, n = 1, xlab = "GC content")
cqnplot(cqn.res, n = 2, xlab = "Length")
```

### 4. Extracting Results
CQN provides two main outputs:
- **Normalized Expression**: `y + offset` provides log2-scale RPKM-like values.
- **GLM Offsets**: `glm.offset` is the correct scale for `edgeR` or `DESeq2`.

```r
# For visualization or clustering
normalized_log2_rpkm <- cqn.res$y + cqn.res$offset

# For differential expression (edgeR)
dge <- DGEList(counts = counts, group = groups)
dge$offset <- cqn.res$glm.offset
```

## Integration with edgeR

When using CQN with `edgeR`, do **not** use `calcNormFactors()`. The CQN offset already accounts for library size and composition biases.

```r
library(edgeR)
design <- model.matrix(~group)
dge <- DGEList(counts = counts)
dge$offset <- cqn.res$glm.offset

# Estimate dispersion and fit GLM
dge <- estimateGLMCommonDisp(dge, design)
fit <- glmFit(dge, design)
lrt <- glmLRT(fit, coef = 2)
```

## Usage Tips

- **Small RNA-seq**: For microRNAs where lengths are nearly identical, use `lengthMethod = "fixed"` or set `lengths = 1` to disable the length-bias spline and avoid mathematical instability.
- **Single Samples**: While `cqn()` can run on a single sample, it is designed for multi-sample normalization to make biases comparable across the experiment.
- **Filtering**: Always filter out genes with very low counts before or after normalization, as CQN cannot reliably correct regions with near-zero observations.
- **Scale Difference**: `cqn$offset` is for log2-RPKM calculation; `cqn$glm.offset` is on the natural log scale for use in count-based GLMs.

## Reference documentation
- [CQN (Conditional Quantile Normalization)](./references/cqn.md)