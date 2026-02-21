---
name: bioconductor-illuminahumanmethylation450kmanifest
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation450kmanifest.html
---

# bioconductor-illuminahumanmethylation450kmanifest

name: bioconductor-illuminahumanmethylation450kmanifest
description: Provides the manifest object for the Illumina HumanMethylation450 (450k) microarray. Use this skill when working with DNA methylation data from the 450k platform in R, specifically when using the minfi package or other Bioconductor tools that require the array design, probe annotations, and control probe information to process IDAT files or create MethylSet/GenomicRatioSet objects.

# bioconductor-illuminahumanmethylation450kmanifest

## Overview

The `IlluminaHumanMethylation450kmanifest` package is a data annotation package providing the design specifications for the Illumina HumanMethylation450 BeadChip. It contains the `IlluminaMethylationManifest` object required by the `minfi` package to map intensities to genomic locations and probe types (Infinium I vs. Infinium II). This package is essential for the preprocessing and normalization of 450k methylation data.

## Usage and Workflows

### Loading the Manifest
The manifest is typically loaded automatically by high-level functions in `minfi`, but it can be accessed manually:

```r
library(IlluminaHumanMethylation450kmanifest)
data(IlluminaHumanMethylation450kmanifest)

# View the object
IlluminaHumanMethylation450kmanifest
```

### Integration with minfi
The primary use case for this package is during the creation of a `RGChannelSet` or when converting raw data to a `MethylSet`.

```r
library(minfi)

# When reading IDAT files, minfi identifies the array type
# and looks for this manifest package automatically.
rgSet <- read.metharray.exp(base = "path/to/idat/files")

# To check the manifest associated with an object:
getManifest(rgSet)
```

### Accessing Probe Information
You can extract specific probe information (Type I, Type II, Control, or SNP probes) from the manifest object using `minfi` accessor functions:

```r
# Get probe names and types
manifest <- getManifest(IlluminaHumanMethylation450kmanifest)

# Get Type I probes (using two color channels)
getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "I")

# Get Type II probes (using a single color channel)
getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "II")

# Get Control probes
getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "Control")
```

## Tips
- **Automatic Loading**: You rarely need to call `data()` explicitly. If you have an `RGChannelSet` from a 450k array, `minfi` functions like `preprocessRaw()` or `preprocessQuantile()` will utilize this package in the background.
- **Version Consistency**: This manifest is based on the "HumanMethylation450_15017482_v.1.2.csv" design file. Ensure your sample sheets match this version if you encounter mapping errors.
- **Annotation vs. Manifest**: Do not confuse this package with `IlluminaHumanMethylation450kanno.ilmn12.hg19`. The *manifest* defines the physical array design (probes/addresses), while the *annotation* provides genomic coordinates and gene mappings.

## Reference documentation

- [IlluminaHumanMethylation450kmanifest Reference Manual](./references/reference_manual.md)