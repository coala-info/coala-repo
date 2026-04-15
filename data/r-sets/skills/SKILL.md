---
name: r-sets
description: The r-sets tool provides data structures and operations for finite sets, multisets, fuzzy sets, and intervals in R. Use when user asks to perform set operations like union and intersection, manage multisets with element multiplicities, work with fuzzy logic membership functions, or handle numerical intervals.
homepage: https://cloud.r-project.org/web/packages/sets/index.html
---

# r-sets

name: r-sets
description: Data structures and operations for ordinary sets, fuzzy sets, multisets, and intervals in R. Use this skill when you need to perform set operations (union, intersection, complement), handle multisets (elements with multiplicities), work with fuzzy logic/membership functions, or manage customizable sets with specific matching rules.

# r-sets

## Overview
The `sets` package provides a comprehensive infrastructure for finite sets and their generalizations. Unlike base R's set operations (which work on vectors and can be inconsistent with types), `r-sets` uses a formal class system (`set`, `gset`, `cset`) that ensures permutation invariance and supports nested structures, fuzzy logic families, and user-defined matching functions.

## Installation
```R
install.packages("sets")
library(sets)
```

## Core Workflows

### 1. Basic Sets
Use `set()` to create a collection of distinct objects.
```R
s1 <- set(1L, 2L, 3L)
s2 <- set("a", 2.5, set(1, 2)) # Nested sets
s3 <- as.set(1:5)               # Coercion

# Operations
s1 | s2          # Union
s1 & s3          # Intersection
s1 %D% s3        # Symmetric difference
s1 <= s3         # Subset test
2 ^ s1           # Power set
s1 * s1          # Cartesian product
```

### 2. Generalized Sets (Multisets & Fuzzy Sets)
Use `gset()` for elements with multiplicities or membership grades.
```R
# Multiset (elements with counts)
ms <- gset(support = c("A", "B"), memberships = c(2, 5))

# Fuzzy Set (membership in [0, 1])
fs <- gset(support = c("A", "B"), memberships = c(0.1, 0.8))

# Intensional definition (using membership function)
f <- function(x) ifelse(x > 5, 1, 0.2)
fs_rule <- gset(universe = 1:10, charfun = f)

# Specific methods
gset_support(fs)     # Get elements
gset_memberships(fs) # Get grades/counts
gset_core(fs)        # Elements with membership 1
cut(fs, 0.5)         # Alpha-cut (returns crisp set)
```

### 3. Fuzzy Logic Families
The behavior of fuzzy operations depends on the active logic.
```R
fuzzy_logic("Zadeh") # Default: min/max
# Other families: "Lukasiewicz", "Product", "Fodor", "Hamacher"
.T.(0.5, 0.5)        # Current T-norm (conjunction)
.S.(0.5, 0.5)        # Current T-conorm (disjunction)
```

### 4. Customizable Sets (cset)
Use `cset()` when you need specific element matching (e.g., ignoring case or numerical tolerance).
```R
# Match using base R match (allows type conversion)
cs <- cset(set(1L, "1"), matchfun = match) 

# Match with tolerance
FUN <- matchfun(function(x, y) isTRUE(all.equal(x, y)))
cs_tol <- cset(set(1, 1.00000001), matchfun = FUN)
```

### 5. Intervals
The package handles numerical intervals.
```R
i1 <- interval(1, 5)             # [1, 5]
i2 <- interval(3, 7, "open")     # (3, 7)
i1 & i2                          # Intersection
i1 | i2                          # Union (if overlapping)
5 %e% i1                         # Element of
```

## Tips and Best Practices
- **Canonical Ordering**: `sets` automatically sorts elements internally. This ensures that `set(1, 2) == set(2, 1)` is TRUE.
- **Type Strictness**: By default, `set(1L)` and `set(1)` are different. Use `cset` with `match` if you need loose typing.
- **Avoid `for` loops**: Use `sapply()` or `lapply()` on sets; they automatically call `as.list()` to iterate safely over elements.
- **Visualizing Fuzzy Sets**: Use `plot(gset)` to see membership functions. The package provides generators like `fuzzy_normal()`, `fuzzy_cone()`, and `fuzzy_sigmoid()`.

## Reference documentation
- [Generalized and Customizable Sets in R](./references/sets.md)