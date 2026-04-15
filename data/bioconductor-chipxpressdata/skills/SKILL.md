---
name: bioconductor-chipxpressdata
description: This package provides pre-built, large-scale gene expression databases for human and mouse samples to support ChIPXpress analysis. Use when user asks to load mouse or human expression compendia, retrieve fRMA-processed GEO data, or access summary statistics for integrative ChIP-seq and microarray analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ChIPXpressData.html
---

# bioconductor-chipxpressdata

name: bioconductor-chipxpressdata
description: Access and load pre-built gene expression databases for ChIPXpress analysis. Use this skill when you need to retrieve mouse (GPL1261) or human (GPL570) expression compendia to rank transcription factor targets or perform integrative ChIP-seq and microarray analysis.

# bioconductor-chipxpressdata

## Overview

ChIPXpressData is a specialized data package providing large-scale, processed gene expression databases for use with the `ChIPXpress` package. It contains normalized expression profiles from thousands of NCBI GEO samples (9,634 mouse and 18,257 human) processed using frozen robust multiarray analysis (fRMA). These databases are stored in `big.matrix` format via the `bigmemory` package to allow efficient memory mapping of large datasets.

## Loading Databases

The primary datasets are not loaded via the standard `data()` command because they are stored as external binary files. You must use `attach.big.matrix` to point to the description files located within the package's `extdata` directory.

### Mouse Database (GPL1261)
Used for Affymetrix Mouse 430 2.0 Array data.
```r
library(bigmemory)
library(ChIPXpressData)

path <- system.file("extdata", package="ChIPXpressData")
DB_GPL1261 <- attach.big.matrix("DB_GPL1261.bigmemory.desc", path=path)

# Inspect the database
describe(DB_GPL1261)
```

### Human Database (GPL570)
Used for Affymetrix Human U133 Plus 2.0 Array data.
```r
library(bigmemory)
library(ChIPXpressData)

path <- system.file("extdata", package="ChIPXpressData")
DB_GPL570 <- attach.big.matrix("DB_GPL570.bigmemory.desc", path=path)

# Inspect the database
describe(DB_GPL570)
```

## Summary Statistics

The package provides pre-calculated mean and variance vectors for the probesets in these databases. These are useful for filtering out low-expression or low-variance probesets before analysis. These are loaded using the standard `data()` function.

### Mouse Statistics
```r
data(GPL1261mean) # Mean of each probeset
data(GPL1261var)  # Variance of each probeset
```

### Human Statistics
```r
data(GPL570mean) # Mean of each probeset
data(GPL570var)  # Variance of each probeset
```

## Workflow Integration

1. **Initialize**: Load `bigmemory` and `ChIPXpressData`.
2. **Attach**: Use `system.file` and `attach.big.matrix` to create a pointer to the expression database.
3. **Analyze**: Pass the resulting `big.matrix` object directly into the `ChIPXpress()` function from the `ChIPXpress` package.
4. **Filter (Optional)**: Use the `GPLXXXmean` or `GPLXXXvar` vectors to identify and exclude unreliable probesets from your target list.

## Tips
- **Memory Efficiency**: Because these are `big.matrix` objects, they are memory-mapped. This means the data stays on disk until accessed, allowing you to work with these large compendia even on machines with limited RAM.
- **Probe Selection**: Only the probe with the highest variance in the compendium for each gene was retained as the representative measurement.
- **Dependencies**: Ensure the `bigmemory` package is installed and loaded, as the databases cannot be accessed without it.

## Reference documentation
- [ChIPXpressData Reference Manual](./references/reference_manual.md)