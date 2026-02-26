---
name: bioconductor-human1mduov3bcrlmm
description: This package provides data and annotation support for the Illumina 1M Duo v3b array within the crlmm framework. Use when user asks to perform genotype calling, copy number analysis, or preprocessing of Illumina 1M Duo v3b SNP array data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/human1mduov3bCrlmm.html
---


# bioconductor-human1mduov3bcrlmm

name: bioconductor-human1mduov3bcrlmm
description: Provides data and annotation support for the Illumina 1M Duo v3b array. Use this skill when performing genotype calling, copy number analysis, or preprocessing of Illumina 1M Duo v3b SNP array data using the crlmm package.

# bioconductor-human1mduov3bcrlmm

## Overview

The `human1mduov3bCrlmm` package is a specialized data annotation package for the Bioconductor `crlmm` (Corrected Robust Linear Model with Maximum likelihood) infrastructure. It contains the specific metadata, probe sequences, and reference distributions required to process Illumina 1M Duo v3b arrays. This package is primarily intended for internal use by `crlmm` functions rather than direct manual manipulation.

## Usage in R

### Loading the Package

To ensure the annotation data is available for your analysis:

```r
library(human1mduov3bCrlmm)
```

### Integration with crlmm

The most common workflow involves passing the package name or allowing `crlmm` to detect it automatically when processing IDAT files or CEL files (though this specific package is for Illumina).

```r
library(crlmm)

# Example: Genotype calling for Illumina 1M Duo v3b
# The crlmm function will look for this package based on the array type
# specified in the samplesheet or IDAT metadata.
result <- crlmmIllumina(filenames = myIdatFiles, 
                        arrayNames = "human1mduov3b")
```

### Accessing Internal Data

While the package is designed for internal use, you can explore the data objects it provides:

```r
# List objects in the package
ls("package:human1mduov3bCrlmm")
```

## Workflow Tips

1.  **Automatic Detection**: You do not usually need to call functions from this package directly. When you run `crlmmIllumina`, the `crlmm` engine identifies the array type and loads `human1mduov3bCrlmm` to retrieve the necessary normalization constants and SNP locations.
2.  **Dependency**: Ensure that the `crlmm` package is installed alongside this data package, as this package contains only the data and not the processing algorithms.
3.  **Memory Management**: These data packages can be large. If working with many samples, ensure your R session has sufficient RAM to hold the annotation metadata.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)