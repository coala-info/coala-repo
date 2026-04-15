---
name: bioconductor-matchbox
description: This tool performs Correspondence-At-the-TOP analysis to compare and visualize the consistency of ranked genomic features across different experiments or platforms. Use when user asks to filter redundant genomic features, merge datasets by common identifiers, compute overlapping proportions between ranked lists, or generate CAT curves with hypergeometric probability intervals.
homepage: https://bioconductor.org/packages/release/bioc/html/matchBox.html
---

# bioconductor-matchbox

name: bioconductor-matchbox
description: Perform Correspondence-At-the-TOP (CAT) analysis to compare ranked vectors of features (e.g., genes) across different experiments, platforms, or studies. Use this skill to filter redundant genomic features, merge datasets by common identifiers, compute overlapping proportions at increasing list depths, and visualize agreement using CAT curves and hypergeometric probability intervals.

## Overview

The `matchBox` package is designed to assess the consistency of high-throughput data (like differential gene expression) across different studies. It uses CAT curves to plot the proportion of overlapping elements between two ranked lists against the number of considered features. This is particularly useful in genomics where only the top-ranked features are expected to be biologically relevant.

## Typical Workflow

### 1. Data Preparation and Redundancy Filtering
Datasets often contain multiple probes for the same gene. Use `filterRedundant` to ensure unique identifiers before comparison.

```R
library(matchBox)
data(matchBoxExpression)

# Remove redundancy (e.g., multiple probes per SYMBOL)
# byCol: the statistics used to select the representative feature (e.g., "t", "logFC", "P.Value")
# method: "maxORmin", "geoMean", "random", "mean", or "median"
filteredData <- lapply(matchBoxExpression, filterRedundant, 
                       idCol="SYMBOL", 
                       byCol="t", 
                       absolute=TRUE)
```

### 2. Merging Datasets
Combine multiple data frames into a single object containing only common identifiers and their respective ranking statistics.

```R
# idCol: common identifier column
# byCol: the statistics column to extract for ranking
mergedData <- mergeData(filteredData, idCol="SYMBOL", byCol="t")
```

### 3. Computing CAT Curves
Calculate the overlapping proportions. You can compare all pairs or use a specific dataset as a reference.

```R
# method: "equalRank" (compare top N) or "equalStat" (compare features meeting a threshold)
# decreasing: TRUE for up-regulated/top-ranked; FALSE for down-regulated
catResults <- computeCat(data = mergedData, 
                         idCol = 1, 
                         ref = "dataSetA.t", 
                         method = "equalRank", 
                         decreasing = TRUE)
```

### 4. Probability Intervals
Compute expected overlap intervals based on the hypergeometric distribution to determine if the observed agreement is better than random.

```R
# expectedProp: assumed proportion of similarly ranked features (default 0.1)
# Set expectedProp = NULL for an unspecified proportion
intervals <- calcHypPI(data = mergedData, expectedProp = 0.3)
```

### 5. Visualization
Plot the CAT curves with the computed probability intervals.

```R
plotCat(catData = catResults, 
        preComputedPI = intervals, 
        main = "CAT curves: Decreasing t-statistics",
        col = c("red", "blue"), 
        legend = TRUE)
```

## Key Functions and Parameters

- `filterRedundant()`: Essential for mapping probe-level data to gene-level data. Use `absolute=TRUE` when ranking by magnitude (like t-statistics) regardless of direction.
- `computeCat()`: The core engine. If `ref` is omitted, all possible pairwise combinations are calculated.
- `calcHypPI()`: Generates the grey-shaded confidence zones seen in CAT plots. The `prob` argument defines the quantiles (e.g., 0.95, 0.99).
- `plotCat()`: Customizes the visual output. Use `spacePts` to control the frequency of symbols on the lines for better readability.

## Reference documentation

- [matchBox](./references/matchBox.md)