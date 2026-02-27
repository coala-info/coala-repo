---
name: bioconductor-oncosimulr
description: This tool performs individual-based forward genetic simulations in asexual populations to model evolutionary trajectories and tumor progression. Use when user asks to simulate clonal dynamics, model fitness landscapes with epistasis or order effects, and analyze mutation accumulation patterns in R.
homepage: https://bioconductor.org/packages/release/bioc/html/OncoSimulR.html
---


# bioconductor-oncosimulr

name: bioconductor-oncosimulr
description: Forward genetic simulation in asexual populations (e.g., tumor progression) with arbitrary epistatic interactions, order effects, and frequency-dependent fitness. Use this skill when Claude needs to simulate evolutionary trajectories, model fitness landscapes, or analyze clonal dynamics in R.

## Overview
OncoSimulR is a Bioconductor package for individual-based forward-time genetic simulations. It is particularly suited for modeling cancer progression where the accumulation of mutations follows specific constraints (e.g., Oncogenetic Trees, Conjunctive Bayesian Networks) or exhibits complex epistasis. It supports various growth models (Exponential, McFarland logistic-like), mutator effects, and frequency-dependent selection.

## Core Workflow

### 1. Specify Fitness Effects
The `allFitnessEffects` function is the entry point for defining how genotypes map to fitness.

```r
library(OncoSimulR)

# Simple independent genes
fe <- allFitnessEffects(noIntGenes = c("A" = 0.1, "B" = 0.05, "C" = -0.02))

# Epistasis and Modules
# Modules allow multiple genes to share the same functional role
fe_epi <- allFitnessEffects(
  epistasis = c("A:B" = 0.3, "A:C" = -0.1),
  geneToModule = c("A" = "a1, a2", "B" = "b1", "C" = "c1")
)

# Order Effects (fitness depends on mutation sequence)
fe_order <- allFitnessEffects(orderEffects = c("A > B" = 0.1, "B > A" = 0.4))

# Restrictions (DAG/Poset)
# sh is the penalty for violating the restriction
pancr <- allFitnessEffects(data.frame(
  parent = c("Root", "KRAS"),
  child = c("KRAS", "TP53"),
  s = 0.1, sh = -0.9, typeDep = "MN"
))
```

### 2. Run Simulations
Use `oncoSimulIndiv` for a single simulation or `oncoSimulPop` for multiple replicates.

```r
# Single simulation
sim <- oncoSimulIndiv(fe, 
                      model = "McFL", # McFarland (logistic) or "Exp" (exponential)
                      mu = 1e-6, 
                      initSize = 1000, 
                      finalTime = 2000,
                      onlyCancer = FALSE)

# Multiple simulations (parallelized)
sims_pop <- oncoSimulPop(10, fe, mc.cores = 2)
```

### 3. Sampling and Analysis
Sample the population to mimic clinical or experimental data.

```r
# Sample genotypes from the population
sampled <- samplePop(sims_pop, timeSample = "unif", propError = 0.05)

# Extract diversity measures
lod <- LOD(sims_pop) # Lines of Descent
pom <- POM(sims_pop) # Path of the Maximum
```

### 4. Visualization
OncoSimulR provides plotting methods for trajectories and fitness landscapes.

```r
# Plot clonal evolution
plot(sim, show = "genotypes")

# Plot the fitness landscape
plot(fe)
```

## Advanced Features

### Frequency-Dependent Fitness
Define birth rates as functions of clone frequencies using the `frequencyDependentFitness` argument.

### Mutator Effects
Use `allMutatorEffects` to define genes that increase or decrease the global mutation rate when mutated.

### Stopping Conditions
Simulations can be stopped based on:
- `detectionSize`: Total population size.
- `detectionDrivers`: Number of mutated driver genes.
- `detectionProb`: Stochastic detection based on population size.
- `fixation`: When specific genotypes reach fixation.

## Tips for Efficiency
- **Large Gene Sets**: For >1000 genes, use `keepEvery = NA` to avoid massive memory consumption from tracking every intermediate clone.
- **Model Selection**: Use "McFL" for populations with a carrying capacity and "Exp" for unconstrained growth.
- **Reproducibility**: Always set a seed using `set.seed()` and `RNGkind("L'Ecuyer-CMRG")` for parallel runs.

## Reference documentation
- [OncoSimulR: forward genetic simulation in asexual populations](./references/OncoSimulR.md)