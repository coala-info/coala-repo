---
name: bioconductor-pd.mapping50k.xba240
description: This package provides annotation and platform design information for the Affymetrix Mapping 50K Xba240 SNP array. Use when user asks to process raw .CEL files, perform SNP genotyping, or conduct copy number analysis for the Xba240 microarray using the oligo or crlmm packages.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mapping50k.xba240.html
---


# bioconductor-pd.mapping50k.xba240

name: bioconductor-pd.mapping50k.xba240
description: Annotation and platform design information for the Affymetrix Mapping 50K Xba240 SNP array. Use when processing Affymetrix 50K Xba240 microarray data, performing SNP genotyping, or conducting copy number analysis using the oligo or crlmm packages.

# bioconductor-pd.mapping50k.xba240

## Overview

The `pd.mapping50k.xba240` package is a Bioconductor annotation package (Platform Design) for the Affymetrix Mapping 50K Xba240 SNP array. It was built using the `pdInfoBuilder` package and provides the necessary metadata, probe sequences, and genomic coordinates required to process raw intensity data (.CEL files).

This package is primarily a dependency for high-level analysis packages like `oligo` and `crlmm`. It is not typically used for direct function calls but must be installed for the analysis software to recognize and correctly map the probes on the Xba240 chip.

## Usage in R

### Loading the Package

While usually loaded automatically by analysis functions, you can load it manually to verify installation:

```r
library(pd.mapping50k.xba240)
```

### Typical Workflow with oligo

The most common use case is reading .CEL files. The `oligo` package detects the chip type and looks for this annotation package.

```r
library(oligo)

# List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# Read CEL files - the pd.mapping50k.xba240 package is used here automatically
rawData <- read.celfiles(celFiles)

# Summarize and normalize (e.g., using RMA)
featureData <- rma(rawData)
```

### SNP Genotyping with crlmm

For SNP calling, the `crlmm` package utilizes the platform design information provided by this package.

```r
library(crlmm)

# Perform genotype calling
# Ensure you have the corresponding CEL files for the Xba240 array
genotypes <- crlmm(celFiles)
```

### Accessing Platform Metadata

You can inspect the platform design object directly if needed:

```r
# Get the SQLite database connection for the platform
conn <- db(pd.mapping50k.xba240)

# List tables in the annotation database
dbListTables(conn)

# Example: View probe information
dbGetQuery(conn, "SELECT * FROM featureSet LIMIT 10")
```

## Tips

- **Installation**: Ensure the package is installed via BiocManager: `BiocManager::install("pd.mapping50k.xba240")`.
- **Memory Management**: SNP arrays like the 50K Xba240 generate large datasets. Ensure sufficient RAM is available when reading multiple CEL files.
- **Compatibility**: This package is specific to the Xba240 chip. If you are using the Hind240 chip (the other half of the 100K set), you will need `pd.mapping50k.hind240`.

## Reference documentation

- [pd.mapping50k.xba240 Reference Manual](./references/reference_manual.md)