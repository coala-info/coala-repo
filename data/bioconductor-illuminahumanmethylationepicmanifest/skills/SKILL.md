---
name: bioconductor-illuminahumanmethylationepicmanifest
description: This package provides the manifest object containing design metadata for the Illumina HumanMethylationEPIC v1.0 microarray. Use when user asks to process EPIC beadchip data, map methylation probes to genomic locations, or initialize GenomicRatioSet objects using the minfi package.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICmanifest.html
---


# bioconductor-illuminahumanmethylationepicmanifest

name: bioconductor-illuminahumanmethylationepicmanifest
description: Provides the manifest object for the Illumina HumanMethylationEPIC (845k) microarray. Use this skill when analyzing EPIC v1.0 methylation data in R, specifically when using the minfi package to map probes to genomic locations, identify probe types (Infinium I vs II), or initialize GenomicRatioSet objects.

# bioconductor-illuminahumanmethylationepicmanifest

## Overview
The `IlluminaHumanMethylationEPICmanifest` package is a data annotation package for Bioconductor. It contains the `IlluminaMethylationManifest` object required to process and analyze Illumina Infinium MethylationEPIC beadchip data. This manifest is based on the v1.0b2 version of the Illumina design and is primarily used as a dependency for the `minfi` package.

## Usage and Workflows

### Loading the Manifest
The manifest object is loaded into the R environment using the `data()` function.

```r
library(IlluminaHumanMethylationEPICmanifest)
data(IlluminaHumanMethylationEPICmanifest)

# View the object
IlluminaHumanMethylationEPICmanifest
```

### Integration with minfi
This package is rarely used in isolation. It is typically called automatically by `minfi` when reading IDAT files or converting `RGChannelSet` objects to `MethylSet` or `GenomicRatioSet` objects.

If you need to manually associate a raw data object with this manifest:

```r
library(minfi)
# Assuming 'rgSet' is an RGChannelSet object
annotation(rgSet) <- c(array = "IlluminaHumanMethylationEPIC", annotation = "ilm10b2.hg19")
```

### Accessing Manifest Details
The object belongs to the `IlluminaMethylationManifest` class. You can inspect the probe designs (Infinium I, Infinium II, Control, and OOB probes) using accessors from the `minfi` package:

```r
# Get probe information
getManifestInfo(IlluminaHumanMethylationEPICmanifest, type = "locusNames")

# Get specific design tables
getProbeInfo(IlluminaHumanMethylationEPICmanifest, type = "I")
getProbeInfo(IlluminaHumanMethylationEPICmanifest, type = "II")
getProbeInfo(IlluminaHumanMethylationEPICmanifest, type = "Control")
```

## Tips
- **Version Specificity**: This manifest is for the **EPIC v1.0 (B2)** array. If you are working with the newer **EPIC v2.0** array, you must use the `IlluminaHumanMethylationEPICv2manifest` package instead, as the probe IDs and locations differ significantly.
- **Memory**: The manifest object is relatively lightweight as it contains design metadata rather than per-sample data.
- **Dependency**: Ensure `minfi` is installed to properly interact with the manifest object structure.

## Reference documentation
- [IlluminaHumanMethylationEPICmanifest Reference Manual](./references/reference_manual.md)