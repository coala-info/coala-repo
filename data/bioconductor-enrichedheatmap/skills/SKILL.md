---
name: bioconductor-enrichedheatmap
description: This tool creates enriched heatmaps in R to visualize genomic signal enrichment patterns over specific target regions. Use when user asks to normalize genomic signals into matrices, visualize enrichment patterns with line plots, or concatenate multiple heatmaps to show associations between different epigenomic data sources.
homepage: https://bioconductor.org/packages/release/bioc/html/EnrichedHeatmap.html
---

# bioconductor-enrichedheatmap

name: bioconductor-enrichedheatmap
description: Specialized for creating enriched heatmaps in R to visualize genomic signal enrichment (e.g., ChIP-seq, methylation) over target regions (e.g., TSS, CpG islands). Use this skill when you need to normalize genomic data into matrices, visualize enrichment patterns with line plots, and concatenate multiple heatmaps to show associations between different epigenomic data sources.

## Overview
The `EnrichedHeatmap` package extends `ComplexHeatmap` to visualize genomic signals relative to specific target regions. It follows a two-step workflow: first, normalizing genomic signals into a `normalizedMatrix` based on distance to targets, and second, visualizing that matrix with specialized annotations (like `anno_enriched`) that summarize enrichment patterns.

## Core Workflow

### 1. Data Preparation
Load the library and prepare your genomic coordinates as `GRanges` objects.
```r
library(EnrichedHeatmap)
library(GenomicRanges)

# Example: Targets (TSS) and Signals (H3K4me3)
tss = promoters(genes, upstream = 0, downstream = 1)
```

### 2. Normalize to Matrix
Use `normalizeToMatrix()` to transform genomic signals into a heatmap-ready format.
```r
mat = normalizeToMatrix(signal, target, 
                        value_column = "coverage", # Column in signal GRanges
                        extend = 5000,             # Upstream/downstream extension
                        w = 50,                    # Window size
                        mean_mode = "w0",          # Averaging method
                        smooth = TRUE)             # Impute NAs/smooth rows
```
**Mean Modes:**
- `w0`: Weighted mean of intersected and un-intersected parts (standard for ChIP-seq coverage).
- `absolute`: Mean of signal regions regardless of width (good for methylation).
- `weighted`: Mean weighted by intersection width.
- `coverage`: Mean signal averaged by window length.

### 3. Create the Heatmap
Use `EnrichedHeatmap()` to plot. It accepts all arguments from `ComplexHeatmap::Heatmap()`.
```r
EnrichedHeatmap(mat, 
                col = c("white", "red"), 
                name = "Signal",
                column_title = "Enrichment at TSS")
```

## Advanced Features

### Customizing Enrichment Annotations
The top annotation (line plot) is controlled via `anno_enriched()`.
```r
EnrichedHeatmap(mat, 
    top_annotation = HeatmapAnnotation(
        enriched = anno_enriched(gp = gpar(col = "blue", lty = 1))
    ))
```

### Concatenating Multiple Data Sources
You can use the `+` operator to combine enriched heatmaps with standard heatmaps (e.g., gene expression).
```r
ht_list = EnrichedHeatmap(mat_chip, name = "ChIP") + 
          EnrichedHeatmap(mat_meth, name = "Meth") + 
          Heatmap(log2_rpkm, name = "Expression", width = unit(10, "mm"))

draw(ht_list, main_heatmap = "ChIP")
```

### Handling Outliers and Colors
Genomic data often has extreme values. Use `keep` in normalization or `colorRamp2` for robust mapping.
```r
# Method 1: Trim during normalization
mat = normalizeToMatrix(..., keep = c(0, 0.99))

# Method 2: Robust color mapping
library(circlize)
col_fun = colorRamp2(quantile(mat, c(0, 0.99)), c("white", "red"))
EnrichedHeatmap(mat, col = col_fun)
```

### Mapping Signals to Specific Targets
If signals should only be associated with specific targets (e.g., a peak only associated with its nearest gene), use `mapping_column`.
```r
mat = normalizeToMatrix(signal, target, mapping_column = "gene_id")
```

## Tips for Success
- **Smoothing:** Set `smooth = TRUE` for sparse data like methylation to impute windows without CpG sites.
- **Target Regions:** If targets are regions (not points), use `target_ratio` to control the width of the target body in the heatmap.
- **Row Ordering:** By default, rows are ordered by enrichment. Use `row_km` or `row_split` to group patterns.
- **Rasterization:** For large datasets (thousands of genes), use `use_raster = TRUE` to improve performance and reduce file size.

## Reference documentation
- [The EnrichedHeatmap package](./references/EnrichedHeatmap.md)
- [Make Enriched Heatmaps](./references/EnrichedHeatmap.Rmd)
- [Introduction to EnrichedHeatmap](./references/EnrichedHeatmap_intro.Rmd)
- [Visualize Comprehensive Associations in Roadmap dataset](./references/roadmap.md)
- [Roadmap Analysis Workflow](./references/roadmap.Rmd)
- [Row Ordering Methods](./references/row_ordering.md)
- [Row Ordering Comparison](./references/row_ordering.Rmd)
- [Visualizing Categorical Signals](./references/visualize_categorical_signals.Rmd)
- [Categorical Signal Wrapper](./references/visualize_categorical_signals_wrapper.md)