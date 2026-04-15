---
name: bioconductor-pd.ht.hg.u133a
description: This package provides annotation data and platform design information for the Affymetrix HT HG-U133A microarray. Use when user asks to process HT-HG-U133A arrays with the oligo package, access probe sequence data, or map physical array coordinates to probe identifiers.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ht.hg.u133a.html
---

# bioconductor-pd.ht.hg.u133a

name: bioconductor-pd.ht.hg.u133a
description: Annotation data package for the Affymetrix HT HG-U133A microarray. Use when processing HT-HG-U133A arrays with the oligo package, specifically for feature-level annotation, probe sequences, and mapping probe IDs to sequences.

# bioconductor-pd.ht.hg.u133a

## Overview
The `pd.ht.hg.u133a` package is a Bioconductor annotation package built using `pdInfoBuilder`. It provides the platform design information required to analyze Affymetrix High-Throughput (HT) Human Genome U133A microarrays. It is designed to work seamlessly with the `oligo` package for low-level analysis (preprocessing, normalization, and summarization).

## Usage
This package is typically not called directly by the user but is loaded automatically by the `oligo` package when it detects HT-HG-U133A CEL files. However, it can be used manually to access probe sequence information.

### Loading the Package
```r
library(pd.ht.hg.u133a)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes, as well as background (bg) and Mismatch (mm) sequences if applicable.

```r
# Load the PM sequence data
data(pmSequence)

# The data is stored in a DataFrame object
# Columns: 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Integration with oligo
When using the `oligo` package to read CEL files, the `pd.ht.hg.u133a` package provides the necessary mapping between physical coordinates on the array and probe identifiers.

```r
library(oligo)
# Assuming .CEL files for HT-HG-U133A are in the working directory
raw_data <- read.celfiles(filenames = list.celfiles())

# oligo will use pd.ht.hg.u133a to annotate 'raw_data'
```

## Tips
- Ensure that the version of `pd.ht.hg.u133a` matches the Bioconductor release you are using to maintain compatibility with the `oligo` package.
- If you encounter errors regarding "missing platform design," ensure this package is installed: `BiocManager::install("pd.ht.hg.u133a")`.

## Reference documentation
- [pd.ht.hg.u133a Reference Manual](./references/reference_manual.md)