---
name: r-multicool
description: A set of tools to permute multisets without loops or hash tables and to generate integer partitions. The permutation functions are based on C code from Aaron Williams. Cool-lex order is similar to colexicographical order. The algorithm is described in Williams, A. Loopless Generation of Multiset Permutations by Prefix Shifts. SODA 2009, Symposium on Discrete Algorithms, New York, United States. The permutation code is distributed without restrictions. The code for stable and efficient computation of multinomial coefficients comes from Dave Barber.
homepage: https://cloud.r-project.org/web/packages/multicool/index.html
---

# r-multicool

## Overview
The `multicool` package provides high-performance tools for combinatorial tasks. Its primary feature is the "cool-lex" algorithm, which generates multiset permutations in a loopless manner (each new permutation is generated in constant time). It also includes functions for calculating multinomial coefficients without overflow and generating all partitions of an integer.

## Installation
```R
install.packages("multicool")
```

## Main Functions and Workflows

### 1. Multiset Permutations
To generate permutations, you first create a `multicool` object and then iterate through it.

```R
library(multicool)

# Define a multiset (e.g., two 1s, one 2)
x <- c(1, 1, 2)

# Create the generator object
m1 <- initMC(x)

# Get the total number of permutations
nm <- multinom(x, counts = FALSE) 

# Generate all permutations
all_perms <- allPerm(m1)

# Or iterate one by one to save memory
m2 <- initMC(x)
nextPerm(m2) # Returns the next permutation or NULL if finished
```

### 2. Multinomial Coefficients
The `multinom` function calculates the number of ways to arrange a multiset. It is designed to be stable and efficient.

```R
# Calculate (n!) / (n1! * n2! * ... * nk!)
# Example: How many ways to arrange "MISSISSIPPI"
# M=1, I=4, S=4, P=2 (Total = 11)
counts <- c(1, 4, 4, 2)
multinom(counts, counts = TRUE)
```

### 3. Integer Partitions
Generate all ways to write a positive integer $n$ as a sum of positive integers.

```R
# Generate partitions of 5
parts <- generatePartitions(5)
# Returns a list of vectors
```

## Tips and Best Practices
- **Memory Efficiency**: For very large multisets, avoid `allPerm()`. Use `initMC()` and a `while` loop with `nextPerm()` to process permutations one at a time.
- **Cool-lex Order**: Note that the permutations are generated in "cool-lex" order, which is a specific prefix-shift based ordering. It is not the standard lexicographical order.
- **Input Types**: `initMC` accepts numeric or character vectors. If you have a string, split it first: `initMC(strsplit("abb", "")[[1]])`.

## Reference documentation
- [README](./references/README.html.md)
- [home_page](./references/home_page.md)