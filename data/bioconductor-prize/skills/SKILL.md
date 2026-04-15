---
name: bioconductor-prize
description: The bioconductor-prize package prioritizes biological entities using the Analytic Hierarchy Process based on multiple criteria and expert judgments. Use when user asks to rank genes or proteins using multiple criteria, perform Analytic Hierarchy Process modeling, aggregate expert judgments, or calculate priorities using relative or rating AHP models.
homepage: https://bioconductor.org/packages/3.6/bioc/html/Prize.html
---

# bioconductor-prize

name: bioconductor-prize
description: Prioritization estimation using the Analytic Hierarchy Process (AHP). Use this skill when you need to rank biological entities (like genes or proteins) based on multiple criteria, subcriteria, and expert judgments using either relative or rating AHP models.

# bioconductor-prize

## Overview

The `Prize` package implements the Analytic Hierarchy Process (AHP) for biological data prioritization. It allows researchers to move beyond single-metric ranking by structuring decision problems into a hierarchy of goals, criteria, and alternatives. It supports both **Relative AHP** (pairwise comparison of all alternatives) and **Rating AHP** (categorizing alternatives into predefined scales), as well as group decision-making through judgment aggregation.

## Core Workflow

### 1. Define the Hierarchy
Create a matrix representing the decision tree. Each row defines a relationship between a parent node and a child node.

```r
library(Prize)
# Column 1: Parent ID, Column 2: Child Name
hier_mat <- matrix(c(
  "0",   "Goal_Name",
  "1",   "Criterion_1",
  "2",   "Criterion_2",
  "2.1", "SubCriterion_A"
), ncol = 2, byrow = TRUE)

# Visualize the structure
ahplot(hier_mat)
```

### 2. Construct Pairwise Comparison Matrices (PCM)
PCMs use the Saaty scale (1-9) to compare elements.
- `1`: Equal importance
- `3`: Moderate importance
- `5`: Strong importance
- `7`: Very strong
- `9`: Extreme importance

Use `ahmatrix()` to complete a triangular matrix (where you only provide the upper triangle) into a full square matrix.

```r
# Load a partial matrix (NA for lower triangle)
pcm_data <- read.table("my_pcm.tsv", header = TRUE, row.names = 1)
full_pcm <- ahmatrix(pcm_data)
```

### 3. Group Aggregation
If multiple experts provide judgments, aggregate them using `gaggregate`.

```r
# src_mat contains paths to individual PCM files
res_agg <- gaggregate(srcfile = src_mat, method = "geometric", simulation = 500)

# Check Consistency Ratio (CR) - should be <= 0.1
GCR(res_agg) 

# Visualize distances between experts
dplot(IP(res_agg))
```

### 4. Calculate Final Priorities
The `pipeline` function automates the calculation of local and global priorities across the hierarchy.

```r
# mat: 3-column matrix [ID, Name, Path_to_PCM_or_Rating_File]
# model: "relative" or "rating"
results <- pipeline(mat, model = "relative", simulation = 500)

# Visualize results
rainbowplot(rainbow_plot(results)$criteria_rainbowplot)
```

## Rating AHP Model
Use the Rating model when the number of alternatives is too large for pairwise comparison.

1. Define categories for a criterion (e.g., "High", "Medium", "Low").
2. Create a PCM for these categories using `rating()`.
3. Assign each alternative to a category in an alternative matrix.

```r
# category_pcm: PCM of the scales (e.g., High vs Low)
# alt_mat: Mapping of alternatives to those scales
rat_res <- rating(category_pcm, alt_mat, simulation = 500)
ideal_priorities <- RM(rat_res)
```

## Key Functions
- `ahplot()`: Visualizes the decision hierarchy or global priorities.
- `ahmatrix()`: Completes a reciprocal pairwise comparison matrix.
- `gaggregate()`: Combines individual judgments (AIJ) or priorities (AIP).
- `pipeline()`: The main wrapper for executing the full AHP analysis.
- `rainbowplot()`: Generates a stacked bar chart showing how each criterion contributes to the final score of an alternative.
- `crplot()`: Visualizes the consistency ratio to ensure judgments are logical.

## Reference documentation
- [Prize](./references/Prize.md)