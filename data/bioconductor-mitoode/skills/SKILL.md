---
name: bioconductor-mitoode
description: This tool performs dynamical modelling of cell-cycle phenotypes by fitting ordinary differential equation models to time-course cell count data. Use when user asks to fit ODE models to live-cell imaging data, estimate transition rates between cellular states, or reproduce phenotypic analysis from the Mitocheck screen.
homepage: https://bioconductor.org/packages/3.8/bioc/html/mitoODE.html
---

# bioconductor-mitoode

name: bioconductor-mitoode
description: Use this skill to perform dynamical modelling of cell-cycle phenotypes using the mitoODE R package. This includes fitting ordinary differential equation (ODE) models to time-course cell count data (interphase, mitotic, polynucleated, and apoptotic states) from live-cell imaging assays, estimating transition rates, and reproducing phenotypic analysis from the Mitocheck screen.

# bioconductor-mitoode

## Overview
The `mitoODE` package implements a population-level dynamic model to quantify the effects of siRNA treatments on cell populations. It uses a system of ordinary differential equations (ODEs) to model transitions between four cellular states: Interphase (I), Mitotic (M), Polynucleated (P), and Dead (D). The skill enables the estimation of parameters such as penetrance and timing of disruption events (quiescence, mitosis arrest, polynucleation, and cell death).

## Core Workflow

### 1. Data Preparation
The package typically works with cell count matrices where rows are time points and columns represent cell states.

```r
library(mitoODE)
# Load data for a specific spot from the Mitocheck assay
spotid <- 1000
y <- readspot(spotid) # Returns matrix with columns: i, m, s, a
```

### 2. Setting Model Parameters
Fitting requires defining constant parameters and initial starting values for the optimization.

```r
# Define constant parameters
# g.kim: basal interphase-to-mitosis rate
# g.kmi: basal mitosis-to-interphase rate
# g.mit0: mitotic index at seeding
# p.lambda: regularization parameter
pconst <- c(g.kim=0.025, g.kmi=0.57, g.mit0=0.05, p.lambda=4)

# Generate initial parameter vector (10 parameters)
p0 <- getp0()
```

### 3. Model Fitting
Use `fitmodel` to estimate the 10 parameters: `him` (αIM), `hmi` (αMI), `hmp` (αMP), `ha` (αD), `tim` (τIM), `tmi` (τMI), `tmp` (τMP), `ta` (τD), `mu` (μ), and `i0` (n0).

```r
# Basic fit
fit_results <- fitmodel(y, p0, pconst)

# Robust fit using multiple starts with Gaussian noise to avoid local minima
fit_robust <- fitmodel(y, p0, pconst, nfits=4, sd=0.1)
```

### 4. Visualization and Interpretation
```r
# Plot observed vs fitted data
plotfit(spotid, fit_results)

# Plot raw spot data
plotspot(spotid)
```

## Key Functions
- `readspot(id)`: Reads cell count data for a specific Mitocheck spot.
- `getp0()`: Returns the default initial parameter vector for the optimization.
- `fitmodel(y, p0, pconst, ...)`: Fits the ODE model to the data `y` using Levenberg-Marquardt optimization.
- `plotfit(id, p)`: Visualizes the fit results against the experimental data.
- `loadFittedData()`: Loads pre-computed fitted data from the Mitocheck screen for analysis.

## Reproducing Paper Results
The package includes built-in functions to reproduce specific figures from the original publication:
- `figure1()`: Model schematic/basic dynamics.
- `figure2()`: Example fits.
- `figure7()`: Phenotypic map of the Mitocheck screen using LDA.

## Reference documentation
- [mitoODE Introduction](./references/mitoODE-introduction.md)