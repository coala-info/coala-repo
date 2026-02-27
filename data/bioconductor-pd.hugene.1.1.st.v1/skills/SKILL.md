---
name: bioconductor-pd.hugene.1.1.st.v1
description: This package provides annotation and platform design information for the Affymetrix GeneChip Human Gene 1.1 ST Array. Use when user asks to process .CEL files from this platform, perform RMA normalization using the oligo package, or access probe sequence information for low-level analysis.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.hugene.1.1.st.v1.html
---


# bioconductor-pd.hugene.1.1.st.v1

name: bioconductor-pd.hugene.1.1.st.v1
description: Annotation and platform design information for the Affymetrix GeneChip Human Gene 1.1 ST Array. Use this skill when processing .CEL files from this specific microarray platform using the oligo or xps packages, or when probe sequence information (PM/MM/BG) is required for low-level analysis.

# bioconductor-pd.hugene.1.1.st.v1

## Overview
The `pd.hugene.1.1.st.v1` package is a Bioconductor annotation data package specifically built for the Affymetrix GeneChip Human Gene 1.1 ST platform. It provides the necessary mapping between physical probe locations (fids) and their corresponding sequences or genomic targets. This package is primarily used as a backend dependency for the `oligo` package to enable preprocessing, normalization (like RMA), and quality control of transcript-level microarray data.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be invoked directly:

```r
library(pd.hugene.1.1.st.v1)
```

### Integration with oligo
When analyzing Human Gene 1.1 ST arrays, use the `read.celfiles` function. The `oligo` package will identify the platform and use this `pd` (platform design) package to organize the data.

```r
library(oligo)

# List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# Read data - the pd.hugene.1.1.st.v1 package must be installed
rawData <- read.celfiles(celFiles)

# Perform RMA normalization
eset <- rma(rawData)
```

### Accessing Probe Sequences
If you need to perform sequence-specific analysis (e.g., GC-content correction or custom background adjustment), you can access the Perfect Match (PM) probe sequences.

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)

# Example: Get the number of probes
nrow(pmSequence)
```

## Usage Tips
- **Memory Management**: This package contains large SQLite databases and sequence objects. Ensure your R session has sufficient memory when loading `pmSequence`.
- **Platform Verification**: This package is version-specific (v1). Ensure your CEL files match the "HuGene-1_1-st-v1" identifier in the CEL header.
- **Annotation Mapping**: While this package provides the physical layout, use the corresponding transcript-level annotation packages (like `hugene11sttranscriptcluster.db`) for mapping probesets to Gene Symbols or Entrez IDs.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)