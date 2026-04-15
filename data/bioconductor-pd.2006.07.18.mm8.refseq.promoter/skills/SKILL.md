---
name: bioconductor-pd.2006.07.18.mm8.refseq.promoter
description: This package provides annotation data and probe-level mappings for the Mus musculus mm8 RefSeq promoter tiling array. Use when user asks to process raw tiling array data, map probe identifiers to sequences, or analyze mouse promoter regions using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.2006.07.18.mm8.refseq.promoter.html
---

# bioconductor-pd.2006.07.18.mm8.refseq.promoter

name: bioconductor-pd.2006.07.18.mm8.refseq.promoter
description: Annotation package for the pd.2006.07.18.mm8.refseq.promoter platform. Use when processing or analyzing Mus musculus (mm8) RefSeq promoter tiling arrays, specifically when using the oligo package to handle probe-level data, sequences, and feature identifiers.

# bioconductor-pd.2006.07.18.mm8.refseq.promoter

## Overview
The `pd.2006.07.18.mm8.refseq.promoter` package is a Platform Design (pd) annotation package built using `pdInfoBuilder`. It provides the necessary mapping between probe identifiers and physical sequences for the mm8 RefSeq promoter array. This package is designed to work seamlessly with the `oligo` package for the analysis of tiling arrays.

## Usage

### Loading the Package
The package is typically loaded automatically when reading raw data files with `oligo`, but can be loaded manually:
```r
library(pd.2006.07.18.mm8.refseq.promoter)
```

### Integration with oligo
When analyzing CEL or XYS files from this platform, the `oligo` package uses this annotation to create a FeatureSet object:
```r
library(oligo)
# Assuming XYS or CEL files are in the working directory
data <- read.xysfiles(list.files(pattern = ".xys$"))
# The annotation slot will be set to "pd.2006.07.18.mm8.refseq.promoter"
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored in the package:
```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence is a DataFrame object
```

### Data Objects
- `pmSequence`: Contains sequences for Perfect Match probes.
- `bgSequence`: Contains sequences for background probes (if applicable).
- `mmSequence`: Contains sequences for Mismatch probes (if applicable).

## Workflow Tips
- **Memory Management**: Platform design packages can be large. Ensure your R session has sufficient memory when loading large datasets with `oligo`.
- **Platform Matching**: This package is specific to the mm8 (Mouse) RefSeq promoter design from 2006-07-18. Ensure your experimental data matches this specific array design to avoid incorrect mapping.
- **Downstream Analysis**: Once the data is loaded into a `FeatureSet` using this package, you can proceed with normalization (e.g., RMA) and tiling-specific analyses provided by Bioconductor.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)