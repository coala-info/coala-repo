---
name: bioconductor-snphooddata
description: This package provides example ChIP-Seq and genotype datasets for the SNPhood R package. Use when user asks to access example data for allele-specific binding analyses, explore molecular neighborhoods of SNPs, or run SNPhood vignette workflows.
homepage: https://bioconductor.org/packages/release/data/experiment/html/SNPhoodData.html
---


# bioconductor-snphooddata

name: bioconductor-snphooddata
description: Access and use the SNPhoodData experiment data package, which provides example datasets for the SNPhood R package. Use this skill when a user needs to perform allele-specific binding analyses, explore molecular neighborhoods of SNPs, or run the SNPhood vignette workflows using real-world ChIP-Seq and genotype data.

# bioconductor-snphooddata

## Overview

The `SNPhoodData` package is a Bioconductor experiment data package designed as a companion to the `SNPhood` package. It provides "real-world" datasets, including H3K27ac ChIP-Seq data for CEU population individuals (GM10847, GM12890) and corresponding genotype information from the 1000 Genomes Project. These datasets are primarily used to investigate how quantitative trait loci (QTLs) correlate with histone mark variations and to demonstrate allele-specific binding analysis.

## Loading the Data

Since `SNPhoodData` is a data-only package, its primary use is providing file paths to the raw data required by `SNPhood` functions.

```r
# Load the package
library(SNPhoodData)

# List files contained in the package to identify available datasets
list.files(system.file("extdata", package = "SNPhoodData"))
```

## Typical Workflow Integration

The data in this package is intended to be processed using the `SNPhood` package. A typical workflow involves identifying the paths to the BAM files (ChIP-Seq reads) and VCF files (genotypes) provided here.

### 1. Locating Example Files
Use `system.file` to retrieve the full paths to the example data:

```r
# Path to the SNP list (H3K27ac QTLs)
snp_file <- system.file("extdata", "SNPs.txt", package = "SNPhoodData")

# Path to genotype data (VCF)
vcf_file <- system.file("extdata", "genotypes.vcf.gz", package = "SNPhoodData")

# Path to ChIP-Seq BAM files
bam_files <- list.files(system.file("extdata", package = "SNPhoodData"), 
                        pattern = ".bam$", full.names = TRUE)
```

### 2. Using Data with SNPhood
Once the paths are identified, they are passed into `SNPhood` functions like `analyzeSNPs` or `collectData`.

```r
# Example of how this data is typically consumed (requires SNPhood)
# library(SNPhood)
# snphood_object <- analyzeSNPs(vcfFile = vcf_file, bamFiles = bam_files, ...)
```

## Dataset Contents

- **QTLs**: 14,000 previously identified H3K27ac QTLs from the YRI population.
- **ChIP-Seq Data**: H3K27ac signal for two CEU individuals (GM10847, GM12890), including two replicates each, mapped to personalized phased genomes.
- **Genotypes**: SNP genotypes for the corresponding individuals obtained from the 1000 Genomes Project.

## Tips
- This package does not contain complex functions; it is a container for data.
- Always use `system.file(..., package = "SNPhoodData")` to ensure your scripts are portable and can find the data regardless of the R library location.
- For the full analysis pipeline using these datasets, refer to the `SNPhood` package vignettes.

## Reference documentation
- [The SNPhoodData package](./references/SNPhoodData.md)