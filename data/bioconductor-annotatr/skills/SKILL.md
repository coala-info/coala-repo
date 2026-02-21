---
name: bioconductor-annotatr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/annotatr.html
---

# bioconductor-annotatr

name: bioconductor-annotatr
description: Genomic region annotation and visualization using the Bioconductor package annotatr. Use this skill to intersect genomic regions (BED files, GRanges) with genomic features like CpG islands, promoters, exons, enhancers, and chromatin states. It supports summarizing and plotting numerical or categorical data across these annotations.

# bioconductor-annotatr

## Overview
The `annotatr` package is designed to provide context to genomic regions (e.g., ChIP-seq peaks, differentially methylated regions, SNPs) by intersecting them with known genomic annotations. It facilitates a workflow of reading regions, selecting/building annotations, intersecting them, and generating summaries or visualizations to understand the distribution of data across the genome.

## Core Workflow

### 1. Reading Genomic Regions
Use `read_regions()` to import BED files into `GRanges` objects. You can include extra metadata columns (e.g., p-values, fold-change).

```r
library(annotatr)

# Define extra columns if present in the BED file
extraCols = c(diff_meth = 'numeric', pval = 'numeric')
regions = read_regions(con = 'path/to/file.bed', genome = 'hg19', extraCols = extraCols, format = 'bed', rename_score = 'pval')
```

### 2. Selecting and Building Annotations
Annotations must be built before use. You can use built-in shortcuts or custom sources.

*   **Built-in Shortcuts:** `hg19_cpgs`, `hg19_basicgenes`, `hg19_genes_intergenic`, `hg19_enhancers_fantom5`.
*   **Custom Annotations:** Use `read_annotations()` for custom BED files.
*   **AnnotationHub:** Use `build_ah_annots()` for Bioconductor resources.

```r
# Select desired annotation codes
annots = c('hg19_cpgs', 'hg19_basicgenes')

# Build the annotation object
annotations = build_annotations(genome = 'hg19', annotations = annots)
```

### 3. Annotating Regions
Intersect your data regions with the built annotations.

```r
annotated_data = annotate_regions(
    regions = regions,
    annotations = annotations,
    ignore.strand = TRUE)

# Convert to data.frame for standard R manipulation
df_annotated = data.frame(annotated_data)
```

### 4. Summarization
Summarize the distribution of regions or associated data across annotation types.

```r
# Count regions per annotation
annsum = summarize_annotations(annotated_regions = annotated_data)

# Summarize numerical data (e.g., mean methylation per annotation)
numsum = summarize_numerical(annotated_regions = annotated_data, by = c('annot.type'), over = c('diff_meth'))

# Summarize categorical data
catsum = summarize_categorical(annotated_regions = annotated_data, by = c('annot.type', 'DM_status'))
```

### 5. Visualization
All plotting functions return `ggplot2` objects.

*   `plot_annotation()`: Bar plot of region counts per annotation.
*   `plot_coannotations()`: Heatmap showing regions occurring in pairs of annotations.
*   `plot_numerical()`: Histograms or scatter plots of numerical data faceted by annotation.
*   `plot_categorical()`: Stacked or filled bar plots of categorical data across annotations.

```r
# Example: Plotting counts
plot_annotation(annotated_regions = annotated_data, plot_title = 'Region Distribution')
```

## Advanced Features

### Randomization
To determine if an overlap is significant, compare your results against randomized regions using `randomize_regions()`. This is a wrapper for `regioneR`.

```r
random_regions = randomize_regions(regions = regions, genome = 'hg19')
annotated_random = annotate_regions(regions = random_regions, annotations = annotations)

# Plot data vs random
plot_annotation(annotated_regions = annotated_data, annotated_random = annotated_random)
```

### Annotation Cache
Use `annotatr_cache$list_env()` to see currently loaded annotations and `annotatr_cache$get()` to retrieve specific ones.

## Reference documentation
- [annotatr: Making sense of genomic regions](./references/annotatr-vignette.md)