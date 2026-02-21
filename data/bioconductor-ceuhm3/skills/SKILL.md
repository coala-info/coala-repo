---
name: bioconductor-ceuhm3
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/experiment/html/ceuhm3.html
---

# bioconductor-ceuhm3

name: bioconductor-ceuhm3
description: Access and analyze HapMap Phase III genotype calls and expression data for the CEPH CEU cohort. Use this skill when performing genetic association studies, expression quantitative trait loci (eQTL) analysis, or retrieving genomic coordinates for SNPs specifically within the CEU subpopulation using the ceuhm3 data package.

# bioconductor-ceuhm3

## Overview
The `ceuhm3` package is a Bioconductor data experiment package providing genotype data from HapMap Phase III and corresponding expression data for the CEPH (Utah residents with Northern and Western European ancestry) cohort. It integrates SNP calls with expression data provided by the Wellcome Trust GENEVAR project, facilitating genomic analyses within the R/Bioconductor environment, particularly when used alongside the `GGtools` and `GGBase` packages.

## Data Structures
The package contains several key data representations:
- `ceuhm3.sms`: The full genotype data derived from HapMap Phase III.
- `hm3ceuSMS`: A dataset coupling genotypes with March 2007 expression data for specific samples.
- `hm3ceuLocs`: Genomic coordinates for all referenced SNPs in the package.

## Typical Workflow

### Loading the Data
To use the data, you typically interact with it through the `GGBase` or `GGtools` infrastructure.

```r
library(ceuhm3)
library(GGtools)
library(GGBase)

# Load specific chromosome data for the CEU cohort
h3_20 <- getSS("ceuhm3", "chr20")
```

### Performing SNP Association Tests
You can perform genome-wide or gene-specific SNP tests (e.g., testing for association between a phenotype/covariate and genotypes).

```r
# Example: Test association between CPNE1 expression and gender on chromosome 20
t1 <- gwSnpTests(genesym("CPNE1") ~ male, h3_20, chrnum("chr20"))

# View the top significant SNPs
topSnps(t1)
```

## Usage Tips
- **Dependencies**: Ensure `GGBase` and `GGtools` are installed and loaded, as `ceuhm3` is primarily a data container designed to work with these analysis frameworks.
- **Lazy Loading**: The package uses lazy loading, meaning datasets like `hm3ceuLocs` are available once the library is loaded without needing explicit `data()` calls in most contexts.
- **Chromosome Naming**: When using `getSS`, ensure chromosome strings match the expected format (e.g., "chr20").

## Reference documentation
- [ceuhm3 Reference Manual](./references/reference_manual.md)