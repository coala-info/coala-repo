---
name: bioconductor-pd.vitis.vinifera
description: This package provides annotation and platform design information for the Affymetrix Vitis vinifera genome array. Use when user asks to process grapevine microarray data, map probe IDs to sequences, or manage platform-specific design information for the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.vitis.vinifera.html
---

# bioconductor-pd.vitis.vinifera

name: bioconductor-pd.vitis.vinifera
description: Annotation package for the Vitis vinifera (Grapevine) Affymetrix chip. Use when processing Vitis vinifera microarray data with the oligo package, specifically for mapping probe IDs to sequences and managing platform-specific design information.

# bioconductor-pd.vitis.vinifera

## Overview
The `pd.vitis.vinifera` package is a Bioconductor annotation data package specifically designed for the Affymetrix Vitis vinifera (Grape) genome array. It was built using `pdInfoBuilder` and serves as the infrastructure for the `oligo` package to correctly parse and process raw CEL files for this specific organism.

## Workflow and Usage

### Loading the Package
The package is typically loaded automatically when using `oligo` to read CEL files, but can be called directly:

```r
library(pd.vitis.vinifera)
```

### Integration with oligo
The primary use case is providing the platform design information required for preprocessing:

```r
library(oligo)
# When reading CEL files, oligo identifies the platform and uses this package
raw_data <- read.celfiles(filenames)
# The annotation slot will point to "pd.vitis.vinifera"
```

### Accessing Probe Sequences
The package contains sequence information for Perfect Match (PM) probes, as well as Mismatch (MM) and Background (BG) sequences if applicable to the array design.

```r
# Load the sequence data
data(pmSequence)

# View the structure (DataFrame with 'fid' and 'sequence' columns)
head(pmSequence)

# Access specific probe types if available
# data(mmSequence)
# data(bgSequence)
```

### Database Connection
The package maintains an SQLite database containing the mapping between features and probes.

```r
# Get the connection object
conn <- db(pd.vitis.vinifera)

# List tables in the annotation database
dbListTables(conn)

# Example: Querying the feature table
dbGetQuery(conn, "SELECT * FROM feature LIMIT 5")
```

## Tips
- **Memory Management**: This is a data-heavy package. Ensure sufficient RAM when loading large datasets in `oligo`.
- **Platform Matching**: This package is strictly for the Vitis vinifera chip. If using a different grapevine array (like a custom GeneChip), a different `pd` package or a custom one built with `pdInfoBuilder` may be required.
- **Dependency**: Always ensure the `oligo` package is installed, as `pd.vitis.vinifera` is designed to function as its backend.

## Reference documentation
- [pd.vitis.vinifera Reference Manual](./references/reference_manual.md)