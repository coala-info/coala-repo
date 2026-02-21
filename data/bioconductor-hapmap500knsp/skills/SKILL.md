---
name: bioconductor-hapmap500knsp
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/hapmap500knsp.html
---

# bioconductor-hapmap500knsp

name: bioconductor-hapmap500knsp
description: Access and use the hapmap500knsp Bioconductor experiment data package. Use this skill when you need to load sample Affymetrix 500K Nsp SNP array data (CEL files) for demonstrating or testing Bioconductor tools like 'oligo'.

## Overview

The `hapmap500knsp` package is a Bioconductor ExperimentData package containing sample dataset files from the International HapMap Project. It specifically provides data for the Affymetrix 500K Nsp platform. This package is primarily intended for demonstration, testing, and vignette examples for high-density oligonucleotide array analysis tools.

## Loading the Data

The package does not contain R objects directly, but rather raw CEL files stored within the package installation directory. To use this data, you must locate the files and read them using a package like `oligo`.

### Locating CEL Files

To find the path to the sample CEL files included in the package:

```r
library(hapmap500knsp)
cel_path <- system.file("celFiles", package="hapmap500knsp")
list.files(cel_path)
```

### Typical Workflow with 'oligo'

The most common use case is reading these files into an `FeatureSet` object for analysis:

```r
library(oligo)
library(hapmap500knsp)

# 1. Get the full paths to the CEL files
cel_path <- system.file("celFiles", package="hapmap500knsp")
fns <- list.celfiles(path = cel_path, full.names = TRUE)

# 2. Read the CEL files
# Note: Using a temporary directory for caching is recommended for large data
temp_dir <- tempdir()
rawData <- read.celfiles(fns, tmpdir = temp_dir)

# 3. Inspect the object
show(rawData)
```

## Usage Tips

- **Purpose**: Remember that this is a subset of data meant for demonstration. It is not intended for biological inference but for software workflow validation.
- **Platform Specificity**: This package is specific to the **Nsp** enzyme portion of the 500K set. If you are looking for the Sty portion, you likely need the `hapmap500ksty` package.
- **Dependencies**: While `hapmap500knsp` contains the data, you will almost always need the `oligo` package to actually process the CEL files.

## Reference documentation

- [hapmap500knsp Reference Manual](./references/reference_manual.md)