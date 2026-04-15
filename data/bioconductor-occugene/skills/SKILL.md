---
name: bioconductor-occugene
description: This tool performs statistical analysis of gene occupancy in random mutagenesis libraries to estimate gene essentiality and predict library saturation. Use when user asks to estimate the number of essential genes, calculate the expected number of knockouts in transposon libraries, or model multinomial occupancy distributions for prokaryotic genomes.
homepage: https://bioconductor.org/packages/release/bioc/html/occugene.html
---

# bioconductor-occugene

name: bioconductor-occugene
description: Statistical analysis of gene occupancy in random mutagenesis libraries. Use this skill to estimate the number of essential genes, calculate the expected number of knockouts in transposon libraries, and model multinomial occupancy distributions for prokaryotic genomes.

# bioconductor-occugene

## Overview

The `occugene` package provides tools for analyzing the distribution of insertions in random mutagenesis experiments. It is primarily used to estimate the number of essential genes (those that cannot sustain insertions) and to predict the progress of library construction (e.g., how many new genes will be hit in the next set of clones). It models insertions as a multinomial distribution and provides both theoretical calculations and Monte Carlo simulations.

## Core Workflows

### 1. Multinomial Occupancy Calculations
Calculate the expected number of genes hit and the variance given a number of clones ($n$) and a probability vector ($p$) representing gene sizes or hit probabilities.

```r
library(occugene)

# Define number of clones and probabilities for each gene
n <- 60
p <- c(seq(10, 1, -1), seq(10, 1, -1), 18) / 124
p <- p / sum(p)

# Theoretical moments
eMult(n, p)
varMult(n, p)

# Monte Carlo approximations (useful for complex distributions)
eMult(n, p, iter = 100, seed = 4)
varMult(n, p, iter = 100, seed = 4)
```

### 2. Estimating Future Progress (Efron-Thisted)
Predict how many new genes will be knocked out in the next $m$ clones based on current experimental data.

```r
# orf: a matrix/dataframe with 'first' and 'last' position columns
# clone: a vector of observed insertion positions
orf_coords <- cbind(sampleAnnotation$first, sampleAnnotation$last)
insertions <- sampleInsertions$position

# Estimate for next 10 clones
etDelta(10, orf_coords, insertions)
```

### 3. Estimating Essential Genes (Will-Jacobs Bootstrap)
Estimate the total number of non-essential genes ($b_0$) and the number of new knockouts using a bootstrap approach.

```r
# Fit the non-linear model to the accumulation curve
fFit(orf_coords, insertions, plot = FALSE)

# Estimate new knockouts in next 10 clones with Confidence Interval
unbiasDelta0(10, orf_coords, insertions, iter = 100, alpha = 0.05)

# Estimate total number of non-essential genes (b0)
# Total Genes - b0 = Estimated Essential Genes
unbiasB0(orf_coords, insertions, iter = 100, alpha = 0.05)
```

### 4. Data Interoperability
Convert `occugene` data structures to the format required by the `negenes` package.

```r
newOrf <- occup2Negenes(orf_coords, insertions)
```

## Data Structures
- **ORF Matrix**: A two-column matrix where column 1 is the start position and column 2 is the end position of each gene on the chromosome.
- **Insertion Vector**: A numeric vector containing the base-pair positions of every transposon insertion observed in the library.

## Tips
- Use `data(sampleAnnotation)` and `data(sampleInsertions)` to explore the expected input formats.
- The `iter` parameter in bootstrap functions significantly impacts runtime; start with low values (e.g., 10-100) for testing before running production estimates.
- If `fFit` fails to converge, check if your library is too sparse or if the insertion positions are outside the ranges defined in your ORF matrix.

## Reference documentation
- [Estimating the Number of Essential Genes using Occugene](./references/occugene.md)