---
name: bioconductor-affxparser
description: This tool parses Affymetrix microarray files including CEL, CDF, and CHP formats using the Fusion SDK. Use when user asks to read probe-level intensities, extract data by probeset units, manage chip definition files, or convert between Affymetrix file formats.
homepage: https://bioconductor.org/packages/release/bioc/html/affxparser.html
---

# bioconductor-affxparser

name: bioconductor-affxparser
description: Expert guidance for parsing Affymetrix microarray files (CDF, CEL, CHP, BPMAP, BAR) using the Fusion SDK. Use this skill when you need to read probe-level data, extract intensities by probeset (unit), manage chip definition files, or convert between Affymetrix file formats (ASCII, binary, Calvin).

# bioconductor-affxparser

## Overview
The `affxparser` package is a high-performance R interface to the Affymetrix Fusion SDK. It is designed for fast, memory-efficient parsing of microarray data files. Unlike higher-level packages that return complex objects, `affxparser` focuses on low-level data extraction into standard R list and matrix structures, making it ideal for custom preprocessing pipelines and large-scale data analysis.

## Core Workflows

### 1. Reading Probe Intensities (CEL Files)
To read raw intensity data from CEL files, use `readCel()` for single files or `readCelIntensities()` for multiple files.

```r
library(affxparser)

# Read specific probe indices from a CEL file
indices <- c(1, 10, 100)
data <- readCel("sample.CEL", indices = indices)
intensities <- data$intensities

# Read all intensities from multiple files into a matrix
files <- c("sample1.CEL", "sample2.CEL")
intensity_matrix <- readCelIntensities(files)
```

### 2. Unit-Based Extraction (CDF + CEL)
The most common workflow involves reading data organized by "units" (probesets) as defined in a CDF file.

```r
# 1. Find the CDF file for the chip type
cdf_file <- findCdf("HG-U133_Plus_2")

# 2. Read CEL data organized by units
# stratifyBy="pmmm" returns a matrix with PM in row 1 and MM in row 2
unit_data <- readCelUnits("sample.CEL", units = 1:100, stratifyBy = "pmmm", cdf = cdf_file)

# Accessing data for the first unit
first_unit_pm <- unit_data[[1]]$groups[[1]]$intensities[1, ]
```

### 3. Working with CDF Files
CDF files define the layout of the chip. You can read headers or specific unit structures.

```r
# Read CDF header to get chip dimensions
hdr <- readCdfHeader("chip.cdf")
# rows: hdr$rows, cols: hdr$cols

# Get unit names
unit_names <- readCdfUnitNames("chip.cdf", units = 1:10)

# Read full unit information (coordinates, bases, etc.)
units <- readCdfUnits("chip.cdf", units = 1:5)
```

### 4. File Format Conversion
`affxparser` can convert older ASCII or binary files into the modern XDA (binary) format for better performance.

```r
# Convert an ASCII CDF to Binary (v4)
convertCdf("input_ascii.cdf", "output_binary.cdf", version = "4")

# Convert a CEL file
convertCel("input.CEL", "output_v4.CEL", version = "4")
```

## Key Functions and Concepts

- **Cell Indices**: `affxparser` uses 1-based indexing for probes. The index $i$ for a probe at $(x, y)$ on a chip with $K$ columns is $i = K \times y + x + 1$.
- **Units and Groups**: A "Unit" is a probeset. A "Group" (or block) is a subset of probes within a unit (e.g., Allele A vs Allele B in SNP arrays).
- **Memory Efficiency**: Use the `indices` or `units` arguments to read only the data you need, rather than loading entire files.
- **findCdf()**: Searches for CDF files in the current directory and paths defined in the `AFFX_CDF_PATH` environment variable.

## Tips for Large Datasets
- **Pre-calculate Indices**: Use `readCdfCellIndices()` to get probe indices once, then pass them to `readCel()` across many files to avoid redundant CDF parsing.
- **Invert Maps**: For non-standard layouts (e.g., dChip rotated files), use `invertMap()` to handle cell-index remapping efficiently.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)