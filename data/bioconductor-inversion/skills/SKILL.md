---
name: bioconductor-inversion
description: This package identifies genomic inversions from SNP-array data by modeling linkage disequilibrium patterns between flanking blocks. Use when user asks to detect genomic inversions, scan chromosomes for inversion events using SNP data, or classify individuals by inversion status.
homepage: https://bioconductor.org/packages/3.6/bioc/html/inveRsion.html
---


# bioconductor-inversion

## Overview

The `inveRsion` package identifies genomic inversions using SNP-array data. It works by modeling the linkage disequilibrium (LD) patterns between flanking blocks of SNPs. It supports both phased haplotype data and unphased genotype data. The workflow typically involves coding haplotypes into decimal integers, scanning the chromosome with a sliding window to find candidate regions, and then reconstructing the final inversion sequence and individual classifications.

## Core Workflow

### 1. Data Preparation and Coding
Data must be loaded and transformed into a coded format where flanking blocks of SNPs are represented as integers.

```r
library(inveRsion)

# For Haplotype data:
# file should have SNP coordinates in first row, then 0/1 for alleles
hapFile <- system.file("extdata", "haplotypesROI.txt", package = "inveRsion")
hapCode <- codeHaplo(file = hapFile, blockSize = 5, minAllele = 0.3)

# For Genotype data:
# Use setUpGenoDatSNPmat (for SNPmatrix objects) or setUpGenoDatFile
# then run codeHaplo with geno=TRUE
```

### 2. Scanning for Inversions
Use a sliding window approach to calculate the Bayes Information Criterion (BIC) for trial segments across the region of interest.

```r
# window is the size in Mb
window <- 0.5 
scanRes <- scanInv(hapCode, window = window, saveRes = TRUE)

# Visualize the scan results (BIC difference)
plot(scanRes, which = "b", thBic = 0)
```

### 3. Reconstructing Inversion Sequences
Identify overlapping significant segments to define the final inversion boundaries and frequency.

```r
# thBic: threshold for significance
invList <- listInv(scanRes, hapCode = hapCode, geno = FALSE, thBic = 0)

# View summary (LBP/RBP intervals, frequency, Max BIC)
print(invList)
```

### 4. Classification of Subjects
Extract the probability or binary status of the inversion for each individual/chromosome.

```r
# Get average responsibilities (probabilities)
probs <- getClassif(invList, thBic = 0, wROI = 1, bin = FALSE)

# Get genotype-style classification (homozygote, heterozygote, etc.)
# Set geno=TRUE to get subject-level counts
genotypes <- getClassif(invList, thBic = 2000, wROI = 1, geno = TRUE)

# Plot histogram of responsibilities
plot(invList, wROI = 1)
```

## Key Functions

- `codeHaplo`: Encodes SNP blocks into decimal integers. Essential first step.
- `scanInv`: Performs the sliding window search using the inversion model.
- `listInv`: Consolidates scan results into discrete inversion events.
- `getClassif`: Retrieves individual-level inversion status.
- `accBic`: (Optional) Assesses classification accuracy if true status is known (e.g., in simulations).

## Tips and Constraints

- **Block Size**: `blockSize` (default 3-5) determines the number of SNPs used to define the LD pattern at the breakpoints.
- **Window Size**: The `window` parameter in `scanInv` should be approximately the expected size of the inversion.
- **Genotype Data**: While the workflow is similar, genotype data is more computationally intensive as it requires local haplotyping (via `haplo.stats`). Use `geno = TRUE` in `scanInv` and `listInv`.
- **BIC Threshold**: Use `plot(scanRes)` to determine a sensible `thBic`. High BIC values indicate stronger evidence for an inversion.

## Reference documentation

- [inveRsion](./references/inveRsion.md)