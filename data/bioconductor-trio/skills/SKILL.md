---
name: bioconductor-trio
description: This package analyzes case-parent trio data to detect disease-associated SNPs, SNP-SNP interactions, and gene-environment interactions. Use when user asks to perform genotypic Transmission Disequilibrium Tests, identify higher-order genetic interactions via trio logic regression, check for Mendelian errors, or estimate LD blocks.
homepage: https://bioconductor.org/packages/release/bioc/html/trio.html
---

# bioconductor-trio

name: bioconductor-trio
description: Analysis of case-parent trio data for detecting disease-associated SNPs, SNP-SNP interactions, and gene-environment interactions. Use when performing genotypic Transmission Disequilibrium Tests (gTDT), allelic TDT, score tests, or trio logic regression on genetic data in ped/linkage or genotype formats.

# bioconductor-trio

## Overview

The `trio` package is designed for the analysis of case-parent trio data. It provides tools for testing single SNPs, two-way interactions, and gene-environment interactions using genotypic Transmission Disequilibrium Tests (gTDT) and score tests. It also implements trio logic regression to identify higher-order SNP interactions and includes utilities for data preparation, Mendelian error checking, LD block estimation, and trio data simulation.

## Core Workflows

### 1. Data Preparation

Data can be imported from standard linkage (`.ped`) files or genotype matrices.

```R
library(trio)

# Read a ped file and convert to genotype format (3 rows per trio: father, mother, child)
# p2g=TRUE transforms alleles to counts of minor alleles (0, 1, 2)
geno <- read.pedfile("path_to_file.ped", p2g = TRUE)

# Alternatively, convert an existing ped data frame
# Requires unique IDs; often involves combining family and person IDs
geno_mat <- ped2geno(trio.ped1)
```

### 2. Genotypic TDT (gTDT)

Use these functions to test associations using conditional logistic regression with pseudo-controls.

*   **Single SNP:** `tdt(mat.test[,1], model = "additive")` (models: "additive", "dominant", "recessive").
*   **All SNPs in a matrix:** `colTDT(mat.test)`.
*   **MAX Test:** `colTDTmaxTest(mat.test, perm = 1000)` (tests across all three genetic models).
*   **Two-way Interactions:** `colGxG(mat.test)` or `tdtGxG(snp1, snp2)`.
*   **Gene-Environment (GxE):** `colGxE(mat.test, env_vector)` where `env_vector` is a binary (0/1) variable.

### 3. Trio Logic Regression

Used for detecting high-order interactions (3+ SNPs).

```R
# 1. Check for Mendelian errors (replace=TRUE converts errors to NA)
trio.tmp <- trio.check(dat = trio.ped1, replace = TRUE)

# 2. Prepare data (imputes missing values and creates pseudo-controls)
# 'blocks' defines LD structure; if unknown, use findLDblocks first
trio.bin <- trio.prepare(trio.dat = trio.tmp, blocks = c(1, 4, 2, 3))

# 3. Run Logic Regression
# Search can be "anneal", "greedy", or "mcmc"
my.control <- lrControl(iter = 10000)
lr.out <- trioLR(trio.bin, control = my.control)

# 4. Visualize
plot(lr.out)
```

### 4. LD and Block Detection

Estimate Linkage Disequilibrium (LD) and blocks using the Gabriel et al. (2002) algorithm.

```R
# Compute LD (D' and r2)
ld.out <- getLD(geno_mat, parentsOnly = TRUE)

# Find LD blocks
blocks <- findLDblocks(ld.out)
plot(blocks)

# Extract block lengths for trio.prepare
block_lengths <- as.vector(table(blocks$blocks))
```

### 5. Simulation

Simulate trios with specific risk models.

```R
# Define interaction (e.g., "1R and 5R" means SNP1 recessive AND SNP5 recessive)
sim <- trio.sim(freq = simuBkMap, interaction = "1R and 5R", prev = 0.001, OR = 2, n = 100)
```

## Tips and Best Practices

*   **Mendelian Errors:** Always run `trio.check` before `trio.prepare`. If errors exist, the preparation will fail unless `replace = TRUE` is used.
*   **Pseudo-controls:** `trio` functions automatically generate pseudo-controls (non-transmitted alleles). For single SNPs, there are 3 pseudo-controls; for two-way interactions, there are 15.
*   **Memory Management:** When computing LD for many SNPs, `getLD` can be memory-intensive. Use `asMatrix = FALSE` (default) to store results as vectors.
*   **Logic Regression Iterations:** For publication-quality results, use at least 100,000+ iterations in `lrControl`.

## Reference documentation

- [Preparing Case-Parent Trio Data and Detecting Disease-Associated SNPs, SNP Interactions, and Gene-Environment Interactions with trio](./references/trio.md)