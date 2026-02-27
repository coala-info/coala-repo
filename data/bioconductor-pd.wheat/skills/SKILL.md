---
name: bioconductor-pd.wheat
description: This package provides platform design annotation data for the Affymetrix Wheat Genome Array. Use when user asks to process wheat microarray data, map probe identifiers to sequences, or manage chip layout information using the oligo or eeR packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.wheat.html
---


# bioconductor-pd.wheat

name: bioconductor-pd.wheat
description: Annotation data package for the Affymetrix Wheat Genome Array. Use when processing wheat microarray data with the 'oligo' or 'eeR' packages, specifically for mapping probe identifiers to sequences and managing chip layout information.

# bioconductor-pd.wheat

## Overview
The `pd.wheat` package is a platform design (PD) annotation package for the Affymetrix Wheat Genome Array. It is built using the `pdInfoBuilder` infrastructure and is designed to work seamlessly with the `oligo` package to provide the necessary metadata for preprocessing, normalization, and analysis of wheat expression microarrays.

## Typical Workflow

### Loading the Package
To use the annotation data, load the package alongside the `oligo` library:

```r
library(oligo)
library(pd.wheat)
```

### Using with Expression Data
When reading CEL files, the `oligo` package automatically detects and uses `pd.wheat` if the CEL files originate from the Wheat Genome Array:

```r
# Read CEL files in the current directory
affyData <- read.celfiles()

# The platform design information is automatically linked
show(affyData)
```

### Accessing Probe Sequences
You can manually load and inspect the Perfect Match (PM) probe sequences stored within the package:

```r
# Load the sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID
# Example: Get sequence for feature ID 1
pmSequence[pmSequence$fid == 1, ]
```

## Key Data Objects
- **pd.wheat**: The main annotation object containing the SQLite database mapping probes to locations and gene identifiers.
- **pmSequence**: A `DataFrame` containing the sequences for PM probes.
- **bgSequence**: Sequence data for background probes (if applicable).
- **mmSequence**: Sequence data for Mismatch (MM) probes (if applicable).

## Tips
- **Memory Management**: This package uses an SQLite backend. Ensure you have sufficient disk space in your R temporary directory for database operations.
- **Integration**: This package is primarily a backend provider. Most users will interact with it indirectly through `oligo` functions like `rma()`, `backgroundCorrect()`, or `summarize()`.
- **Verification**: To verify the package is correctly mapped to your data, check `annotation(affyData)`. It should return `"pd.wheat"`.

## Reference documentation
- [pd.wheat Reference Manual](./references/reference_manual.md)