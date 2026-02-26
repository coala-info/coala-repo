---
name: bioconductor-affyio
description: This package provides high-performance routines for parsing Affymetrix CEL and CDF data files using C-based infrastructure. Use when user asks to read probe intensities into matrices, extract file headers, check CDF file formats, or parse microarray metadata.
homepage: https://bioconductor.org/packages/release/bioc/html/affyio.html
---


# bioconductor-affyio

name: bioconductor-affyio
description: Expert assistance for the Bioconductor R package 'affyio'. Use this skill when you need to parse Affymetrix data files, specifically CEL and CDF formats. It is ideal for low-level data access, extracting probe intensities into matrices, reading file headers, and identifying CDF file types (text vs. binary/XDA).

# bioconductor-affyio

## Overview
The `affyio` package provides high-performance C-based routines for parsing Affymetrix microarrays. While it serves as the infrastructure for the more user-friendly `affy` package, it is used directly when memory efficiency or specific low-level access to CEL (intensity) and CDF (chip definition) files is required.

## Core Workflows

### Reading CEL Files
To read the entire contents of a CEL file into an R list:
```r
library(affyio)

# Read full CEL file
cel_data <- read.celfile("sample.CEL")

# Read only the mean intensity section to save memory
cel_means <- read.celfile("sample.CEL", intensity.means.only = TRUE)
```
The resulting list contains `HEADER`, `INTENSITY` (MEAN, STDEV, NPIXELS), `MASKS`, and `OUTLIERS`.

### Extracting Probe Intensities
To read intensities from multiple CEL files directly into matrices (useful for downstream normalization):
```r
# Requires a cdfInfo list (typically from make.cdf.package or similar)
pm_mm_list <- read.celfile.probeintensity.matrices(
  filenames = c("file1.CEL", "file2.CEL"),
  cdfInfo = my_cdf_info,
  which = "pm" # Options: "pm", "mm", "both"
)
```

### Handling CDF Files
Before parsing a CDF, you can check its format:
```r
# Returns "text", "xda" (binary), or "unknown"
format_type <- check.cdf.type("chip_definition.cdf")

# Read CDF into a list structure
cdf_list <- read.cdffile.list("chip_definition.cdf")
```

### Metadata and Headers
To extract specific metadata without loading the full intensity data:
```r
# Get basic dimensions and CDF name
header_basic <- read.celfile.header("sample.CEL", info = "basic")

# Get full header details
header_full <- read.celfile.header("sample.CEL", info = "full")

# Extract scan dates from a vector of CEL files
dates <- get.celfile.dates(c("file1.CEL", "file2.CEL"))
```

## Tips and Best Practices
- **Memory Management**: `read.cdffile.list` and `read.celfile` can be extremely memory-intensive for large chips (e.g., Human Exon or SNP arrays). Use `intensity.means.only = TRUE` or `read.celfile.header` whenever possible.
- **Internal Functions**: Functions like `read_abatch` or `Read.CYCHP` are intended for internal use by the `affy` package and should generally not be called directly unless you are developing infrastructure.
- **File Paths**: Ensure full paths are provided if the files are not in the current working directory.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)