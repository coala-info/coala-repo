---
name: bioconductor-h5vcdata
description: This package provides example datasets, including HDF5 tally files and BAM files, for testing and demonstrating the h5vc package. Use when user asks to access example variant call data, locate sample HDF5 tally files, or retrieve BAM files for the NRAS and DNMT3A loci.
homepage: https://bioconductor.org/packages/release/data/experiment/html/h5vcData.html
---


# bioconductor-h5vcdata

name: bioconductor-h5vcdata
description: Access and use example data for the h5vc package, including HDF5 tally files, BAM files for NRAS and DNMT3A loci, and example variant call data frames. Use this skill when demonstrating or testing the h5vc package's variant calling and tallying capabilities.

# bioconductor-h5vcdata

## Overview

The `h5vcData` package is a dedicated data experiment package providing the necessary datasets for the `h5vc` package vignettes and examples. It contains HDF5-formatted tally files, BAM files covering specific loci (NRAS and DNMT3A) for AML and control samples, and pre-computed variant call objects.

## Data Access and Usage

### Loading Example Variant Calls
The package includes a pre-defined data frame of variant calls used in `h5vc` demonstrations.

```r
library(h5vcData)
data("example.variants", package = "h5vcData")
head(variantCalls)
```

### Locating External Data Files
Many functions in the `h5vc` package require paths to HDF5 or BAM files. Use `system.file` to retrieve the absolute paths to these resources within the `h5vcData` installation.

**HDF5 Tally File:**
```r
tallyFile <- system.file("extdata", "example.tally.hfs5", package = "h5vcData")
```

**BAM Files (NRAS Locus):**
```r
caseBam <- system.file("extdata", "NRAS.AML.bam", package = "h5vcData")
controlBam <- system.file("extdata", "NRAS.Control.bam", package = "h5vcData")
```

**BAM Files (DNMT3A Locus):**
The package contains 6 pairs of cancer/control BAM files for the DNMT3A locus, named using the `Pt*` prefix.

### Available Resources in `inst/extdata`
- `example.tally.hfs5`: The primary HDF5 tally file for testing.
- `NRAS.AML.bam` / `NRAS.Control.bam`: BAM files for the NRAS locus.
- `Pt*bam`: Multiple BAM files for the DNMT3A locus across different patients.
- Corresponding `.bai` index files are provided for all BAM files.

## Typical Workflow with h5vc
1. Load `h5vcData` to get file paths.
2. Pass these paths to `h5vc` functions like `h5readBlock` or `tallyReads`.
3. Use the `variantCalls` data frame to test filtering or visualization functions in `h5vc`.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)