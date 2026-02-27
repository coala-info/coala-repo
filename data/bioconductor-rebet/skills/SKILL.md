---
name: bioconductor-rebet
description: This tool performs the subREgion-based BurdEn Test to detect rare variant associations by aggregating variants into biologically meaningful sub-regions. Use when user asks to identify specific sub-regions within a gene that drive genetic associations, aggregate rare variants into functional domains, or perform burden testing with heterogeneous risk effects.
homepage: https://bioconductor.org/packages/release/bioc/html/REBET.html
---


# bioconductor-rebet

name: bioconductor-rebet
description: Perform the subREgion-based BurdEn Test (REBET) to detect rare variant associations. Use this skill when you need to identify specific sub-regions within a gene that drive genetic associations, especially when risk effects are heterogeneous across different functional domains.

## Overview

REBET (subREgion-based BurdEn Test) is an R package designed to aggregate rare variants into biologically meaningful sub-regions. Unlike standard burden tests that collapse all variants in a gene, REBET searches for the strongest association signal among all possible combinations of sub-regions. This approach is particularly powerful for identifying which specific parts of a gene (e.g., functional domains) contribute most to a disease phenotype.

## Typical Workflow

### 1. Data Preparation
REBET requires four primary inputs:
- **Y**: A numeric vector of the phenotype/response variable.
- **G**: A genotype matrix (subjects in rows, variants in columns) containing expected dosages.
- **E**: A character vector of sub-region names corresponding to each column (variant) in `G`.
- **covariates** (Optional): A matrix of adjusted covariates (e.g., Age, Gender).

### 2. Defining Sub-regions
Sub-regions are typically defined by genomic coordinates. You must map each variant in your genotype matrix to a specific sub-region name.

```r
# Example: Mapping variants to sub-regions based on position
# locs: vector of variant positions
# subRegions: matrix with start/end coordinates and row names as sub-region IDs
E <- rep("", length(locs))
for (i in 1:nrow(subRegions)) {
  idx <- (locs >= subRegions[i, 1]) & (locs <= subRegions[i, 2])
  if (any(idx, na.rm = TRUE)) E[idx] <- rownames(subRegions)[i]
}
```

### 3. Running the Test
The core function is `rebet()`. It handles the search for the optimal sub-region combination and adjusts for multiple testing.

```r
library(REBET)
# Run REBET
result <- rebet(Y, G, E, covariates = X)
```

### 4. Summarizing Results
REBET results are best interpreted using the `h.summary()` function from the `ASSET` package (a dependency).

```r
library(ASSET)
summary_stats <- h.summary(result)
print(summary_stats)
```

The output includes:
- **$Meta**: Overall gene-level significance.
- **$Subset.1sided / $Subset.2sided**: Identification of the specific sub-regions (e.g., "Region_SR3") driving the association.

## Implementation Tips

- **Dosage Data**: If using IMPUTE2 or similar data, calculate dosages as `P(a1/a2) + 2*P(a2/a2)`.
- **Missing Data**: Ensure missing genotypes are handled as `NA`. If all genotype probabilities for a subject are 0, the dosage should be `NA`.
- **Subject Matching**: Always ensure the order of subjects in the phenotype vector `Y` and covariate matrix `X` matches the row order of the genotype matrix `G`.
- **Sub-region Names**: Ensure every variant used in the test is assigned to a sub-region in the `E` vector; variants with empty strings in `E` may be excluded or cause errors depending on the implementation context.

## Reference documentation

- [REBET Vignette](./references/vignette.md)