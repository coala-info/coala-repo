---
name: bioconductor-profileplyr
description: This tool visualizes and annotates sequencing read signals over genomic ranges. Use when user asks to import deepTools matrices or BAM/BigWig files, annotate genomic ranges to genes, cluster regions, group data by gene lists, or generate heatmaps and profile plots.
homepage: https://bioconductor.org/packages/release/bioc/html/profileplyr.html
---

# bioconductor-profileplyr

name: bioconductor-profileplyr
description: Visualization and annotation of read signal (ChIP-seq, ATAC-seq, etc.) over genomic ranges. Use this skill when you need to import deepTools matrices, BAM, or BigWig files into R to cluster genomic regions, annotate them to genes (via ChIPseeker or GREAT), group them by gene lists or genomic overlaps, and generate high-quality heatmaps or profile plots.

# bioconductor-profileplyr

## Overview

The `profileplyr` package serves as a bridge between raw sequencing data (BAM/BigWig) or deepTools outputs and Bioconductor's powerful visualization tools like `EnrichedHeatmap` and `ComplexHeatmap`. It uses a `SummarizedExperiment`-based object to store read signals over genomic intervals, allowing for flexible manipulation, subsetting, and grouping of genomic data based on biological metadata or gene associations.

## Core Workflows

### 1. Data Import

You can start with deepTools matrices or raw signal files.

```r
library(profileplyr)

# Import from deepTools computeMatrix output
object <- import_deepToolsMat("path/to/matrix.gz")

# Import from BAM/BigWig files directly
# style can be "percentOfRegion" or "point"
object <- BamBigwig_to_chipProfile(
  signalFiles = c("sample1.bw", "sample2.bw"),
  testRanges = "peaks.bed",
  format = "bigwig",
  style = "point",
  distanceAround = 1000
)

# Convert soGGi objects
# object <- as_profileplyr(soggi_obj)
```

### 2. Annotation and Grouping

Annotate ranges to the nearest genes or specific genomic features.

```r
# Annotate using ChIPseeker (supports hg19, hg38, mm9, mm10)
object <- annotateRanges(object, TxDb = "mm10", tssRegion = c(-3000, 3000))

# Annotate using GREAT
object <- annotateRanges_great(object, species = "mm10")

# Group ranges by overlap with other GRanges
data("K27ac_GRlist_hind_liver_top5000")
object <- groupBy(object, group = K27ac_GRlist_hind_liver_top5000, GRanges_names = c("Hindbrain", "Liver"))

# Group by gene lists (requires prior annotation)
gene_list <- list(GroupA = c("Gene1", "Gene2"), GroupB = c("Gene3", "Gene4"))
object <- groupBy(object, group = gene_list)
```

### 3. Clustering and Ordering

```r
# K-means clustering (e.g., 3 clusters)
object <- clusterRanges(object, fun = rowMeans, kmeans_k = 3)

# Hierarchical clustering
object <- clusterRanges(object, fun = rowMeans, cutree_rows = 3)

# Order rows by a specific metadata column
object <- orderBy(object, column = "hierarchical_order")
```

### 4. Visualization

`profileplyr` provides wrappers for `EnrichedHeatmap` and `ggplot2`.

```r
# Generate a complex heatmap
generateEnrichedHeatmap(object, include_group_annotation = TRUE)

# Label specific genes on the heatmap
generateEnrichedHeatmap(object, genes_to_label = c("Sox2", "Pax6"))

# Generate an average profile plot (metagene plot)
generateProfilePlot(object)
```

### 5. Data Export and Summarization

```r
# Export back to deepTools format
export_deepToolsMat(object, con = "output_matrix.MAT")

# Summarize signal per range (e.g., for boxplots)
long_df <- summarize(object, fun = rowMeans, output = "long")
```

## Key Functions and Parameters

- `sampleData(object)`: Access or modify sample metadata (similar to `colData`).
- `params(object)`: View internal parameters like `rowGroupsInUse` or `mcolToOrderBy`.
- `subsetbyRangeOverlap()` / `subsetbyGeneListOverlap()`: Specific subsetting utilities.
- `summarize()`: Collapses the bin-level signal into a single value per range/sample.

## Reference documentation

- [profileplyr Reference Manual](./references/reference_manual.md)