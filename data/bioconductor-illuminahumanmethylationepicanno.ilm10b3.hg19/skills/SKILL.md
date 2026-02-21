---
name: bioconductor-illuminahumanmethylationepicanno.ilm10b3.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICanno.ilm10b3.hg19.html
---

# bioconductor-illuminahumanmethylationepicanno.ilm10b3.hg19

## Overview
This package is a Bioconductor annotation object for the Illumina HumanMethylationEPIC (EPIC) platform. It contains the manifest information required to map probe IDs (cg numbers) to genomic coordinates (hg19), gene symbols, and CpG island contexts. It also includes extensive SNP annotation from various dbSNP versions (132 through 147) to help researchers identify potential biases in methylation measurements caused by underlying genetic variants.

## Loading Annotation Data
The package is typically used in conjunction with the `minfi` package, but data components can be loaded directly using the `data()` function.

```r
library(IlluminaHumanMethylationEPICanno.ilm10b3.hg19)

# Load the primary annotation object
data("IlluminaHumanMethylationEPICanno.ilm10b3.hg19")

# Load specific data components
data(Locations)      # Genomic coordinates (chr, pos, strand)
data(Islands.UCSC)   # Relation to CpG Islands (Island, Shore, Shelf, OpenSea)
data(Other)          # Gene annotations (UCSC_RefGene_Name, Group, etc.)
data(Manifest)       # Probe design metadata
data(SNPs.Illumina)  # SNPs identified by Illumina
```

## Working with SNP Annotations
A key feature of this package is the inclusion of multiple dbSNP versions to identify variants overlapping the probe, the CpG site, or the Single Base Extension (SBE) site.

```r
# Load a specific dbSNP version (e.g., version 147)
data(SNPs.147CommonSingle)

# The resulting DataFrame contains:
# Probe_rs / Probe_maf: SNP in the probe sequence
# CpG_rs / CpG_maf: SNP at the CpG site
# SBE_rs / SBE_maf: SNP at the single base extension site

# Example: Filter for probes with a high MAF at the CpG site
high_maf_probes <- SNPs.147CommonSingle[which(SNPs.147CommonSingle$CpG_maf > 0.05), ]
```

## Integration with minfi
When using `minfi` for EPIC array analysis, this package is often specified in the `RGChannelSet` or used to annotate a `GenomicRatioSet`.

```r
# If you have a minfi object 'mset'
library(minfi)
annotation(mset) <- c(array = "IlluminaHumanMethylationEPIC", 
                      annotation = "ilm10b3.hg19")

# Get full annotation table
ann <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b3.hg19)
```

## Key Data Structures
- **Locations**: Contains `chr` and `pos` for hg19.
- **Islands.UCSC**: Contains `Relation_to_Island` (e.g., "Island", "S_Shore", "N_Shelf", "OpenSea").
- **Other**: Contains `UCSC_RefGene_Name` (gene symbols) and `UCSC_RefGene_Group` (e.g., TSS1500, Body, 5'UTR).

## Reference documentation
- [IlluminaHumanMethylationEPICanno.ilm10b3.hg19 Reference Manual](./references/reference_manual.md)