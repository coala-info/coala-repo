---
name: genepop
description: Genepop is a specialized suite for population genetics that implements both traditional methods and advanced statistical tests.
homepage: https://f-rousset.r-universe.dev/genepop
---

# genepop

## Overview

Genepop is a specialized suite for population genetics that implements both traditional methods and advanced statistical tests. Use this skill to process genetic datasets (typically in Genepop format) to determine population structure, gene flow, and genetic equilibrium. It is particularly effective for analyzing microsatellite and SNP data across multiple populations or individuals.

## Core Workflows

### Data Preparation and Conversion
- Ensure input files follow the Genepop format: a header line, locus names (one per line or comma-separated), and population data separated by the "Pop" keyword.
- Use `conversion(inputFile, format)` to migrate data to other formats like Fstat, Biosys, or Linkdos if required for secondary analyses.
- Validate file extensions and accessibility before running long-compute functions.

### Statistical Testing
- **Hardy-Weinberg Equilibrium**: Use `test_HW()` to perform exact tests for heterozygote excess or deficiency.
- **Population Differentiation**: Use `test_diff()` to evaluate genic or genotypic differentiation between populations.
- **Linkage Disequilibrium**: Use `test_LD()` to create contingency tables and perform exact tests for genotypic disequilibrium among pairs of loci.
- **F-statistics**: Use `Fst()` to estimate Weir and Cockerham's (1984) parameters or allele size-based statistics (rho_ST).

### Spatial and Individual Analysis
- **Isolation by Distance (IBD)**: Use `ibd()` to analyze the relationship between genetic and geographic distances.
- **Private Alleles**: Use `Nm_private()` to estimate the number of immigrants using Barton and Slatkin's method.
- **Null Alleles**: Use `nulls()` to estimate allele frequencies when genotyping failure is suspected.

## Expert Tips and Best Practices

### Markov Chain Parameters
For exact tests, the precision of the p-value depends on the Markov chain settings.
- **Dememorization**: Default is 1000. Increase for complex datasets to ensure the chain reaches a stationary distribution.
- **Batches/Iterations**: Default is 100 batches of 5000 iterations. For publication-quality results, increase these values (e.g., 200 batches, 10000 iterations) to reduce standard error.

### Workspace Management
Genepop generates numerous intermediate and output files (e.g., .INF, .FST, .GE, .G).
- Use `clean_workdir()` regularly to remove temporary files and prevent directory clutter.
- Specify `outputFile` paths explicitly in functions to avoid overwriting previous results.

### Handling Missing Data
- Be aware that missing genotypes can significantly impact IBD slope estimates.
- Use the `bootstrapMethod` and `bootstrapNsim` arguments in `ibd()` for more robust confidence intervals, especially with large (thousands of loci) datasets.

## Reference documentation

- [Package 'genepop' reference manual](./references/f-rousset_r-universe_dev_genepop_doc_manual.html.md)
- [genepop NEWS](./references/f-rousset_r-universe_dev_genepop_NEWS.md)