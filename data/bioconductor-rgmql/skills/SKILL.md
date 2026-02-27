---
name: bioconductor-rgmql
description: RGMQL provides an R interface for the GenoMetric Query Language to perform scalable, declarative queries on large-scale genomic datasets and metadata. Use when user asks to perform integrative analysis of genomic regions, join datasets based on coordinates, filter samples by metadata, or execute high-level queries using Spark or Hadoop backends.
homepage: https://bioconductor.org/packages/3.8/bioc/html/RGMQL.html
---


# bioconductor-rgmql

## Overview
RGMQL brings the power of the GenoMetric Query Language (GMQL) to the R/Bioconductor environment. It allows for declarative, high-level querying of genomic regions and their associated metadata. The package uses a scalable data management engine (Spark/Hadoop) to handle thousands of samples efficiently. It is particularly useful for integrative analysis where you need to join or compare datasets based on genomic coordinates (e.g., finding mutations within specific exons) while filtering by clinical or experimental metadata.

## Core Workflow

### 1. Initialization
Every session must start by initializing the GMQL context.
```r
library(RGMQL)
# For local processing
init_gmql()

# For remote processing (requires a GMQL server URL)
init_gmql(url = "http://www.gmql.eu/gmql-rest/", remote_processing = TRUE)
```

### 2. Reading Data
RGMQL works with "datasets" (folders containing region files and metadata).
- **Local Folders:** `data <- read_gmql("/path/to/dataset_folder")`
- **Remote Datasets:** `data <- read_gmql("public.Dataset_Name", is_local = FALSE)`
- **R Objects:** `data <- read_GRangesList(my_grl)` (converts GRangesList to GMQL format)

### 3. Query Operations
Operations are lazy; they build a query graph but do not execute immediately.
- **filter:** Select samples based on metadata or regions.
  `mut = filter(dataset, dataType == 'dnaseq' & tissue == 'breast')`
- **map:** Align regions of one dataset (experiments) to another (references, like exons).
  `mapped = map(ref_exons, mut_samples)`
- **extend:** Aggregate region data into metadata (e.g., count regions).
  `res = extend(mapped, region_count = COUNT())`
- **arrange:** Sort samples based on metadata.
  `sorted = arrange(res, list(DESC("region_count")))`
- **union/merge/difference:** Standard set operations for genomic datasets.

### 4. Execution and Retrieval
To trigger the computation and get results:
- **Materialize:** Mark a dataset to be saved.
  `collect(dataset, "output_name")`
- **Execute:** Run the pending query.
  `execute()`
- **Take:** Execute and immediately return a `GRangesList` (useful for small subsets).
  `grl <- take(dataset, rows = 100)`

## Remote Processing Tips
- **Authentication:** Use `login_gmql(url)` to get an `authToken`.
- **Job Tracking:** Remote queries return a job object. Use `trace_job(url, job$id)` to check status.
- **Downloading:** Use `download_as_GRangesList(url, "dataset_name")` to bring remote results into your R session.

## Metadata Handling
GMQL metadata is semi-structured (attribute-value pairs).
- When importing to R via `import_gmql()`, metadata is stored in the `metadata()` slot of the `GRangesList`.
- If an attribute has multiple values (e.g., multiple diseases), access them using:
  `meta_list$sample_id[names(meta_list$sample_id) == "attribute_name"]`

## Reference documentation
- [RGMQL: GenoMetric Query Language for R/Bioconductor](./references/RGMQL-vignette.md)