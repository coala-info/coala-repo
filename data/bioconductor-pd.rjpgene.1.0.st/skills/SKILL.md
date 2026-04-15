---
name: bioconductor-pd.rjpgene.1.0.st
description: This package provides platform design and annotation information for the Affymetrix Rhesus Gene 1.0 ST microarray. Use when user asks to process Rhesus macaque Gene ST arrays using the oligo package, map probe IDs to sequences, or initialize feature-level annotation for CEL files.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rjpgene.1.0.st.html
---

# bioconductor-pd.rjpgene.1.0.st

name: bioconductor-pd.rjpgene.1.0.st
description: Annotation and platform design information for the Affymetrix rjpgene.1.0.st microarray. Use when processing Gene ST arrays for Rhesus macaque (Jungle) using the oligo package, specifically for mapping probe IDs to sequences or initializing feature-level annotation.

# bioconductor-pd.rjpgene.1.0.st

## Overview
The `pd.rjpgene.1.0.st` package is a Bioconductor annotation data package specifically designed for use with the `oligo` package. It provides the necessary platform design information for the Affymetrix Rhesus Gene 1.0 ST array. This package acts as the infrastructure that allows R to understand the physical layout, probe sequences, and feature mapping of the CEL files generated from this specific microarray hardware.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically by `oligo` when reading CEL files, but can be invoked directly:

```r
library(pd.rjpgene.1.0.st)
```

### Integration with oligo
The primary use case is providing the annotation backend for `ExpressionFeatureSet` objects. When reading CEL files, ensure this package is installed so `read.celfiles` can correctly identify the geometry and probe types.

```r
library(oligo)
# Read CEL files; the pd.rjpgene.1.0.st package is used internally
raw_data <- read.celfiles(filenames = list.celfiles())
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package for custom sequence analysis or validation.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence[pmSequence$fid == 12345, ]
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes. It includes the feature ID (`fid`) and the actual nucleotide `sequence`.
- **bgSequence**: Background probe sequences (if applicable, accessed via the same dataset).
- **mmSequence**: Mismatch probe sequences (if applicable).

## Tips
- **Memory Management**: These annotation packages can be large. If you are only performing standard normalization (like RMA), you rarely need to interact with `pd.rjpgene.1.0.st` directly; `oligo` handles the mapping in the background.
- **Compatibility**: Ensure that the version of `oligo` and `pd.rjpgene.1.0.st` are compatible by keeping your Bioconductor installation updated via `BiocManager::install()`.

## Reference documentation
- [pd.rjpgene.1.0.st Reference Manual](./references/reference_manual.md)