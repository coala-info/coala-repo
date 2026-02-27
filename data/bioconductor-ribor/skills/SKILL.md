---
name: bioconductor-ribor
description: The ribor package provides an R interface for the efficient storage, quantification, and visualization of ribosome profiling data in the .ribo file format. Use when user asks to analyze ribosome footprint length distributions, perform metagene analysis around start and stop codons, or quantify region-specific counts for translational efficiency studies.
homepage: https://bioconductor.org/packages/release/bioc/html/ribor.html
---


# bioconductor-ribor

## Overview
The `ribor` package is an R interface for the **.ribo** file format, a highly efficient HDF5-based storage system for ribosome profiling data. It allows for rapid quantification and visualization of Ribosome Protected Footprints (RPFs) across different transcript regions (UTR5, CDS, UTR3) and read lengths.

## Core Workflow

### 1. Initializing a Ribo Object
To interact with a `.ribo` file, you must first create a `Ribo` object. This object acts as a handle to the file.

```r
library(ribor)

# Define file path
file_path <- "path/to/your/data.ribo"

# Create object with default alias renaming (recommended for GENCODE)
ribo_obj <- Ribo(file_path, rename = rename_default)

# Inspect file attributes and experiment metadata
print(ribo_obj)
get_info(ribo_obj)
```

### 2. RPF Length Distribution
Analyze the quality of RNase digestion by plotting or retrieving the distribution of RPF lengths.

```r
# Plot fraction of reads per length in the CDS
plot_length_distribution(ribo_obj, region = "CDS", range.lower = 28, range.upper = 32, fraction = TRUE)

# Get raw counts as a DataFrame
dist_df <- get_length_distribution(ribo_obj, region = "CDS", range.lower = 28, range.upper = 32)
```

### 3. Metagene Analysis
Inspect ribosome occupancy around start and stop codons to check for periodicity and enrichment.

```r
# Plot metagene at start site for specific experiments
plot_metagene(ribo_obj, site = "start", range.lower = 28, range.upper = 32, normalize = TRUE)

# Get tidy metagene data
tidy_meta <- get_tidy_metagene(ribo_obj, site = "start", range.lower = 28, range.upper = 32)
```

### 4. Region Counts
Quantify reads mapping to UTR5, CDS, and UTR3. `ribor` uses "junction" regions (UTR5J and UTR3J) to isolate start/stop site peaks.

```r
# Visual comparison of region distributions
plot_region_counts(ribo_obj, range.lower = 28, range.upper = 32)

# Extract counts for downstream analysis (e.g., DESeq2)
# Set transcript = FALSE to get per-transcript counts
counts_df <- get_region_counts(ribo_obj, transcript = FALSE, alias = TRUE, compact = FALSE)
```

## Advanced Features

### Working with Aliases
GENCODE headers are often long. Use aliases to simplify transcript names in your data frames.
- Use `rename = rename_default` during `Ribo()` initialization.
- Use `alias = TRUE` in all `get_` functions.
- Custom renaming: `set_aliases(ribo_obj, custom_names_vector)`.

### Genomic Coordinates and Lengths
Retrieve the boundaries used for the internal region definitions (including junctions).
- `get_internal_region_coordinates(ribo_obj)`
- `get_internal_region_lengths(ribo_obj)`
- `get_original_region_lengths(ribo_obj)` (Standard UTR/CDS boundaries)

### Optional Data: Coverage and RNA-Seq
If the `.ribo` file contains optional datasets:
- **Coverage:** `get_coverage(ribo_obj, name = "Transcript-Alias")` returns nucleotide-level counts.
- **RNA-Seq:** `get_rnaseq(ribo_obj)` returns matched transcript abundance.

### Translational Efficiency (TE) Calculation
A common workflow involves calculating the ratio of RPF counts to RNA-Seq counts.

```r
# Get CDS counts for both
rpf <- get_region_counts(ribo_obj, region = "CDS", transcript = FALSE, compact = FALSE)
rna <- get_rnaseq(ribo_obj, region = "CDS", compact = FALSE)

# Merge and calculate TE
te_df <- merge(rpf, rna, by = c("experiment", "transcript"))
te_df$TE <- te_df$count.x / te_df$count.y
```

## Usage Tips
- **Memory Management:** By default, `get_` functions use `compact = TRUE` (returning S4 DataFrames with Rle encoding). For standard data frame manipulation with `dplyr` or `ggplot2`, set `compact = FALSE`.
- **Aggregation:** Use the `length` and `transcript` boolean parameters in `get_` functions to control whether data is summed across read lengths or transcripts.
- **Multiple Files:** Use the helper pattern `lapply(ribo_list, get_region_counts, ...)` to aggregate data from multiple `.ribo` files.

## Reference documentation
- [A Walk-through of RiboR](./references/ribor.md)