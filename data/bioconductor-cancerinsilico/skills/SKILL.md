---
name: bioconductor-cancerinsilico
description: This package provides an R interface for running and analyzing cell-based mathematical models of tumor progression. Use when user asks to simulate cancer cell growth, run the Drasdo and Hohme model, or extract cell coordinates and growth metrics from tumor simulations.
homepage: https://bioconductor.org/packages/3.6/bioc/html/CancerInSilico.html
---


# bioconductor-cancerinsilico

name: bioconductor-cancerinsilico
description: An R interface for computational modeling of tumor progression. Use this skill to run mathematical models of cancer cell growth (e.g., Drasdo and Hohme 2003), simulate cell-based tumor dynamics, and analyze simulation outputs including cell coordinates, growth rates, and density.

# bioconductor-cancerinsilico

## Overview

The `CancerInSilico` package provides a high-performance R interface for running cell-based mathematical models of tumor progression. The underlying simulation engine is implemented in C++ for efficiency, while the analysis and visualization tools are provided in R. It allows researchers to simulate how individual cells interact, divide, and form tumors under various parameters like initial density and cell cycle length distributions.

## Core Workflow

### 1. Running a Simulation
The primary function is `runCancerSim`. It defaults to the "DrasdoHohme2003" model.

```r
library(CancerInSilico)

# Run a basic simulation
# initialNum: starting cells, runTime: hours, density: seeding density (0 to 0.1]
model <- runCancerSim(initialNum = 10, runTime = 24, density = 0.05)

# Run with specific cell cycle distribution and inheritance
model_custom <- runCancerSim(initialNum = 20, 
                             runTime = 48, 
                             cycleLengthDist = 24, 
                             inheritGrowth = TRUE)
```

### 2. Extracting Simulation Data
The simulation returns a `CellModel` S4 object. Use accessor functions to retrieve data at specific time points (in model hours).

*   **Cell Count:** `getNumberOfCells(model, time)`
*   **Coordinates:** `getCoordinates(model, time)` returns an N x 2 matrix.
*   **Cell Properties:** 
    *   `getRadii(model, time)`
    *   `getGrowthRates(model, time)`
    *   `getCycleLengths(model, time)`
    *   `getAxisLength(model, time)` and `getAxisAngle(model, time)`
*   **Global Metrics:** `getDensity(model, time)`

### 3. Visualization
The package provides both static and interactive plotting methods.

```r
# Static plot of cells at a specific hour
plotCells(model, time = 24)

# Interactive console-based plot (type 'h' in console for help)
# interactivePlot(model, time = 0)
```

### 4. Model Parameters
To inspect the parameters used in a simulation:
```r
params <- getParameters(model)
# To see the full distribution of cycle lengths
params_full <- getParameters(model, fullDist = TRUE)
```

## Implementation Tips

*   **Density Limits:** The `density` parameter must be in the range `(0, 0.1]`.
*   **Time Steps:** Use `timeToRow(model, time)` if you need to manually index into the `mCells` slot, though accessor functions are preferred.
*   **Model Types:** Currently, the package focuses on the Drasdo and Hohme (2003) model. Specific parameters like `epsilon` and `nG` can be passed via `...` in `runCancerSim`.
*   **Summary:** Calling `show(model)` or simply typing the model object name will display a summary of available functions and parameters.

## Reference documentation

- [Package ‘CancerInSilico’](./references/reference_manual.md)