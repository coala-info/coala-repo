---
name: bioconductor-pd.hg.u219
description: This package provides platform design and annotation data for the Affymetrix Human Genome U219 microarray. Use when user asks to process HG-U219 CEL files, access probe sequences, or map feature IDs to sequences using the oligo framework.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u219.html
---

# bioconductor-pd.hg.u219

name: bioconductor-pd.hg.u219
description: Annotation package for the Affymetrix Human Genome U219 (HG-U219) array. Use this skill when processing HG-U219 microarray data in R, specifically for platform design information, probe sequences, and mapping feature IDs to sequences using the oligo or pdInfoBuilder frameworks.

# bioconductor-pd.hg.u219

## Overview
The `pd.hg.u219` package is a Bioconductor annotation resource for the Affymetrix HG-U219 array. It provides the SQLite-based infrastructure required by the `oligo` package to preprocess, normalize, and analyze high-density oligonucleotide arrays. It contains platform design information, including probe coordinates and sequences.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically when using `oligo` functions on HG-U219 CEL files, but can be loaded manually:

```r
library(pd.hg.u219)
```

### Integration with oligo
This package is a dependency for the `oligo` workflow. When reading CEL files from the HG-U219 platform, `oligo` uses this package to identify probe types (PM, MM, background) and their locations.

```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())
# oligo automatically detects and uses pd.hg.u219
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for sequence-specific analysis or custom normalization (like GC-RMA).

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID (fid)
# fid corresponds to the row index in the intensity matrix
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: (If available) Sequences for background probes.
- **mmSequence**: (If available) Sequences for Mismatch probes.

## Tips
- **Memory Management**: These annotation objects can be large. Ensure you have sufficient RAM when loading `pmSequence` for genome-wide arrays.
- **Feature IDs**: The `fid` (Feature ID) is the primary key used to link sequences in this package to the intensity values in `ExpressionFeatureSet` objects created by `oligo`.
- **Annotation**: For gene-level annotation (mapping probesets to Gene Symbols or Entrez IDs), use this package in conjunction with the `hgu219.db` package.

## Reference documentation
- [pd.hg.u219 Reference Manual](./references/reference_manual.md)