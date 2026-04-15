---
name: bioconductor-pd.hg.u95av2
description: This package provides platform design annotation data for the Affymetrix Human Genome U95AV2 microarray chip. Use when user asks to process CEL files, access probe sequences, or perform low-level analysis of hg.u95av2 platform data using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95av2.html
---

# bioconductor-pd.hg.u95av2

name: bioconductor-pd.hg.u95av2
description: Provides annotation data for the Affymetrix Human Genome U95AV2 chip. Use this skill when working with the 'oligo' or 'bioc-pdInfoBuilder' packages to process, normalize, or analyze microarrays using the hg.u95av2 platform.

# bioconductor-pd.hg.u95av2

## Overview
The `pd.hg.u95av2` package is a platform design (PD) annotation package for the Affymetrix Human Genome U95AV2 array. It is specifically designed to work with the `oligo` package to provide the necessary mapping between probe identifiers, sequences, and physical locations on the chip. This package is essential for low-level analysis of .CEL files from this specific platform.

## Usage and Workflows

### Loading the Package
The package is typically loaded automatically by `oligo` when reading CEL files, but can be loaded manually:
```r
library(pd.hg.u95av2)
```

### Integration with oligo
When analyzing U95AV2 data, the `oligo` package uses this annotation to create `FeatureSet` objects.
```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# oligo will automatically look for pd.hg.u95av2
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package. This is useful for custom sequence-based filtering or analysis.
```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences
# 'fid' corresponds to the feature ID on the array
```

### Data Structures
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: (If available) Sequence data for background probes.
- **mmSequence**: (If available) Sequence data for Mismatch probes.

## Tips
- Ensure this package is installed if you encounter errors in `oligo` stating that the annotation package for "hg.u95av2" is missing.
- This package is a "data" package; it contains the SQLite database and sequence information required for preprocessing rather than analysis functions themselves.
- Use `ls("package:pd.hg.u95av2")` to see all available data objects in the package.

## Reference documentation
- [pd.hg.u95av2 Reference Manual](./references/reference_manual.md)