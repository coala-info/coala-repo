---
name: bioconductor-pd.hg18.60mer.expr
description: This package provides platform design and annotation metadata for the hg18 60mer expression microarray. Use when user asks to process microarray data from the hg18 60mer platform, perform feature-level analysis with the oligo package, or access probe sequence information for background correction.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hg18.60mer.expr.html
---


# bioconductor-pd.hg18.60mer.expr

name: bioconductor-pd.hg18.60mer.expr
description: Annotation package for the hg18 60mer expression platform. Use when processing microarray data that requires the pd.hg18.60mer.expr platform design, typically in conjunction with the oligo package for feature-level analysis, normalization, and sequence-specific adjustments.

# bioconductor-pd.hg18.60mer.expr

## Overview

The `pd.hg18.60mer.expr` package is a Bioconductor annotation (Platform Design) package. It provides the necessary metadata and sequence information for the hg18 60mer expression array. It is built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package to facilitate the analysis of high-density oligonucleotide arrays.

## Package Usage

### Loading the Package

To use the annotation data in an R session:

```r
library(pd.hg18.60mer.expr)
```

### Integration with oligo

This package is rarely called directly by the user. Instead, it is utilized by the `oligo` package when reading CEL files. If your data was generated on this specific platform, `oligo` will automatically detect and load this package.

```r
library(oligo)
# Assuming CEL files are in the current directory
data <- read.celfiles(list.celfiles())
# The 'data' object will now use pd.hg18.60mer.expr for feature mapping
```

### Accessing Sequence Data

You can access the probe sequence information directly, which is useful for sequence-specific background correction or custom analysis.

```r
# Load the PM (Perfect Match) sequence data
data(pmSequence)

# View the structure of the sequence data
# It contains 'fid' (feature ID) and 'sequence' (the 60mer string)
head(pmSequence)

# Accessing specific columns
sequences <- pmSequence$sequence
fids <- pmSequence$fid
```

### Data Structures

The package primarily provides:
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes.
- **bgSequence**: (If available) Sequences for background probes.
- **mmSequence**: (If available) Sequences for Mismatch probes.

Each of these objects typically contains:
- `fid`: The feature identifier corresponding to the physical location on the array.
- `sequence`: The actual nucleotide sequence of the probe.

## Workflow Tips

1. **Automatic Discovery**: Ensure this package is installed if you are working with hg18 60mer expression arrays; `oligo` functions like `rma()` or `summarize()` depend on it to map probes to probesets.
2. **Memory Management**: These annotation objects can be large. If you are only interested in the expression values, you may not need to interact with `pmSequence` directly.
3. **Platform Verification**: Use `annotation(data)` on your `FeatureSet` object to verify that `pd.hg18.60mer.expr` is being used.

## Reference documentation

- [pd.hg18.60mer.expr Reference Manual](./references/reference_manual.md)