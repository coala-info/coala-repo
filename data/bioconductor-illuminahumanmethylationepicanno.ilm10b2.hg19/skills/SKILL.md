---
name: bioconductor-illuminahumanmethylationepicanno.ilm10b2.hg19
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylationEPICanno.ilm10b2.hg19.html
---

# bioconductor-illuminahumanmethylationepicanno.ilm10b2.hg19

name: bioconductor-illuminahumanmethylationepicanno.ilm10b2.hg19
description: Access and use annotation data for the Illumina Human Methylation EPIC (850k) microarray (B2 manifest version, hg19 genome build). Use this skill when performing DNA methylation analysis in R (e.g., with minfi or missMethyl) to map CpG probes to genomic locations, SNPs, UCSC islands, and gene annotations.

# bioconductor-illuminahumanmethylationepicanno.ilm10b2.hg19

## Overview

This package provides the essential annotation data for the Illumina Human Methylation EPIC (850k) array, specifically based on the `MethylationEPIC_v-1-0_B2.csv` manifest and the hg19 (GRCh37) genome build. It is primarily used as a dependency for the `minfi` package to annotate `GenomicRatioSet` objects or to manually map probe IDs to genomic features.

Key components include:
- **Locations**: Genomic coordinates (chr, pos, strand).
- **Islands.UCSC**: Relation to CpG islands (Island, Shore, Shelf, OpenSea).
- **SNPs.CommonSingle**: Overlap with dbSNP variants (various versions) to identify potential probe bias.
- **Manifest**: Basic probe design information.

## Loading and Accessing Data

The package does not contain functions, but rather data objects of class `DataFrame` or `IlluminaMethylationAnnotation`.

```r
# Load the package
library(IlluminaHumanMethylationEPICanno.ilm10b2.hg19)

# List available data objects
data(package = "IlluminaHumanMethylationEPICanno.ilm10b2.hg19")

# Load specific annotation components
data(Locations)
data(Islands.UCSC)
data(Other)
data(Manifest)
```

## Common Workflows

### Using with minfi
The most common use case is providing the annotation name to `minfi` functions.

```r
# Set the annotation on a RGChannelSet
annotation(rgSet) <- c(array = "IlluminaHumanMethylationEPIC", 
                       annotation = "ilm10b2.hg19")

# Get annotation data from a GenomicRatioSet
ann <- getAnnotation(GRset)
```

### Filtering Probes by SNPs
To avoid methylation measurements being confounded by underlying genetic variation, use the `SNPs.CommonSingle` data.

```r
# Load SNP info (e.g., dbSNP 147)
data(SNPs.147CommonSingle)

# View columns: Probe_rs, Probe_maf, CpG_rs, CpG_maf, SBE_rs, SBE_maf
head(SNPs.147CommonSingle)

# Identify probes with a SNP at the CpG site with MAF > 0.01
snps <- SNPs.147CommonSingle
probes_to_exclude <- rownames(snps[!is.na(snps$CpG_maf) & snps$CpG_maf > 0.01, ])
```

### Mapping to UCSC Islands
```r
data(Islands.UCSC)
# 'Relation_to_Island' values: Island, N_Shore, S_Shore, N_Shelf, S_Shelf, OpenSea
table(Islands.UCSC$Relation_to_Island)
```

## Tips
- **Genome Build**: This package is strictly for **hg19**. If your analysis requires hg38, use the `.hg38` version of the annotation package.
- **Manifest Version**: Ensure your IDAT files correspond to the **B2** version of the EPIC manifest. If using the newer EPIC v2.0 array, this package is not compatible.
- **Memory**: Loading all data objects simultaneously can be memory-intensive. Only load the specific `data()` objects required for your filtering or annotation step.

## Reference documentation
- [Reference Manual](./references/reference_manual.md)