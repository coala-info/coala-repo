---
name: fastlink
description: The fastlink tool performs probabilistic record linkage to merge disparate datasets while accounting for typographical errors and missing values. Use when user asks to merge dataframes using probabilistic matching, link records with string similarity, or perform deduplication on large administrative datasets.
homepage: https://github.com/kosukeimai/fastLink
metadata:
  docker_image: "biocontainers/fastlink:v4.1P-fix100dfsg-2-deb_cv1"
---

# fastlink

## Overview
The `fastlink` skill enables the merging of disparate dataframes by calculating the probability that two records refer to the same entity. Unlike deterministic merging, it accounts for typographical errors, missing values, and varying levels of string similarity. It is specifically optimized for performance on large administrative datasets, utilizing parallelization and efficient algorithms to handle millions of potential record pairs.

## Implementation Patterns

### Core Linkage Workflow
The primary entry point is the `fastLink()` wrapper, which automates the entire process from parameter estimation to final matching.

```r
library(fastLink)

# Basic probabilistic merge
results <- fastLink(
  dfA = data1, 
  dfB = data2, 
  varnames = c("firstname", "lastname", "zipcode"),
  stringdist.match = c("firstname", "lastname"), # Variables for Jaro-Winkler distance
  partial.match = c("firstname")                 # Variables allowing partial agreement
)
```

### Optimization for Large Datasets
When working with very large files (e.g., >100k rows), use these patterns to prevent memory exhaustion and reduce runtime:

1.  **Sampling for EM Estimation**: Run the EM algorithm on a random sample to estimate parameters, then apply those parameters to the full dataset.
    ```r
    # Step 1: Estimate parameters on a sample
    em_estimates <- fastLink(
      dfA = data1, dfB = data2, varnames = vars,
      estimate.only = TRUE
    )
    
    # Step 2: Apply estimates to full data
    results <- fastLink(
      dfA = data1, dfB = data2, varnames = vars,
      em.obj = em_estimates
    )
    ```
2.  **Parallelization**: Explicitly set `n.cores` to utilize multi-core processing.
3.  **Blocking**: While `fastLink` is fast, consider pre-blocking data if the Cartesian product is prohibitively large.

### Expert Tips and Best Practices
*   **String Distance Thresholds**: The default `cut.a` (full match) is 0.92 and `cut.p` (partial match) is 0.88. Lower these if your data has significant OCR errors or high variance in spelling.
*   **Deduplication**: Set `dedupe.matches = TRUE` to ensure a 1-to-1 mapping between datasets. For very large N where linear programming is slow, `linprog.dedupe = FALSE` uses a faster iterative maximum posterior selection.
*   **Gender Blocking**: If matching on gender, use the `gender.field` argument. This enforces near-perfect blocking, preventing matches between different genders and improving EM convergence.
*   **Handling Movers**: Use `calcMoversPriors()` if you have auxiliary information about population mobility to improve match accuracy across different geographic regions.

## Common Parameters
*   `varnames`: Vector of variable names present in both dataframes used for matching.
*   `stringdist.match`: Variables where Jaro-Winkler distance should be calculated instead of exact matching.
*   `partial.match`: Variables that should have a "partial agreement" category (requires being in `stringdist.match`).
*   `threshold.match`: The posterior probability cutoff (default 0.85). Increase this to reduce false positives.

## Reference documentation
- [fastLink: Fast Probabilistic Record Linkage](./references/github_com_kosukeimai_fastLink.md)