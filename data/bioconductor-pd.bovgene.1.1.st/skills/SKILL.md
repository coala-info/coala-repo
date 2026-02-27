---
name: bioconductor-pd.bovgene.1.1.st
description: This package provides annotation and platform design metadata for the Affymetrix BovGene-1_1-st-v1 expression array. Use when user asks to process bovine microarray data, map probe identifiers to genomic coordinates, or perform RMA normalization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.bovgene.1.1.st.html
---


# bioconductor-pd.bovgene.1.1.st

name: bioconductor-pd.bovgene.1.1.st
description: Annotation package for the Affymetrix BovGene-1_1-st-v1 expression array. Use when processing bovine (cow) microarray data with the oligo package to map probe identifiers to sequences and genomic coordinates.

# bioconductor-pd.bovgene.1.1.st

## Overview
The `pd.bovgene.1.1.st` package is a Platform Design (PD) annotation package for the Affymetrix BovGene 1.1 ST array. It is specifically designed to work with the `oligo` package to provide the necessary metadata for preprocessing, normalizing, and analyzing bovine gene-level ST (Sense Target) microarrays. It contains information about probe sequences, locations, and feature identifiers.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when reading CEL files using `oligo`, but can be loaded manually:

```r
library(pd.bovgene.1.1.st)
```

### Integration with oligo
The primary use case is providing the annotation backend for `ExpressionFeatureSet` objects.

```r
library(oligo)

# Read CEL files
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# The rawData object will automatically link to pd.bovgene.1.1.st
# if the CEL files identify as BovGene-1_1-st-v1
show(rawData)
```

### Accessing Sequence Data
You can access the probe sequence information stored within the package for quality control or custom analysis.

```r
# Load the probe sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence is a DataFrame object
```

### Typical Workflow: RMA Normalization
The PD package is essential for the Robust Multi-array Average (RMA) algorithm to correctly group probes into probesets.

```r
# Perform RMA normalization
# This uses the pd.bovgene.1.1.st mapping internally
eset <- rma(rawData)

# Get expression matrix
expMatrix <- exprs(eset)
```

## Tips
- **Memory Management**: PD packages can be large as they contain SQLite databases. Ensure your R session has sufficient memory when processing large batches of bovine arrays.
- **Compatibility**: This package is specifically for the "ST" (Sense Target) version of the bovine array. Ensure your array type matches "BovGene-1_1-st-v1".
- **Feature IDs**: The `fid` (feature ID) is the internal identifier used to link sequences to the physical locations on the chip.

## Reference documentation
- [pd.bovgene.1.1.st Reference Manual](./references/reference_manual.md)