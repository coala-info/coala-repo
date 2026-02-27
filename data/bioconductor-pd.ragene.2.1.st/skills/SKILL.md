---
name: bioconductor-pd.ragene.2.1.st
description: This package provides annotation and platform design data for the Affymetrix Rat Gene 2.1 ST microarray. Use when user asks to process Rat Gene 2.1 ST CEL files using the oligo package, perform platform-specific normalization, or retrieve probe sequences for this array.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.ragene.2.1.st.html
---


# bioconductor-pd.ragene.2.1.st

name: bioconductor-pd.ragene.2.1.st
description: Annotation package for the Affymetrix Rat Gene 2.1 ST array. Use when processing Rat Gene 2.1 ST CEL files using the oligo package, performing platform-specific background correction, normalization, or retrieving probe sequences for this specific microarray platform.

# bioconductor-pd.ragene.2.1.st

## Overview
The `pd.ragene.2.1.st` package is a Bioconductor annotation package (Platform Design or "pd" package) specifically for the Affymetrix Rat Gene 2.1 ST array. It provides the necessary mapping between probe identifiers and their physical locations on the chip. This package is primarily used as a backend dependency for the `oligo` package to enable the processing of .CEL files.

## Usage in R

### Loading the Package
While you can load the package directly, it is typically loaded automatically by the `oligo` package when reading CEL files from this platform.

```r
library(pd.ragene.2.1.st)
```

### Integration with oligo
When analyzing Rat Gene 2.1 ST data, the `oligo` package uses this package to create a FeatureSet object.

```r
library(oligo)

# Read CEL files (the pd package is detected and used automatically)
celFiles <- list.celfiles(full.names = TRUE)
rawData <- read.celfiles(celFiles)

# The 'annotation' slot of the resulting object will be "pd.ragene.2.1.st"
print(annotation(rawData))
```

### Accessing Probe Sequences
The package contains sequence information for the Perfect Match (PM) probes on the array. This is useful for custom sequence-specific analysis or GC-content calculations.

```r
# Load the probe sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Example: Get the sequence for a specific feature ID
# pmSequence is a DataFrame object
specific_probe <- pmSequence[pmSequence$fid == 12345, ]
```

### Key Data Objects
- `pmSequence`: A `DataFrame` containing the sequences for PM probes. It has two columns: `fid` (feature ID) and `sequence` (the actual nucleotide sequence).
- `bgSequence`: Sequence data for background probes (if applicable).
- `mmSequence`: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Automatic Detection**: You do not usually need to call functions within this package directly. Ensure it is installed so that `oligo::read.celfiles()` can find it.
- **Memory**: These annotation objects can be large; ensure your R session has sufficient memory when working with large feature sets.
- **Platform Specificity**: This package is strictly for the "2.1 ST" version of the Rat Gene array. Using it with other versions (like 1.0 ST or 1.1 ST) will result in incorrect mappings.

## Reference documentation
- [pd.ragene.2.1.st Reference Manual](./references/reference_manual.md)