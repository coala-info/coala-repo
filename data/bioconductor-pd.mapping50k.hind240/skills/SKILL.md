---
name: bioconductor-pd.mapping50k.hind240
description: This package provides annotation data and SQLite-based infrastructure for the Affymetrix GeneChip Mapping 50K Hind240 SNP array. Use when user asks to process Hind240 restriction fragment CEL files, perform SNPRMA preprocessing, or retrieve probe genomic coordinates for this specific platform.
homepage: https://bioconductor.org/packages/release/data/annotation/html/pd.mapping50k.hind240.html
---


# bioconductor-pd.mapping50k.hind240

name: bioconductor-pd.mapping50k.hind240
description: Annotation package for the Affymetrix GeneChip Mapping 50K Hind240 array. Use when processing SNP microarrays with the oligo package, specifically for Hind240 restriction fragment data.

# bioconductor-pd.mapping50k.hind240

## Overview
The `pd.mapping50k.hind240` package is a platform design (pd) annotation package for the Affymetrix Mapping 50K Hind240 SNP array. It provides the necessary SQLite-based infrastructure for the `oligo` package to correctly map probes to genomic locations, identify allele-specific probes, and perform preprocessing (like RMA or SNPRMA) on raw CEL files.

## Usage in R

### Loading the Package
This package is typically not called directly by the user but is loaded automatically by `oligo` when reading CEL files from the 50K Hind240 platform. However, it can be loaded manually:

```r
library(pd.mapping50k.hind240)
```

### Typical Workflow with oligo
The primary use case is providing the annotation backend for `read.celfiles`.

```r
library(oligo)
library(pd.mapping50k.hind240)

# 1. List CEL files
celFiles <- list.celfiles(full.names = TRUE)

# 2. Read CEL files (oligo will automatically detect and use this pd package)
rawData <- read.celfiles(celFiles)

# 3. Preprocessing (SNPRMA is standard for SNP arrays)
# This step uses the SQLite database in pd.mapping50k.hind240 to map probes
normData <- snprma(rawData)

# 4. Accessing platform metadata
# View the database connection and tables
db <- db(pd.mapping50k.hind240)
dbListTables(db)
```

### Accessing Annotation Data
You can query the underlying SQLite database to retrieve probe sequences or genomic coordinates:

```r
# Get probe information
pInfo <- getProbeInfo(pd.mapping50k.hind240)

# Get SNP-specific information (position, chromosome)
snpInfo <- getSnpInfo(pd.mapping50k.hind240)
```

## Tips
- **Memory Management**: SNP 50K arrays are large. Ensure you have sufficient RAM when running `snprma`.
- **Restriction Enzyme Specificity**: This package is specific to the **Hind240** enzyme. If you are working with the Xba130 set of the 50K pair, you must use `pd.mapping50k.xba130` instead.
- **Database Connection**: The package uses `RSQLite`. If you need custom annotations, you can query the `db` object directly using standard SQL via `DBI::dbGetQuery`.

## Reference documentation
- [pd.mapping50k.hind240 Reference Manual](./references/reference_manual.md)