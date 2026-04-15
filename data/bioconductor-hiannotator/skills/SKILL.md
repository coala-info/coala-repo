---
name: bioconductor-hiannotator
description: bioconductor-hiannotator provides a framework for annotating genomic intervals by relating them to features like genes, CpG islands, or regulatory elements. Use when user asks to annotate genomic coordinates, find the nearest genomic feature, or count feature density within specific window sizes.
homepage: https://bioconductor.org/packages/release/bioc/html/hiAnnotator.html
---

# bioconductor-hiannotator

## Overview
The `hiAnnotator` package provides a framework for annotating genomic intervals (query) with respect to other genomic features (subject). It is particularly useful for high-throughput sequencing analysis where one needs to relate specific sites (like viral integration sites or SNPs) to genomic annotations like genes, CpG islands, or regulatory elements.

## Core Workflow

### 1. Data Preparation
The package works primarily with `GRanges` objects. It includes a helper function to convert data frames with genomic coordinates into `GRanges` objects automatically.

```r
library(hiAnnotator)

# Convert data frame to GRanges
# It automatically looks for columns like 'chr', 'start', 'stop', 'strand'
query_gr <- makeGRanges(my_data_frame, freeze = "hg19")
```

### 2. Annotation Functions
There are three primary types of annotation logic:

#### A. Within Features (`getAnnotationThreeWay`)
Determines if a query position falls within a feature, or is upstream/downstream.
```r
# Returns the feature name and the relative position (Inside, Upstream, Downstream)
annotated <- getAnnotationThreeWay(query_gr, subject_gr, "geneName")
```

#### B. Nearest Features (`getNearestFeature`)
Finds the closest feature to each query point and calculates the distance.
```r
# Finds the nearest feature and distance
# side = "both" (default), "fivePrime", or "threePrime"
nearest <- getNearestFeature(query_gr, subject_gr, colName = "nearestGene")
```

#### C. Feature Density/Counting (`getFeatureCounts`)
Counts how many features fall within specific window sizes around the query points.
```r
# Count features in 1kb and 10kb windows
counts <- getFeatureCounts(query_gr, subject_gr, windowSize = c(1000, 10000))
```

### 3. Parallel Processing
All main functions support a `parallel` argument. You must register a parallel backend (via `foreach` and `doParallel`) before use.

```r
library(doParallel)
registerDoParallel(cores = 4)

annotated <- getAnnotationThreeWay(query_gr, subject_gr, "geneName", parallel = TRUE)
```

## Key Functions Reference
- `makeGRanges(x, ...)`: Wrapper to create GRanges from data frames.
- `getAnnotationThreeWay(query, subject, colName)`: Basic "is it inside" check.
- `getNearestFeature(query, subject, colName, side)`: Distance-based annotation.
- `getFeatureCounts(query, subject, windowSize)`: Density-based annotation.
- `getSitesInFeature(query, subject, ...)`: Find all query sites falling within a specific subject feature.

## Tips for Success
- **Column Names**: When using `makeGRanges`, ensure your data frame has standard coordinate columns or specify them using `chromCol`, `startCol`, and `endCol`.
- **Memory**: For very large datasets, ensure the `subject` GRanges is simplified (e.g., merging overlapping features) if only presence/absence is needed.
- **Strand Awareness**: Pay attention to the `side` parameter in `getNearestFeature` if biological orientation (5' or 3' end) is relevant to your analysis.

## Reference documentation
- [hiAnnotator Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/hiAnnotator.html)