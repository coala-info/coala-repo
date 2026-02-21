---
name: r-mutoss
description: "Designed to ease the application and comparison of multiple     hypothesis testing procedures for FWER, gFWER, FDR and FDX. Methods are      standardized and usable by the accompanying 'mutossGUI'.</p>"
homepage: https://cran.r-project.org/web/packages/mutoss/index.html
---

# r-mutoss

name: r-mutoss
description: Expert guidance for the mutoss R package, used for unified multiple hypothesis testing. Use this skill when performing multiple testing procedures (MHT) to control error rates like FWER, gFWER, FDR, and FDX. It is ideal for applying standardized procedures (BH, Holm, etc.), comparing different MHT methods, and setting up benchmark simulations to evaluate procedure performance under various dependency structures.

# r-mutoss

## Overview
The `mutoss` package provides a unified interface for Multiple Hypothesis Testing (MHT). it standardizes the application of various procedures for controlling different error rates and includes a simulation tool (`simTool`) for comparing the performance of these procedures.

## Installation
To install the package from CRAN:
```R
install.packages("mutoss")
```

## Core Workflows

### 1. Applying MHT Procedures
Most procedures in `mutoss` take a vector of p-values and a significance level `alpha`.

```R
library(mutoss)

# Generate or load p-values
p_values <- runif(100)

# Benjamini-Hochberg (FDR control)
result_bh <- BH(pValues = p_values, alpha = 0.05)
print(result_bh$rejected)

# Holm (FWER control)
result_holm <- holm(pValues = p_values, alpha = 0.05)
```

### 2. Using the Unified Interface (mutoss.apply)
For working with S4 class objects and standardized metadata, use `mutoss.apply`. This is useful when integrating with the GUI or complex pipelines.

### 3. Simulation and Comparison (simTool)
The `simulation` function allows for large-scale comparison of procedures across different data-generating processes.

**Workflow:**
1. **Data Generating Function**: Must return a list with `$procInput` (input for the test) and optionally `$groundTruth`.
2. **Procedure Specification**: A list of functions to apply to the generated data.
3. **Statistics**: Functions to calculate metrics like False Discovery Proportion (FDP) or Type 1 Error count.

```R
# 1. Define data generator
my_gen <- function(n=100, pi0=0.8) {
  p <- runif(n)
  # Simulate some signal
  p[1:(n*(1-pi0))] <- p[1:(n*(1-pi0))]^2 
  list(procInput = list(pValues = p), groundTruth = (1:n > n*(1-pi0)))
}

# 2. Run simulation
sim_results <- simulation(
  replications = 100,
  list(funName = "DataGen", fun = my_gen, n = 100, pi0 = c(0.5, 0.8)),
  list(list(funName = "BH", fun = BH, alpha = 0.05))
)

# 3. Gather statistics
stats <- gatherStatistics(sim_results, list(V = function(data, result) sum(data$groundTruth * result$rejected)), mean)
```

## Key Functions
- `BH()`: Benjamini-Hochberg procedure for FDR.
- `holm()`: Holm's step-down procedure for FWER.
- `adaptiveSTS()`: Adaptive Storey-Taylor-Siegmund procedure.
- `simulation()`: Main engine for running MHT simulations.
- `gatherStatistics()`: Summarizes simulation results into data frames for analysis or plotting.

## Tips for Efficiency
- **Memory Management**: In large simulations, use `discardProcInput = TRUE` in the `simulation()` call to avoid storing every generated dataset.
- **Standardization**: Ensure your custom procedures follow the `function(pValues, ...)` signature to be compatible with the simulation tool.
- **Visualization**: Use the `lattice` package to plot results from `gatherStatistics` (e.g., `bwplot` or `xyplot`).

## Reference documentation
- [µTOSS Quick Start Guide](./references/quickstart.md)
- [simTool: Simulation Tool for µTOSS](./references/simToolManual.md)