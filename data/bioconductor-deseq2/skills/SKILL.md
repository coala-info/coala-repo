---
name: bioconductor-deseq2
description: DESeq2 performs differential expression analysis of RNA-seq and other count-based data using the negative binomial distribution. Use when user asks to perform statistical inference on gene expression changes, normalize count data, estimate dispersions, or apply log fold change shrinkage.
homepage: https://bioconductor.org/packages/release/bioc/html/DESeq2.html
---


# bioconductor-deseq2

name: bioconductor-deseq2
description: Expert guidance for differential expression analysis of RNA-seq (and other count-based) data using the DESeq2 R package. Use this skill when performing statistical inference on systematic changes between conditions, including data normalization, dispersion estimation, Wald tests, Likelihood Ratio Tests (LRT), and effect size shrinkage.

# bioconductor-deseq2

## Overview
DESeq2 is a Bioconductor package designed for differential gene expression analysis based on the negative binomial distribution. It is the industry standard for analyzing un-normalized RNA-seq read counts. The package estimates variance-mean dependence (dispersion) and uses shrinkage estimators for fold changes to improve the stability and interpretability of results, especially for genes with low counts.

## Core Workflow

### 1. Data Input and Object Construction
DESeq2 requires un-normalized integer counts. The primary object is the `DESeqDataSet`.

- **From Matrix**: Use when you have a count matrix and a sample metadata data frame.
  ```R
  dds <- DESeqDataSetFromMatrix(countData = cts, colData = coldata, design = ~ condition)
  ```
- **From Tximport**: Recommended for Salmon/Kallisto/RSEM outputs to account for gene length changes.
  ```R
  dds <- DESeqDataSetFromTximport(txi, colData = samples, design = ~ condition)
  ```
- **From SummarizedExperiment**:
  ```R
  dds <- DESeqDataSet(se, design = ~ condition)
  ```

### 2. Differential Expression Analysis
The `DESeq()` function wraps size factor estimation, dispersion estimation, and GLM fitting into one call.

```R
# Standard analysis
dds <- DESeq(dds)

# Access results
res <- results(dds, name="condition_treated_vs_untreated")
# Or using contrasts for specific comparisons
res <- results(dds, contrast=c("condition", "level_A", "level_B"))
```

### 3. Log Fold Change (LFC) Shrinkage
Essential for ranking and visualization (MA-plots). It reduces noise from low-count genes.

```R
# 'apeglm' is the recommended default (requires the apeglm package)
resLFC <- lfcShrink(dds, coef="condition_treated_vs_untreated", type="apeglm")
```

### 4. Data Transformation for Visualization
For PCA or clustering, use transformations that stabilize variance across the dynamic range. Do NOT use these for differential testing.

- **VST (Variance Stabilizing Transformation)**: Fast, recommended for large datasets (n > 30).
  ```R
  vsd <- vst(dds, blind=FALSE)
  ```
- **rlog (Regularized Log)**: Robust for small datasets (n < 30).
  ```R
  rld <- rlog(dds, blind=FALSE)
  ```

## Advanced Features

### Multi-factor Designs
To control for batch effects or other covariates:
```R
design(dds) <- ~ batch + condition
```

### Likelihood Ratio Test (LRT)
Use for time-series or to test any change across a factor with more than two levels (ANOVA-like).
```R
dds <- DESeq(dds, test="LRT", reduced=~batch)
res <- results(dds)
```

### Single-Cell Recommendations
For sparse single-cell data:
- Use `test="LRT"`.
- Set `useT=TRUE`, `minmu=1e-6`, and `minReplicatesForReplace=Inf`.
- Use `fitType="glmGamPoi"` for significant speed improvements.

## Tips and Best Practices
- **Pre-filtering**: Remove rows with very low counts (e.g., `rowSums(counts(dds)) < 10`) to speed up computation and reduce memory.
- **Factor Levels**: Ensure the reference level (e.g., "control") is set correctly using `relevel(dds$condition, ref="untreated")`.
- **Independent Filtering**: `results()` automatically filters genes with low mean counts to optimize power; these will appear as `NA` in the `padj` column.
- **Outliers**: Cook's distance is used to flag outliers. If a gene has an outlier, `pvalue` and `padj` will be `NA`.

## Reference documentation
- [Analyzing RNA-seq data with DESeq2](./references/DESeq2.md)