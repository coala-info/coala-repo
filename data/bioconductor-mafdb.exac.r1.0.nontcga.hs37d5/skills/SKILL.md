---
name: bioconductor-mafdb.exac.r1.0.nontcga.hs37d5
description: This package provides minor allele frequency data from the ExAC release 1.0 excluding TCGA samples for the hs37d5 human reference genome. Use when user asks to query population-specific allele frequencies, filter genetic variants by frequency, or access non-cancer germline variation data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/MafDb.ExAC.r1.0.nonTCGA.hs37d5.html
---

# bioconductor-mafdb.exac.r1.0.nontcga.hs37d5

name: bioconductor-mafdb.exac.r1.0.nontcga.hs37d5
description: Annotation package for Minor Allele Frequency (MAF) data from the Exome Aggregation Consortium (ExAC) release 1.0, excluding TCGA samples, for the hs37d5 (GRCh37) human reference genome. Use this skill to query population-specific allele frequencies for genetic variants using GScores objects and the GenomicScores framework.

# bioconductor-mafdb.exac.r1.0.nontcga.hs37d5

## Overview

The `MafDb.ExAC.r1.0.nonTCGA.hs37d5` package provides access to MAF data from over 60,000 exomes, specifically filtered to exclude samples from The Cancer Genome Atlas (TCGA). This makes it ideal for germline variation analysis where somatic contamination or cancer-specific cohorts should be avoided. Data is stored as a `GScores` object, which is memory-efficient as it loads specific chromosomes and populations only upon query.

Note on precision: To save space, MAF values $\ge 0.1$ use two significant digits, while values $< 0.1$ use one significant digit.

## Basic Usage

### Loading the Package and Object
The data object is named identically to the package.

```r
library(MafDb.ExAC.r1.0.nonTCGA.hs37d5)

# Assign to a shorter variable for convenience
mafdb <- MafDb.ExAC.r1.0.nonTCGA.hs37d5
mafdb
```

### Checking Available Populations
ExAC data includes several global populations. Use `populations()` to see the available identifiers (e.g., AF, AF_AFR, AF_AMR, AF_EAS, AF_FIN, AF_NFE, AF_OTH, AF_SAS).

```r
populations(mafdb)
```

### Querying Allele Frequencies
Use the `gscores()` function from the `GenomicScores` package. You can query using `GRanges` objects or specific genomic coordinates.

```r
library(GenomicScores)

# Query by genomic coordinates (Reference: hs37d5/GRCh37)
# Example: A SNP on chromosome 15
gscores(mafdb, GRanges("15:28356859"))

# Query using a SNP ID (requires a SNPlocs package)
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)
snpdb <- SNPlocs.Hsapiens.dbSNP144.GRCh37
rng <- snpsById(snpdb, ids="rs1129038")
gscores(mafdb, rng)
```

## Workflows

### Filtering Variants by Frequency
A common task is filtering a list of variants to keep only rare alleles (e.g., MAF < 0.01).

```r
# Assume 'my_variants' is a GRanges object
res <- gscores(mafdb, my_variants)

# Filter for rare variants in the Non-Finnish European population
rare_variants <- res[res$AF_NFE < 0.01 & !is.na(res$AF_NFE)]
```

### Extracting Specific Population Data
If you only need the global allele frequency (AF) and a specific sub-population:

```r
# Query specific columns
res <- gscores(mafdb, rng, pop=c("AF", "AF_AFR"))
```

## Tips
- **Reference Genome**: Ensure your input coordinates are based on **hs37d5** (or GRCh37/hg19). Using hg38 coordinates will result in incorrect or missing data.
- **Metadata**: Use `citation(mafdb)` to get the correct publication reference for the ExAC data.
- **Missing Values**: A `NA` result typically means the variant was not observed in the ExAC non-TCGA cohort.

## Reference documentation
- [MafDb.ExAC.r1.0.nonTCGA.hs37d5 Reference Manual](./references/reference_manual.md)