---
name: bioconductor-dsqtl
description: This tool analyzes associations between DNA variants and DNaseI hypersensitivity sites using the dsQTL Bioconductor package. Use when user asks to explore dsQTL data, perform cis-association analysis between SNPs and DNase-seq data, or visualize relationships between genotypes and hypersensitivity scores.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/dsQTL.html
---

# bioconductor-dsqtl

name: bioconductor-dsqtl
description: specialized for the dsQTL Bioconductor package to explore DNA-variants associated with DNaseI hypersensitivity. Use this skill when analyzing associations between SNPs/indels and DNase-seq data, specifically for Yoruba (YRI) HapMap subjects. It provides access to normalized DNaseI hypersensitivity scores and genotype data (primarily for chromosome 2 and 17) using SummarizedExperiment and GGBase structures.

# bioconductor-dsqtl

## Overview
The `dsQTL` package provides data and tools to explore associations between DNA variants and DNaseI hypersensitivity (dsQTLs). It includes normalized DNase-seq data and genotype information from the Chicago group (Degner et al. 2012). The package is designed to work with `SummarizedExperiment`, `GGBase`, and `gQTLstats` for scalable QTL identification.

## Loading Data and Core Structures
The package provides several key datasets representing different stages of the dsQTL analysis pipeline.

```R
library(dsQTL)

# Load the primary SummarizedExperiment for hg19 (Top 5% hypersensitivity sites)
data(DHStop5_hg19)

# Load chromosome-specific data structures
data(DSQ_2)  # Chromosome 2 (most mature data)
data(DSQ_17) # Chromosome 17

# Accessing metadata and assays
metadata(DSQ_2)
assays(DSQ_2)[[1]][1:5, 1:5] # View normalized scores
rowRanges(DSQ_2)             # View genomic locations of hypersensitivity sites
```

## Typical Workflows

### 1. Cis-Association Analysis with gQTLstats
To perform a search for dsQTLs using VCF files (e.g., from 1000 Genomes):

```R
library(gQTLstats)
library(geuvPack)

# Define path to VCF (example uses S3 for chr 17)
tf17 = gtpath(17, useS3=TRUE)

# Prepare the hypersensitivity data
data(DHStop5_hg19)
dhs17 = DHStop5_hg19[ seqnames(DHStop5_hg19) == "chr17", ]
seqlevelsStyle(dhs17) = "NCBI"

# Run cis-association search (radius in base pairs)
c17_1 = cisAssoc(dhs17[1:5,], tf17, cisradius=5000)
```

### 2. Using GGBase and GGtools
For legacy workflows or specific smlSet generation:

```R
library(GGBase)
library(GGtools)

# Get integrated container (rounded genotypes for chr 2)
ds2 = getSS("dsQTL", "roundGT_2")

# Perform a restricted cis-eQTL search
# Note: Ensure dsQTL's getSNPlocs is used if conflicts arise
getSNPlocs = dsQTL::getSNPlocs 

n1 = best.cis.eQTLs(
  smpack="dsQTL", 
  radius=2000, 
  geneannopk="dsQTL", 
  snpannopk="dsQTL", 
  chrnames="2", 
  smchrpref="roundGT_",
  smFilter = function(x) GTFfilter(x, lower=0.05)[23810:23830,]
)
```

### 3. Visualizing Results
To plot the relationship between a specific DNaseI hypersensitivity site (probe) and a SNP:

```R
plot_EvG(probeId("dhs_2_45370802"), 
         rsid("chr2.45370846"), 
         getSS("dsQTL", "roundGT_2", wrapperEndo=function(x){annotation(x)="dsQTL"; x}))
```

## Data Notes
- **Genotypes**: The package uses imputed genotypes (1000 Genomes haplotypes). While original doses are reals [0,2], the package images often use rounded integers (`round(x,0)`) for compatibility with `snpMatrix`.
- **Features**: Feature data refers to 100bp segments in the uppermost 5% of the DNaseI hypersensitivity distribution.
- **Normalization**: Scores are quantile-normalized to a standard normal distribution, corrected for GC bias, and have the top 4 principal components removed.

## Reference documentation
- [dsQTL: exploring DNA-variants associated with DNaseI hypersensitivity](./references/dsq.md)