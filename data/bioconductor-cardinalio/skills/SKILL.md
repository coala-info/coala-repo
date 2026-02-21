---
name: bioconductor-cardinalio
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CardinalIO.html
---

# bioconductor-cardinalio

name: bioconductor-cardinalio
description: Comprehensive parsing and writing of imzML files for mass spectrometry imaging experiments. Use when Claude needs to import, export, or manipulate MS imaging data in the imzML format, including handling experimental metadata and binary spectral data (m/z and intensity arrays).

# bioconductor-cardinalio

## Overview

CardinalIO provides fast and efficient parsing and writing of imzML files, the open standard for mass spectrometry (MS) imaging data. It serves as the primary I/O engine for the Cardinal ecosystem. An imzML dataset consists of two files: an XML metadata file (.imzML) and a binary data file (.ibd). Both must be present for successful data import.

## Installation

Install the package using BiocManager:

```r
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("CardinalIO")
library(CardinalIO)
```

## Parsing imzML Files

Use `parseImzML()` to read datasets. By default, it parses metadata; set `ibd=TRUE` to attach spectral data without loading it into memory.

```r
# Parse metadata and attach binary data
p <- parseImzML("path/to/file.imzML", ibd=TRUE)

# Access experimental metadata (recursive list structure)
p$fileDescription
p$instrumentConfigurationList

# Access spectrum metadata (data frames)
p$run$spectrumList$positions
p$run$spectrumList$mzArrays
p$run$spectrumList$intensityArrays
```

## Accessing Mass Spectra

Spectral data is stored as out-of-memory lists using the `matter` package.

```r
# Access m/z and intensity lists
mz_list <- p$ibd$mz
int_list <- p$ibd$intensity

# Subset specific spectra (returns numeric vectors)
mz1 <- p$ibd$mz[[1]]
int1 <- p$ibd$intensity[[1]]

# Pull all data into memory (caution: memory intensive)
all_mz <- as.list(p$ibd$mz)
```

## Managing Metadata with ImzMeta

The `ImzMeta` class provides a simplified interface for creating or editing metadata using controlled vocabularies (CV).

```r
# Create new metadata
meta <- ImzMeta(spectrumType="MS1 spectrum",
                spectrumRepresentation="profile")

# Update fields (automatically matches CV terms)
meta$instrumentModel <- "LTQ FT Ultra"
meta$ionSource <- "electrospray ionization"

# Convert between ImzML and ImzMeta
meta_from_file <- as(p, "ImzMeta")
imzml_template <- as(meta, "ImzML")
```

## Writing imzML Files

Use `writeImzML()` to export datasets. You can write from an existing `ImzML` object or from scratch using `ImzMeta` with raw data.

### Writing from Metadata
```r
# Write only the .imzML file (metadata only)
writeImzML(p, file="output.imzML")
```

### Writing from Scratch
```r
# Required: positions (data.frame), mz (vector or list), intensity (matrix or list)
writeImzML(meta, 
           file="output.imzML", 
           positions=positions, 
           mz=mz_vector, 
           intensity=intensity_matrix)
```

## Key Considerations
- **Storage Types**: Supports both "continuous" (shared m/z axis) and "processed" (unique m/z per spectrum) imzML files.
- **Memory Efficiency**: Spectral data is handled out-of-core. Do not use `as.list()` on large datasets unless necessary.
- **Validation**: `ImzMeta` enforces valid CV terms. If an assignment fails, check the error message for a list of allowed values.

## Reference documentation
- [CardinalIO-guide](./references/CardinalIO-guide.md)