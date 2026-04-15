---
name: r-relations
description: This tool provides data structures and algorithms for creating, manipulating, and analyzing k-ary mathematical relations in R. Use when user asks to perform relational algebra operations, test mathematical properties like transitivity or reflexivity, or compute consensus relations from ensembles.
homepage: https://cloud.r-project.org/web/packages/relations/index.html
---

# r-relations

name: r-relations
description: Data structures and algorithms for k-ary relations with arbitrary domains. Use this skill when you need to create, manipulate, and analyze mathematical relations in R, including relational algebra (joins, projections, selections), testing relation properties (transitivity, reflexivity), and computing consensus relations (Borda, Condorcet, Medians) from ensembles.

## Overview

The `relations` package provides a comprehensive framework for handling k-ary relations. It supports:
- **Data Structures**: `relation` objects and `relation_ensemble` (collections of relations).
- **Relational Algebra**: Operations similar to SQL/Codd (projection, selection, joins, division).
- **Property Testing**: Predicates for binary and endorelations (e.g., `relation_is_transitive`).
- **Consensus Methods**: Algorithms to find a single representative relation from a group (e.g., finding a consensus ranking).

## Installation

```R
install.packages("relations")
library(relations)
```

## Core Workflows

### 1. Creating Relations
Relations can be created from graphs (data frames of tuples), incidences (0/1 matrices), or characteristic functions.

```R
# From a data frame (graph)
R <- relation(graph = data.frame(A = c(1, 1, 2), B = c(2, 3, 4)))

# From a characteristic function (e.g., "divides")
divides <- function(a, b) b %% a == 0
R_div <- relation(domain = list(1:10, 1:10), charfun = divides)

# Coercion
as.relation(1:3) # Creates an order relation
as.relation(factor(c("A", "B", "A"))) # Creates an equivalence relation
```

### 2. Relational Algebra
Perform database-like operations on relation objects.

```R
# Projection: Keep specific columns
relation_projection(R, c("Age", "Weight"))

# Selection: Filter tuples
relation_selection(R, Age < 29)

# Joins
R1 %|><|% R2  # Natural join
R1 %=><% R2   # Left join
R1 %><=% R2   # Right join
R1 %=><=% R2  # Full outer join

# Other operators
R1 %U% R2     # Union
R1 - R2       # Complement
R1 %><% R2    # Cartesian product
R1 %/% R2     # Division
```

### 3. Testing Properties
Use `relation_is_foo` to check mathematical properties.

```R
# Basic properties
relation_is(R, "transitive")
relation_is(R, "reflexive")
relation_is(R, "symmetric")
relation_is(R, "antisymmetric")

# Categories
relation_is(R, "partial_order")
relation_is(R, "weak_order")
relation_is(R, "equivalence")
relation_is(R, "linear_order")
```

### 4. Consensus Relations
Find a consensus relation from an ensemble (e.g., aggregating multiple rankings).

```R
# Create an ensemble
ens <- relation_ensemble(R1, R2, R3)

# Compute consensus using different methods
# "symdiff/L" finds the closest Linear Order using symmetric difference distance
cons_L <- relation_consensus(ens, method = "symdiff/L")

# "Borda" or "Copeland" for voting-based consensus
cons_B <- relation_consensus(ens, method = "Borda")

# Extract class IDs (rankings/groupings)
relation_class_ids(cons_L)
```

## Tips and Best Practices
- **Visualization**: Use `plot(R)` to generate Hasse diagrams (requires `Rgraphviz`).
- **Dissimilarity**: Use `relation_dissimilarity(R1, R2)` to calculate the symmetric difference distance between relations.
- **Incidence**: Use `relation_incidence(R)` to view the underlying 0/1 matrix representation.
- **Solvers**: For complex consensus problems (`symdiff/F`), ensure a solver like `Rglpk` (default), `lpSolve`, or `Rsymphony` is installed.

## Reference documentation
- [Good Relations with R](./references/relations.md)