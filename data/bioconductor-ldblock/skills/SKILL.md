---
name: bioconductor-ldblock
description: This package provides data structures and functions to manage linkage disequilibrium data and define LD blocks using population-level datasets. Use when user asks to import HapMap LD data, visualize LD matrix structures, or expand SNP sets to include neighboring variants in high linkage disequilibrium.
homepage: https://bioconductor.org/packages/release/bioc/html/ldblock.html
---


# bioconductor-ldblock

## Overview

The `ldblock` package provides specialized data structures to manage and manipulate linkage disequilibrium (LD) data. It is primarily designed to simplify the process of defining LD blocks using existing population-level data (like HapMap) and facilitates the expansion of SNP sets (e.g., from GWAS catalogs) to include neighboring SNPs that exhibit high linkage.

## Core Workflows

### 1. Importing HapMap LD Data
The package provides the `hmld` function to import gzipped tabular LD data. This creates an `ldstruct` object containing the LD matrix (typically D'), genomic coordinates, and SNP identifiers.

```r
library(ldblock)
library(GenomeInfoDb)

# Path to gzipped HapMap LD files
path = dir(system.file("hapmap", package="ldblock"), full=TRUE)

# Import data for a specific population and chromosome
ceu17 = hmld(path, poptag="CEU", chrom="chr17")

# Inspect the structure
print(ceu17)
```

### 2. Visualizing LD Block Structure
You can visualize the LD matrix using the `image` method from the `Matrix` package. This helps identify blocks of high LD (bright areas) versus regions of recombination.

```r
library(Matrix)
# View a subset of the LD matrix (e.g., first 400 SNPs)
image(ceu17@ldmat[1:400, 1:400], 
      col.reg=heat.colors(120), 
      colorkey=TRUE, 
      useRaster=TRUE)
```

### 3. Expanding SNP Sets via LD
A common task is to take a list of "index" SNPs (like those found in a GWAS) and find all other SNPs in the population that are in high LD with them. The `expandSnpSet` function automates this.

```r
# Example: rsh17 is a character vector of rsids (GWAS hits)
# lb defines the lower bound for the LD statistic (e.g., D' > 0.9)
expanded_snps = ldblock::expandSnpSet(rsh17, ldstruct = ceu17, lb = 0.9)

# The result includes the original SNPs plus those meeting the LD threshold
length(expanded_snps)
```

## Key Functions and Objects

- **`hmld(path, poptag, chrom)`**: Constructor for `ldstruct` objects from HapMap-formatted files.
- **`ldstruct` Class**: An S4 class containing:
    - `@ldmat`: A sparse matrix (`dsCMatrix`) of LD statistics.
    - `@allrs`: Character vector of SNP RS-identifiers.
    - `@allpos`: Numeric vector of physical positions.
    - `@statInUse`: Usually "Dprime".
- **`expandSnpSet(rsids, ldstruct, lb)`**: Returns a character vector of SNP names that have an LD statistic $\ge$ `lb` with any of the input `rsids`.

## Usage Tips
- **Memory Efficiency**: The package uses sparse matrices (`Matrix` package) to handle large LD maps efficiently.
- **Coordinate Matching**: Ensure your SNP identifiers (RSIDs) match the format used in the `ldstruct` (HapMap usually uses "rs..." prefixes).
- **Missing SNPs**: `expandSnpSet` will issue a warning if some input SNPs are not found in the LD matrix; these are simply dropped from the expansion process.

## Reference documentation
- [ldblock package: linkage disequilibrium data structures](./references/ldblock.md)