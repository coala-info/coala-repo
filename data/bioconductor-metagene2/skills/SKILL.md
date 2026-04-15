---
name: bioconductor-metagene2
description: The metagene2 package produces metagene plots and heatmaps by aggregating genomic coverages from BAM files over multiple regions using bootstrap analysis. Use when user asks to create metagene plots, calculate mean enrichment estimations with confidence intervals, or visualize ChIP-seq and RNA-seq coverage profiles across genomic regions.
homepage: https://bioconductor.org/packages/release/bioc/html/metagene2.html
---

# bioconductor-metagene2

## Overview
The `metagene2` package is designed to produce metagene plots that aggregate coverages from multiple BAM files over multiple genomic regions. It uses bootstrap analysis to provide mean enrichment estimations and confidence intervals. It supports both ChIP-seq (contiguous regions) and RNA-seq (stitched exons) assays, and allows for complex experimental designs including control samples and metadata-based grouping.

## Core Workflow

### 1. Initialization
Create a `metagene2` object by providing BAM files and genomic regions.
```r
library(metagene2)

# Basic initialization
mg <- metagene2$new(regions = "path/to/regions.bed", 
                   bam_files = c("sample1.bam", "sample2.bam"),
                   assay = 'chipseq') # or 'rnaseq'
```

### 2. Specifying Regions
Regions can be provided as:
*   **File paths**: `.bed`, `.narrowPeak`, `.broadPeak`, or `.gtf`.
*   **GRanges/GRangesList**: Contiguous regions.
*   **Stitch Mode**: Use `region_mode = "stitch"` (default for `assay='rnaseq'`) to treat a `GRangesList` element as a single logical unit (e.g., exons in a transcript).

### 3. Experimental Design
Define how BAM files are grouped and normalized.
```r
# 0: ignore, 1: input, 2: control
design <- data.frame(Samples = c("s1.bam", "s2.bam", "ctrl.bam"),
                     group1 = c(1, 1, 2))

mg$produce_metagene(design = design, normalization = "RPM")
```
**Normalization options**: `NULL`, `"RPM"`, `"log2_ratio"`, or `"NCIS"`.

### 4. Plotting and Customization
The `produce_metagene` method wraps the entire pipeline, but parameters can be updated iteratively.
```r
mg$produce_metagene(
    bin_count = 100,
    alpha = 0.05,
    sample_count = 1000,
    title = "My Metagene Plot",
    facet_by = ~region_name,
    group_by = "design"
)
```

## Advanced Features

### Metadata Grouping
Attach metadata to regions or designs to enable complex faceting.
```r
# Region metadata
mg <- metagene2$new(regions = my_regions, 
                   region_metadata = my_metadata_df,
                   bam_files = my_bams)

# Split and plot by metadata columns
mg$produce_metagene(split_by = c("Condition"), facet_by = ~Condition)
```

### Heatmaps
Visualize individual region coverages instead of aggregates.
```r
metagene2_heatmap(mg)

# Reorder by signal in a specific group
metagene2_heatmap(mg, coverage_order(mg, "sample_name"))
```

### Intermediary Steps
For fine-grained control or debugging, call pipeline steps individually:
1.  `group_coverages()`: Apply design and normalization.
2.  `bin_coverages()`: Divide regions into bins.
3.  `split_coverages_by_regions()`: Group by metadata.
4.  `calculate_ci()`: Perform bootstrap resampling.
5.  `add_metadata()`: Merge design/region info.
6.  `plot()`: Generate ggplot2 object.

## Tips for Large Datasets
*   **Memory Management**: If memory is an issue, process datasets separately and merge results: `plot_metagene(rbind(mg1$add_metadata(), mg2$add_metadata()))`.
*   **Parallelization**: Use the `cores` argument in `metagene2$new` to speed up coverage calculations.
*   **Caching**: `metagene2` uses smart caching. Changing a downstream parameter (like `title`) will not trigger a recalculation of coverages or bootstrap values.

## Reference documentation
- [metagene2: a package to produce metagene plots](./references/metagene2.md)
- [Introduction to metagene2](./references/metagene2.Rmd)