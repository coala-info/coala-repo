---
name: bioconductor-gosummaries
description: This tool visualizes Gene Ontology enrichment results by combining word clouds with experimental data plots like boxplots or violin plots. Use when user asks to visualize GO enrichment results, create word clouds for gene lists, or summarize results from PCA, k-means clustering, and differential expression analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GOsummaries.html
---


# bioconductor-gosummaries

name: bioconductor-gosummaries
description: Visualizing Gene Ontology (GO) enrichment results using word clouds combined with experimental data plots. Use this skill when you need to create summary visualizations for gene lists derived from clustering (k-means), PCA, or differential expression analysis (limma), or when you want to display custom word clouds for biological data.

## Overview

GOsummaries is an R package designed to visualize gene lists by representing significant GO categories as word clouds. These word clouds are integrated into a multi-panel layout that can also display underlying experimental data (like expression levels) using boxplots, violin plots, or histograms. It is particularly useful for summarizing complex results from PCA, k-means clustering, or linear modeling in a single, publication-ready figure.

## Core Workflow

The typical workflow involves two main steps:
1.  **Create a GOsummaries object**: Use `gosummaries()` or its specialized methods to perform GO enrichment (via g:Profiler) and organize data.
2.  **Plot the object**: Use `plot()` to generate the visualization.

### 1. Creating GOsummaries Objects

**From Gene Lists:**
```r
# gl is a list of gene lists
gs <- gosummaries(gl)
```

**From Analysis Results (Convenience Functions):**
*   **K-means**: `gosummaries.kmeans(km, exp = expression_matrix, annotation = annot_df)`
*   **PCA**: `gosummaries.prcomp(pca, ...)`
*   **Limma**: `gosummaries.MArrayLM(fit, ...)`
*   **MDS/Matrix**: `gosummaries.matrix(matrix, ...)`

### 2. Adding Expression Data
To show boxplots of gene expression alongside word clouds:
```r
gs_exp <- add_expression.gosummaries(gs, exp = exp_matrix, annotation = annot_df)
```
*   `exp`: Matrix where rows are genes and columns are samples.
*   `annotation`: Data frame where row names match `exp` column names.

### 3. Customizing the Plot
The `plot()` function (or `plot.gosummaries`) handles the rendering.
```r
plot(gs, 
     fontsize = 8, 
     classes = "Condition", # Column name in annotation for coloring
     panel_plot = panel_violin, # Options: panel_boxplot, panel_violin, panel_violin_box
     filename = "output.pdf")
```

## Advanced Usage

### Custom Word Clouds
If you have pre-calculated enrichment results or non-GO data (e.g., gene names, metabolites):
```r
# Data frame must have "Term" and "Score" columns
wcd <- data.frame(Term = c("GeneA", "GeneB"), Score = c(0.01, 0.001))
gs <- gosummaries(wc_data = list(Component1 = wcd))
```

### Configuring GO Enrichment
Adjust the `gosummaries()` call to filter results:
*   `go_branches`: e.g., `c("BP")` for Biological Process only.
*   `min_set_size` / `max_set_size`: Filter GO categories by size.
*   `max_p_value`: Significance threshold.
*   `ordered_query`: Set to `FALSE` if the input gene list is not ranked.

### Displaying Gene Names
For small datasets or non-gene data (like metagenomics), toggle `show_genes = TRUE` in specialized functions (`gosummaries.prcomp`, `gosummaries.matrix`) to display the actual identifiers instead of GO terms.

## Tips
*   **File Output**: Because the layout is strict, plots often don't fit in the R IDE's small plotting window. Always specify a `filename` (e.g., .pdf or .png) in the `plot` function.
*   **Color Schemes**: Use `panel_customize` to pass a function that adds ggplot2 scales (e.g., `scale_fill_brewer`) to the internal panel plots.
*   **ID Conversion**: The package uses `gconvert` internally. If using non-standard IDs, ensure they are compatible with g:Profiler or provide `wc_data` manually.

## Reference documentation
- [GOsummaries basics](./references/GOsummaries-basics.md)