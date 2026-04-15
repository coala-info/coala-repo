---
name: bioconductor-perfect
description: This tool filters rare and spurious taxa from microbiome datasets using covariance-based filtering loss functions. Use when user asks to remove noise from 16S rRNA sequencing data, perform simultaneous or permutation-based taxa filtering, or identify a filtering cutoff for OTU tables.
homepage: https://bioconductor.org/packages/3.10/bioc/html/PERFect.html
---

# bioconductor-perfect

name: bioconductor-perfect
description: Comprehensive taxa filtering for microbiome data using the PERFect R package. Use when Claude needs to identify and remove noise or spurious taxa from 16S rRNA sequencing data using permutation-based or simultaneous filtering algorithms based on covariance loss.

# bioconductor-perfect

## Overview

PERFect (PERmutation Filtering test) is an R package designed to filter rare and spurious taxa from microbiome datasets (e.g., 16S rRNA gene sequencing). Unlike simple abundance-based filtering, PERFect uses a "filtering loss" (FL) function to measure a taxon's contribution to the total covariance of the OTU table. It identifies a "cutoff" taxon; all taxa less important than this cutoff are removed.

The package provides two main approaches:
1. **Simultaneous Filtering**: A faster, distribution-based approach.
2. **Permutation Filtering**: A more robust approach using permutation tests, with a "fast" binary search option for efficiency.

## Installation

```r
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("PERFect")
library(PERFect)
```

## Core Workflows

### 1. Simultaneous Filtering
This is the quickest method. It fits a Skew-Normal distribution to the log-difference in filtering loss to calculate p-values.

```r
# X is an OTU matrix/data frame (taxa in columns, samples in rows)
res_sim <- PERFect_sim(X = Counts)

# Access filtered data
filtered_counts <- res_sim$filtX

# Access p-values
taxa_pvals <- res_sim$pvals
```

### 2. Permutation Filtering
More robust than simultaneous filtering. It builds a permutation distribution for each taxon.

*   **Full Algorithm**: Calculates p-values for all taxa (computationally expensive).
*   **Fast Algorithm**: Uses an unbalanced binary search to find the cutoff taxon efficiently.

```r
# Using the 'fast' algorithm is recommended for large datasets
res_perm <- PERFect_perm(X = Counts, 
                         Order = "pvals", 
                         pvals_sim = res_sim, 
                         algorithm = "fast")
```

### 3. Handling Metadata
If your OTU table contains metadata columns (e.g., SampleID, Treatment), specify them using `infocol` so they are ignored during the mathematical filtering but preserved if necessary.

```r
# Ignore the first 3 columns as metadata
res_sim <- PERFect_sim(X = Counts, infocol = c(1, 2, 3))
```

### 4. Custom Taxa Ordering
By default, PERFect orders taxa by abundance. You can provide a custom order (e.g., alphabetical or based on prior significance).

```r
custom_order <- colnames(Counts)[order(colnames(Counts))]
res_sim <- PERFect_sim(X = Counts, Order.user = custom_order)
```

## Visualization

Use `pvals_Plots()` to visualize the p-values and the identified filtering cutoff.

```r
# Generate plot object
p_obj <- pvals_Plots(PERFect = res_sim, X = Counts, alpha = 0.1)

# Display plot
p_obj$plot
```

## Key Parameters

*   `alpha`: Significance level (default is 0.1). Lower values are more conservative (keep more taxa).
*   `k`: Number of permutations for `PERFect_perm()` (default is 10,000).
*   `rollmean`: Whether to use a rolling mean to smooth p-values (default is `TRUE`).

## Reference documentation

- [Method Illustration](./references/MethodIllustration.md)
- [Method Illustration (Rmd Source)](./references/MethodIllustration.Rmd)