---
name: bioconductor-rvisdiff
description: This tool generates interactive web-based visualizations and portable HTML reports for differential expression analysis results. Use when user asks to create interactive Volcano plots, generate exploratory interfaces for DESeq2 or edgeR results, or visualize gene-level expression data through heatmaps and box plots.
homepage: https://bioconductor.org/packages/release/bioc/html/Rvisdiff.html
---

# bioconductor-rvisdiff

name: bioconductor-rvisdiff
description: Create interactive web-based visualizations for differential expression analysis results. Use this skill when you need to generate an exploratory interface (Volcano plots, MA-plots, Heatmaps, Box plots) from DESeq2, edgeR, limma, or custom statistical test outputs.

# bioconductor-rvisdiff

## Overview

`Rvisdiff` is a Bioconductor package designed to bridge the gap between statistical differential expression (DE) results and interactive data exploration. It transforms static tables into a local, portable HTML report containing synchronized visualizations. The primary function is `DEreport()`, which accepts results from major DE frameworks and raw/normalized expression data to produce an interface for inspecting gene-level details across samples.

## Core Workflow

The general workflow involves performing a differential expression analysis using standard R packages and then passing the results to `Rvisdiff`.

### 1. Installation and Loading

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install("Rvisdiff")
library(Rvisdiff)
```

### 2. Generating Reports from DE Frameworks

`Rvisdiff` automatically detects the output formats of `DESeq2`, `edgeR`, and `limma`.

#### From DESeq2
```r
# dres: DESeqResults object
# countdata: matrix/df of expression values
# condition: factor/vector of sample groups
DEreport(dres, countdata, condition)
```

#### From edgeR
```r
# tt: topTags object (from exactTest or glm)
DEreport(tt, countdata, condition)
```

#### From limma
```r
# limmares: topTable object
DEreport(limmares, countdata, condition)
```

### 3. Custom Statistical Results
If using custom tests (e.g., Wilcoxon), provide a data frame containing at least `stat`, `pvalue`, `padj`, `baseMean`, and `log2FoldChange` columns.

```r
# Example for custom data frame 'res_df'
DEreport(res_df, countdata, condition)
```

## Interactive Features

The generated HTML report includes several linked visualizations:
- **Volcano Plot**: -log10(p-value) vs log2(Fold Change).
- **MA-Plot**: log2(Fold Change) vs Mean Expression.
- **Line Diagram**: Expression levels across individual samples, grouped by condition.
- **Box Plot**: Distribution of expression for selected genes across conditions.
- **Cluster Heatmap**: Scaled expression grid with dendrograms and zoom capabilities.

## Tips for Success

- **Input Consistency**: Ensure the row names of the DE results match the row names of the expression matrix (`countdata`).
- **Sample Ordering**: The `condition` vector must be in the same order as the columns in your `countdata` matrix.
- **Portability**: The output is a standalone HTML file. It does not require a Shiny server or internet connection to view once generated, making it ideal for sharing with collaborators.
- **Data Privacy**: Since the report is generated locally, no data is uploaded to external servers.

## Reference documentation

- [Visualize Differential Expression results](./references/Rvisdiff.md)