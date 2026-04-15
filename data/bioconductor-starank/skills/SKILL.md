---
name: bioconductor-starank
description: The bioconductor-starank package identifies variables that consistently rank highly across replicate measurements using stability ranking and bootstrapping. Use when user asks to perform stability ranking, identify robust gene hits across replicates, or compare base rankings with averaged and stability-based rankings.
homepage: https://bioconductor.org/packages/3.5/bioc/html/staRank.html
---

# bioconductor-starank

## Overview
The `staRank` package provides methods for stability ranking, which identifies variables (like genes) that consistently rank highly across replicate measurements. It uses bootstrapping to estimate the stability of an element's position within the top *k* set of a ranking. This approach is more robust than simple averaging as it accounts for variance and reproducibility, helping to prioritize hits in high-throughput biological experiments.

## Core Workflow

### 1. Data Preparation
Input data should be a matrix where rows represent variables (e.g., genes) and columns represent replicate measurements.

```r
library(staRank)
# Example: matrix with genes as rows and replicates as columns
# data <- matrix(...) 
```

### 2. Performing Stability Ranking
The primary function is `stabilityRanking()`. It can be used with built-in methods or external ranking data.

**Using Built-in Methods:**
Supported methods include `'mean'`, `'median'`, `'mwtest'` (Mann-Whitney/Rank Sum), `'ttest'`, and `'RSA'`.

```r
# Perform stability ranking using the mean as the base statistic
sRank_results <- stabilityRanking(data, method = 'mean')
```

**Using External Rankings:**
If you have a custom ranking and a matrix of bootstrap/sample rankings:
```r
# extRanking: named vector of original ranks
# sampleRankings: matrix where rows match extRanking and columns are bootstrap iterations
sRank_ext <- stabilityRanking(extRanking, sampleRankings, method = 'custom')
```

### 3. Extracting and Interpreting Results
The function returns a `RankSummary` object containing three types of rankings:
*   **Base Rank**: The ranking based on the original statistic (e.g., mean).
*   **Stability Rank**: The final ranking based on the stability of the element in the top *k* sets.
*   **Averaged Rank**: An aggregated ranking averaging the rank of a variable over all bootstrap samples.

```r
# Get specific rankings
base_r <- baseRank(sRank_results)
stab_r <- stabRank(sRank_results)
avrg_r <- avrgRank(sRank_results)

# Get a combined matrix of all three rankings
rank_matrix <- getRankmatrix(sRank_results)

# Check correlation between the different ranking types
rankCor(sRank_results)
```

### 4. Assessing Stability
To understand how stable the ranking is at different cutoffs (*k*), use `stableSetSize()`.

```r
# Returns a vector of stable set sizes for each cutoff k
stable_sizes <- stableSetSize(sRank_results)

# Plotting stable set sizes (the closer to the diagonal, the more stable)
plot(stable_sizes, type='l', xlab='k*', ylab='stable genes')
abline(0, 1, col='gray')
```

## Summary and Visualization
Use the `summary()` function on a `RankSummary` object to quickly view top percentage cutoffs and stable set sizes.

```r
summary(sRank_results)
```

## Tips
*   **RSA Method**: The RSA (Redundant siRNA Activity) method is particularly useful for RNAi screens where multiple reagents target the same gene.
*   **Filtering**: It is often beneficial to filter out low-effect variables (e.g., genes with mean values near zero) before running the stability analysis to focus on potential hits.
*   **Replicates**: Stability ranking is most effective when at least 3 replicates are available to allow for meaningful bootstrapping.

## Reference documentation
- [Stability ranking with the staRank package](./references/staRank.md)