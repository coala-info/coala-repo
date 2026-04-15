---
name: bioconductor-illuminahumanmethylationepicanno.ilm10b4.hg19
description: This package provides annotation data for the Illumina Human Methylation EPIC microarray based on the B4 manifest and hg19 genome build. Use when user asks to map CpG probes to genomic locations, identify associated genes or CpG islands, and check for SNP overlaps in EPIC array data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICanno.ilm10b4.hg19.html
---

# bioconductor-illuminahumanmethylationepicanno.ilm10b4.hg19

name: bioconductor-illuminahumanmethylationepicanno.ilm10b4.hg19
description: Provides annotation data for the Illumina Human Methylation EPIC (850k) microarray based on the B4 manifest and hg19 genome build. Use this skill when analyzing EPIC array data in R (e.g., with minfi) to map CpG probes to genomic locations, SNPs, gene annotations, and UCSC islands.

# bioconductor-illuminahumanmethylationepicanno.ilm10b4.hg19

## Overview

This package is a Bioconductor annotation object for the Illumina HumanMethylationEPIC (EPIC) array. It is based on the `MethylationEPIC_v-1-0_B4.csv` manifest from Illumina and mapped to the hg19 (GRCh37) genome build. It provides essential metadata for CpG sites, including genomic coordinates, associated genes, CpG island status, and SNP overlaps.

## Loading and Using Annotation Data

The package is typically used as a dependency for high-level DNA methylation analysis packages like `minfi`.

### Basic Loading
To load the annotation object into your R session:
```r
library(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)

# View available data objects
data(package = "IlluminaHumanMethylationEPICanno.ilm10b4.hg19")
```

### Accessing Specific Annotation Components
The package contains several data objects that can be loaded individually to inspect probe metadata:

```r
# Genomic locations (Chr, pos, strand)
data(Locations)
head(Locations)

# CpG Island annotations (UCSC)
data(Islands.UCSC)
head(Islands.UCSC)

# Manifest information (Probe type, address, etc.)
data(Manifest)

# Other annotations (Gene symbols, groups)
data(Other)
```

### SNP Annotation
The package includes detailed SNP information to help identify probes that may be biased by underlying genetic variation.

```r
# Illumina's default SNP annotation
data(SNPs.Illumina)

# Common SNPs from various dbSNP versions (MAF > 1%)
# Options include: SNPs.132CommonSingle through SNPs.147CommonSingle
data(SNPs.147CommonSingle)
head(SNPs.147CommonSingle)
```
The SNP dataframes include:
- `Probe_rs` / `Probe_maf`: SNP in the probe body.
- `CpG_rs` / `CpG_maf`: SNP at the CpG site itself.
- `SBE_rs` / `SBE_maf`: SNP at the Single Base Extension site.

## Integration with minfi

This package is most commonly used when creating a `GenomicRatioSet` or when adding annotation to an `RGChannelSet`.

```r
library(minfi)

# If you have an RGChannelSet 'rgSet'
# minfi will often detect this package automatically if the manifest matches
annotation(rgSet) <- c(array = "IlluminaHumanMethylationEPIC", 
                       annotation = "ilm10b4.hg19")

# Get full annotation as a DataFrame
ann <- getAnnotation(IlluminaHumanMethylationEPICanno.ilm10b4.hg19)
```

## Tips
- **Genome Build**: This package is specifically for **hg19**. If your analysis requires hg38, ensure you use the appropriate liftover or a different annotation package.
- **OpenSea**: In the `Islands.UCSC` object, empty values from the original Illumina manifest have been converted to "OpenSea" for clarity.
- **Version B4**: Ensure your array manifest version matches "B4". Using the wrong manifest version (e.g., B2 or the newer EPIC v2.0) will result in probe mismatches.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)