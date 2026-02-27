---
name: bioconductor-cnordt
description: This tool trains and optimizes synchronous Boolean logic models of signaling networks using time-course data. Use when user asks to fit Boolean simulations to experimental data with multiple time points, include feedback loops in logic models, or optimize model structure and time-scaling factors.
homepage: https://bioconductor.org/packages/release/bioc/html/CNORdt.html
---


# bioconductor-cnordt

name: bioconductor-cnordt
description: Training and optimizing Boolean logic models of signaling networks using time-course data. Use this skill when you need to fit synchronous Boolean simulations to experimental data where multiple time points are available, allowing for the inclusion of feedback loops and complex dynamics like oscillations.

## Overview

CNORdt (CellNOptR discrete time) is an extension of the CellNOptR framework. While the parent package focuses on steady-state logic modeling, CNORdt introduces a scaling parameter that allows synchronous Boolean simulations to be compared against real-time course data. It achieves this by defining a "tick" frequency (simulation steps) relative to the experimental time scale.

## Typical Workflow

### 1. Load Libraries and Data
CNORdt requires both the base `CellNOptR` package and the `CNORdt` extension.

```r
library(CellNOptR)
library(CNORdt)

# Load example data provided in the package
data(CNOlistPB, package="CNORdt")
data(modelPB, package="CNORdt")
```

### 2. Preprocessing
The model must be preprocessed to match the species present in the CNOlist.

```r
# Pre-process the model against the data
model <- preprocessing(CNOlistPB, modelPB)

# Initialize the binary string (1s indicate all edges are initially included)
initBstring <- rep(1, length(model$reacID))
```

### 3. Optimization with gaBinaryDT
The core function `gaBinaryDT` performs a Genetic Algorithm optimization to find the best model structure and time-scaling factor.

Key parameters:
- `boolUpdates`: The number of simulation steps (ticks) to run.
- `lowerB` / `upperB`: The bounds for the scaling factor optimization.
- `maxTime`: Maximum time allowed for the optimization.

```r
opt1 <- gaBinaryDT(
  CNOlist = CNOlistPB, 
  model = model, 
  initBstring = initBstring,
  boolUpdates = 10, 
  maxTime = 30, 
  lowerB = 0.8, 
  upperB = 10,
  verbose = FALSE
)
```

### 4. Visualization and Results
Use `cutAndPlotResultsDT` to visualize how the optimized model fits the time-course data across different conditions.

```r
cutAndPlotResultsDT(
  model = model,
  CNOlist = CNOlistPB,
  bString = opt1$bString,
  boolUpdates = 10,
  lowerB = 0.8,
  upperB = 10,
  plotPDF = FALSE
)
```

### 5. Post-Optimization
Since CNORdt is compatible with CellNOptR, you can use standard functions to export the network or analyze the fit.

```r
# Map the optimized network back to the Prior Knowledge Network (PKN)
writeNetwork(
  modelOriginal = modelPB,
  modelComprExpanded = model,
  optimResT1 = opt1,
  CNOlist = CNOlistPB
)

# Write a scaffold of the results
writeScaffold(
  modelOriginal = modelPB,
  modelComprExpanded = model,
  optimResT1 = opt1,
  CNOlist = CNOlistPB
)
```

## Tips and Constraints
- **Feedback Loops**: Unlike steady-state Boolean models, CNORdt can handle feedback loops because it simulates discrete time steps.
- **boolUpdates**: This parameter is currently manual. It should be chosen based on the complexity of the model and the length of the experimental time course.
- **Scaling Factor**: The scaling factor (optimized between `lowerB` and `upperB`) represents a single global rate for all reactions in the model.

## Reference documentation
- [Training of boolean logic models of signalling networks to time course data with CNORdt](./references/CNORdt-vignette.md)