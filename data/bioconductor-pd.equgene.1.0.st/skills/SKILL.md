---
name: bioconductor-pd.equgene.1.0.st
description: This package provides annotation and platform design information for the Affymetrix EquGene 1.0 ST array. Use when user asks to process horse gene-level microarray data, analyze CEL files using the oligo package, or retrieve probe sequence information for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.equgene.1.0.st.html
---


# bioconductor-pd.equgene.1.0.st

name: bioconductor-pd.equgene.1.0.st
description: Provides annotation and platform design information for the Affymetrix EquGene 1.0 ST array. Use when processing horse (Equus caballus) gene-level microarray data, specifically when using the 'oligo' package to analyze CEL files or when probe sequence information is required for this specific platform.

# bioconductor-pd.equgene.1.0.st

## Overview
This package is a Platform Design (PD) dataset for the EquGene 1.0 ST array. It contains the mapping between probe identifiers and their physical locations or sequences, enabling the preprocessing of Affymetrix ST (Sense Target) arrays. It was built using the pdInfoBuilder package and is designed to work seamlessly with the oligo package for low-level analysis.

## Usage

### Integration with oligo
The package is primarily used as a backend dependency. When analyzing EquGene 1.0 ST CEL files, the oligo package will automatically detect the chip type and attempt to load this package.

library(oligo)
# When reading CEL files, oligo uses this package to map probes
# rawData <- read.celfiles(filenames)

### Accessing Probe Sequences
To retrieve the sequences for the Perfect Match (PM) probes on the array, use the internal data objects.

library(pd.equgene.1.0.st)
data(pmSequence)

# View the structure of the sequence data
# The object is a DataFrame with 'fid' (feature ID) and 'sequence' columns
head(pmSequence)

### Data Objects
- pmSequence: Contains sequence data for PM probes.
- bgSequence: Contains sequence data for background probes (if available).
- mmSequence: Contains sequence data for Mismatch (MM) probes (if available).

## Workflow Tips
- Ensure this package is installed when performing RMA (Robust Multi-array Average) or other normalization techniques on EquGene 1.0 ST data using the oligo package.
- If the package is not automatically recognized, ensure the annotation slot of the ExpressionFeatureSet object matches "pd.equgene.1.0.st".
- Use the 'fid' column in the pmSequence data to map sequences back to specific probe locations on the chip.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)