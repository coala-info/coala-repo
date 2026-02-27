---
name: bioconductor-sechm
description: This tool generates and customizes annotated heatmaps from SummarizedExperiment objects. Use when user asks to create heatmaps from omics data, compare multiple datasets with aligned heatmaps, customize color scales and annotations, or sort features using MDS angle.
homepage: https://bioconductor.org/packages/release/bioc/html/sechm.html
---


# bioconductor-sechm

name: bioconductor-sechm
description: Create and customize annotated heatmaps from SummarizedExperiment objects using the sechm package. Use this skill when you need to visualize gene expression or omics data, specifically for: (1) Generating publication-quality heatmaps with automatic scaling and annotation, (2) Comparing multiple datasets with aligned heatmaps (crossHm), (3) Customizing color scales with quantile capping, or (4) Sorting rows using MDS angle or clustering.

## Overview

The `sechm` package is a high-level wrapper around `ComplexHeatmap` specifically designed for `SummarizedExperiment` (SE) objects. It simplifies the process of mapping `rowData` and `colData` to heatmap annotations and provides sensible defaults for color scales and row ordering.

## Basic Heatmap Generation

The primary function is `sechm()`. It requires a `SummarizedExperiment` object and a vector of features (row names).

```r
library(sechm)

# Basic heatmap
sechm(SE, features = c("Gene1", "Gene2", "Gene3"))

# With row scaling (Z-score)
sechm(SE, features = g, do.scale = TRUE)

# Specify assay and annotations
sechm(SE, 
      features = g, 
      assayName = "logcpm", 
      top_annotation = c("Condition", "Time"), 
      left_annotation = "meanLogCPM")
```

## Customizing the View

### Row Ordering and Highlighting
By default, `sechm` sorts rows using the MDS angle method.
- **Disable sorting**: Set `sortRowsOn = NULL`.
- **Highlight specific genes**: Use the `mark` argument to label specific rows in a large heatmap.
- **Gaps**: Use `gaps_at` (for columns) or `gaps_row` (for rows) referencing metadata columns.

```r
sechm(SE, features = row.names(SE), mark = g, gaps_at = "Condition")
```

### Color Scales and Breaks
`sechm` uses quantile capping to prevent outliers from dominating the color scale.
- **breaks**: Set to a value < 1 (e.g., 0.985) for quantile capping. Set to `1` for symmetric scales without capping.
- **hmcols**: Pass a vector of colors or set via options.

### Global Options and Metadata
You can store preferences directly in the SE object metadata or set them globally to ensure consistency across multiple plots.

```r
# Store colors in the object
metadata(SE)$anno_colors$Condition <- c(Control="white", Treated="black")

# Set global options
setSechmOption("hmcols", value = c("blue", "white", "red"))

# Reset options
resetAllSechmOptions()
```

## Cross-Dataset Comparisons

Use `crossHm()` to plot the same features across multiple `SummarizedExperiment` objects. It handles the alignment of features and annotations automatically.

```r
# List of SE objects
se_list <- list(Study1 = SE1, Study2 = SE2)

# Plot with separate scaling per dataset
crossHm(se_list, features = g, do.scale = TRUE)

# Force a unique color scale across all datasets
crossHm(se_list, features = g, do.scale = TRUE, uniqueScale = TRUE)
```

## Convenience Functions

- **log2FC()**: Adds assays for log2-fold changes and scaled LFC relative to a control group.
- **meltSE()**: Extracts assay data and metadata into a long-format `data.frame` suitable for `ggplot2`.
- **getDEGs()**: Retrieves differentially expressed genes if results are stored in `rowData` columns starting with `DEA.`.

```r
# Prepare data for ggplot2
df <- meltSE(SE, features = g, genes_label = "symbol")
```

## Reference documentation

- [sechm Vignette (Rmd)](./references/sechm.Rmd)
- [sechm Documentation (Markdown)](./references/sechm.md)