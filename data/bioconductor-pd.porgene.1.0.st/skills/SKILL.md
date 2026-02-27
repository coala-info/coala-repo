---
name: bioconductor-pd.porgene.1.0.st
description: This package provides annotation and platform design information for the Affymetrix PorGene 1.0 ST array. Use when user asks to process porcine gene expression data, map probe identifiers to sequences, or manage chip layout metadata for the PorGene 1.0 ST platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.porgene.1.0.st.html
---


# bioconductor-pd.porgene.1.0.st

name: bioconductor-pd.porgene.1.0.st
description: Annotation and platform design information for the Affymetrix PorGene 1.0 ST array. Use when processing Porcine (pig) gene expression data using the oligo or xps packages, specifically for mapping probe identifiers to sequences and managing chip layout metadata.

# bioconductor-pd.porgene.1.0.st

## Overview

The `pd.porgene.1.0.st` package is a Bioconductor annotation package specifically designed for the Affymetrix PorGene 1.0 ST array. It provides the necessary SQLite-based infrastructure to map probe sets to their physical locations and sequences on the chip. This package is not typically used in isolation but serves as a critical dependency for high-level analysis packages like `oligo`.

## Usage and Workflows

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo::read.celfiles()`, but can be loaded manually:

```r
library(pd.porgene.1.0.st)
```

### Integration with oligo
The primary workflow involves using this package to provide the platform design information for an ExpressionFeatureSet:

```r
library(oligo)

# Read CEL files (the pd package is identified from the CEL header)
raw_data <- read.celfiles(filenames = list.celfiles())

# The pd.porgene.1.0.st package allows oligo to perform:
# 1. Background correction
# 2. Normalization (e.g., RMA)
# 3. Summarization
eset <- rma(raw_data)
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence-level analysis.

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get sequence for a specific feature ID
# pmSequence[pmSequence$fid == 123, ]
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (rarely present in ST arrays but defined in the schema).

## Tips
- **Memory Management**: These annotation objects can be large. Ensure your R session has sufficient RAM when processing large batches of PorGene 1.0 ST arrays.
- **Platform Matching**: This package is specific to the "1.0 ST" version of the Porcine array. Ensure your CEL files match this specific platform designator.
- **Annotation Updates**: While this package provides the physical map, use the `porgene10stprobeset.db` or `porgene10sttranscriptcluster.db` packages for biological annotations (Gene Symbols, Entrez IDs, GO terms).

## Reference documentation

- [pd.porgene.1.0.st Reference Manual](./references/reference_manual.md)