---
name: bioconductor-ggbase
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GGBase.html
---

# bioconductor-ggbase

name: bioconductor-ggbase
description: Infrastructure for genetics of gene expression (eQTL) analysis. Use when managing integrative datasets containing both gene expression (eSet) and genotype (SnpMatrix) data. This skill is essential for creating, manipulating, and visualizing 'smlSet' objects, which are the primary containers for SNP-based expression studies in the Bioconductor ecosystem.

# bioconductor-ggbase

## Overview

The `GGBase` package provides the fundamental data structures for eQTL (expression Quantitative Trait Loci) analysis. Its primary contribution is the `smlSet` class, which extends the standard Bioconductor `eSet` to include genotype data managed by the `snpStats` package. It is designed to handle large-scale genomic data efficiently by using environments to store genotype matrices, reducing memory overhead during function calls.

## Core Workflows

### 1. Data Structure: The smlSet
The `smlSet` object integrates expression data, SNP genotypes, and phenotypic metadata.

```r
library(GGBase)

# Inspect the class structure
getClass("smlSet")

# Access genotype data (returns a list of SnpMatrix objects)
snps <- smList(mySmlSet)

# Access expression data
expression <- exprs(mySmlSet)

# Filter features
filtered_set <- nsFilter(mySmlSet)
```

### 2. Loading Data with getSS
While `GGBase` defines the structure, `getSS` (often used in conjunction with `GGtools`) is the standard way to instantiate these objects, typically partitioned by chromosome to save memory.

```r
# Example: Loading data for chromosome 20
# Requires a package formatted for GGBase/GGtools
s20 <- getSS("PackageName", "20")
```

### 3. Visualizing Gene-SNP Relationships
Use `plot_EvG` (Expression vs Genotype) to visualize the relationship between a specific gene (by symbol or probe ID) and a specific SNP (by rsid).

```r
# Plotting by Gene Symbol and RSID
plot_EvG(genesym("CPNE1"), rsid("rs6060535"), s20)

# Plotting by Probe ID
plot_EvG(probeId("12345_at"), rsid("rs6060535"), s20)
```

### 4. Genotype Representations
Genotypes in an `smlSet` are stored as `SnpMatrix` objects. You can coerce them into different formats for analysis:

```r
# Extract the first chromosome's matrix
sm <- smList(s20)[[1]]

# Raw bytes (internal representation)
as(sm, "matrix")[1:5, 1:5]

# Character calls (e.g., "A/A", "A/B")
as(sm, "character")[1:5, 1:5]

# Numeric counts (0, 1, 2 - counts of the risk allele)
as(sm, "numeric")[1:5, 1:5]
```

## Memory Management

- **Environment Storage**: Genotypes are stored in the `smlEnv` slot (an R environment). This allows the `smlSet` to be passed to functions without copying the heavy genotype data.
- **Externalization**: For very large datasets, use the `externalize` function to create a package structure where genotypes are stored as `.rda` files in `inst/parts`, allowing chromosome-at-a-time loading.
- **Principal Components**: Use `clipPCs` to remove principal components from the expression data to control for population structure or batch effects.

## Reference documentation

- [GGBase: infrastructure for genetics of gene expression](./references/ggbase.md)