---
name: bioconductor-gg4way
description: This tool creates 4-way plots to compare log-fold change values between two differential expression contrasts from RNA-seq or microarray data. Use when user asks to visualize shared and unique differentially expressed genes, calculate correlations between contrasts, or label specific genes of interest across two comparisons.
homepage: https://bioconductor.org/packages/release/bioc/html/gg4way.html
---


# bioconductor-gg4way

name: bioconductor-gg4way
description: Create 4-way plots to compare log-fold change (logFC) values between two differential expression contrasts. Use this skill when analyzing RNA-seq or microarray data to visualize shared and unique differentially expressed genes (DEGs) across two comparisons, calculate correlations between contrasts, and label specific genes of interest. Supports Bioconductor objects from limma, edgeR, and DESeq2.

# bioconductor-gg4way

## Overview

The `gg4way` package is a visualization tool for comparing two differential gene expression contrasts. It generates a scatter plot where the x and y axes represent the logFC of two different comparisons. The plot automatically categorizes genes into quadrants (shared DEGs, unique DEGs, or non-significant) and provides a Pearson correlation coefficient. This is particularly useful for identifying genes that behave similarly or oppositely across different experimental conditions or cell lines.

## Core Workflow

### 1. Data Preparation
`gg4way` integrates directly with standard Bioconductor differential expression workflows. Ensure your data contains gene symbols if you intend to label specific points.

### 2. Generating the 4-way Plot
The primary function is `gg4way()`. It accepts various object types:

- **limma**: Pass the `MArrayLM` object (output of `eBayes()`).
- **edgeR**: Pass a named list of `DGEExact` or `DGELRT` objects.
- **DESeq2**: Pass the `DESeqDataSet` (after `DESeq()`) or a named list of `DESeqResults`.
- **Custom Data**: A named list of data frames containing `ID`, `logFC`, and `FDR` columns.

```r
library(gg4way)

# Basic plot using limma efit object
p <- gg4way(efit, 
            x = "Contrast_Name_1", 
            y = "Contrast_Name_2")
print(p)
```

### 3. Labeling Genes
You can highlight specific genes by passing a character vector of symbols to the `label` argument.

```r
# Label specific genes
gg4way(efit, 
       x = "Contrast_1", 
       y = "Contrast_2", 
       label = c("GENE1", "GENE2"))

# Label all significant shared genes
gg4way(efit, x = "C1", y = "C2", label = TRUE)
```

### 4. Extracting Data and Statistics
- **Shared DEGs**: Use `getShared(plot_object)` to retrieve a tibble of genes significant in both contrasts.
- **Correlation**: Use `getCor(plot_object)` to get the Pearson correlation coefficient between the two contrasts' logFC values.

## Integration Examples

### DESeq2 (Results Name)
```r
gg4way(dds, x = "condition_A_vs_ctrl", y = "condition_B_vs_ctrl")
```

### DESeq2 (Manual Contrasts/Shrinkage)
If using `lfcShrink`, wrap the results in a named list:
```r
res_list <- list(
  "A_vs_Ctrl" = lfcShrink(dds, coef="condition_A_vs_ctrl", type="apeglm"),
  "B_vs_Ctrl" = lfcShrink(dds, coef="condition_B_vs_ctrl", type="apeglm")
)
gg4way(res_list, x = "A_vs_Ctrl", y = "B_vs_Ctrl")
```

### edgeR
```r
# rfit_list is a named list of glmQLFTest results
gg4way(rfit_list, x = "Group1", y = "Group2")
```

## Customization
Since `gg4way` returns a `ggplot` object, you can extend it using standard `ggplot2` functions:
- Change labels: `p + xlab("New X Label") + ylab("New Y Label")`
- Change themes: `p + theme_minimal()`

## Tips
- **Contrast Names**: The `x` and `y` arguments must match the names in your model matrix or the names in your results list exactly.
- **Significance Thresholds**: You can adjust thresholds using `padj` (default 0.05) and `lfc` (default 0) arguments within `gg4way()`.
- **Point Transparency**: Use the `alpha` argument to manage overplotting in large datasets.

## Reference documentation
- [gg4way](./references/gg4way.md)