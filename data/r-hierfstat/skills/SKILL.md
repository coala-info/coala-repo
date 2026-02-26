---
name: r-hierfstat
description: The hierfstat package estimates hierarchical F-statistics and genetic diversity measures from haploid or diploid genetic data. Use when user asks to calculate F-statistics, estimate genetic distances, perform hierarchical variance analysis, or assess population-specific differentiation and sex-biased dispersal.
homepage: https://cloud.r-project.org/web/packages/hierfstat/index.html
---


# r-hierfstat

## Overview
The `hierfstat` package is designed for the estimation of hierarchical F-statistics from genetic data with any number of levels in the hierarchy. It supports haploid and diploid data and provides tools for descriptive statistics, population-specific F-statistics, genetic distances, and individual-level analyses like PCA and kinship estimation.

## Installation
```R
install.packages("hierfstat")
library(hierfstat)
```

## Data Formats and Import
`hierfstat` primarily uses a data frame where the first column is a population identifier (integer) and subsequent columns are genotypes.

### Genotype Encoding
- **Standard Format**: Alleles are encoded as 1, 2, or 3-digit integers. Genotypes are the two alleles concatenated (e.g., alleles `120` and `124` become `120124`).
- **Dosage Format**: Number of alternate alleles (0, 1, or 2). Used for SNP data.
- **Missing Data**: Represented as `NA`.

### Import Methods
- **FSTAT files**: `read.fstat("path/to/file.dat")`
- **adegenet objects**: `genind2hierfstat(my_genind)`
- **VCF files**: `read.VCF("path/to/file.vcf.gz")`
- **Dosage conversion**: `fstat2dos(dat[,-1])` converts standard format to dosage.

## Descriptive Statistics
Use `basic.stats` for a comprehensive summary of genetic diversity.

```R
# Calculate Ho, Hs, Fis, and Fst per locus and population
stats <- basic.stats(nancycats)
stats$perloc      # Statistics per locus
stats$overall     # Global statistics

# Allelic richness (rarefied)
ar <- allelic.richness(nancycats)$Ar
```

## F-Statistics and Variance Components
### Global and Pairwise Fst
- **Global**: `wc(data)` (Weir and Cockerham's estimates).
- **Pairwise**: `genet.dist(data, method="Fst")`.
- **Confidence Intervals**: `boot.vc(levels, genotypes)` for variance components or `boot.ppfst(data)` for pairwise Fst.

### Population Specific Fst
To identify populations that have diverged significantly from the average:
```R
# For standard data
beta_vals <- betas(nancycats)
barplot(beta_vals$betaiovl)

# For dosage data
fs_dos <- fs.dosage(dosage_matrix, pop=pop_vector)
```

## Hierarchical Analysis
For multi-level hierarchies (e.g., individuals within patches, patches within localities):
```R
# levels: data frame where each column is a hierarchical level
# genotypes: data frame of genotypes
varcomp(levels, genotypes)
```

## Genetic Distances and Ordination
`genet.dist` supports 10 methods (e.g., "Ds", "Fst", "Nei").
```R
# Calculate Nei's standard genetic distance
dist_matrix <- genet.dist(data, method="Ds")

# Principal Coordinate Analysis (PCoA)
pcoa(as.matrix(dist_matrix))

# Individual PCA
ipca <- indpca(data, ind.labels=pop_labels)
plot(ipca, col=pop_labels)
```

## Specialized Tests
### Sex-Biased Dispersal
Tests if one sex disperses more than the other using Assignment Indices (AIc).
```R
# genot: genotypes, sex: vector of sexes
sexbias.test(genot, sex)
```

### Simulations
- `sim.genot()`: Simulate data at equilibrium.
- `sim.genot.t()`: Simulate data for a specific number of generations.

## Reference documentation
- [Hierfstat latest features](./references/hierfstat.Rmd)
- [Importing data in Hierfstat](./references/import.Rmd)