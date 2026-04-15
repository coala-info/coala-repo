---
name: bioconductor-pd.clariom.d.human
description: This package provides annotation data and platform design information for the Affymetrix Clariom D Human microarray. Use when user asks to preprocess Clariom D Human CEL files, perform probe-level analysis, or retrieve probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.clariom.d.human.html
---

# bioconductor-pd.clariom.d.human

name: bioconductor-pd.clariom.d.human
description: Annotation data package for the Affymetrix Clariom D Human array. Use when preprocessing Clariom D Human microarray data with the 'oligo' package, performing probe-level analysis, or retrieving probe sequence information for this specific platform.

# bioconductor-pd.clariom.d.human

## Overview

The `pd.clariom.d.human` package is a Bioconductor annotation package (Platform Design) for the Affymetrix Clariom D Human array. It provides the necessary infrastructure to map probe identifiers to their physical locations on the chip and their corresponding sequences. This package is primarily designed to work as a backend for the `oligo` package during the preprocessing of .CEL files.

## Typical Workflow

### 1. Automatic Integration with oligo
In most cases, you do not call functions from this package directly. Instead, the `oligo` package detects the array type from the .CEL file headers and loads this package automatically.

```r
library(oligo)

# Load CEL files
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# The pd.clariom.d.human package is used internally here
eset <- rma(rawData)
```

### 2. Accessing Probe Sequences
If you need to perform sequence-specific analysis (e.g., GC-content correction or probe-specific alignment), you can load the probe sequence data manually.

```r
library(pd.clariom.d.human)

# Load the PM (Perfect Match) sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### 3. Identifying the Package Object
The package creates an object named `pd.clariom.d.human` which is an instance of a `PlatformDesign` class. This object contains the SQLite database connection used to map probes.

```r
# Check package info
pd.clariom.d.human
```

## Tips and Best Practices
- **Installation**: Ensure this package is installed via `BiocManager::install("pd.clariom.d.human")` before attempting to process Clariom D Human CEL files.
- **Memory**: Annotation packages can be large. If you are processing many arrays, ensure your R session has sufficient memory to hold the platform design information.
- **Probe Types**: This package specifically handles the "D" (Deep) version of the Clariom Human array, which provides high-resolution transcriptome coverage including alternative splicing and non-coding RNA.

## Reference documentation

- [pd.clariom.d.human Reference Manual](./references/reference_manual.md)