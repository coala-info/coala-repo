---
name: bioconductor-pd.xenopus.laevis
description: This package provides platform design annotation for the Affymetrix Xenopus laevis expression microarray. Use when user asks to perform low-level preprocessing, access probe sequences, or conduct feature-level analysis on Xenopus laevis microarray data using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.xenopus.laevis.html
---


# bioconductor-pd.xenopus.laevis

name: bioconductor-pd.xenopus.laevis
description: Annotation package for the Affymetrix Xenopus laevis (African clawed frog) expression array. Use this skill when performing low-level preprocessing, feature-level analysis, or sequence-based operations on Xenopus laevis microarray data, typically in conjunction with the 'oligo' package.

# bioconductor-pd.xenopus.laevis

## Overview
The `pd.xenopus.laevis` package is a Platform Design (PD) annotation package for the Affymetrix Xenopus laevis microarray. It was built using the `pdInfoBuilder` engine and is specifically designed to work with the `oligo` package. It provides the necessary mapping between probe identifiers, physical locations on the array, and probe sequences required for robust multi-array average (RMA) normalization and other preprocessing steps.

## Package Usage

### Integration with oligo
In most workflows, you do not need to call functions from `pd.xenopus.laevis` directly. The `oligo` package automatically detects and loads this package when reading CEL files from the Xenopus laevis platform.

```r
library(oligo)
# When reading CEL files, oligo uses this package for annotation
raw_data <- read.celfiles(filenames = list.celfiles())
```

### Accessing Probe Sequences
If you need to perform sequence-specific analysis (e.g., GC-content calculations or custom probe filtering), you can load the Perfect Match (PM) sequence data.

```r
library(pd.xenopus.laevis)
data(pmSequence)

# View the structure of the sequence data
# It contains 'fid' (feature ID) and 'sequence' columns
head(pmSequence)
```

### Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for the Perfect Match probes.
- **bgSequence**: Sequence data for background probes (if available).
- **mmSequence**: Sequence data for Mismatch probes (if available).

## Workflow Tips
- **Memory Management**: PD packages can be large. If you encounter memory issues, ensure you are only loading the necessary objects.
- **Platform Matching**: Ensure that the CEL files you are analyzing actually correspond to the Xenopus laevis platform; otherwise, `oligo` will throw an error regarding the missing or mismatched PD package.
- **Annotation**: For higher-level annotation (mapping probes to Gene Symbols or Entrez IDs), use the corresponding chip-specific annotation package (e.g., `xenopuslaevis.db`) after preprocessing with this package.

## Reference documentation
- [pd.xenopus.laevis Reference Manual](./references/reference_manual.md)