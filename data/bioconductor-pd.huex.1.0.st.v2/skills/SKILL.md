---
name: bioconductor-pd.huex.1.0.st.v2
description: This package provides annotation and platform design information for Affymetrix Human Exon 1.0 ST v2 arrays. Use when user asks to preprocess CEL files from Human Exon 1.0 ST v2 arrays, retrieve probe sequence information, or perform normalization and summarization using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.huex.1.0.st.v2.html
---

# bioconductor-pd.huex.1.0.st.v2

name: bioconductor-pd.huex.1.0.st.v2
description: Annotation package for Affymetrix Human Exon 1.0 ST v2 arrays. Use when analyzing microarray data from this platform, specifically for preprocessing CEL files with the oligo package or retrieving probe sequence information.

## Overview
The `pd.huex.1.0.st.v2` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the platform design information required to analyze Affymetrix Human Exon 1.0 ST v2 arrays. It is designed to work seamlessly with the `oligo` package to handle low-level microarray data tasks such as background correction, normalization, and summarization.

## Usage
This package is typically not called directly by the user but is loaded automatically by high-level analysis packages. However, it can be used to inspect probe-level information.

### Loading the Package
```r
library(pd.huex.1.0.st.v2)
```

### Integration with oligo
When processing raw CEL files, the `oligo` package identifies the array type and uses this package for mapping:
```r
library(oligo)
# Assuming .CEL files are in the current directory
raw_data <- read.celfiles(list.celfiles())
# The annotation slot will automatically point to pd.huex.1.0.st.v2
```

### Accessing Probe Sequences
You can retrieve the sequences for Perfect Match (PM) probes, which is useful for custom sequence-based analysis:
```r
# Load the sequence data
data(pmSequence)

# View the first few rows
# Returns a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Data Objects
- `pmSequence`: Contains sequences for PM probes.
- `bgSequence`: Contains sequences for background probes (if applicable).
- `mmSequence`: Contains sequences for Mismatch (MM) probes (if applicable).

## Workflow: Preprocessing Exon Arrays
1. **Installation**: Ensure the package is installed via `BiocManager::install("pd.huex.1.0.st.v2")`.
2. **Data Import**: Use `oligo::read.celfiles()` to create a FeatureSet object.
3. **Normalization**: Apply RMA (Robust Multi-array Average) or other algorithms. The `oligo` package will use the metadata in this package to correctly group probes into probesets.
4. **Sequence Analysis**: Use `data(pmSequence)` if you need to perform probe-effect modeling or GC-content adjustments manually.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)