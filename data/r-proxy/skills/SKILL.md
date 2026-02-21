---
name: r-proxy
description: Provides an extensible framework for the efficient calculation of auto- and cross-proximities, along with implementations of the most popular ones. </p>
homepage: https://cloud.r-project.org/web/packages/proxy/index.html
---

# r-proxy

## Overview
The `proxy` package provides an extensible framework for efficient calculation of auto- and cross-proximities. It abstracts the process of computing distances and similarities, offering a unified interface (`dist` and `simil`) for over 50 built-in measures while allowing users to register new ones.

## Installation
```R
install.packages("proxy")
```

## Core Functions

### 1. Computing Proximities
The package provides two main entry points. Both return a `dist` object (for auto-proximities) or a `matrix` (for cross-proximities).

- `dist(x, y = NULL, method = NULL, ...)`: Computes distances (dissimilarities).
- `simil(x, y = NULL, method = NULL, ...)`: Computes similarities.

**Key Arguments:**
- `x`: A data matrix or data frame.
- `y`: Optional second data matrix. If provided, the function computes cross-proximities between rows of `x` and rows of `y`.
- `method`: A character string naming the measure (e.g., "Jaccard", "cosine", "Euclidean").

### 2. Managing Measures
- `pr_DB`: The central registry of all available proximity measures.
- `summary(pr_DB)`: Lists all available measures and their properties.
- `pr_DB$get_entry("method_name")`: Retrieves detailed metadata for a specific measure.

## Common Workflows

### Auto-proximity (Distance between rows in one dataset)
```R
library(proxy)
data(iris)
# Compute Euclidean distance between iris observations
d <- dist(iris[,1:4], method = "Euclidean")
```

### Cross-proximity (Distance between two different datasets)
```R
set.seed(123)
A <- matrix(runif(10), nrow = 2)
B <- matrix(runif(15), nrow = 3)
# Compute Jaccard similarity between rows of A and B
s <- simil(A, B, method = "Jaccard")
```

### Converting Between Similarity and Distance
The package can automatically convert similarities to distances and vice versa if the relationship is defined in the registry.
```R
# Convert a similarity matrix to a distance matrix
d_from_s <- as.dist(s)
```

## Supported Measures
The package supports a vast array of types:
- **Binary**: Jaccard, Kulczynski1/2, Mountford, Fager, Russel, Hamman, Faith, Tanimoto, Dice, Phi, Yule.
- **Metric/Continuous**: Euclidean, Manhattan, Minkowski, Canberra, Cosine, Mahalanobis, Chord, Geodesic.
- **Nominal**: Chi-squared, Phi-squared, Cramer, Pearson.
- **Other**: Levenshtein (for strings), Gower (for mixed data).

## Tips and Best Practices
- **Case Insensitivity**: Method names are case-insensitive (e.g., "Euclidean" and "euclidean" both work).
- **Binary Data**: For binary measures, ensure your data consists of 0s and 1s (or logicals). The package uses a contingency table (a, b, c, d) internally.
- **Custom Measures**: You can add your own function to the registry using `pr_DB$set_entry()`.
- **Coercion**: Use `as.matrix()` on a `dist` object if you need a full square matrix instead of the compact lower-triangular representation.

## Reference documentation
- [Proximity measures in the proxy package](./references/overview.md)