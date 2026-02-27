---
name: bioconductor-paircompviz
description: This tool visualizes multiple pairwise comparison test results using Hasse diagrams to represent significant differences between groups. Use when user asks to visualize pairwise comparison results, create Hasse diagrams for statistical tests, or represent significant differences between treatments as a hierarchical graph.
homepage: https://bioconductor.org/packages/release/bioc/html/paircompviz.html
---


# bioconductor-paircompviz

name: bioconductor-paircompviz
description: Visualization of multiple pairwise comparison test results using Hasse diagrams. Use this skill when you need to represent significant differences between multiple treatments or groups in a clear, hierarchical graph format, especially as an alternative to compact letter displays or line diagrams.

## Overview

The `paircompviz` package provides tools to visualize the results of all-pairwise comparison tests (such as t-tests, Wilcoxon tests, or Tukey tests) as Hasse diagrams. In these diagrams, vertices represent treatments, and directed edges represent statistically significant differences. A Hasse diagram is often more readable than traditional letter displays for complex comparison sets.

## Main Functions and Workflows

### 1. Visualizing Comparisons from Raw Data
The primary function is `paircomp()`. It performs the statistical tests and generates the visualization in one step.

```r
library(paircompviz)

# Basic usage with t-test
paircomp(obj = cholesterol$response, grouping = cholesterol$trt, test = "t")

# Customizing the test and p-value adjustment
paircomp(InsectSprays$count, InsectSprays$spray, 
         test = "t", 
         p.adjust.method = "bonferroni",
         level = 0.05)
```

**Supported Test Types (`test` argument):**
- `"t"`: Pairwise t-tests (default).
- `"wilcox"`: Pairwise Wilcoxon rank sum tests.
- `"prop"`: Pairwise tests for proportions.

### 2. Integrating with `multcomp` (Tukey's Test)
You can pass results from the `multcomp` package's `glht` function directly to `paircomp`.

```r
library(multcomp)
aov_result <- aov(Price ~ Type, data = car90)
glht_result <- glht(aov_result, linfct = mcp(Type = "Tukey"))

# Generate Hasse diagram from Tukey test
paircomp(glht_result)
```

### 3. Advanced Visualization Options
The `visualize` argument allows you to add more information to the diagram:
- `position`: Vertex background color reflects the mean/median/proportion.
- `size`: Vertex size reflects the sample size.
- `pvalue`: Edge thickness and labels reflect the p-values.

```r
paircomp(cholesterol$response, cholesterol$trt, 
         visualize = c("position", "size", "pvalue"))
```

### 4. Edge Compression
For complex diagrams where many nodes in one group are all different from many nodes in another, use `compress = TRUE`. This introduces a "dot" node to simplify the edge structure.

```r
paircomp(InsectSprays$count, InsectSprays$spray, compress = TRUE)
```

### 5. Manual Hasse Diagrams
If you already have an adjacency matrix (where $e_{ij} = 1$ if $i$ is significantly different from $j$), use `hasse()`.

```r
# 1. Define adjacency matrix
adj_matrix <- matrix(c(0,0,0, 1,0,0, 1,1,0), nrow=3) 

# 2. Reduce transitive edges (optional but recommended for Hasse diagrams)
reduced_matrix <- transReduct(adj_matrix)

# 3. Plot
hasse(reduced_matrix, v = c("Group A", "Group B", "Group C"))
```

## Tips and Constraints

- **Partial Order Requirement**: Hasse diagrams require the comparison results to form a partial order (specifically, transitivity must hold). If the statistical results contain a "broken transitivity" (e.g., A > B and B > C, but A is not significantly different from C), `paircomp` will throw an error.
- **Dependencies**: This package relies on `Rgraphviz` for rendering. Ensure `BiocManager::install("Rgraphviz")` is run if plotting fails.
- **Interpretation**: In the resulting diagram, if there is a path downwards from node A to node B, it means treatment A is significantly "greater" (or different according to the test) than treatment B.

## Reference documentation

- [paircompviz: An R Package for Visualization of Multiple Pairwise Comparison Test Results](./references/vignette.md)