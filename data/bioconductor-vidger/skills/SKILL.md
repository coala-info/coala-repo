---
name: bioconductor-vidger
description: This tool generates information-rich visualizations such as boxplots, volcano plots, and scatter plots from RNA-seq differential gene expression results. Use when user asks to visualize DGE data from Cuffdiff, DESeq2, or edgeR, create publication-quality plots of gene expression distributions, or compare fold changes across multiple experimental conditions.
homepage: https://bioconductor.org/packages/release/bioc/html/vidger.html
---


# bioconductor-vidger

name: bioconductor-vidger
description: Visualization of Differential Gene Expression Results (ViDGER). Use this skill to generate information-rich visualizations (boxplots, scatter plots, MA plots, volcano plots, and four-way plots) from RNA-seq analysis results produced by Cuffdiff, DESeq2, or edgeR.

# bioconductor-vidger

## Overview
The `vidger` package provides a streamlined suite of functions to visualize Differential Gene Expression (DGE) results. It acts as a wrapper for three major RNA-seq analysis tools: **Cuffdiff**, **DESeq2**, and **edgeR**. The package simplifies the process of creating publication-quality plots by handling the underlying data structures of these specific tools automatically.

## Typical Workflow

### 1. Load Package and Data
Load the library and your specific analysis object. `vidger` includes toy datasets for practice: `df.cuff`, `df.deseq`, and `df.edger`.

```r
library(vidger)

# Load toy data
data("df.deseq")
```

### 2. Core Visualization Functions
All functions require the `type` argument (one of `"cuffdiff"`, `"deseq"`, or `"edger"`) and the `data` object.

*   **Distribution Analysis**: Use `vsBoxPlot()` to check FPKM/CPM distributions.
    *   Aesthetics (`aes`): `"box"`, `"violin"`, `"boxdot"`, `"viodot"`, `"viosumm"`, or `"notch"`.
*   **Sample Comparisons**: Use `vsScatterPlot()` for two-way comparisons or `vsScatterMatrix()` for all-against-all.
*   **DGE Summary**: Use `vsDEGMatrix()` to see a heatmap of the number of DEGs across all comparisons at a specific `padj` threshold.
*   **Variance and Fold Change**:
    *   `vsMAPlot()` / `vsMAMatrix()`: Log-fold change vs. mean counts.
    *   `vsVolcano()` / `vsVolcanoMatrix()`: Significance (-log10 p-value) vs. log2 fold change.
*   **Multi-condition Analysis**: `vsFourWay()` compares log2 fold changes between two treatments against a common control.

### 3. Key Parameters
*   **d.factor**: Required for `DESeq2` objects to specify the experimental condition (e.g., `d.factor = 'condition'`).
*   **padj**: Set the significance threshold (default is often 0.05).
*   **lfc**: Set the log-fold change threshold for highlighting.
*   **highlight**: Pass a vector of gene/transcript IDs to label specific points on scatter, MA, volcano, or four-way plots.

## Tips and Tricks

### Data Extraction
If you need the processed data used to generate a plot for custom analysis, set `data.return = TRUE`. This returns a list containing both the data frame and the ggplot object.

```r
tmp <- vsScatterPlot(x = "hESC", y = "iPS", data = df.cuff, type = "cuffdiff", data.return = TRUE)
processed_df <- tmp$data
plot_obj <- tmp$plot
```

### Customizing Appearance
*   **Colors**: Use `fill.color` with RColorBrewer palette names (e.g., `"Paired"`, `"RdGy"`, `"Greys"`).
*   **Text Size**: Fine-tune labels using parameters like `xaxis.text.size`, `main.title.size`, and `legend.text.size`.
*   **Point Shapes**: `vidger` automatically changes point shapes to triangles if they exceed the defined viewing area (axes limits).

## Reference documentation
- [Visualizing RNA-seq data with ViDGER](./references/vidger.Rmd)
- [ViDGER Supplementary Material](./references/vidger.md)