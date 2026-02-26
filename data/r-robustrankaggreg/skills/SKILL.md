---
name: r-robustrankaggreg
description: This tool aggregates multiple prioritized lists into a single consensus ranking using robust rank aggregation or simple summary statistics. Use when user asks to combine ranked gene lists, perform meta-analysis of ranked data, or calculate significance scores for aggregated elements.
homepage: https://cran.r-project.org/web/packages/robustrankaggreg/index.html
---


# r-robustrankaggreg

name: r-robustrankaggreg
description: Methods for robust rank aggregation (RRA) to combine multiple prioritized lists (e.g., gene lists from different experiments) into a single consensus ranking. Use this skill when you need to perform meta-analysis of ranked data, calculate significance probabilities for aggregated elements, or use simple aggregation methods like min, max, or average ranking.

## Overview
The `RobustRankAggreg` package provides methods for aggregating ranked lists, specifically designed for biological data like gene lists. The primary method, Robust Rank Aggregation (RRA), uses a probabilistic model to detect elements that are ranked consistently higher than expected by chance. It is robust to noise, outliers, and varying list lengths.

## Installation
```R
install.packages("RobustRankAggreg")
```

## Core Functions

### aggregateRanks
The main function for performing rank aggregation.
- `glist`: A list of character vectors, where each vector is a ranked list of items.
- `rmethod`: The aggregation method. Options include:
    - `"RRA"`: Robust Rank Aggregation (default).
    - `"min"`, `"max"`, `"mean"`, `"median"`, `"geometric"`: Simple summary statistics.
- `N`: The total number of possible items (e.g., total genes in the genome). If NULL, it is inferred from the input.

### rhoScores
Calculates the rho scores (the basis of RRA) for a set of ranks. Useful for custom workflows or manual significance testing.

## Workflow: Basic Rank Aggregation

1. **Prepare Data**: Organize your rankings into a list of character vectors.
```R
library(RobustRankAggreg)

list1 <- c("GeneA", "GeneB", "GeneC", "GeneD")
list2 <- c("GeneB", "GeneA", "GeneE", "GeneC")
list3 <- c("GeneB", "GeneA", "GeneC", "GeneF")

all_lists <- list(list1, list2, list3)
```

2. **Run Aggregation**:
```R
# Perform RRA
results <- aggregateRanks(glist = all_lists, rmethod = "RRA")

# View top results
head(results)
```

3. **Interpret Results**:
The output is a data frame with two columns: `Name` (the item) and `Score` (the p-value/significance score). Lower scores indicate higher confidence in the consensus ranking.

## Tips for Success
- **Normalization**: RRA internally converts ranks to relative ranks (rank/N). Ensure `N` is consistent across your analysis if you are comparing different runs.
- **Incomplete Lists**: You do not need all items to appear in every list. RRA handles missing items by assuming they are ranked at the bottom of the missing lists.
- **Input Order**: Ensure your input lists are ordered from most significant (top) to least significant (bottom).

## Reference documentation
- [RobustRankAggreg: Methods for Robust Rank Aggregation](./references/home_page.md)