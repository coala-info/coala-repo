---
name: bioconductor-deseq2
description: This tool performs statistical analysis of high-throughput sequencing count data to identify differentially expressed genes between experimental conditions. Use when user asks to perform differential expression analysis, estimate log fold change shrinkage, or generate variance-stabilized transformations for RNA-seq data visualization.
homepage: https://bioconductor.org/packages/release/bioc/html/DESeq2.html
---


# bioconductor-deseq2

## Overview

The `bioconductor-deseq2` skill provides a standardized framework for the statistical analysis of high-throughput sequencing count data. It is primarily used to identify systematic changes between experimental conditions while accounting for within-condition variability. This skill covers the end-to-end R-based workflow, from importing raw counts and defining experimental designs to performing statistical tests and generating shrunken fold-change estimates for robust visualization.

## Core Workflow

### 1. Data Import and Object Construction

DESeq2 requires un-normalized integer counts. Use the appropriate constructor based on your upstream pipeline:

- **From Matrix**: Use `DESeqDataSetFromMatrix()` if you have a count matrix and a sample metadata dataframe.
- **From tximport**: Use `DESeqDataSetFromTximport()` for transcript-level estimates (Salmon/Kallisto).
- **From HTSeq**: Use `DESeqDataSetFromHTSeqCount()` for `.txt` count files.

```r
# Basic matrix construction
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ batch + condition)
```

### 2. Differential Expression Analysis

The `DESeq()` function wraps size factor estimation, dispersion estimation, and the Wald test into a single call.

```r
# Run the standard pipeline
dds <- DESeq(dds)

# Extract results for a specific comparison
res <- results(dds, contrast=c("condition", "treated", "untreated"))
```

### 3. Log Fold Change (LFC) Shrinkage

Shrinkage is essential for ranking and visualization (MA-plots), as it reduces noise from low-count genes. The `apeglm` method is the recommended default.

```r
# List available coefficients
resultsNames(dds)

# Apply shrinkage to a specific coefficient
resLFC <- lfcShrink(dds, coef="condition_treated_vs_untreated", type="apeglm")
```

### 4. Data Transformation for Visualization

For PCA or heatmaps, use transformations that stabilize variance across the dynamic range. Do NOT use these transformed values for differential testing.

- **vst()**: Fast; recommended for large datasets (n > 30).
- **rlog()**: Robust; recommended for smaller datasets.

```r
# Variance Stabilizing Transformation
vsd <- vst(dds, blind=FALSE)

# Principal Component Analysis
plotPCA(vsd, intgroup=c("condition", "batch"))
```

## Expert Tips and Best Practices

- **Factor Levels**: R assigns reference levels alphabetically by default. Explicitly set your control group using `relevel(dds$condition, ref="untreated")` before running `DESeq()`.
- **Pre-filtering**: While not strictly required, removing rows with very low counts (e.g., `keep <- rowSums(counts(dds)) >= 10`) improves speed and reduces memory overhead.
- **Multi-factor Designs**: Put the variable of interest at the end of the design formula (e.g., `~ batch + condition`).
- **Independent Filtering**: `results()` automatically performs independent filtering to maximize the number of rejections at a given FDR. If you change your target alpha, specify it in the call: `results(dds, alpha=0.05)`.
- **Outliers**: For experiments with 7+ replicates, DESeq2 automatically replaces outliers detected by Cook's distance. For smaller cohorts, genes with outliers are flagged as `NA`.

## Reference documentation

- [Analyzing RNA-seq data with DESeq2](./references/DESeq2.md)
- [DESeq2 Bioconductor Page](./references/bioconductor_org_packages_release_bioc_html_DESeq2.html.md)