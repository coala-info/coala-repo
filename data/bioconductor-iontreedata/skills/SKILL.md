---
name: bioconductor-iontreedata
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/iontreeData.html
---

# bioconductor-iontreedata

name: bioconductor-iontreedata
description: Access and utilize the iontreeData experiment data package. Use this skill when you need to load raw MS2 and MS3 mass spectrometry scans or the demo SQLite-based ion tree database (mzDB) for testing the iontree package's functionality.

# bioconductor-iontreedata

## Overview

The `iontreeData` package provides example datasets derived from direct infusion mass spectrometry (DIMS). It is primarily designed to demonstrate the functionalities of the `iontree` package, specifically for managing and exploring ion trees (MSn data). It contains raw MS2 and MS3 scans from four samples and a pre-constructed SQLite database.

## Data Loading and Usage

To use the datasets provided in this package, first load the library and then use the `data()` function to bring the objects into your R environment.

### Loading MS2 Scans
The `MS2RAW` object contains MS2 scans from 4 samples.
```r
library(iontreeData)
data(MS2RAW)

# Explore the structure
length(MS2RAW)
attributes(MS2RAW[[1]])
```

### Loading MS3 Scans
The `MS3RAW` object contains MS3 scans from 4 samples.
```r
library(iontreeData)
data(MS3RAW)

# Explore the structure
length(MS3RAW)
```

### Accessing the mzDB Database
The package includes a demo SQLite-based ion tree database named `mzDB`. This is typically used as input for functions in the `iontree` package to demonstrate database searching and ion tree construction.

## Typical Workflow

1. **Initialization**: Load the data package alongside the main `iontree` analysis package.
2. **Data Inspection**: Use `length()` and `attributes()` to understand the list structure of the raw scans.
3. **Integration**: Pass `MS2RAW` or `MS3RAW` objects into `iontree` functions for processing, or use the `mzDB` file path for database-related demonstrations.

## Reference documentation

- [iontreeData Reference Manual](./references/reference_manual.md)