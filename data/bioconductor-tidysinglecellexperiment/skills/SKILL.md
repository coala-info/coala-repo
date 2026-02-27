---
name: bioconductor-tidysinglecellexperiment
description: This tool provides a bridge between Bioconductor's SingleCellExperiment container and the tidyverse ecosystem for seamless single-cell RNA-seq analysis. Use when user asks to manipulate metadata with dplyr verbs, join gene expression data for visualization, or perform pseudobulk aggregation on SingleCellExperiment objects.
homepage: https://bioconductor.org/packages/release/bioc/html/tidySingleCellExperiment.html
---


# bioconductor-tidysinglecellexperiment

name: bioconductor-tidysinglecellexperiment
description: Comprehensive single-cell RNA-seq analysis using tidyverse principles. Use when working with SingleCellExperiment objects to perform data manipulation (dplyr, tidyr), visualization (ggplot2, plotly), and pseudobulk aggregation while maintaining full compatibility with Bioconductor tools like scran and scater.

## Overview

`tidySingleCellExperiment` provides a bridge between Bioconductor's `SingleCellExperiment` (SCE) container and the `tidyverse` ecosystem. It allows users to treat SCE objects as tibbles, where each row represents a cell and columns represent cell-level metadata. This enables the use of standard `dplyr` verbs (`filter`, `mutate`, `select`, `group_by`) and `tidyr` functions (`pivot_longer`, `nest`) directly on the SCE object without losing the underlying biological assays or reduced dimensions.

## Key Functions and Workflows

### Data Representation
When the library is loaded, `SingleCellExperiment` objects are automatically displayed as tibbles.
- To toggle this view: `options("restore_SingleCellExperiment_show" = TRUE/FALSE)`.
- To convert to a permanent tibble: `as_tibble(sce_object)`.

### Feature Integration
Since the tibble view primarily shows cell metadata, use `join_features()` to bring assay data (e.g., gene expression) into the tidy workflow.
- **Long format (default):** Useful for ggplot2 facets.
  `sce %>% join_features(features = c("CD3E", "CD19"), shape = "long")`
- **Wide format:** Useful for gene-vs-gene correlation plots.
  `sce %>% join_features(features = c("CD3E", "CD19"), shape = "wide")`

### Data Manipulation and Polishing
Use standard tidyverse verbs to clean metadata:
- **Extracting info:** `sce %>% extract(file, "sample_id", "path/to/(.*)_counts", remove = FALSE)`
- **Filtering:** `sce %>% filter(nCount_RNA > 500)`
- **Mutating:** `sce %>% mutate(is_mitochondrial = grepl("^MT-", gene_name))`

### Pseudobulk Aggregation
The `aggregate_cells()` function simplifies the creation of pseudobulk data for differential expression or cross-sample comparisons.
- `sce %>% aggregate_cells(groups = c(sample, cluster), assays = "counts")`
- Returns a `SummarizedExperiment` object.

### Nested Analysis
A powerful pattern for performing independent analyses on cell subsets (e.g., analyzing Myeloid and Lymphoid cells separately):
```r
sce_nested <- sce %>%
  nest(data = -cell_class) %>%
  mutate(data = map(data, ~ .x %>% runPCA() %>% runUMAP()))
```

### Visualization
Because the object behaves like a tibble, it can be piped directly into `ggplot()` or `plot_ly()`:
```r
sce %>%
  ggplot(aes(x = UMAP1, y = UMAP2, color = cluster)) +
  geom_point()
```

## Tips for Success
- **Column Names:** Be aware that `tidySingleCellExperiment` adds a `.cell` column to represent cell barcodes/identifiers.
- **Reduced Dimensions:** Coordinates like `UMAP1` or `PC1` are treated as columns in the tibble view, making them easy to plot.
- **Compatibility:** You can still use any Bioconductor function (e.g., `scran::modelGeneVar(sce)`) on the tidy object; it remains a valid `SingleCellExperiment`.
- **Combining Data:** Use `append_samples()` to merge multiple SCE objects while maintaining the tidy abstraction.

## Reference documentation
- [Introduction](./references/introduction.Rmd)
- [Introduction](./references/introduction.md)