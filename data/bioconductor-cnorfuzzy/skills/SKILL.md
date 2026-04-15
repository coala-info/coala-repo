---
name: bioconductor-cnorfuzzy
description: This tool trains signaling pathway maps to biochemical data using Constrained Fuzzy Logic to model continuous protein activity levels. Use when user asks to train signaling models with fuzzy logic, optimize prior knowledge networks against quantitative data, or visualize fits between simulations and experimental signaling data.
homepage: https://bioconductor.org/packages/release/bioc/html/CNORfuzzy.html
---

# bioconductor-cnorfuzzy

name: bioconductor-cnorfuzzy
description: Use this skill to train signaling pathway maps to biochemical data using Constrained Fuzzy Logic (cFL). This skill is appropriate for modeling quantitative signaling data that exceeds the capabilities of boolean logic, allowing for continuous values between 0 and 1. Use it to optimize Prior Knowledge Networks (PKN) against perturbation data (CNOlist), perform multi-run optimizations, and visualize the fit between model simulations and experimental data.

## Overview

CNORfuzzy extends the CellNOptR package by implementing Constrained Fuzzy Logic (cFL). While boolean models represent protein activity as binary (0 or 1), cFL allows for continuous activity levels, providing a more granular fit to quantitative biochemical data. The workflow typically involves taking a Prior Knowledge Network (PKN) and a CNOlist (data object), defining transfer functions (Hill functions), and using a Genetic Algorithm (GA) followed by a refinement step to find the optimal model parameters.

## Core Workflow

### 1. Data Preparation
Load the package and your data. CNORfuzzy relies on the `CNOlist` class from CellNOptR.

```R
library(CNORfuzzy)
library(CellNOptR)

# Load example data or your own
data(CNOlistToy, package="CellNOptR")
data(ToyModel, package="CellNOptR")

# Ensure data is in the correct CNOlist class
cnolist <- CNOlist(CNOlistToy)
pkn_model <- ToyModel
```

### 2. Parameter Configuration
Initialize default parameters and customize the Genetic Algorithm or Fuzzy Logic settings.

```R
params <- defaultParametersFuzzy(cnolist, pkn_model)

# Genetic Algorithm settings
params$popSize <- 50
params$maxGens <- 100
params$maxTime <- 300 # seconds

# Fuzzy Logic Transfer Functions (Hill functions: g, n, k)
# Type1Funs are for internal gates; Type2Funs are for stimuli-to-species
params$type1Funs[,2] <- c(3, 3, 3, 3, 3, 3, 1.01) # Hill coefficients (n)
params$redThres <- c(0, 0.0001, 0.001, 0.01)     # Reduction thresholds
```

### 3. Optimization
Run the optimization wrapper. For complex models, it is recommended to run multiple iterations (N > 1) to ensure convergence.

```R
N <- 5 # Number of runs
allRes <- list()

for (i in 1:N) {
  allRes[[i]] <- CNORwrapFuzzy(cnolist, pkn_model, paramsList = params)
}

# Compile results from multiple runs
summary <- compileMultiRes(allRes, show = TRUE)
```

### 4. Visualization and Interpretation
Evaluate the Mean Squared Error (MSE) against the reduction threshold to choose the best model complexity.

```R
# Plot the fit (simulated vs experimental)
# The first argument is the chosen reduction threshold (e.g., 0.01)
plotMeanFuzzyFit(0.01, summary$allFinalMSEs, allRes)

# Export the optimized network to files (SIF, DOT, etc.)
writeFuzzyNetwork(0.01, summary$allFinalMSEs, allRes, "my_optimized_model")
```

## Key Functions

- `defaultParametersFuzzy(CNOlist, model)`: Generates the required parameter list with default Hill function values and GA settings.
- `CNORwrapFuzzy(CNOlist, model, paramsList)`: The primary wrapper that performs preprocessing, GA optimization, and refinement.
- `compileMultiRes(allRes, show)`: Aggregates results from multiple `CNORwrapFuzzy` runs and plots the trade-off between MSE and number of parameters.
- `plotMeanFuzzyFit(threshold, allFinalMSEs, allRes)`: Visualizes the experimental data with simulated data overlaid as dashed lines. Background colors indicate the error magnitude.
- `writeFuzzyNetwork(threshold, allFinalMSEs, allRes, filename)`: Saves the optimized model as a .dot and .sif file for use in Cytoscape.

## Tips for Success

- **Threshold Selection**: Use the plot from `compileMultiRes` to find the "elbow" where the MSE starts to increase significantly. Choose a threshold just before this jump to balance model simplicity and accuracy.
- **Hill Coefficients**: A Hill coefficient ($n$) of exactly 1 can be numerically unstable; use 1.01 instead.
- **Computational Time**: Optimization is CPU-intensive. If runs are too slow, reduce `params$optimisation$maxtime` or `params$maxGens`.
- **Missing Links**: If a specific node (e.g., NFkB) consistently shows a poor fit (red/pink boxes in `plotMeanFuzzyFit`), it often indicates a missing interaction in your Prior Knowledge Network.

## Reference documentation
- [Training Signalling Pathway Maps to Biochemical Data with Constrained Fuzzy Logic using CNORfuzzy](./references/CNORfuzzy-vignette.md)