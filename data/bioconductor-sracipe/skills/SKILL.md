---
name: bioconductor-sracipe
description: sRACIPE simulates gene regulatory circuits using randomized parameters to identify robust phenotypic states and analyze circuit topology. Use when user asks to model gene regulatory networks, perform knockdown or knockout perturbations, identify basins of attraction, or visualize circuit dynamics through PCA and UMAP.
homepage: https://bioconductor.org/packages/release/bioc/html/sRACIPE.html
---


# bioconductor-sracipe

## Overview
sRACIPE (stochastic Random Circuit Perturbation) is used to model gene regulatory circuits without requiring precise kinetic parameters. It generates an ensemble of models with randomized parameters based solely on the network topology. This allows researchers to identify the robust phenotypic states (basins of attraction) of a circuit and understand how noise and parametric variation influence cellular decision-making.

## Core Workflow

### 1. Circuit Definition
Circuits are defined as data frames with three columns: `Source`, `Target`, and `Interaction Type`.
- **Interaction Types**: 1 (Activation), 2 (Inhibition), 3 (Activation by inhibiting degradation), 4 (Inhibition by activating degradation), 5 (Signaling activation), 6 (Signaling inhibition).

```r
library(sRACIPE)
# Load demo or create custom
data("demoCircuit") 
# Example custom: circuit <- data.frame(Source=c("A","B"), Target=c("B","A"), Type=c(2,2))
```

### 2. Simulation
The primary function is `sracipeSimulate`. It returns a `RacipeSE` object (extending `SummarizedExperiment`).

**Deterministic Simulation:**
```r
rSet <- sracipeSimulate(circuit = demoCircuit, 
                        numModels = 100, 
                        integrateStepSize = 0.1, 
                        numConvergenceIter = 10)
```

**Stochastic Simulation:**
Requires noise parameters. `nNoise` defines the number of noise levels.
```r
rSet <- sracipeSimulate(circuit = demoCircuit, 
                        numModels = 50,
                        nNoise = 2, 
                        initialNoise = 15, 
                        noiseScalingFactor = 0.1,
                        simulationTime = 30)
```

### 3. Data Processing and Visualization
Normalize the simulated expressions and visualize using PCA, UMAP, or Heatmaps.

```r
rSet <- sracipeNormalize(rSet)
# Plotting generates PCA, UMAP, and Hierarchical Clustering by default
rSet <- sracipePlotData(rSet, plotToFile = FALSE)
```

### 4. Perturbation Analysis
sRACIPE supports several methods to test circuit robustness:

- **Knockdown**: Reduces the production rate of a specific gene.
  ```r
  kd <- sracipeKnockDown(rSet, reduceProduction = 50) # 50% reduction
  ```
- **Knockout**: Sets production rate and initial conditions to zero.
  ```r
  # In sracipeSimulate call
  rSet <- sracipeSimulate(demoCircuit, knockOut = "A")
  ```
- **Gene Clamping**: Forces a gene to a fixed value throughout simulation.
  ```r
  rSet <- sracipeSimulate(demoCircuit, geneClamping = data.frame(A = 1.0))
  ```

## Advanced Features

### Multistability and Convergence
To analyze multiple steady states for the same parameter set, use `nIC` (number of initial conditions) and `sracipeUniqueStates`.
```r
rSet <- sracipeSimulate(demoCircuit, nIC = 5)
states <- sracipeUniqueStates(rSet)
```

### Limit Cycle Detection
For circuits like the repressilator, enable limit cycle detection in the simulation parameters.
```r
rSet <- sracipeSimulate(repressilator, limitcycles = TRUE)
```

### Parameter Manipulation
You can extract, modify, and re-inject parameters into the simulation.
```r
params <- sracipeParams(rSet)
# Modify params...
sracipeParams(rSet) <- params
rSet <- sracipeSimulate(rSet, genParams = FALSE)
```

## Tips
- **Performance**: For large circuits, start with a small `numModels` and `numConvergenceIter` to test the workflow before running full-scale simulations.
- **Annealing**: Set `anneal = TRUE` in stochastic simulations to find the most stable states by slowly reducing noise.
- **Network Visualization**: Use `sracipePlotCircuit(rSet)` to verify the topology visually.

## Reference documentation
- [A systems biology tool for gene regulatory circuit simulation](./references/sRACIPE.Rmd)
- [sRACIPE Vignette](./references/sRACIPE.md)