---
name: bioconductor-hierinf
description: This tool performs hierarchical inference for genome-wide association studies to identify significant associations between SNP clusters and phenotypes while controlling the familywise error rate. Use when user asks to test for associations between groups of SNPs and a response variable, cluster variables by similarity or genomic position, or perform meta-analysis across multiple datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/hierinf.html
---

# bioconductor-hierinf

name: bioconductor-hierinf
description: Perform hierarchical inference for genome-wide association studies (GWAS) using the hierinf R package. Use this skill to test for significant associations between groups of SNPs and a response variable while controlling the familywise error rate (FWER). It supports high-dimensional multivariate models, hierarchical clustering of variables, position-based partitioning, and meta-analysis across multiple datasets.

## Overview

The `hierinf` package provides a framework for statistically efficient hypothesis testing in GWAS. It uses a top-down approach on a hierarchical tree of SNPs (often organized by chromosomes) to identify significant clusters or individual SNPs associated with a phenotype. This method is particularly effective for high-dimensional data where SNPs are correlated.

## Core Workflow

The standard analysis involves two primary steps: building the hierarchy and testing it.

### 1. Data Preparation
The package requires complete observations (no missing values). Input SNP data should be a matrix for optimal performance.

```r
library(hierinf)

# Set random number generator for reproducibility (especially for parallel computing)
RNGkind("L'Ecuyer-CMRG")

# Load example data
data(simGWAS)
sim.geno <- simGWAS$x      # SNP matrix
sim.pheno <- simGWAS$y     # Response (binary or continuous)
sim.clvar <- simGWAS$clvar # Control variables (age, sex, etc.)
```

### 2. Building the Hierarchical Tree
You can build the tree based on variable similarity or genomic position. It is highly recommended to define "blocks" (e.g., chromosomes) to allow for parallel processing.

**Option A: Clustering by Similarity**
```r
# Define blocks (e.g., Chromosome 1 and 2)
block <- data.frame("colname" = colnames(sim.geno),
                    "block" = rep(c("chrom 1", "chrom 2"), each = 500),
                    stringsAsFactors = FALSE)

# Cluster based on correlation
dendr <- cluster_var(x = sim.geno, block = block)
```

**Option B: Clustering by Genomic Position**
```r
position <- data.frame("colnames" = colnames(sim.geno),
                       "position" = 1:1000,
                       stringsAsFactors = FALSE)

dendr.pos <- cluster_position(position = position, block = block)
```

### 3. Hierarchical Testing
The `test_hierarchy` function performs the inference using multi-sample splitting.

```r
set.seed(1234)
result <- test_hierarchy(x = sim.geno,
                         y = sim.pheno,
                         clvar = sim.clvar,
                         dendr = dendr,
                         family = "binomial") # Use "gaussian" for continuous response

# View significant clusters
print(result)
```

## Advanced Features

### Parallel Computing
Most functions support parallelization via the `parallel` and `ncpus` arguments. Use `"multicore"` for Unix/Mac and `"snow"` for Windows.

```r
result <- test_hierarchy(..., parallel = "multicore", ncpus = 4)
```

### Meta-analysis (Multiple Datasets)
To analyze multiple studies jointly, provide `x`, `y`, and `clvar` as lists of matrices. The package aggregates p-values using Tippett's rule (default) or Stouffer's method.

```r
# x, y, and clvar are lists where each element is a dataset
result_meta <- test_hierarchy(x = list(geno1, geno2),
                              y = list(pheno1, pheno2),
                              dendr = joint_dendr,
                              agg.method = "Tippett")
```

### Calculating R-squared
For significant clusters, you can calculate the adjusted R² (continuous) or Nagelkerke’s R² (binary).

```r
# Get column names of a specific significant cluster
coln.cluster <- result$res.hierarchy[[2, "significant.cluster"]]

# Compute R2
r2_val <- compute_r2(x = sim.geno, y = sim.pheno, 
                     res.test.hierarchy = result, 
                     colnames.cluster = coln.cluster)
```

## Tips and Best Practices
- **Missing Values**: Impute missing data using packages like `mice` or `missForest` before using `hierinf`.
- **Block Definition**: Always specify the `block` argument (usually by chromosome) when working with large GWAS datasets to prevent memory exhaustion and enable parallelization.
- **Reproducibility**: Always set `RNGkind("L'Ecuyer-CMRG")` and `set.seed()` before running `test_hierarchy`.

## Reference documentation
- [Hierarchical inference for genome-wide association studies](./references/vignette-hierinf.md)