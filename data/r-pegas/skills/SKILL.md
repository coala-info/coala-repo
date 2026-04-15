---
name: r-pegas
description: This tool provides functions for population and evolutionary genetics analysis in R, including data manipulation, statistical testing, and haplotype network construction. Use when user asks to read or write genetic data formats, calculate population statistics like Fst and AMOVA, perform Hardy-Weinberg equilibrium tests, or build and plot haplotype networks.
homepage: https://cloud.r-project.org/web/packages/pegas/index.html
---

# r-pegas

name: r-pegas
description: Expert guidance for the R package 'pegas' (Population and Evolutionary Genetics Analysis System). Use this skill when performing population genetics analyses in R, including reading/writing genetic data (VCF, Fstat, Genepop), calculating population statistics (Fst, Amova, HWE), and constructing/plotting haplotype networks (TCS, MST, MJN).

## Overview

The `pegas` package provides a comprehensive framework for population genetic analysis in R. It introduces the `loci` class for efficient storage of genotypic data and offers tools for both classical population genetics (equilibrium tests, linkage disequilibrium) and modern phylogeographic methods (haplotype networks).

## Installation

```R
install.packages("pegas")
library(pegas)
```

## Data Structures

`pegas` primarily uses the `loci` class, which is a data frame where specific columns are genotypes (factors).

- **Genotype Format**: Unphased genotypes use a forward slash (e.g., `A/A`, `132/148`). Phased genotypes use a vertical bar (e.g., `A|T`).
- **Conversion**: Use `as.loci()` to convert data frames or `genind2loci()` to convert from `adegenet` objects.

## Reading and Writing Data

### Common Formats
- **VCF Files**: `read.vcf("file.vcf", from = 1, to = 10000)` reads variants into a `loci` object.
- **Tabular Text**: `read.loci("file.txt", header = TRUE, allele.sep = "/")`.
- **Genetix**: `read.gtx("file.gtx")`.
- **Fstat/Genepop/Structure**: Use `adegenet` functions (e.g., `read.fstat`) then convert via `as.loci()`.

### From Data Frames
If data is in a "two columns per locus" format (allelic data), use `alleles2loci(x)`.

## Population Genetic Analysis

### Basic Statistics
- **Allele Frequencies**: `allele.count(x)` or `predict(x)` for frequencies.
- **Genotype Counts**: `genotype.counts(x)`.
- **Heterozygosity**: `H(x)` calculates expected heterozygosity.

### Equilibrium and Structure
- **Hardy-Weinberg**: `hw.test(x)` performs Chi-square and permutations tests.
- **F-statistics**: `Fst(x)` calculates Weir and Cockerham's F-statistics.
- **AMOVA**: `amova(formula, data)` for Analysis of Molecular Variance.
- **Linkage Disequilibrium**: `LD(x)` or `LD2(x)` for pairwise LD measures.

## Haplotype Networks

### Network Construction
`pegas` supports several methods, all returning a `haploNet` object:
- **TCS (Parsimony)**: `haploNet(h)` where `h` is a `haplotype` object.
- **Minimum Spanning Tree**: `mst(d)` where `d` is a distance matrix.
- **Minimum Spanning Network**: `msn(d)`.
- **Randomized MST**: `rmst(d)`.
- **Median-Joining**: `mjn(s)` where `s` is a `DNAbin` object.

### Plotting and Customization
```R
# Basic plot
plot(nt)

# Proportional to frequency
h <- haplotype(dna)
sz <- summary(h)
plot(nt, size = sz[attr(nt, "labels")])

# Pie charts for populations
f <- haploFreq(dna, fac = population, haplo = h)
plot(nt, pie = f[attr(nt, "labels"), ])
```

### Interactive Editing
- **replot(nt)**: Allows interactive movement of nodes. Save coordinates with `xy <- replot(nt)` and reuse in `plot(nt, xy = xy)`.
- **mutations(nt)**: Interactively identify and label mutations on network links.

## Workflow: DNA Sequences to Network

1. **Load Data**: `dna <- read.dna("data.fas", format = "fasta")`
2. **Extract Haplotypes**: `h <- haplotype(dna)`
3. **Distance Matrix**: `d <- dist.dna(h, model = "N")`
4. **Build Network**: `nt <- rmst(d)`
5. **Visualize**: `plot(nt)`

## Reference documentation

- [Plotting Haplotype Networks with pegas](./references/PlotHaploNet.md)
- [Reading Genetic Data Files Into R](./references/ReadingFiles.md)