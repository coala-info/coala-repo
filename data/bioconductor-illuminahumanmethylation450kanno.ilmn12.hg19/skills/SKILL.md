---
name: bioconductor-illuminahumanmethylation450kanno.ilmn12.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation450kanno.ilmn12.hg19.html
---

# bioconductor-illuminahumanmethylation450kanno.ilmn12.hg19

## Overview

This package is an annotation data package for the Illumina HumanMethylation450k DNA methylation microarray. It is based on Illumina's v1.2 annotation (hg19) and is primarily used as a dependency for the `minfi` package to map probe IDs to genomic coordinates, CpG islands, and SNP information.

## Loading and Accessing Data

The package contains several `DataFrame` objects that can be loaded using the `data()` function.

```r
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)

# Load the main annotation object
data("IlluminaHumanMethylation450kanno.ilmn12.hg19")

# Load specific components
data(Locations)      # Genomic coordinates (hg19)
data(Islands.UCSC)   # Relation to CpG Islands (e.g., Shore, Shelf, OpenSea)
data(Manifest)       # Probe design metadata
data(Other)          # Additional Illumina annotations (e.g., Gene names)
data(SNPs.Illumina)  # SNPs identified by Illumina
```

## Working with SNP Information

A key feature of this package is the inclusion of updated SNP information from various dbSNP versions (132 through 147). These are used to identify probes that may be biased by underlying genetic variation.

```r
# Load a specific dbSNP version (e.g., version 147)
data(SNPs.147CommonSingle)

# The SNP dataframes contain:
# - Probe_rs / Probe_maf: SNP in the probe body
# - CpG_rs / CpG_maf: SNP at the CpG site
# - SBE_rs / SBE_maf: SNP at the Single Base Extension site
```

## Integration with minfi

In most workflows, you do not call these data objects directly. Instead, you specify the annotation when creating or processing a `GenomicRatioSet` or `MethylSet`.

```r
# Example: Setting the annotation on a minfi object
# annotation(myMethylSet) <- c(array = "IlluminaHumanMethylation450k", 
#                             annotation = "ilmn12.hg19")

# To get the full annotation table via minfi:
# ann <- getAnnotation(IlluminaHumanMethylation450kanno.ilmn12.hg19)
```

## Tips
- **OpenSea**: In the `Islands.UCSC` object, empty values from the original Illumina source have been converted to "OpenSea" for clarity.
- **Genome Build**: This package is strictly for **hg19**. If your data is mapped to hg38, you must use a different annotation package.
- **SNP Filtering**: When using `minfi::dropLociWithSnps()`, this package provides the underlying data to determine which probes to drop based on MAF (Minor Allele Frequency).

## Reference documentation
- [IlluminaHumanMethylation450kanno.ilmn12.hg19 Reference Manual](./references/reference_manual.md)