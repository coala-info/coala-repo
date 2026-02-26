---
name: bioconductor-ashkenazimsonchr21
description: This tool provides access to the AshkenazimSonChr21 dataset containing annotated variants from human chromosome 21 for the HG002 sample. Use when user asks to load GIAB Ashkenazim Trio son variants, perform rare variant analysis testing, or provide example data for the RareVariantVis package.
homepage: https://bioconductor.org/packages/release/data/experiment/html/AshkenazimSonChr21.html
---


# bioconductor-ashkenazimsonchr21

name: bioconductor-ashkenazimsonchr21
description: Access and use the AshkenazimSonChr21 dataset, a subset of the Genome in a Bottle (GIAB) Ashkenazim Trio son sample (HG002). Use this skill to load annotated variants from human chromosome 21 (hg19) for rare variant analysis, visualization testing (specifically with RareVariantVis), or benchmarking whole genome sequencing (WGS) workflows.

## Overview
The `AshkenazimSonChr21` package provides a curated subset of whole genome sequencing data from the Stanford Genome in a Bottle Consortium. It contains variants specifically from chromosome 21 of the son (HG002/NA24385) in the Ashkenazim Trio. The data is pre-processed to exclude homozygous reference calls and small indels to minimize noise, making it an ideal lightweight dataset for testing R-based genomic analysis tools.

## Loading the Data
The package provides two primary ways to access the data: as a pre-loaded data frame or as a raw VCF file.

### Accessing the Variant Data Frame
The `SonVariantsChr21` object is a data frame containing rare variants with annotations such as gene names, SNP frequencies, and quality metrics.

```r
library(AshkenazimSonChr21)

# Load and inspect the data frame
data(SonVariantsChr21)
head(SonVariantsChr21)

# Check available columns (e.g., Chromosome, Start.position, Gene.name, phyloP, GT)
colnames(SonVariantsChr21)
```

### Accessing the VCF File
The package includes a compressed VCF file in its `extdata` directory. This is useful for testing VCF parsers or workflows that require standard genomic formats.

```r
library(VariantAnnotation)

# Locate the VCF file path
vcf_path <- system.file("extdata", "SonVariantsChr21.vcf.gz", package="AshkenazimSonChr21")

# Read the VCF into a VCF object
vcf <- readVcf(vcf_path, genome="hg19")

# Inspect genotype and info fields
geno(vcf)
info(vcf)
```

## Typical Workflows

### Integration with RareVariantVis
This dataset is specifically designed as example input for the `RareVariantVis` package.
```r
# Example pattern for visualization (requires RareVariantVis)
# library(RareVariantVis)
# rareVariantVis(SonVariantsChr21)
```

### Filtering and Analysis
You can use standard R operations to filter the variants based on the provided annotations:
*   **Quality Filtering:** Use the `Quality.by.Depth` (QD) or `DP` (Depth) columns.
*   **Functional Impact:** Filter by `phyloP` scores or `Gene.component` (e.g., exonic, intronic).
*   **Genotype Selection:** Filter by the `GT` column (e.g., "0/1" for heterozygous).

## Data Characteristics
*   **Genome Build:** hg19 (GRCh37).
*   **Sample:** HG002 (Ashkenazim Son).
*   **Scope:** Chromosome 21 only.
*   **Variant Types:** Primarily substitutions (SNPs); small indels and homozygous reference calls have been filtered out to reduce size and noise.

## Reference documentation
- [AshkenazimSonChr21](./references/AshkenazimSonChr21.md)