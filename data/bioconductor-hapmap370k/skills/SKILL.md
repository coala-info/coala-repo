---
name: bioconductor-hapmap370k
description: This package provides example HapMap dataset files from the Illumina 370k platform for demonstration and testing purposes. Use when user asks to access raw Illumina IDAT files, demonstrate genotyping workflows, or benchmark copy number analysis tools like crlmm.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hapmap370k.html
---


# bioconductor-hapmap370k

name: bioconductor-hapmap370k
description: Provides access to an example HapMap dataset from the Illumina 370k platform. Use this skill when demonstrating, testing, or benchmarking Bioconductor genotyping and copy number analysis tools (such as crlmm) that require raw Illumina IDAT files.

# bioconductor-hapmap370k

## Overview
The `hapmap370k` package is a data-only package providing a subset of HapMap data generated on the Illumina 370k BeadChip platform. These samples were processed at the Center for Inherited Disease Research (CIDR). The package is intended strictly for demonstration and documentation purposes, allowing users to practice workflows for processing raw microarray data without needing to source their own large datasets.

## Data Access and Workflow
The primary utility of this package is providing the file path to raw `.idat` files, which can then be processed by packages like `crlmm`.

### Locating Raw IDAT Files
To use the data in an analysis pipeline, locate the directory containing the raw files using `system.file`:

```r
library(hapmap370k)
idat_path <- system.file("idatFiles", package="hapmap370k")
list.files(idat_path)
```

### Typical Workflow with crlmm
The most common use case is demonstrating the `readIdatFiles` function from the `crlmm` package:

```r
library(crlmm)
library(hapmap370k)

# Define path to raw data
the.path <- system.file("idatFiles", package="hapmap370k")

# Read the IDAT files into an RGset-like object
# Note: This requires the crlmm package to be installed
RG <- readIdatFiles(path = the.path)
```

## Key Considerations
- **Data Accuracy**: The data is provided "as-is" for software demonstration. It should not be used for biological inference or as a gold standard for HapMap genotypes.
- **Dependencies**: While the package itself contains data, you will almost always need a processing package (like `crlmm` or `beadarray`) to do anything useful with the files.
- **Platform Specificity**: This data is specific to the Illumina 370k platform. Ensure that any annotation packages or CDFs used in conjunction with this data match this specific array version.

## Reference documentation
- [hapmap370k Reference Manual](./references/reference_manual.md)