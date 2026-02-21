---
name: bioconductor-faahko
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/faahKO.html
---

# bioconductor-faahko

name: bioconductor-faahko
description: A data package providing LC/MS (Liquid Chromatography/Mass Spectrometry) data from FAAH knockout and wild-type mice. Use this skill to access sample NetCDF files and pre-processed xcmsSet or XCMSnExp objects for metabolomics data analysis workflows, particularly when demonstrating or testing the xcms package.

## Overview

The `faahKO` package is a Bioconductor experiment data package. It contains a subset of the Liquid Chromatography/Mass Spectrometry (LC/MS) data originally reported by Saghatelian et al. (2004). The data consists of spinal cord samples from 6 wild-type (WT) and 6 fatty acid amide hydrolase (FAAH) knockout (KO) mice.

The package is primarily used as a standard dataset for demonstrating metabolomics preprocessing steps such as peak detection, alignment, and correspondence using the `xcms` package.

## Loading Data and Locating Files

The package provides both raw data files (in NetCDF format) and pre-processed objects.

### Accessing Raw NetCDF Files
The raw files are stored in the `cdf` subdirectory of the package. Use `find.package` to locate them for use with `xcms` or `MSnbase`.

```r
# Locate the directory containing the .CDF files
cdfpath <- file.path(find.package("faahKO"), "cdf")

# List the files (organized into KO and WT subdirectories)
list.files(cdfpath, recursive = TRUE)
```

### Loading Pre-processed Objects
The package includes two main data objects representing the same experiment at different stages of the `xcms` evolution:

1.  **faahko**: An `xcmsSet` object (older `xcms` interface).
2.  **faahko3**: An `XCMSnExp` object (modern `xcms` interface).

```r
library(faahKO)

# Load the modern XCMSnExp object
data(faahko3)
show(faahko3)

# Load the legacy xcmsSet object
data(faahko)
show(faahko)
```

## Typical Workflows

### Using faahko3 (Modern xcms)
The `faahko3` object is an `XCMSnExp` object that has already undergone peak detection (centWave), alignment (peak groups), and correspondence (peak density).

```r
library(xcms)
data(faahko3)

# Check sample groups
phenoData(faahko3)

# Access identified features
featureDefinitions(faahko3)

# Extract ion chromatograms for a specific feature
# (Example: first feature)
chr <- chromatogram(faahko3, mz = c(200, 201), rt = c(2500, 4500))
plot(chr)
```

### Using Raw Files for New Analysis
To practice peak picking from scratch:

```r
library(xcms)
cdfpath <- file.path(find.package("faahKO"), "cdf")
files <- list.files(cdfpath, recursive = TRUE, full.names = TRUE)

# Create a phenodata data.frame
pd <- data.frame(sample_name = sub("(.*)\\..*", "\\1", basename(files)),
                 sample_group = c(rep("KO", 6), rep("WT", 6)),
                 stringsAsFactors = FALSE)

# Read raw data
raw_data <- readMSData(files, pdata = new("NAnnotatedDataFrame", pd), mode = "onDisk")
```

## Tips and Best Practices
- **Data Subset**: Remember that this is a subset (m/z 200-600, RT 2500-4500 seconds). Results obtained here are for demonstration and may not reflect the full biological complexity of the original study.
- **Object Versions**: Prefer `faahko3` for modern Bioconductor workflows. Use `faahko` only when working with legacy code that specifically requires the `xcmsSet` class.
- **Sample Metadata**: The samples are balanced (6 KO vs 6 WT), making this an ideal dataset for testing differential expression or statistical grouping methods in metabolomics.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)