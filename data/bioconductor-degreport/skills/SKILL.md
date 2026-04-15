---
name: bioconductor-degreport
description: DEGreport provides a suite of tools for the post-processing, quality control, and visualization of differential expression analysis results. Use when user asks to perform quality control on differential expression results, analyze the impact of covariates, visualize gene expression patterns, or cluster genes with similar expression profiles in complex experimental designs.
homepage: https://bioconductor.org/packages/release/bioc/html/DEGreport.html
---

# bioconductor-degreport

## Overview
The `DEGreport` package provides a suite of tools for the post-processing of differential expression (DE) analyses, primarily focusing on RNA-seq data. It bridges the gap between raw DE results (from DESeq2 or edgeR) and biological interpretation. Its core strengths lie in identifying expression patterns in complex designs (like time-series), performing rigorous QC to detect biases in DE genes, and visualizing the impact of covariates on the data.

## Core Workflows

### 1. Quality Control of DE Results
Before biological interpretation, use these functions to ensure the DE results are not biased by library size or dispersion issues.

```r
library(DEGreport)
library(DESeq2)

# Check if library size factors are appropriate
# counts: normalized count matrix
degCheckFactors(counts[, 1:6])

# Integrated QC: Mean-Variance, p-value distribution, and dispersion
# res: results object from DESeq2
degQC(counts, design[["group"]], pvalue = res[["pvalue"]])
```

### 2. Covariate Analysis
Identify if metadata variables (e.g., batch, age, sex) are significantly correlating with the principal components of your expression data.

```r
# Correlation between PCs and covariates
resCov <- degCovariates(log2(counts + 0.5), colData(dds))

# Correlation among covariates themselves
cor_results <- degCorCov(colData(dds))
```

### 3. Advanced Visualizations
`DEGreport` provides wrappers for common DE plots that are highly customizable.

*   **Volcano Plots:** Use `degVolcano` for standard or labeled volcano plots.
*   **MA Plots:** Use `degMA` with `DEGSet` objects to visualize shrunken vs. raw log2 fold changes.
*   **Gene Plots:** Use `degPlot` or `degPlotWide` to view expression levels across groups.

```r
# Volcano plot with specific genes labeled
res$id <- row.names(res)
show_genes <- as.data.frame(res[1:10, c("log2FoldChange", "padj", "id")])
degVolcano(res[,c("log2FoldChange", "padj")], plot_text = show_genes)

# Plot top genes by group
degPlot(dds = dds, res = res, n = 6, xs = "group")
```

### 4. Pattern Discovery (Time-Series/Complex Designs)
One of the most powerful features is `degPatterns`, which clusters genes that share similar expression profiles across conditions or time-points.

```r
# ma: expression matrix (e.g., rlog or vst transformed)
# time: the column in design used for grouping/ordering
clusters <- degPatterns(ma, design, time = "group")

# Access the cluster membership
head(clusters$df)
```

### 5. Working with DEGSet
The `DEGSet` class is used to manage multiple contrasts and shrunken results efficiently.

```r
# Create a DEGSet from multiple DESeq2 contrasts
degs <- degComps(dds, combs = "group")

# Extract specific results (defaults to shrunken)
res_table <- deg(degs[[1]], tidy = "tibble")

# Get significant gene list directly
sig_genes <- significants(degs[[1]], fc = 1, fdr = 0.05)
```

## Useful Utilities
*   **degFilter:** Filter genes based on minimum counts in a minimum number of samples per group.
*   **degColors:** Automatically generate color palettes for metadata annotations in heatmaps.
*   **degResults:** Generate a comprehensive HTML report containing MA plots, Volcano plots, and top gene tables in one command.

## Reference documentation
- [QC and downstream analysis for differential expression RNA-seq](./references/DEGreport.md)
- [Toolkit for differential expression analysis](./references/DEGreport.Rmd)