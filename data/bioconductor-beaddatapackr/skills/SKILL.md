---
name: bioconductor-beaddatapackr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/BeadDataPackR.html
---

# bioconductor-beaddatapackr

name: bioconductor-beaddatapackr
description: Compression and decompression of raw Illumina BeadArray data (.txt and .locs files). Use this skill when you need to reduce the storage footprint of Illumina bead-level data into .bab files, restore .bab files to their original formats, or extract specific bead data directly from compressed archives without full decompression.

# bioconductor-beaddatapackr

## Overview

BeadDataPackR provides specialized tools for the efficient, often lossless, compression of raw Illumina BeadArray data. While .tif images are handled by standard compression, this package targets the associated .txt (intensity/data) and .locs (bead location) files, which typically occupy significant space. It converts these into a single .bab (BeadArray Binary) file.

**Note:** This package does not currently support iScan data (which uses Swath1/Swath2 formats).

## Core Workflows

### 1. Compressing Raw Data
To compress a set of Illumina files into a .bab archive, use `compressBeadData()`.

```r
library(BeadDataPackR)

# Basic compression for single-channel data
compressBeadData(
  txtFile = "example.txt", 
  locsGrn = "example_Grn.locs",
  outputFile = "example.bab", 
  path = "path/to/data",
  nBytes = 4
)

# For two-channel data, include the red channel locs
compressBeadData(
  txtFile = "example.txt", 
  locsGrn = "example_Grn.locs",
  locsRed = "example_Red.locs",
  outputFile = "example_2ch.bab",
  nBytes = 8
)
```

**Key Parameters:**
- `nBytes`: Controls precision. Use 4 (single channel) or 8 (two channel) for maximum precision (single precision floating point). Smaller values store fractional parts with less precision to save more space.
- `nrow`/`ncol`: Dimensions of grid segments. Usually inferred automatically, but can be specified from the .sdf file (<SizeGridX> and <SizeGridY>) if automatic detection fails.

### 2. Decompressing Data
To restore the original .txt and .locs files from a .bab file:

```r
decompressBeadData(
  inputFile = "example.bab", 
  inputPath = "path/to/bab",
  outputMask = "restored_name",
  outputPath = "path/to/output",
  outputNonDecoded = FALSE, 
  roundValues = TRUE
)
```

**Key Parameters:**
- `outputMask`: Prefix for the restored files (e.g., "restored_name.txt").
- `outputNonDecoded`: If TRUE, includes beads in the .txt file that failed the decoding process (these are in .locs but usually absent from Illumina .txt files).
- `roundValues`: If TRUE, mimics Illumina's 7-significant-figure rounding. If FALSE, outputs full precision.

### 3. Direct Data Extraction
You can read data into R memory without writing files to disk. This is often used by the `beadarray` package.

**Extract Intensity/Probe Data:**
```r
# Extract specific probes by ID
data_matrix <- readCompressedData(
  inputFile = "example.bab", 
  path = "path/to/bab",
  probeIDs = c(10008, 10010)
)

# Extract all data (including non-decoded beads)
all_data <- readCompressedData(inputFile = "example.bab")
```

**Extract Bead Coordinates:**
```r
# Returns bead center coordinates in .locs file order
locs_coords <- extractLocsFile(inputFile = "example.bab")
```

## Tips and Best Practices
- **Lossless Settings:** To ensure data is restored exactly as it was, use `nBytes = 4` (or 8) and `roundValues = TRUE`.
- **Integration:** If using the `beadarray` package (version 2.1.11+), it can read .bab files directly for analysis, saving the step of manual decompression.
- **File Locations:** The package functions rely heavily on the `path` and `inputPath` arguments; ensure these point to the directory containing the files, not the files themselves.

## Reference documentation
- [BeadDataPackR](./references/BeadDataPackR.md)