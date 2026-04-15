---
name: bioconductor-metaseq
description: This tool performs meta-analysis of RNA-seq count data from multiple studies while accounting for sequencing depth variations. Use when user asks to integrate differentially expressed gene probabilities across experiments, perform meta-analysis on RNA-seq datasets, or identify consistently regulated genes using Fisher's or Stouffer's methods.
homepage: https://bioconductor.org/packages/release/bioc/html/metaSeq.html
---

# bioconductor-metaseq

name: bioconductor-metaseq
description: Meta-analysis of RNA-seq count data from multiple studies. Use this skill to integrate differentially expressed gene (DEG) probabilities across different experiments while accounting for Read-Size Effect (RSE). This skill is appropriate for combining results from studies with varying sequencing depths using NOISeq-based probabilities and Fisher's or Stouffer's integration methods.

# bioconductor-metaseq

## Overview

The `metaSeq` package provides tools for the meta-analysis of RNA-seq count data. It specifically addresses the "Read-Size Effect" (RSE), where differences in sequencing depth between studies can bias statistical significance. The package utilizes the NOISeq method for individual study analysis because of its robustness against sequencing depth variations. It then integrates these one-sided probabilities using either Fisher’s method or Stouffer’s (inverse normal) method to identify consistently up-regulated or down-regulated genes across multiple datasets.

## Core Workflow

### 1. Data Preparation

Prepare a count matrix where rows are genes and columns are samples. You also need two metadata vectors:
- **Condition Factor**: Indicates the experimental group (e.g., 0 for Control, 1 for Treatment).
- **Study Factor**: Indicates which study each sample belongs to (e.g., "StudyA", "StudyB").

```r
library(metaSeq)
library(snow)

# Example data structure
# counts: matrix of RNA-seq counts
# group: c(1,1,0,0, 1,0, 1,1,0)
# study: c("A","A","A","A", "B","B", "C","C","C")

cds <- meta.readData(data = counts, factor = group, studies = study)
```

### 2. Calculate One-Sided Probabilities

Perform one-sided NOISeq for each study. This step is computationally intensive and benefits from parallelization using the `snow` package.

```r
# Setup parallel cluster
cl <- makeCluster(4, "SOCK")

# Calculate probabilities
# k: replacement for 0 counts (default 0.5)
# norm: normalization method ("tmm", "rpkm", "uqua", "none")
result <- meta.oneside.noiseq(cds, k = 0.5, norm = "tmm", 
                             replicates = "biological", 
                             factor = group, conditions = c(1, 0), 
                             studies = study, cl = cl)

stopCluster(cl)
```

### 3. Meta-Analysis Integration

Integrate the results using Fisher's or Stouffer's method. Both return a list containing `Upper` (up-regulated) and `Lower` (down-regulated) probabilities.

- **Fisher's Method**: Standard meta-analysis integration.
- **Stouffer's Method**: Weights studies by the number of replicates (sample size).

```r
# Fisher's Method
res_fisher <- Fisher.test(result)

# Stouffer's Method
res_stouffer <- Stouffer.test(result)

# Access results
head(res_fisher$Upper) # Probabilities for up-regulation
head(res_fisher$Lower) # Probabilities for down-regulation
res_fisher$Weight      # Replicate counts per study
```

## Meta-Analysis with External Methods

If you have p-values from other tools (e.g., DESeq2, edgeR, Cuffdiff), use `other.oneside.pvalues` to format them for integration.

1.  Prepare two matrices: one for "upper" p-values and one for "lower" p-values.
2.  Provide a weight vector (usually sample sizes).

```r
# upper: matrix of p-values for up-regulation
# lower: matrix of p-values for down-regulation (often 1 - upper)
# weights: vector of study weights

ext_result <- other.oneside.pvalues(upper, lower, weights)

# Integrate as usual
final_res <- Fisher.test(ext_result)
```

## Tips and Best Practices

- **One-Sided Tests**: Ensure input p-values or probabilities are one-sided. `metaSeq` is designed to detect direction-specific differential expression.
- **Parallelization**: Always use `makeCluster` for `meta.oneside.noiseq` if working with large datasets or many studies, as the per-gene probability estimation is slow.
- **Interpretation**: The output values are probabilities (0 to 1). Higher values in the `Upper` list indicate a higher probability that the gene is up-regulated in the treatment group across studies.
- **Missing Values**: If a gene is missing in a specific study, the integration functions handle `NA` values, but ensure gene identifiers (row names) are consistent across all input matrices.

## Reference documentation

- [metaSeq](./references/metaSeq.md)