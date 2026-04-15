---
name: bioconductor-clst
description: This tool performs supervised classification using a modified nearest-neighbor approach based on pairwise distances. Use when user asks to perform taxonomic or group classification, calculate optimal distance thresholds using mutual information, or visualize classification confidence and distance distributions.
homepage: https://bioconductor.org/packages/release/bioc/html/clst.html
---

# bioconductor-clst

name: bioconductor-clst
description: Supervised classification using a modified nearest-neighbor approach. Use this skill to perform taxonomic or group classification based on pairwise distances, calculate optimal distance thresholds using mutual information, and visualize classification confidence and confusion.

# bioconductor-clst

## Overview

The `clst` package provides a robust framework for supervised classification based on pairwise distances. Unlike standard nearest-neighbor methods, it uses a "match score" ($s$) calculated relative to a distance threshold ($D$). This threshold is typically determined by maximizing the mutual information between within-class and between-class distances. The package is particularly useful for biological classification where group sizes vary and clear separation between taxa is required.

## Core Workflow

### 1. Data Preparation
The package requires a square distance matrix and a factor defining the groups (classes) for the reference set.

```r
library(clst)
# Example using iris data
data(iris)
dmat <- as.matrix(dist(iris[,1:4], method="euclidean"))
groups <- iris$Species
```

### 2. Finding the Distance Threshold (D)
The threshold $D$ partitions within-class and between-class comparisons.

```r
# Find threshold using mutual information
thresh <- findThreshold(dmat, groups, type="mutinfo")
print(thresh$D) # The optimal distance value
```

### 3. Classification
To classify a new object, you need a vector of distances (`dvect`) between the query and every object in the reference set.

```r
# Extract distances for a single query (e.g., the first item)
dvect1 <- dmat[1, -1]
dmat1 <- dmat[-1, -1]
groups1 <- groups[-1]

# Perform classification
# minScore (C): score cutoff for membership (default 0.45)
# doffset (d): small value to prevent over-weighting small groups (default 0.5)
cc <- classify(dmat1, groups1, dvect1, minScore=0.45, doffset=0.5)

# View results
printClst(cc)
```

### 4. Interpreting Outcomes
The `classify` function returns a list of classification objects (one for each "depth" if re-partitioning occurs).
- **Match**: Query score > `minScore` for exactly one class.
- **Confusion**: Query score > `minScore` for multiple classes.
- **No Match**: Query score < `minScore` for all classes.
- **Outlier**: Distances to reference objects are significantly larger than typical between-class distances.

## Visualization and Analysis

### Distance Distributions
Visualize how well the threshold $D$ separates within-group and between-group distances:
```r
plot(do.call(plotDistances, thresh))
```

### Multidimensional Scaling (MDS)
Visualize the reference set and highlight classification results:
```r
# Basic MDS plot
plot(scaleDistPlot(dmat, groups))

# Highlight specific indices or classification outcomes
# fill: logical vector for filled points
# O: logical vector for circles
# X: logical vector for crossed out points
plot(scaleDistPlot(dmat, groups, fill=is_confused, X=is_nomatch))
```

### Leave-one-out (LOO) Validation
Assess classifier performance by iteratively removing one sample and classifying it against the rest:
```r
loo <- lapply(seq_along(groups), function(i){
  do.call(classify, pull(dmat, groups, i))
})
matches <- lapply(loo, function(x) rev(x)[[1]]$matches)
result <- sapply(matches, paste, collapse='-')
table(result, groups)
```

## Tips
- **Sensitivity vs. Specificity**: Increase `minScore` (e.g., to 0.65) to reduce false positives (confusion), though this may increase "no match" results.
- **Small Groups**: The `doffset` parameter is critical when reference groups have very few members; it prevents a single close match from creating a perfect score of 1.0.
- **Recursive Partitioning**: If `classify` results in confusion, it automatically attempts to re-partition the remaining candidate classes until `maxDepth` is reached.

## Reference documentation
- [clst demo](./references/clstDemo.md)