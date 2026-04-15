---
name: bioconductor-sbmlr
description: This package converts SBML models into R-native data structures for model editing and simulation. Use when user asks to import or export SBML files, simulate metabolic pathways, or perform model perturbations and steady-state analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/SBMLR.html
---

# bioconductor-sbmlr

## Overview

The `SBMLR` package provides a bridge between SBML (XML) files and R-native data structures. It converts SBML models into a "list of lists" core object of class `SBML`. This allows for easy editing of model parameters (initial concentrations, rate constants) directly within R. The package is particularly useful for simulating metabolic pathways and analyzing steady-state or time-course responses to perturbations.

## Core Workflow

### 1. Model Import and Export
The package supports reading from standard SBML (XML) and a specialized R-based format (.r) that is more human-readable for manual editing.

```r
library(SBMLR)

# Read SBML from XML
model <- readSBML(system.file("models", "curto.xml", package = "SBMLR"))

# Save to editable R format
saveSBMLR(model, "model_edit.r")

# Read back the R-formatted model
model_r <- readSBMLR("model_edit.r")

# Export back to standard SBML XML
saveSBML(model, "model_export.xml")
```

### 2. Model Inspection
Use the `summary` function to extract species, reactions, and rate laws.

```r
# View species and reactions
mod_sum <- summary(model)
print(mod_sum$species)
print(mod_sum$reactions)

# Check initial fluxes
head(mod_sum$reactions$initialFluxes)
```

### 3. Simulation
The `sim` function performs the integration. It returns a data frame of species concentrations over time.

```r
# Basic simulation over a time sequence
times <- seq(-20, 70, by = 1)
out <- sim(model, times)

# Plotting results
plot(out$time, out$IMP, type = "l", xlab = "Time", ylab = "IMP Concentration")
```

### 4. Perturbations and Modulators
You can simulate perturbations by modifying the model object or using the `modulator` argument.

**Manual Perturbation:**
```r
# Increase initial concentration of a species
model$species$PRPP$ic <- 50
out_perturbed <- sim(model, 0:70)
```

**Using Modulators:**
The `modulator` argument scales reaction rate amplitudes at $t > 0$.
```r
# Double the amplitude of all reactions at t=0
# rep(2, 37) assumes there are 37 reactions
out_doubled <- sim(model, -10:10, modulator = rep(2, 37))
```

## Tips for AI Agents
- **Object Structure**: The `SBML` object is a list of lists. To change a parameter, navigate to `model$reactions$reaction_id$parameters$param_name`.
- **Steady State**: To verify a steady state, simulate for a period and check if the final concentrations match the initial ones.
- **Comparison**: You can compare two model objects (e.g., XML-imported vs R-imported) using `(model1 == model2)`. This returns a list of data frames with TRUE/FALSE values for every component.
- **Interpolation**: For time-varying boundary conditions (like enzyme changes), the `modulator` argument can accept a list of interpolation functions instead of a numeric vector.

## Reference documentation
- [Quick Intro to SBMLR](./references/quick-start.md)