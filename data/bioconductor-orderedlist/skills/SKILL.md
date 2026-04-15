---
name: bioconductor-orderedlist
description: This tool analyzes the similarity between two ordered gene lists or expression studies using weighted rank-based scores. Use when user asks to compare results from independent genomic experiments, calculate similarity between ranked gene lists, or identify common genes across different expression platforms.
homepage: https://bioconductor.org/packages/release/bioc/html/OrderedList.html
---

# bioconductor-orderedlist

name: bioconductor-orderedlist
description: Analysis of similarity between two ordered gene lists or expression studies. Use this skill to compare results from different genomic experiments, calculate weighted similarity scores based on rank overlap, and identify common genes across studies even when platforms differ.

# bioconductor-orderedlist

## Overview

The `OrderedList` package provides methods to compare two ranked lists of genes (or other identifiers). It is designed for "comparison of comparisons"—for example, comparing the results of two independent gene expression studies investigating the same biological phenomenon. It uses a weighted similarity score that places more importance on genes at the top (up-regulated) and bottom (down-regulated) of the rankings. The package supports both raw expression data (using sub-sampling for significance) and simple ordered lists (using permutations).

## Core Workflows

### 1. Comparing Two Expression Studies

When you have `ExpressionSet` objects for two studies, use the `prepareData` and `OrderedList` functions.

```R
library(OrderedList)

# 1. Prepare data (merges two studies and handles mapping)
# 'out' defines the two classes; order should be c("bad_outcome", "good_outcome")
data_prepared <- prepareData(
  eset1 = list(data = studyA, name = "StudyA", var = "status", out = c("Rec", "NRec"), paired = FALSE),
  eset2 = list(data = studyB, name = "StudyB", var = "risk", out = c("high", "low"), paired = FALSE),
  mapping = mapping_df # Optional: data frame with two columns of matching IDs
)

# 2. Run the comparison
# beta = 1 if class labels match (e.g., both compare good vs bad)
# beta = 0.5 if orientation is unknown
result <- OrderedList(data_prepared, B = 1000, beta = 1)

# 3. Inspect results
print(result)
plot(result, "overlap") # Visualizes overlap across ranks
overlapping_genes <- result$intersect # Genes contributing to 95% of similarity
```

### 2. Comparing Two Ordered Lists (No Expression Data)

If you only have ranked vectors of IDs, use `compareLists`.

```R
# list1 and list2 are character vectors of IDs in ranked order
# two.sided = TRUE compares both ends (up and down regulated)
comparison <- compareLists(list1, list2, B = 1000, two.sided = TRUE)

# View summary table of different alpha (weighting) values
print(comparison)

# Extract overlapping genes for a specific rank depth (e.g., top 100)
overlap_res <- getOverlap(comparison, max.rank = 100)
print(overlap_res$intersect)
```

## Key Parameters

- **alpha**: Controls the exponential decay of weights ($w = \exp(-\alpha n)$). A smaller $\alpha$ considers more genes further down the list. `OrderedList` optimizes this automatically using pAUC scores.
- **beta**: Set to `1` if the direction of the comparison is the same in both studies. Set to `0.5` if you want to test both the direct and flipped orientation (e.g., if "Class 1" in Study A might be "Class 2" in Study B).
- **mapping**: A data frame with two columns. Use this when the two studies use different ID types (e.g., different Affymetrix chips). Each row must represent a one-to-one mapping of the same gene.
- **percent**: By default (0.95), the `intersect` list contains genes contributing to the top 95% of the similarity score.

## Visualization Methods

- `plot(x, "pauc")`: Shows how $\alpha$ was optimized by maximizing the separation between observed and random scores.
- `plot(x, "scores")`: Shows the density of observed vs. random similarity scores.
- `plot(x, "overlap")`: Displays the number of overlapping genes as a step function across ranks, with confidence intervals.

## Reference documentation

- [Similarities of Ordered Gene Lists - User's Guide](./references/tr_2006_01.md)