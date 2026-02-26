---
name: bioconductor-ceu1kg
description: This tool provides access to 1000 Genomes Project genotype data and expression sets for individuals of Central European ancestry. Use when user asks to load SnpMatrix objects for specific chromosomes, integrate genotype data with expression data for eQTL analysis, or explore SNP metadata for the CEU population.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/ceu1kg.html
---


# bioconductor-ceu1kg

name: bioconductor-ceu1kg
description: A skill for accessing and using the ceu1kg Bioconductor package, which provides 1000 Genomes Project genotype data for individuals of Central European (CEU) ancestry. Use this skill when you need to load SnpMatrix objects for specific chromosomes, integrate genotype data with expression data (e.g., using GGtools), or explore SNP metadata for the CEU population.

## Overview

The `ceu1kg` package provides a subset of the 1000 Genomes Project data specifically focused on individuals of Central European (CEU) ancestry. The genotypes are stored as `SnpMatrix` objects (from the `snpStats` package), partitioned by chromosome. This package is frequently used in conjunction with `GGtools` for expression quantitative trait loci (eQTL) analysis, as it includes expression data for a subset of the individuals.

## Loading Genotype Data

Genotypes are stored as `.rda` files within the package's `parts` directory.

```r
library(ceu1kg)

# List available chromosome files
parts_dir <- system.file("parts", package="ceu1kg")
dir(parts_dir)

# Load a specific chromosome (e.g., Chromosome 1)
# Note: load() returns the name of the object loaded (usually a SnpMatrix)
lk <- load(file.path(parts_dir, "chr1.rda"))
c1gt <- get(lk)

# Inspect the SnpMatrix
print(c1gt)
```

## Integrating with Expression Data

The package is designed to work with `GGtools` to create `smlSet` objects, which combine genotype and expression data.

### Using getSS
The `getSS` function (from `GGtools`) can automatically pull data from `ceu1kg`.

```r
library(GGtools)
# Load data for chromosome 20
# Note: This may issue a warning if sample sizes between genotypes and expression differ
c20 <- getSS("ceu1kg", "chr20")
```

### Manual Construction of smlSet
To avoid warnings or to subset data manually, you can load the expression set (`eset`) and align it with the genotypes.

```r
library(ceu1kg)
library(GGBase)

# Load the expression set (eset)
data(eset) 

# Load genotypes for Chromosome 1
lk <- load(system.file("parts/chr1.rda", package="ceu1kg"))
c1gt <- get(lk)

# Subset genotypes to match samples in the expression set
c1m <- c1gt[sampleNames(ex),]

# Create the smlSet
c1ss <- make_smlSet(ex, list(chr1=c1m))
```

## Working with SNP Metadata

To map the SNP identifiers in `ceu1kg` to genomic coordinates, use the `SNPlocs` packages.

```r
library(SNPlocs.Hsapiens.dbSNP.20101109)

# Get locations for chromosome 1
c1loc <- getSNPlocs("ch1", as.GRanges=TRUE)

# Compare 1000 Genomes SNP IDs with dbSNP
rsn1 <- paste("rs", elementMetadata(c1loc)$RefSNP_id, sep="")
intersect_count <- length(intersect(rsn1, colnames(c1gt)))
```

## Key Data Structures
- **SnpMatrix**: The primary container for genotypes. Rows represent individuals (e.g., NA06985), and columns represent SNP loci (e.g., chr1:533).
- **eset**: An `ExpressionSet` containing transcriptomic data for 43 of the CEU individuals.
- **smlSet**: A specialized container from `GGBase` that encapsulates both the `SnpMatrix` and the `ExpressionSet` for integrated analysis.

## Reference documentation
- [ceu1kg](./references/ceu1kg.md)