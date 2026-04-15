---
name: bioconductor-macsdata
description: This package provides access to test datasets from the MACS3 project via Bioconductor's ExperimentHub for ChIP-seq analysis. Use when user asks to access sample ChIP-seq data, retrieve test datasets for MACSr or MACS3, or demonstrate peak-calling workflows in R.
homepage: https://bioconductor.org/packages/release/data/experiment/html/MACSdata.html
---

# bioconductor-macsdata

name: bioconductor-macsdata
description: Accessing and using test datasets for ChIP-seq analysis from the MACSdata package. Use when the user needs sample data for MACSr, MACS3 testing, or ChIP-seq workflow demonstrations in R.

# bioconductor-macsdata

## Overview
The `MACSdata` package provides a collection of 9 test datasets sourced from the MACS3 project. These datasets are hosted on Bioconductor's `ExperimentHub` and are primarily intended for use in examples, unit tests, and vignettes for the `MACSr` package. It serves as a reliable source of small-scale ChIP-seq data for demonstrating peak-calling workflows.

## Loading Data
Since the data is stored in `ExperimentHub`, you must use the `ExperimentHub` interface to search for and download the specific files.

```r
library(ExperimentHub)
library(MACSdata)

# Initialize ExperimentHub
eh <- ExperimentHub()

# Query for MACSdata entries
macs_query <- query(eh, "MACSdata")
print(macs_query)

# Retrieve a specific dataset by its EH ID (e.g., EH3467)
# Note: Actual IDs should be checked via the query results
data_file <- eh[["EH3467"]]
```

## Typical Workflow
1. **Identify Data**: Use `query(eh, "MACSdata")` to see the list of available files (e.g., BED files, BAM files, or peak files).
2. **Download/Cache**: Access the data using the `[[` operator with the ExperimentHub ID. This downloads the file to a local cache.
3. **Use with MACSr**: Pass the local file path obtained from ExperimentHub directly into `MACSr` functions.

```r
library(MACSr)

# Example: Using a downloaded file path in a MACSr call
# macsr_result <- callpeak(tfile = data_file, gsize = "hs", name = "test_run")
```

## Tips
- **Caching**: ExperimentHub caches files locally after the first download. Subsequent calls will be much faster.
- **Metadata**: Use `mcols(macs_query)` to view detailed metadata about the available test sets, including species and file formats.
- **MACS3 Compatibility**: These datasets are identical to those used in the original MACS3 Python test suite, ensuring consistency across implementations.

## Reference documentation
- [MACSdata Reference Manual](./references/reference_manual.md)