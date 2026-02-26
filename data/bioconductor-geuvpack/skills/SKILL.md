---
name: bioconductor-geuvpack
description: This package provides access to processed GEUVADIS RNA-seq expression data and tools for integrating it with genotype information. Use when user asks to load GEUVADIS FPKM data, perform surrogate variable analysis on transcriptomic datasets, or retrieve 1000 Genomes VCF paths for eQTL mapping.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/geuvPack.html
---


# bioconductor-geuvpack

name: bioconductor-geuvpack
description: Access and analyze GEUVADIS expression data (FPKM) annotated to Gencode regions. Use this skill when you need to load the geuFPKM RangedSummarizedExperiment, perform surrogate variable analysis (SVA) on transcriptomic data, or retrieve 1000 Genomes VCF paths for eQTL mapping.

## Overview

The `geuvPack` package provides a processed version of the GEUVADIS (Genetic European Variation in Disease) RNA-seq dataset. It encapsulates FPKM (Fragments Per Kilobase of transcript per Million mapped reads) values into a `RangedSummarizedExperiment` object, making it compatible with standard Bioconductor workflows for genomic analysis. It includes metadata for 462 unique mRNA samples and tools for integrating these with 1000 Genomes genotype data.

## Loading Data

The package centers around several key datasets:

```r
library(geuvPack)

# Load the main expression object
data(geuFPKM) 

# Load gene symbol mappings
data(gs2p) # Gene symbols as values, Gencode IDs as names
data(gen2sym) # Gencode tags as values, symbols as names

# Load pre-computed SVA results
data(gsvs)
```

## Working with geuFPKM

The `geuFPKM` object is a `RangedSummarizedExperiment`. You can interact with it using standard accessors:

- **Assay Data**: `assay(geuFPKM)` contains the FPKM matrix.
- **Sample Metadata**: `colData(geuFPKM)` contains population codes and sample information.
- **Genomic Coordinates**: `rowRanges(geuFPKM)` provides the Gencode V12 coordinates for the features.

### Identifying Outliers and Protein Coding Genes
The package provides convenience vectors to filter the dataset:
- `protco`: Indices of protein-coding features.
- `hasout`: Indices of features with outlying values (defined as `sd(x)/mad(x) > 2`).

```r
# Filter for protein coding genes without outliers
clean_data <- geuFPKM[protco, ]
clean_data <- clean_data[!(seq_len(nrow(clean_data)) %in% hasout), ]
```

## Surrogate Variable Analysis (SVA)

To account for batch effects or unmeasured Confounders in the GEUVADIS data, use the `sva` package in conjunction with `geuFPKM`.

```r
library(sva)
# Create model matrix for population code
popm <- model.matrix(~popcode, data=colData(geuFPKM))
int <- popm[, 1, drop=FALSE]

# Run SVA (Note: This is computationally intensive)
# gsvs_result <- sva(assay(geuFPKM), popm, int)
```

## Genotype Integration

The `gtpath` function facilitates finding the corresponding genotype data from the 1000 Genomes project, which is often used for cis-association (eQTL) studies.

```r
# Get URL for Chromosome 1 VCF on Amazon S3
vcf_url <- gtpath(1)

# Get path for a local VCF using a template
local_vcf <- gtpath(21, useS3=FALSE, tmplate="/data/genotypes/chr%%N%%.vcf.gz")
```

## Reference documentation

- [geuvPack Reference Manual](./references/reference_manual.md)