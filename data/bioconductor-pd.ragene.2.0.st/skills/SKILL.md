---
name: bioconductor-pd.ragene.2.0.st
description: This package provides platform design annotation and metadata for the Affymetrix Rat Gene 2.0 ST microarray. Use when user asks to process Rat Gene 2.0 ST CEL files, perform RMA normalization using the oligo package, or map probe identifiers to sequences for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ragene.2.0.st.html
---

# bioconductor-pd.ragene.2.0.st

name: bioconductor-pd.ragene.2.0.st
description: Annotation package for the Affymetrix Rat Gene 2.0 ST array. Use when processing or analyzing Rat Gene 2.0 ST microarray data in R, specifically for mapping probe IDs to sequences or when using the oligo package for normalization and summarization of .CEL files.

# bioconductor-pd.ragene.2.0.st

## Overview
The `pd.ragene.2.0.st` package is a Platform Design (PD) annotation package for the Affymetrix Rat Gene 2.0 ST array. It was built using the `pdInfoBuilder` package and is designed to work seamlessly with the `oligo` package. It contains the necessary metadata to map feature identifiers to physical locations and sequences on the microarray, which is essential for low-level preprocessing tasks like background correction and normalization (e.g., RMA).

## Usage

### Loading the Package
The package is typically loaded automatically when using `oligo` to read .CEL files, but it can be loaded manually:
```r
library(pd.ragene.2.0.st)
```

### Integration with oligo
When analyzing Rat Gene 2.0 ST arrays, the `oligo` package uses this annotation package to understand the chip layout.
```r
library(oligo)

# Read CEL files; oligo will automatically detect and use pd.ragene.2.0.st
celfiles <- list.celfiles()
data <- read.celfiles(celfiles)

# Perform RMA normalization
eset <- rma(data)
```

### Accessing Probe Sequences
You can access the sequence data for the Perfect Match (PM) probes using the `pmSequence` dataset.
```r
# Load the sequence data
data(pmSequence)

# View the first few entries
# The object is a DataFrame with columns 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes.
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. Ensure your R environment has sufficient memory when loading large datasets.
- **Automatic Detection**: If `read.celfiles()` fails to find the package, ensure it is installed via BiocManager: `BiocManager::install("pd.ragene.2.0.st")`.
- **Annotation**: This package provides the physical layout. For gene-level annotations (symbols, Entrez IDs), use the corresponding chip-specific annotation package (e.g., `ragene20sttranscriptcluster.db`).

## Reference documentation
- [pd.ragene.2.0.st Reference Manual](./references/reference_manual.md)