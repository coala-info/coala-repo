---
name: bioconductor-chipexoqualexample
description: ChIPexoQualExample provides subsetted ChIP-exo data for demonstrating the functionality of the ChIPexoQual quality control package. Use when user asks to access example ChIP-exo BAM files, test quality control pipelines, or run demonstrations for the ChIPexoQual package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/ChIPexoQualExample.html
---


# bioconductor-chipexoqualexample

## Overview

ChIPexoQualExample is a data-only experiment package providing subsetted ChIP-exo data. It contains aligned reads (BAM files) for FoxA1 in mouse liver (replicates 1, 2, and 3), restricted to chromosome 1. This package is primarily used to demonstrate the functionality of the `ChIPexoQual` quality control package.

## Data Access and Usage

### Loading the Package

Load the package to make the data available in the R session:

```r
library(ChIPexoQualExample)
```

### Locating Example Files

The raw BAM files and their indices are stored in the `extdata` directory of the package. Use `system.file` to retrieve the absolute paths for use in downstream analysis:

```r
# List all files in the extdata directory
extdata_path <- system.file("extdata", package = "ChIPexoQualExample")
list.files(extdata_path)

# Get the path to a specific BAM file
bam_file <- system.file("extdata", "ChIPexo_carroll_FoxA1_mouse_rep1_chr1.bam", 
                        package = "ChIPexoQualExample")
```

### Typical Workflow with ChIPexoQual

Use these files as input for `ChIPexoQual` functions to test quality control pipelines:

```r
library(ChIPexoQual)

# Example: Creating a ChIPexoQual object using the example BAM
# Note: This requires the ChIPexoQual package to be installed
# bcc <- create_exo_experiment(bam_file, ...)
```

## Reference documentation

- [ChIPexoQualExample: Accompanying example data for ChIPexoQual](./references/vignette.md)