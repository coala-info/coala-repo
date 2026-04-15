---
name: bioconductor-hmyrib36
description: This package provides HapMap Phase II YRI genotype and GENEVAR expression data mapped to Genome Build 36 for integrative genomic analysis. Use when user asks to load smlSet objects for eQTL mapping, perform genetic association studies on Yoruba population data, or analyze SNP-expression relationships using the GGtools ecosystem.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/hmyriB36.html
---

# bioconductor-hmyrib36

name: bioconductor-hmyrib36
description: Access and analyze HapMap Phase II YRI (Yoruba in Ibadan, Nigeria) SNP data combined with GENEVAR expression data, mapped to Genome Build 36 (r23a). Use this skill to load smlSet objects containing genotypes and expression levels for eQTL analysis and genetic association studies.

# bioconductor-hmyrib36

## Overview
The `hmyriB36` package provides a unified representation of HapMap Phase II genotype data and gene expression data (from the SANGER GENEVAR project) for 90 YRI individuals. The data is mapped to NCBI Build 36. This package is primarily used as a data source for the `GGtools` ecosystem to perform expression Quantitative Trait Loci (eQTL) mapping.

## Core Workflow

### Loading Data
The package does not provide a pre-serialized `smlSet` object. Instead, you must use the `getSS` function from the `GGBase` or `GGtools` package to construct the object dynamically.

```r
library(hmyriB36)
library(GGtools)

# Load data for a specific chromosome (e.g., Chromosome 20)
hmyri_chr20 <- getSS("hmyriB36", "20")

# Load data for multiple chromosomes
hmyri_multi <- getSS("hmyriB36", c("21", "22"))
```

### Inspecting Data
The resulting object is of class `smlSet`, which encapsulates both an `ExpressionSet` and `SnpMatrix` instances.

```r
# View expression data (first 4 probes, first 4 samples)
exprs(hmyri_chr20)[1:4, 1:4]

# View genotype data (first 4 SNPs, first 4 samples)
# Note: smList returns a list of SnpMatrix objects, one per chromosome
as(smList(hmyri_chr20)[[1]][1:4, 1:4], "character")
```

### eQTL Analysis Example
A common use case is testing the association between SNP genotypes and gene expression levels, often adjusting for covariates like sex.

```r
library(illuminaHumanv1.db)

# 1. Identify the probe ID for a gene of interest (e.g., CPNE1)
cptag <- get("CPNE1", revmap(illuminaHumanv1SYMBOL))

# 2. Run eQTL tests for that probe across the loaded genotypes
# Adjusting for the 'male' covariate found in pData
tt <- eqtlTests(hmyri_chr20[probeId(cptag), ], ~male)

# 3. View top features/associations
topFeats(probeId(cptag), mgr = tt, ffind = 1)
```

## Key Components
- **ex**: An internal `ExpressionSet` instance located in the package's `data` folder, used automatically by `getSS` to merge with genotypes.
- **smlSet**: The container class used to manage the high-dimensional genotype and expression data.
- **Build 36 (r23a)**: Ensure your genomic coordinates or external annotation data match Build 36 (Hg18) when performing integrative analyses.

## Reference documentation
- [hmyriB36 Reference Manual](./references/reference_manual.md)