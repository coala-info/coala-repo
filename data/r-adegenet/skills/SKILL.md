---
name: r-adegenet
description: "Toolset for the exploration of genetic and genomic     data. Adegenet provides formal (S4) classes for storing and handling     various genetic data, including genetic markers with varying ploidy     and hierarchical population structure ('genind' class), alleles counts     by populations ('genpop'), and genome-wide SNP data ('genlight'). It     also implements original multivariate methods (DAPC, sPCA), graphics,     statistical tests, simulation tools, distance and similarity measures,     and several spatial methods. A range of both empirical and simulated     datasets is also provided to illustrate various methods.</p>"
homepage: https://cloud.r-project.org/web/packages/adegenet/index.html
---

# r-adegenet

name: r-adegenet
description: Exploratory analysis of genetic and genomic data. Use for handling genotypic data (genind, genlight, genpop), performing multivariate analyses like DAPC and sPCA, and analyzing population structure and genetic diversity.

## Overview
adegenet is a specialized R package for the multivariate analysis of genetic markers. It provides formal S4 classes for efficient data storage and implements advanced statistical methods for population genetics, including Discriminant Analysis of Principal Components (DAPC) and Spatial Principal Component Analysis (sPCA).

## Installation
install.packages("adegenet")

## Core Data Classes
- **genind**: Use for individual genotypes (codominant or dominant markers). Best for small to medium datasets (e.g., microsatellites, few thousand SNPs).
- **genlight**: Use for large-scale genomic data (SNPs). Efficiently stores data as bits to minimize memory usage.
- **genpop**: Use for population-level allele counts or frequencies.

## Data Import and Conversion
- **df2genind**: Convert a data.frame of genotypes to a genind object.
- **import2genind**: Import data from external formats (Fstat, Genepop, Structure).
- **fasta2genlight**: Read SNP data from FASTA files into a genlight object.
- **vcfR2genlight**: Convert VCF files (requires vcfR package) to genlight.
- **genind2genpop**: Aggregate individual data into population data.

## Multivariate Workflows

### Discriminant Analysis of Principal Components (DAPC)
1. Identify clusters without prior information: `grp <- find.clusters(x)`
2. Perform the DAPC: `dapc1 <- dapc(x, grp$grp)`
3. Visualize results: `scatter(dapc1)`
4. Evaluate variable contributions: `loadingplot(dapc1$var.contr)`

### Spatial Principal Component Analysis (sPCA)
1. Define spatial connectivity: `cn <- chooseCN(xy)`
2. Run sPCA: `spca1 <- spca(x, cn)`
3. Test for spatial structure: `global.rtest(x, cn)` and `local.rtest(x, cn)`
4. Plot spatial components: `plot(spca1)`

## Essential Utilities
- **tab**: Access the allele count table (with optional scaling or NA replacement).
- **missingno**: Handle missing data by removing individuals or loci based on thresholds.
- **propShared**: Calculate the proportion of shared alleles between individuals.
- **repool**: Merge multiple genind objects.
- **seppop / repop**: Split or re-group objects by population factors.
- **scaleGen**: Center and scale genind objects for PCA.

## Best Practices
- Use `summary()` on genind objects to check for missing data, polymorphism, and expected heterozygosity.
- When running `find.clusters` or `dapc`, use the cross-validation function `xvalDapc` to determine the optimal number of Principal Components to retain and avoid over-fitting.
- For large SNP datasets, prefer `genlight` functions (prefixed with `gl`) such as `glPCA` or `glPlot`.

## Reference documentation
- [adegenet: Exploratory Analysis of Genetic and Genomic Data](./references/README.md)