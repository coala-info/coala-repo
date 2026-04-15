---
name: bioconductor-ggdata
description: This package provides access to integrated HapMap CEU genomic and transcriptomic data for 90 individuals. Use when user asks to perform eQTL analysis, conduct GWAS exemplars, or integrate SNP data with microarray expression profiles using the GGBase framework.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/GGdata.html
---

# bioconductor-ggdata

name: bioconductor-ggdata
description: Access and manage HapMap CEU sample data (90 individuals) including 47K expression profiles and 4 million SNPs. Use this skill when performing expression quantitative trait loci (eQTL) analysis, genome-wide association studies (GWAS) exemplars, or integrating SNP data with microarray expression data using the GGBase/GGtools framework.

# bioconductor-ggdata

## Overview

The `GGdata` package is an ExperimentData package for Bioconductor that provides a unified representation of genomic and transcriptomic data for 90 CEU (Utah residents with Northern and Western European ancestry) HapMap samples. It specifically integrates expression data from the Sanger GENEVAR project with SNP data from HapMap Build 36. The data is structured to be used with the `GGBase` and `GGtools` infrastructure, primarily through the `smlSet` class.

## Key Workflows

### Loading Data

The primary method for accessing the data is the `getSS` function. Note that as of newer versions, the full `smlSet` is not pre-serialized to save space; you must construct it for specific chromosomes.

```r
library(GGdata)
library(GGBase)

# Load expression data combined with genotypes for a specific chromosome (e.g., Chr 20)
hmceuB36 <- getSS("GGdata", "20")
```

### Inspecting Data Components

Once the `smlSet` is loaded, you can access the expression and genotype components:

```r
# View expression matrix (first 4 probes, first 4 samples)
exprs(hmceuB36)[1:4, 1:4]

# Access SNP data (SnpMatrix objects)
# smList returns a list of SnpMatrix objects, one per chromosome
snps_chr20 <- smList(hmceuB36)[[1]]
as(snps_chr20[1:4, 1:4], "character")
```

### eQTL Analysis Example

`GGdata` is frequently used as a benchmark or example dataset for eQTL testing using `GGtools`.

```r
library(GGtools)
library(illuminaHumanv1.db)

# 1. Identify a probe for a gene of interest (e.g., CPNE1)
cptag <- get("CPNE1", revmap(illuminaHumanv1SYMBOL))

# 2. Run eQTL tests for that probe across the loaded genotypes
# Adjusting for covariates like 'male' (gender)
tt <- eqtlTests(hmceuB36[probeId(cptag), ], ~male)

# 3. View top features/associations
topFeats(probeId(cptag), mgr = tt, ffind = 1)
```

## Usage Tips

- **Memory Management**: Loading all chromosomes simultaneously can be memory-intensive. It is recommended to use `getSS` for specific chromosomes of interest.
- **Dependencies**: This package relies heavily on `GGBase` for data structures (`smlSet`) and `snpStats` for the underlying `SnpMatrix` representation.
- **Annotation**: The expression data is based on the Illumina HumanV1 platform. Use `illuminaHumanv1.db` for mapping probe IDs to gene symbols.
- **Data Provenance**: The expression data originates from the SANGER GENEVAR project, and SNP data is based on HapMap build 36 (hg18).

## Reference documentation

- [GGdata Reference Manual](./references/reference_manual.md)