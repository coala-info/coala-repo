---
name: bioconductor-pd.mg.u74b
description: This package provides annotation data and platform design information for the Affymetrix MG-U74B murine genome microarray. Use when user asks to process MG-U74B CEL files with the oligo package, retrieve probe sequences, or map probe identifiers to physical chip locations.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mg.u74b.html
---


# bioconductor-pd.mg.u74b

name: bioconductor-pd.mg.u74b
description: Provides annotation data for the Affymetrix MG-U74B (Murine Genome U74B) microarray platform. Use this skill when preprocessing or analyzing .CEL files from the MG-U74B array using the oligo package, or when retrieving probe sequence information for this specific platform.

# bioconductor-pd.mg.u74b

## Overview
The `pd.mg.u74b` package is a Bioconductor annotation resource (Platform Design package) for the Affymetrix MG-U74B Mouse Genome array. It is specifically designed to work with the `oligo` package to provide the mapping between probe identifiers, sequences, and physical locations on the chip.

## Typical Workflow

### Loading the Annotation
The package is usually loaded automatically by `oligo` when reading CEL files, but can be loaded manually:

```r
library(pd.mg.u74b)
```

### Use with oligo
When analyzing MG-U74B data, use the `oligo` package to read CEL files. The `pd.mg.u74b` package provides the necessary metadata for the `FeatureSet` objects.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The platform design information is automatically linked
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences, which are stored as a `DataFrame` containing feature IDs (`fid`) and the corresponding sequences.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
head(pmSequence)

# Access specific columns
# pmSequence$fid
# pmSequence$sequence
```

## Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Tips
- This package is a "data" package, not a "software" package. It contains the database schema required by `oligo` to process raw intensity data.
- Ensure the version of `pd.mg.u74b` matches your Bioconductor installation to avoid compatibility issues with the `oligo` or `DBI` packages.
- If you need gene-level annotations (like symbols or Entrez IDs) rather than probe-level design, use the corresponding chip-specific annotation package (e.g., `mgu74b.db`).

## Reference documentation
- [pd.mg.u74b Reference Manual](./references/reference_manual.md)