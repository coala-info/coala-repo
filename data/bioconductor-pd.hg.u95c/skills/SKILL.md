---
name: bioconductor-pd.hg.u95c
description: This package provides platform design and annotation data for the Affymetrix Human Genome U95C microarray. Use when user asks to analyze HG-U95C CEL files using the oligo package, map probes to genomic locations, or retrieve probe sequence data for this specific array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg.u95c.html
---


# bioconductor-pd.hg.u95c

name: bioconductor-pd.hg.u95c
description: Provide annotation and platform design information for the Affymetrix Human Genome U95C microarray. Use when analyzing HG-U95C CEL files with the oligo package or when retrieving probe sequence data for this specific array.

# bioconductor-pd.hg.u95c

## Overview

The `pd.hg.u95c` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the necessary platform design information for the Affymetrix Human Genome U95C array. This package is primarily designed to be used in conjunction with the `oligo` package for the analysis of high-density oligonucleotide arrays.

## Usage

The package serves as a data backend for low-level preprocessing. While it is rarely called directly by users for high-level analysis, it is essential for the `oligo` workflow.

### Integration with oligo

When reading CEL files from an HG-U95C array, the `oligo` package will automatically search for and use this package to map probes to their genomic locations and sequences.

```r
library(oligo)

# When reading CEL files, oligo uses this package automatically
# cels <- read.celfiles(filenames)
```

### Accessing Probe Sequences

You can manually load and inspect the Perfect Match (PM) probe sequences contained within the package. The data is stored in a `DataFrame` object.

```r
library(pd.hg.u95c)

# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)
```

### Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch probes (if applicable).

## Workflow Tips

1. **Automatic Loading**: You do not usually need to call `library(pd.hg.u95c)` manually if you are using `read.celfiles()` from the `oligo` package; it will be loaded as a dependency based on the CEL file metadata.
2. **Memory Management**: These annotation packages can be large. Ensure your R session has sufficient memory when performing preprocessing (like RMA or GCRMA) on large datasets.
3. **Platform Specificity**: This package is specific to the **U95C** version of the Human Genome U95 set. Ensure it matches your specific chip version (as opposed to U95A or U95B).

## Reference documentation

- [pd.hg.u95c Reference Manual](./references/reference_manual.md)