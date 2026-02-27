---
name: bioconductor-pd.mirna.2.0
description: This package provides annotation data and platform design information for the Affymetrix miRNA 2.0 Array. Use when user asks to preprocess raw CEL files from miRNA 2.0 arrays, retrieve probe sequences, or map feature identifiers to sequences using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mirna.2.0.html
---


# bioconductor-pd.mirna.2.0

name: bioconductor-pd.mirna.2.0
description: Annotation data for the Affymetrix miRNA 2.0 Array. Use when processing or analyzing miRNA expression data from this specific platform, typically in conjunction with the oligo package for low-level analysis, probe sequence retrieval, or feature-level annotation.

# bioconductor-pd.mirna.2.0

## Overview
The `pd.mirna.2.0` package is a Bioconductor annotation resource built using `pdInfoBuilder`. It provides the platform design information required to analyze Affymetrix miRNA 2.0 arrays. It is primarily designed to work as a backend for the `oligo` package, enabling the preprocessing of raw CEL files and the mapping of probe identifiers to sequences.

## Usage and Workflows

### Integration with oligo
This package is rarely called directly for analysis. Instead, the `oligo` package detects the array type from the CEL file headers and loads `pd.mirna.2.0` automatically.

```r
library(oligo)
# When reading CEL files from miRNA 2.0 arrays, this package is utilized:
raw_data <- read.celfiles(filenames)
```

### Accessing Probe Sequences
You can manually load and inspect the Perfect Match (PM) probe sequences contained within the package. This is useful for custom sequence analysis or validation.

```r
library(pd.mirna.2.0)

# Load the PM sequence data
data(pmSequence)

# View the structure (contains 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific sequences by feature ID
# pmSequence is a DataFrame object
```

### Key Data Objects
- **pmSequence**: A `DataFrame` containing the sequences for Perfect Match probes. It includes the feature identifier (`fid`) and the actual nucleotide `sequence`.
- **bgSequence**: Background probe sequences (if applicable to the specific platform build).
- **mmSequence**: Mismatch probe sequences (if applicable).

## Tips
- Ensure this package is installed when using `oligo` to process miRNA 2.0 data, otherwise `read.celfiles` will throw an error regarding missing platform design information.
- The package is a "data-only" package; it does not contain complex analytical functions but provides the SQLite database schema required for probe-to-gene mapping.

## Reference documentation
- [pd.mirna.2.0 Reference Manual](./references/reference_manual.md)