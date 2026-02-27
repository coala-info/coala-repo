---
name: bioconductor-tximportdata
description: This package provides sample transcript quantification data from various tools for testing and demonstrating the tximport R package. Use when user asks to access example quantification files, practice using tximport, or locate transcript-to-gene mapping files.
homepage: https://bioconductor.org/packages/release/data/experiment/html/tximportData.html
---


# bioconductor-tximportdata

name: bioconductor-tximportdata
description: Provides sample transcript quantification data from various tools (Salmon, Kallisto, RSEM, etc.) for testing and demonstrating the tximport R package. Use when a user needs example data to learn or test tximport workflows.

# bioconductor-tximportdata

## Overview

The `tximportData` package is a Bioconductor experiment data package. It does not contain analysis functions itself; instead, it provides a standardized set of output files from various transcript abundance quantifiers (such as Salmon, Kallisto, RSEM, and others) run on samples from the GEUVADIS project. Its primary purpose is to provide the necessary file paths and metadata for users to practice using the `tximport` package.

## Accessing the Data

To use the data in an R session, you must first locate the external data directory within the installed package.

```r
# Load the package
library(tximportData)

# Locate the external data directory
dir <- system.file("extdata", package="tximportData")

# List available quantifier directories and files
list.files(dir)
```

## Available Quantifier Outputs

The package includes output files in the following subdirectories of `extdata`:

*   `salmon`: Salmon quantification files (`quant.sf.gz`).
*   `kallisto`: Kallisto quantification files (`abundance.h5` or `abundance.tsv.gz`).
*   `rsem`: RSEM quantification files (`.genes.results.gz` and `.isoforms.results.gz`).
*   `alevin`: Salmon/Alevin single-cell output.
*   `cufflinks`: Cufflinks/Cuffnorm output tables.
*   `sailfish`: Sailfish quantification files.
*   `oarfish`: Oarfish long-read quantification files.

## Typical Workflow with tximport

The standard way to use this package is to construct file paths that are then passed to the `tximport()` function.

### 1. Load Sample Metadata
The package includes a `samples.txt` file describing the 6 GEUVADIS samples.

```r
samples <- read.table(file.path(dir, "samples.txt"), header=TRUE)
# View sample IDs and runs
head(samples)
```

### 2. Construct File Paths
Create a named vector of paths to the quantification files (e.g., for Salmon).

```r
files <- file.path(dir, "salmon", samples$run, "quant.sf.gz")
names(files) <- samples$run
```

### 3. Use Transcript-to-Gene Mappings
`tximport` often requires a mapping between transcript IDs and gene IDs. This package provides several CSV files for this purpose:

*   `tx2gene.csv`
*   `tx2gene.ensembl.v87.csv`
*   `tx2gene.gencode.v27.csv`

```r
tx2gene <- read.csv(file.path(dir, "tx2gene.gencode.v27.csv"))
```

### 4. Import Data
Once paths and mappings are ready, you can use `tximport` (from the `tximport` package).

```r
# library(tximport)
# txi <- tximport(files, type="salmon", tx2gene=tx2gene)
```

## Reference documentation

- [tximportData](./references/tximportData.md)