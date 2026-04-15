---
name: bioconductor-pd.mirna.3.0
description: This package provides platform design and annotation information for the Affymetrix miRNA 3.0 array. Use when user asks to process miRNA 3.0 CEL files, map probe IDs to sequences, or provide platform design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mirna.3.0.html
---

# bioconductor-pd.mirna.3.0

name: bioconductor-pd.mirna.3.0
description: Annotation package for the Affymetrix miRNA 3.0 array. Use when processing miRNA 3.0 array data in R, specifically for mapping probe IDs to sequences and providing platform design information for the oligo package.

# bioconductor-pd.mirna.3.0

## Overview
The `pd.mirna.3.0` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the platform design (PD) information required to analyze Affymetrix miRNA 3.0 arrays. It is designed to work seamlessly with the `oligo` package for low-level processing of microarray data.

## Usage
This package is typically not called directly by the user for high-level analysis but is loaded automatically by the `oligo` package when handling miRNA 3.0 CEL files.

### Loading the Package
```r
library(pd.mirna.3.0)
```

### Accessing Probe Sequences
The package contains sequence information for the probes on the array. You can load the Perfect Match (PM) sequences using the `data` function.

```r
# Load PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Integration with oligo
When analyzing CEL files, the `oligo` package uses this annotation package to map probes to their physical locations and sequences.

```r
library(oligo)

# Assuming CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())

# The 'raw_data' object will automatically reference pd.mirna.3.0 
# if the CEL files are from the miRNA 3.0 platform.
```

## Typical Workflow
1. **Data Import**: Use `oligo::read.celfiles()` to load raw .CEL data.
2. **Annotation**: The `oligo` package identifies the array type and loads `pd.mirna.3.0` to provide the necessary geometry and sequence data.
3. **Preprocessing**: Perform RMA normalization or other preprocessing steps using `oligo::rma()`.
4. **Sequence Analysis**: If custom sequence-level analysis is required (e.g., GC content correction), access `pmSequence` directly.

## Tips
- Ensure `oligo` is installed, as `pd.mirna.3.0` is a support package for it.
- The `pmSequence` object is a `DataFrame` from the `S4Vectors` package.
- If you encounter errors regarding "missing platform design," ensure this package is installed via `BiocManager::install("pd.mirna.3.0")`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)