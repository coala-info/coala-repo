---
name: bioconductor-deepbluer
description: DeepBlueR provides an R interface to the DeepBlue Epigenomics Data Server for querying and processing large-scale epigenomic datasets. Use when user asks to search for epigenomic experiments, select genomic regions by metadata, perform server-side genomic operations like intersections or aggregations, and download processed results as GRanges objects.
homepage: https://bioconductor.org/packages/3.6/bioc/html/DeepBlueR.html
---


# bioconductor-deepbluer

## Overview

DeepBlueR provides an R interface to the DeepBlue Epigenomics Data Server. It allows users to query a vast repository of epigenomic data (histone marks, DNA methylation, etc.) without downloading entire files. The package uses a "request-based" system: you define a query (selection and operations), submit it to the server, wait for processing, and then download the specific results as a `GRanges` object.

## Core Workflow

### 1. Authentication and Setup
Most public data can be accessed using the "anonymous_key".
```r
library(DeepBlueR)
# Set default user key if not using anonymous
# deepblue_options(user_key = "your_key")
```

### 2. Data Discovery
Search for experiments or list available metadata terms to find data of interest.
```r
# List all genomes
genomes <- deepblue_list_genomes()

# Search for specific experiments
experiments <- deepblue_search(keyword = "DNA Methylation BLUEPRINT", type = "experiments")

# List terms in use for a specific category
marks <- deepblue_list_in_use(controlled_vocabulary = "epigenetic_marks")
```

### 3. Selecting Regions
Selection functions return a `query_id`. No data is downloaded yet.
```r
# Select by experiment name
query_id <- deepblue_select_experiments(
  experiment_name = "E002-H3K9ac.narrowPeak.bed",
  chromosome = "chr1"
)

# Select by metadata criteria
query_id2 <- deepblue_select_regions(
  genome = "hg19",
  epigenetic_mark = "H3K27ac",
  project = "BLUEPRINT Epigenome"
)

# Select annotations (e.g., CpG Islands)
cpg_id <- deepblue_select_annotations(annotation_name = "CpG Islands", genome = "hg19")
```

### 4. Genomic Operations
Perform server-side operations on the `query_id`.
```r
# Intersection
intersect_id <- deepblue_intersection(query_data_id = query_id, query_filter_id = cpg_id)

# Flanking and Extending
flank_id <- deepblue_flank(query_id = cpg_id, start = 0, length = 2000)

# Aggregation (summarize signal data over regions)
agg_id <- deepblue_aggregate(data_id = query_id, ranges_id = cpg_id, column = "SCORE")
```

### 5. Requesting and Downloading Data
Convert a `query_id` into a `request_id`, wait for the server, and download.
```r
# 1. Request regions with specific output format
request_id <- deepblue_get_regions(
  query_id = intersect_id,
  output_format = "CHROMOSOME,START,END,STRAND"
)

# 2. Wait and Download (returns GRanges)
regions <- deepblue_download_request_data(request_id)
```

## Key Functions and Tips

- **Metadata Info**: Use `deepblue_info(id)` to get detailed metadata for any ID (experiment, sample, or request).
- **Batch Export**: Use `deepblue_batch_export_results(list_of_requests)` to save multiple results to disk as they finish.
- **Score Matrices**: `deepblue_score_matrix` is powerful for creating a matrix of signal values across multiple experiments for a set of genomic bins (tiles).
- **Tiling**: Use `deepblue_tiling_regions` to create a genome-wide grid for aggregation.
- **Caching**: DeepBlueR caches results locally. Use `deepblue_clear_cache()` if you encounter issues or need to free space.
- **Liftover**: `deepblue_liftover(regions, source, target)` provides a convenient wrapper for assembly conversion.

## Reference documentation
- [DeepBlueR Reference Manual](./references/reference_manual.md)