---
name: bioconductor-pd.rusgene.1.1.st
description: This package provides platform design annotation for the Affymetrix RusGene 1.1 ST microarray. Use when user asks to perform low-level preprocessing, map probes to physical locations, or access probe sequences for RusGene 1.1 ST data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rusgene.1.1.st.html
---

# bioconductor-pd.rusgene.1.1.st

name: bioconductor-pd.rusgene.1.1.st
description: Annotation package for the Affymetrix RusGene 1.1 ST array. Use when performing low-level preprocessing (background correction, normalization, and summarization) of RusGene 1.1 ST microarray data, typically in conjunction with the oligo package.

# bioconductor-pd.rusgene.1.1.st

## Overview

The `pd.rusgene.1.1.st` package is a Platform Design (PD) annotation package for the Affymetrix RusGene 1.1 ST array. It provides the necessary mapping between probe identifiers, physical locations on the chip, and nucleotide sequences. This package is built using `pdInfoBuilder` and is designed to work seamlessly with the `oligo` package for the analysis of Gene ST arrays.

## Usage

### Loading the Package

While you can load the package directly, it is most commonly loaded automatically by the `oligo` package when reading CEL files from the RusGene 1.1 ST platform.

```R
library(pd.rusgene.1.1.st)
```

### Integration with oligo

The primary workflow involves using `oligo` to read and process raw data. The `pd.rusgene.1.1.st` package provides the underlying architecture for these operations.

```R
library(oligo)

# Read CEL files - the pd package is identified from the CEL file header
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
# oligo uses pd.rusgene.1.1.st to map probes to probesets
eset <- rma(rawData)
```

### Accessing Probe Sequences

You can access the probe sequence data directly if needed for custom sequence-based analysis.

```R
# Load the probe sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with columns 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Key Data Objects

- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match (PM) probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch (MM) probes (if applicable).

## Tips

- **Automatic Detection**: Ensure this package is installed if you are working with RusGene 1.1 ST data; `oligo` will look for it specifically by name.
- **Memory Management**: PD packages can be memory-intensive as they contain large SQLite databases. Ensure your R environment has sufficient RAM for large-scale microarray analysis.
- **Annotation**: This package provides platform design information. For functional annotation (gene symbols, GO terms), use the corresponding transcript-level annotation package (e.g., `rusgene11sttranscriptcluster.db`).

## Reference documentation

- [pd.rusgene.1.1.st Reference Manual](./references/reference_manual.md)