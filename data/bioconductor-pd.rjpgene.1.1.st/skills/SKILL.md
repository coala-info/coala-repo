---
name: bioconductor-pd.rjpgene.1.1.st
description: This package provides platform design and annotation data for the Affymetrix Rhesus Gene 1.1 ST microarray. Use when user asks to analyze Rhesus monkey Gene ST array data, load platform design information, or access probe sequences using the oligo or xps packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rjpgene.1.1.st.html
---


# bioconductor-pd.rjpgene.1.1.st

name: bioconductor-pd.rjpgene.1.1.st
description: Annotation package for the Affymetrix rjpgene.1.1.st platform. Use when analyzing Gene ST array data for Rhesus monkey (Macaca mulatta) using the oligo or xps packages. This skill provides guidance on loading platform design information and accessing probe sequences.

# bioconductor-pd.rjpgene.1.1.st

## Overview

The `pd.rjpgene.1.1.st` package is a Bioconductor annotation (Platform Design) package specifically for the Affymetrix Rhesus Gene 1.1 ST array. It is built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package to provide the necessary mapping between probe identifiers, sequences, and genomic locations during the preprocessing of microarray data.

## Typical Workflow

### 1. Loading the Package
The package is usually loaded automatically when using `oligo::read.celfiles()`, but can be called directly:

```r
library(pd.rjpgene.1.1.st)
```

### 2. Integration with oligo
When processing CEL files, `oligo` uses this package to identify the chip layout and perform background correction and normalization (e.g., RMA).

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The pd.rjpgene.1.1.st package provides the annotation slot
# for the resulting FeatureSet object.
```

### 3. Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for quality control or custom analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

## Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for PM probes. It includes the feature ID (`fid`) and the actual nucleotide sequence.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (rarely used in ST arrays but available if defined).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient RAM when loading large `FeatureSet` objects.
- **Platform Matching**: This package is specific to the "rjpgene.1.1.st" array. If you are using a different version (e.g., 1.0 or a different species), ensure you have the corresponding `pd.xxx` package installed.

## Reference documentation

- [pd.rjpgene.1.1.st Reference Manual](./references/reference_manual.md)