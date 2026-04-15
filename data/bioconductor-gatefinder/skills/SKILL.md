---
name: bioconductor-gatefinder
description: This tool identifies optimal gating strategies for flow and mass cytometry data using projection-based convex hulls. Use when user asks to identify a sequence of 2D gates to isolate a target cell population, automate gating strategy discovery, or optimize precision and recall for cytometry data analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/GateFinder.html
---

# bioconductor-gatefinder

name: bioconductor-gatefinder
description: Identify optimal gating strategies for flow and mass cytometry data using projection-based convex hulls. Use this skill when you need to find a series of 2D gates that discriminate a specific target cell population from a background population in high-dimensional cytometry datasets.

# bioconductor-gatefinder

## Overview

GateFinder is an R package designed to automate the discovery of gating strategies for complex cell populations identified through computational analysis (e.g., clustering or dimensionality reduction). It identifies a sequence of 2D polygon gates (convex hulls) that maximize the discrimination of a target population.

The workflow involves:
1. Projecting data into all possible pairs of dimensions.
2. Calculating convex hulls while excluding outliers.
3. Selecting gates based on F-measure (balancing precision and recall).
4. Iteratively refining the gating strategy.

## Basic Workflow

### 1. Data Preparation
GateFinder expects a matrix or data frame of transformed cytometry data (e.g., arcsinh transformed). You must also provide a logical vector identifying the target population.

```r
library(GateFinder)
library(flowCore)

# Example using provided LPSData
data(LPSData)

# Define target population (e.g., cells with high p-p38 expression)
# rawdata is a flowFrame; dimension 34 is p-p38
targetpop <- (exprs(rawdata)[,34] > 3.5)

# Prepare marker matrix (exclude the marker used to define the target)
x <- exprs(rawdata)[, prop.markers]
colnames(x) <- marker.names[prop.markers]
```

### 2. Running GateFinder
The core function `GateFinder()` performs the optimization.

```r
# Run the gating strategy optimization
results <- GateFinder(x, targetpop)
```

### 3. Visualizing Results
GateFinder provides specialized plotting functions to visualize the gating steps and performance metrics.

```r
# Plot the scatter plots for each gating step
# Arguments: data, results object, layout (rows, cols), target mask
plot(x, results, c(2, 3), targetpop)

# Plot F-measure, Precision (Purity), and Recall (Yield) over iterations
plot(results)
```

## Advanced Parameters

You can fine-tune the gating strategy using the following parameters in `GateFinder()`:

*   **outlier.percentile**: (Default: 0.01) Controls the robustness of the convex hulls. Higher values (e.g., 0.05) make gates smaller/stricter, typically increasing precision but decreasing recall.
*   **beta**: (Default: 1) Controls the weight of precision vs. recall in the F-measure. 
    *   `beta < 1`: Prioritizes precision (purity).
    *   `beta > 1`: Prioritizes recall (yield).
*   **update.gates**: A logical value. If `TRUE`, the algorithm recalculates the convex hull for the remaining cells at each step. If `FALSE`, it uses pre-calculated hulls.
*   **max.iter**: The maximum number of gating steps to identify.

```r
# Example: Prioritize precision (beta=0.5) with stricter outlier exclusion
results_strict <- GateFinder(x, targetpop, 
                             outlier.percentile = 0.05, 
                             beta = 0.5)
```

## Tips for Success
*   **Transformation**: Ensure data is properly transformed (e.g., `flowCore::arcsinhTransform`) before running GateFinder, as it relies on scatter plot projections.
*   **Marker Selection**: Only include markers in the input matrix `x` that are feasible for physical sorting or manual gating.
*   **Target Definition**: The `targetpop` logical vector is usually derived from a clustering algorithm (like SPADE or FlowSOM) or a specific functional marker.

## Reference documentation

- [GateFinder](./references/GateFinder.md)