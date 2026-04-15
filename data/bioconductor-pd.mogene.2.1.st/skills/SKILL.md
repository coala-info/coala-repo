---
name: bioconductor-pd.mogene.2.1.st
description: This package provides platform design and annotation data for the Affymetrix Mouse Gene 2.1 ST array. Use when user asks to process raw CEL files, perform RMA normalization, or access probe sequence information for this specific microarray platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mogene.2.1.st.html
---

# bioconductor-pd.mogene.2.1.st

## Overview
The `pd.mogene.2.1.st` package is a Bioconductor annotation package specifically designed for the Affymetrix Mouse Gene 2.1 ST array. It provides the necessary platform design information (probe sequences, locations, and feature identifiers) required by the `oligo` package to process raw microarray data. It acts as the "glue" that allows R to understand the physical layout and sequence information of this specific chip.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when using `oligo` functions on Mouse Gene 2.1 ST data, but can be loaded manually:

```r
library(pd.mogene.2.1.st)
```

### 2. Integration with oligo
The primary use case is during the reading of CEL files. The `oligo` package identifies the chip type and looks for this annotation package.

```r
library(oligo)

# Read CEL files in the current directory
celFiles <- list.celfiles()
rawData <- read.celfiles(celFiles)

# The 'rawData' object will now use pd.mogene.2.1.st for its feature data
# You can then proceed to RMA normalization
eset <- rma(rawData)
```

### 3. Accessing Sequence Data
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)
```

## Tips and Usage Notes
- **Platform Specificity**: This package is strictly for the "2.1 ST" version of the Mouse Gene array. Ensure your CEL files match this specific platform version.
- **Memory Management**: Annotation packages can be large. If working with many arrays, ensure sufficient RAM is available for the `oligo` objects to map features correctly.
- **Feature IDs**: The `fid` column in the sequence data corresponds to the feature identifiers used in the `ExpressionSet` or `FeatureSet` objects created during analysis.

## Reference documentation
- [pd.mogene.2.1.st Reference Manual](./references/reference_manual.md)