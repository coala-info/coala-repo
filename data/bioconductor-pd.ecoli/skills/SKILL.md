---
name: bioconductor-pd.ecoli
description: This package provides platform design and annotation data for Affymetrix E. coli microarrays. Use when user asks to process E. coli microarray data, access probe sequences, or perform normalization and background correction using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ecoli.html
---


# bioconductor-pd.ecoli

name: bioconductor-pd.ecoli
description: Annotation package for the E. coli platform. Use when processing Affymetrix E. coli microarray data in R, specifically to provide platform design information and probe sequences for use with the oligo package during preprocessing steps like normalization and background correction.

# bioconductor-pd.ecoli

## Overview
The `pd.ecoli` package is a Bioconductor annotation (Platform Design) package for E. coli microarrays. It was built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package to handle feature-level data. Its primary role is to provide the mapping between feature identifiers (fids) and their corresponding nucleotide sequences.

## Typical Workflow

### Loading the Package
Load the package to make the annotation data available to the `oligo` infrastructure.
```r
library(pd.ecoli)
```

### Accessing Probe Sequences
The package contains sequence data for Perfect Match (PM) probes. This is useful for sequence-specific background correction or probe effect modeling.

1. Load the sequence data:
```r
data(pmSequence)
```

2. Inspect the data structure:
The `pmSequence` object is a `DataFrame` containing two columns:
- `fid`: The feature identifier.
- `sequence`: The actual nucleotide sequence for that probe.

```r
head(pmSequence)
```

### Integration with oligo
In most cases, you do not call functions within `pd.ecoli` directly. Instead, the `oligo` package detects the platform from the CEL files and loads `pd.ecoli` automatically to perform tasks such as:
- Background correction (e.g., RMA)
- Summarization
- Visualization of array geometry

If you need to manually assign the annotation to a FeatureSet object:
```r
# Assuming 'rawData' is an ExpressionFeatureSet
annotation(rawData) <- "pd.ecoli"
```

## Tips
- Ensure the `oligo` package is installed, as `pd.ecoli` is specifically designed to be its backend.
- If working with mismatch (MM) or background (BG) sequences, they are typically accessed through the same `pmSequence` data object or internal package environment depending on the specific array design.

## Reference documentation
- [pd.ecoli Reference Manual](./references/reference_manual.md)