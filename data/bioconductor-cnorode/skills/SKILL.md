---
name: bioconductor-cnorode
description: CNORode converts Boolean logic models into logic-based ordinary differential equations to quantitatively describe signaling dynamics. Use when user asks to simulate signaling pathways with ODEs, estimate kinetic parameters from experimental data, or perform cross-validation of logic-based dynamic models.
homepage: https://bioconductor.org/packages/release/bioc/html/CNORode.html
---

# bioconductor-cnorode

## Overview

CNORode extends the CellNOptR package by converting Boolean logic models into logic-based ordinary differential equations (ODEs). This allows for a quantitative description of signaling dynamics rather than simple binary (on/off) states. The package uses the CVODES library for efficient simulation and provides interfaces to optimization algorithms like enhanced Scatter Search (eSSR) and Genetic Algorithms (genalg) for parameter estimation.

## Core Workflow

### 1. Data and Model Loading
CNORode uses the same data structures as CellNOptR (SIF for models and MIDAS for data).

```r
library(CNORode)

# Load model (SIF format)
model <- readSIF("path/to/model.sif")

# Load data (MIDAS format) and convert to CNOlist
cno_data <- readMIDAS("path/to/data.csv")
cnolist <- makeCNOlist(cno_data, subfield = FALSE)
```

### 2. Parameter Initialization
Each dynamic state in the ODE model requires parameters: $\tau$ (life-time/speed), $n$ (Hill coefficient), and $k$ (sensitivity).

```r
# Create a structure for ODE parameters
ode_parameters <- createLBodeContPars(
    model, 
    LB_n = 1, UB_n = 5,      # Bounds for Hill coefficient
    LB_k = 0.1, UB_k = 0.9,  # Bounds for sensitivity
    LB_tau = 0.01, UB_tau = 10, # Bounds for time scale
    default_n = 3, default_k = 0.5, default_tau = 1,
    opt_n = TRUE, opt_k = TRUE, opt_tau = TRUE,
    random = FALSE
)
```

### 3. Simulation and Visualization
You can simulate the model using the current parameters to compare against experimental data.

```r
# Plot simulation against data
simulatedData <- plotLBodeFitness(cnolist, model, ode_parameters)

# Plot all species in the model over a time range
modelSim <- plotLBodeModelSim(cnolist, model, ode_parameters, timeSignals = seq(0, 2, 0.5))
```

### 4. Parameter Estimation (Optimization)
To fit the model to data, use `parEstimationLBode`. You can choose between Genetic Algorithms (`ga`) or enhanced Scatter Search (`essm`).

```r
# Setup GA parameters
paramsGA <- defaultParametersGA()
paramsGA$iter <- 100
paramsGA$popSize <- 50

# Run optimization
opt_pars <- parEstimationLBode(
    cnolist, 
    model, 
    method = "ga", 
    ode_parameters = ode_parameters, 
    paramsGA = paramsGA
)

# Visualize the optimized fit
plotLBodeFitness(cnolist, model, opt_pars)
```

### 5. Cross-validation
Assess predictive performance by holding out data points, conditions, or nodes.

```r
# Perform 3-fold cross-validation
R <- crossvalidateODE(
    CNOlist = cnolist, 
    model = model,
    type = "datapoint", 
    nfolds = 3, 
    parallel = TRUE,
    ode_parameters = ode_parameters
)
```

## Key Functions

- `createLBodeContPars`: Generates the parameter list required for ODE simulations.
- `getLBodeModel` / `getLBodeDataSim`: Simulates the ODE system.
- `parEstimationLBode`: Main interface for parameter optimization.
- `plotLBodeFitness`: Visualizes the match between model simulation and experimental data.
- `getLBodeContObjFunction`: Returns the objective function for use with external optimizers (e.g., MEIGOR).

## Tips for Success

- **Transfer Functions**: CNORode supports different transfer functions (e.g., normalized Hill). Ensure the `transfer_function` index matches your modeling assumptions (default is often 2 or 3).
- **Optimization Choice**: For complex landscapes, `method = "essm"` (requires MEIGOR) is generally more robust than the default genetic algorithm.
- **Preprocessing**: Use `CellNOptR::preprocessing` to compress or expand the PKN before converting to ODEs to reduce the parameter space.
- **Time Scales**: If the simulation fails to converge, check if your `LB_tau` and `UB_tau` bounds are realistic for the time-course data provided.

## Reference documentation
- [Training Signalling Pathway Maps to Biochemical Data with Logic-Based Ordinary Differential Equations](./references/CNORode-vignette.md)