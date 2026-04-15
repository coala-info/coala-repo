---
name: bioconductor-ggtools
description: This tool performs eQTL analysis by integrating expression and genotype data to identify genetic sources of expression variation. Use when user asks to perform focused or comprehensive eQTL searches, manage smlSet data structures, apply genotype filters, or calculate permutation-based FDR for cis-eQTL associations.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GGtools.html
---

# bioconductor-ggtools

name: bioconductor-ggtools
description: Analysis of genetic sources of expression variation (eQTL discovery). Use this skill to perform focused or comprehensive eQTL searches, manage smlSet data structures (unifying expression and genotype data), apply filters (MAF, GTF, PCA-based heterogeneity removal), and calculate permutation-based FDR for cis-eQTL associations.

## Overview

GGtools provides infrastructure for eQTL (expression Quantitative Trait Loci) analysis. It integrates expression data (ExpressionSet) with genotype data (SnpMatrix) into a specialized `smlSet` class. The package supports both focused gene-SNP association tests and large-scale comprehensive surveys across chromosomes, utilizing the `snpStats` package for high-performance statistical testing.

## Core Data Structures

The primary container is the `smlSet`.
- **Loading Data**: Use `getSS("PackageName", "ChrNumber")` to load reference data (e.g., from `GGdata`).
- **Accessing Components**:
  - Expression: `exprs(obj)`
  - Phenotype: `pData(obj)`
  - Genotypes: `smList(obj)` (returns a list of SnpMatrix objects stored in an environment).
- **Subsetting**: `obj[probes, samples]` coordinates expression, genotype, and phenotype data automatically. Use `probeId()` to cast character vectors for probe-side subsetting.

## Focused eQTL Analysis

To test a specific gene against all SNPs on a chromosome:
```r
# Test CPNE1 expression against gender (male) on chromosome 20
t1 = gwSnpTests(genesym("CPNE1") ~ male, g20, chrnum("20"))
topSnps(t1)

# Visualization
plot(t1, snplocsDefault()) # Manhattan-style plot
plot_EvG(genesym("CPNE1"), rsid("rs17093026"), g20) # Expression vs Genotype boxplot
```

## Comprehensive cis-eQTL Surveys

For large-scale searches within a specific genomic radius (cis-eQTLs):

### 1. Configuration
Use the `CisConfig` class to define search parameters:
```r
ini = new("CisConfig")
smpack(ini) = "GGdata"
chrnames(ini) = "20"
radius(ini) = 75000L
nperm(ini) = 3L # Number of permutations for FDR
smFilter(ini) = function(x) MAFfilter(x, lower=0.05)
geneApply(ini) = mclapply # For parallel execution
```

### 2. Execution
- **All.cis**: Returns a GRanges object with scores and permutation results.
  ```r
  results = All.cis(ini)
  ```
- **best.cis.eQTLs**: Specifically identifies the best associated SNP per gene.
  ```r
  b1 = best.cis.eQTLs("GGdata", ~male, radius=1e6, folderstem="db_dir", nperm=2)
  ```

## Filtering and Heterogeneity Removal

- **Genotype Filters**: `MAFfilter(obj, lower=0.05)` (Minor Allele Frequency) and `GTFfilter` (Genotype Frequency).
- **Expression Heterogeneity**: 
  - `clipPCs(obj, 1:10)`: Removes the first 10 principal components from the expression matrix to reduce batch effects or hidden factors.
  - Integration with `PEER` or `SVA` is supported by manually updating the `@assayData` of the `smlSet`.

## Statistical Interpretation

- **FDR Calculation**: GGtools uses a plug-in FDR estimation based on the permutation scores stored in the result objects.
- **Amalgamation**: Use `collectFiltered(filenames, mafs=c(0.02, 0.05), hidists=c(10000, 50000))` to combine results from multiple chromosomes and perform sensitivity analysis across different MAF and distance thresholds.

## Reference documentation
- [Using GGtools for eQTL discovery and interpretation](./references/GGtools.md)