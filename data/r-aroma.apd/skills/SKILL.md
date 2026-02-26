---
name: r-aroma.apd
description: The aroma.apd package provides tools for managing Affymetrix Probe-Level Data (APD) files, including high-performance reading and writing of probe intensities. Use when user asks to convert CEL files to APD format, read probe-level data by units or spatial rectangles, or update APD files within legacy aroma projects.
homepage: https://cran.r-project.org/web/packages/aroma.apd/index.html
---


# r-aroma.apd

name: r-aroma.apd
description: Expert guidance for the 'aroma.apd' R package. Use this skill when working with the Affymetrix Probe-Level Data (APD) file format, converting CEL files to APD, or reading/updating probe-level data within the aroma.affymetrix framework. Note: This package is deprecated and should primarily be used for maintaining legacy aroma projects.

## Overview

The `aroma.apd` package provides a specialized binary file format (APD) for storing and accessing Affymetrix probe-level data. It is designed for high-performance access, allowing data to be read by units (probesets) or spatial rectangles. The format is optimized for the `aroma.affymetrix` framework by allowing probe elements to be arranged for sequential reading, significantly increasing speed compared to standard CEL file access.

**Warning:** This package is deprecated. Do not start new projects using the APD format unless required for compatibility with existing `aroma` workflows.

## Installation

```r
install.packages("aroma.apd")
```

## Core Workflows

### 1. Converting CEL to APD
The most common entry point is converting standard Affymetrix CEL files into the optimized APD format.

```r
library(aroma.apd)
library(affxparser)

# Basic conversion
celFile <- "sample.CEL"
apdFile <- celToApd(celFile)

# Optimized conversion using a CDF-based read map
cdfFile <- "chipType.cdf"
map <- cdfToApdMap(cdfFile)
apdFileOpt <- celToApd(celFile, mapType = map$mapType)
```

### 2. Reading APD Data
Data can be retrieved by probe indices, spatial coordinates, or probeset units.

```r
# Read specific probe indices
data <- readApd("sample.apd", indices = 1:1000)

# Read a spatial rectangle (x, y coordinates)
rectData <- readApdRectangle("sample.apd", xrange = c(0, 200), yrange = c(0, 200))

# Read by Units (requires CDF)
# This is the preferred method for aroma.affymetrix workflows
unitData <- readApdUnits("sample.apd", units = 1:10, cdf = "chipType.cdf")
```

### 3. Creating and Updating APD Files
You can create empty APD structures and populate them manually.

```r
# Create an APD file
createApd("new_data.apd", nbrOfCells = 1000000, chipType = "Mapping50K_Hind240")

# Update specific indices
updateApd("new_data.apd", indices = c(1, 5, 10), data = c(1.2, 4.5, 3.2))

# Update by units
# 'data' must be a list structure matching the unit/group layout of the CDF
updateApdUnits("new_data.apd", units = 1:5, data = myUnitList, cdf = "chipType.cdf")
```

## Key Functions

| Function | Description |
| :--- | :--- |
| `celToApd()` | Converts a CEL file to an APD file. |
| `readApd()` | Reads probe intensities from an APD file. |
| `readApdUnits()` | Reads data organized by units/probesets (requires CDF). |
| `readApdRectangle()` | Reads a spatial subset of the chip. |
| `cdfToApdMap()` | Generates a read map from a CDF to optimize access speed. |
| `createApd()` | Initializes a new APD file structure. |
| `updateApd()` | Writes/updates data at specific probe indices. |

## Performance Tips

1. **Use Read Maps:** Always use `cdfToApdMap()` and provide the `mapType` during conversion. This ensures that probes belonging to the same unit are stored contiguously on disk, reducing disk seek time.
2. **Avoid Frequent Small Reads:** Reading large contiguous blocks is significantly faster than many small, scattered reads.
3. **Memory Efficiency:** APD files are stored on disk; `readApd` only loads the requested indices into memory, making it suitable for very large datasets that exceed RAM.

## Reference documentation

- [Package Manual](./references/reference_manual.md)