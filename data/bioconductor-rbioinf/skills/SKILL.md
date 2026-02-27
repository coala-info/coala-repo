---
name: bioconductor-rbioinf
description: This tool provides specialized functions for exploring and visualizing S4 object-oriented programming structures and class inheritance hierarchies in R. Use when user asks to compute class linearization, determine method dispatch order, resolve multiple inheritance conflicts, or visualize S4 class hierarchies as graphs.
homepage: https://bioconductor.org/packages/3.5/bioc/html/RBioinf.html
---


# bioconductor-rbioinf

name: bioconductor-rbioinf
description: Specialized tools for exploring S4 object-oriented programming (OOP) in R, specifically for computing and visualizing class linearization (class precedence lists) in complex inheritance hierarchies. Use this skill when you need to analyze S4 class structures, determine method dispatch order, or resolve multiple inheritance conflicts using Dylan-style or C3 linearization algorithms.

## Overview

The `RBioinf` package provides functions to support the study of S4 object-oriented programming. Its primary utility lies in computing "linearizations"—the deterministic ordering of a class and its superclasses. This is critical for understanding how R's S4 system decides which method to dispatch when multiple inheritance is involved. It includes tools to identify local precedence orders (LPO) and visualize class hierarchies as graphs.

## Core Workflows

### Analyzing Class Linearization

When a class inherits from multiple parents, the order of those parents matters. `RBioinf` helps you see the resulting search path.

```R
library(RBioinf)

# Define a complex hierarchy
setClass("A")
setClass("B")
setClass("C", contains = c("A", "B"))
setClass("D", contains = c("B", "A"))

# Check the linear order (Class Precedence List)
# Default uses Dylan-style linearization
LPO("C")
# [1] "C" "A" "B"

LPO("D")
# [1] "D" "B" "A"
```

### Using C3 Linearization

The C3 algorithm is often preferred for being more monotonic and less surprising in deep hierarchies.

```R
# Compare standard LPO vs C3
# Assuming a complex class 'editable-scrollable-pane' exists
LPO("editable-scrollable-pane")
LPO("editable-scrollable-pane", C3 = TRUE)
```

### Inspecting Superclasses

Standard R functions like `extends` provide the full list, but `RBioinf` provides more granular inspection tools.

```R
# Find only the immediate (direct) superclasses
superClasses(getClass("MyComplexClass"))

# Compute linearization for a specific class string
computeClassLinearization("MyComplexClass", C3 = TRUE)
```

### Visualizing Hierarchies

You can convert S4 class structures into graph objects for plotting (requires `graph` and `Rgraphviz` packages).

```R
# Create a graph object from a class
classGraph <- class2Graph("MyComplexClass")

# Plotting (if Rgraphviz is available)
library(Rgraphviz)
plot(classGraph)
```

## Troubleshooting Inheritance Conflicts

If you encounter an error like "this one failed" or "no linearization possible," it usually means the inheritance graph is inconsistent (e.g., a "confused" class where two parents disagree on the relative order of their own ancestors).

```R
# Test if a hierarchy is valid
tryCatch(LPO("MySuspectClass"), error = function(e) print("Inconsistent hierarchy"))
```

## Tips for S4 Analysis

1.  **Local Precedence**: Remember that S4 follows the order of the `contains` argument in `setClass` from left to right.
2.  **Consistency**: A valid linearization must be consistent with the LPO of the class itself and the linearizations of all its parents.
3.  **Package Context**: When using `superClasses`, the output often includes the package attribute (e.g., `.GlobalEnv` or the specific library name), which is helpful for debugging namespace issues in S4.

## Reference documentation

- [RBioinf Introduction](./references/RBioinf.md)