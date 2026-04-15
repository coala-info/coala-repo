---
name: r-scrm
description: The scrm package provides a highly efficient coalescent simulator for biological sequences that supports complex demographic scenarios and chromosome-scale simulations. Use when user asks to simulate genetic sequences, generate genealogies using the coalescent model, or model population history events like migration and size changes.
homepage: https://cloud.r-project.org/web/packages/scrm/index.html
---

# r-scrm

## Overview
The `scrm` package is a highly efficient coalescent simulator for biological sequences. It is designed as a faster, more memory-efficient alternative to `ms`, supporting complex demographic scenarios including population splits, migration, and size changes. It introduces a sliding-window approximation to allow the simulation of chromosome-scale sequences.

## Installation
To install the package from CRAN:
```r
install.packages("scrm")
library(scrm)
```

## Core Workflow
The primary function is `scrm(args)`, which takes a single string of command-line arguments following the `ms` syntax.

### Basic Simulation
To simulate 5 haplotypes for 1 locus with a mutation rate ($\theta$) of 5.0:
```r
library(scrm)
result <- scrm("5 1 -t 5.0")
# Access segregating sites
result$seg_sites[[1]]
```

### Simulating with Recombination and Trees
To simulate a 100bp locus with a recombination rate ($r$) of 1.5 and output Newick trees:
```r
sum_stats <- scrm("5 1 -r 1.5 100 -T")
# The trees are stored as a list of strings
cat(sum_stats$trees[[1]][1])
```

### Integration with 'ape'
You can visualize the simulated genealogies by passing the output to the `ape` package:
```r
library(ape)
# Convert the first tree of the first replicate
tree <- read.tree(text = sum_stats$trees[[1]][1])
plot(tree)
```

## Key Argument Syntax
The argument string follows the format: `scrm <nhap> <nrep> [options]`
- `nhap`: Total number of haplotypes.
- `nrep`: Number of independent replicates.

### Common Options
- `-t <theta>`: Mutation rate per locus ($\theta = 4N_0u$).
- `-r <rho> <len>`: Recombination rate ($\rho = 4N_0r$) and locus length.
- `-I <npop> <s1> ... <sn> [M]`: Island model with `npop` populations and sample sizes `s1...sn`.
- `-ej <t> <j> <i>`: Speciation event; move all lineages from pop `j` to `i` at time `t`.
- `-en <t> <i> <n>`: Set size of population `i` to `n*N0` at time `t`.
- `-oSFS`: Output the Site Frequency Spectrum (requires `-t`).
- `-l <window>`: Approximation window (in bp or recombinations if suffixed with `r`). Default is 500r. Use `-l -1` to disable approximation for exact ARG simulation.

## Tips for Complex Models
1. **Time Units**: All time parameters (`t`) are in units of $4N_0$ generations.
2. **Argument Order**: When using population admixture (`-es`), ensure all timed events are sorted chronologically to avoid errors.
3. **Reproducibility**: Use the `-seed <S1> <S2> <S3>` flag for deterministic results.
4. **Memory Efficiency**: For very long sequences, ensure approximation (`-l`) is active to prevent exponential memory growth.

## Reference documentation
- [Command Line Arguments](./references/scrm-Arguments.Rmd)
- [Simulating trees for ape](./references/scrm-TreesForApe.Rmd)