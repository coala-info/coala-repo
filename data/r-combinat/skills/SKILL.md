---
name: r-combinat
description: routines for combinatorics</p>
homepage: https://cloud.r-project.org/web/packages/combinat/index.html
---

# r-combinat

## Overview
The `combinat` package provides a collection of utilities for combinatorial computing in R. It is particularly useful for generating all possible arrangements (permutations) or subsets (combinations) of a vector, as well as partitioning integers or sets.

## Installation
To install the package from CRAN:
```R
install.packages("combinat")
```

## Main Functions

### Permutations and Combinations
- `permn(x)`: Generates all permutations of the elements in vector `x`. Returns a list.
- `combn(x, m)`: Generates all combinations of the elements of `x` taken `m` at a time. (Note: Base R now has `combn`, but `combinat` provides an alternative implementation).
- `nsamp(n, k, replacement = FALSE, ordered = FALSE)`: Calculates the number of samples of size `k` from a population of size `n`, with or without replacement/ordering.

### Partitions
- `parts(n)`: Returns all partitions of the integer `n`.
- `diffparts(n)`: Returns all partitions of the integer `n` into distinct parts.
- `xsimplex(p, n)`: Generates all points on a p-dimensional simplex lattice (integer compositions of `n` into `p` parts).

### Mathematical Utilities
- `factorial(n)`: Computes n!.
- `nCm(n, m)`: Computes the binomial coefficient (n choose m).
- `nPk(n, k)`: Computes the number of permutations of n objects taken k at a time.

## Workflows

### Generating All Permutations
To find every possible ordering of a small set:
```R
library(combinat)
items <- c("A", "B", "C")
all_orders <- permn(items)
# To convert the list to a matrix:
do.call(rbind, all_orders)
```

### Applying a Function to Combinations
You can pass a function to be applied to each combination as it is generated:
```R
# Sum of all combinations of 3 numbers from 1:5
combn(1:5, 3, sum)
```

### Integer Partitions
To see how the number 5 can be summed using integers:
```R
parts(5)
```

## Tips
- **Memory Warning**: Combinatorial functions grow factorially. Generating `permn(10)` results in 3,628,800 elements. Always check the expected size using `factorial(length(x))` before running `permn`.
- **List Output**: `permn` returns a list. Use `sapply` or `lapply` to process the results efficiently.
- **Base R Overlap**: If you have both `utils` (base) and `combinat` loaded, be aware of potential masking for `combn`. Use `combinat::combn` if specific package behavior is required.

## Reference documentation
- [combinat: combinatorics utilities](./references/home_page.md)