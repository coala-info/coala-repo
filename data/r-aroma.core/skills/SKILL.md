---
name: r-aroma.core
description: aroma.core provides the foundational classes and methods for the Aroma Project framework to analyze extremely large microarray data sets using a file-system-based approach. Use when user asks to manage large-scale genomic data, locate data sets by name, or implement memory-efficient workflows for Affymetrix, SNP, and exon arrays.
homepage: https://cran.r-project.org/web/packages/aroma.core/index.html
---


# r-aroma.core

## Overview
`aroma.core` provides the foundational classes and methods for the Aroma Project, an open-source R framework designed for analyzing extremely large microarray data sets (e.g., Affymetrix, SNP, exon, and tiling arrays). It implements a file-system-based approach to data management, allowing for "unlimited" data sizes by keeping data on disk and only loading what is needed into RAM.

## Installation
```r
install.packages("aroma.core")
# It is often used alongside aroma.affymetrix
install.packages("aroma.affymetrix")
```

## Core Concepts and Workflows

### 1. File-Based Data Sets
The framework relies on a specific directory structure. Data is organized into "data sets" and "chip types."
- **Data Set:** A collection of files (e.g., CEL files) of the same chip type.
- **Chip Type:** Defines the layout of the array (e.g., CDF files).

### 2. Locating Data
Aroma uses a "search by name" mechanism rather than hardcoded paths.
```r
library(aroma.core)

# Define a chip type
ct <- ChipTypeAnnotationFile$byName("Mapping250K_Nsp")

# Define a data set
ds <- GenericDataFileSet$byName("MyExperiment", chipType="Mapping250K_Nsp")
```

### 3. Key Classes
- `AffymetrixCelSet`: Represents a set of Affymetrix CEL files.
- `AffymetrixCdfFile`: Represents an Affymetrix CDF chip definition file.
- `AromaUnitTotalCnBinarySet`: Used for storing and accessing copy number data.
- `ChromosomeExplorer`: A class for generating interactive HTML reports for copy number results.

### 4. Memory Management
`aroma.core` uses `R.oo` (Object-Oriented R) and `R.cache`. It minimizes RAM usage by:
- Using `mapped' files or reading specific chunks of data.
- Storing intermediate results on the file system so analysis can resume if interrupted.

### 5. Parallel Processing
The framework supports parallelization via the `future` package.
```r
library(future)
plan(multisession) # Enable parallel processing on local machine
```

## Best Practices
- **Directory Structure:** Always place your raw data in `rawData/<DataSetName>/<ChipType>/`.
- **Annotation Files:** Place CDF, UFL, and UGP files in `annotationData/chipTypes/<ChipType>/`.
- **Persistent Results:** Do not manually move files in the `probeData` or `vcfData` directories, as the framework tracks these by relative paths and checksums.

## Reference documentation
- [The Aroma Project Home Page](./references/home_page.md)
- [Documentation Index](./references/index.html.md)