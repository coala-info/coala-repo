---
name: bioconductor-pd.rcngene.1.1.st
description: This package provides annotation and platform design data for the Affymetrix rcngene.1.1.st microarray. Use when user asks to process CEL files, map probe identifiers to genomic locations, or access probe sequences for this specific chip using the oligo package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.rcngene.1.1.st.html
---


# bioconductor-pd.rcngene.1.1.st

name: bioconductor-pd.rcngene.1.1.st
description: Annotation package for the Affymetrix rcngene.1.1.st platform. Use when processing, normalizing, or annotating Gene ST (Sense Target) array data for this specific chip using the oligo or biomaRt packages.

# bioconductor-pd.rcngene.1.1.st

## Overview
The `pd.rcngene.1.1.st` package is a platform design (pd) annotation package for the Affymetrix rcngene.1.1.st array. It is primarily used as a backend for the `oligo` package to provide mapping between probe identifiers, sequences, and genomic locations during the analysis of expression microarrays.

## Typical Workflow

### Loading the Package
The package is usually loaded automatically when reading CEL files with `oligo`, but can be called directly:

```r
library(pd.rcngene.1.1.st)
```

### Integration with oligo
When analyzing .CEL files, `oligo` uses this package to understand the chip layout:

```r
library(oligo)
# Read CEL files in the current directory
raw_data <- read.celfiles(filenames = list.celfiles())

# The 'pd.rcngene.1.1.st' package provides the annotation 
# for 'raw_data' automatically if the chip type is correct.
```

### Accessing Probe Sequences
You can access the Perfect Match (PM) probe sequences stored within the package:

```r
# Load the sequence data
data(pmSequence)

# View the first few sequences
# The object is a DataFrame with 'fid' (feature ID) and 'sequence'
head(pmSequence)
```

### Database Interaction
The package contains an SQLite database mapping probes to features. You can interact with it using `RSQLite` or `DBI` if advanced mapping is required:

```r
# Get the connection to the internal database
con <- db(pd.rcngene.1.1.st)

# List tables (e.g., featureSet, pmfeature, mmfeature)
dbListTables(con)

# Example: Query the featureSet table
feature_info <- dbGetQuery(con, "SELECT * FROM featureSet LIMIT 10")
```

## Tips
- **Memory Management**: Annotation packages can be large. Ensure you have sufficient RAM when processing large batches of CEL files.
- **Compatibility**: This package is specifically designed for the `oligo` package. If you are using the older `affy` package, you would typically use a CDF-based environment instead.
- **Probe IDs**: Use the `fid` column to map sequences back to the intensities found in the `ExpressionFeatureSet` objects.

## Reference documentation
- [pd.rcngene.1.1.st Reference Manual](./references/reference_manual.md)