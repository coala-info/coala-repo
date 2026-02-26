---
name: bioconductor-biggr
description: BiGGR is an R package for constraint-based modeling, flux balance analysis, and hypergraph visualization of metabolic networks using the RECON1 human reconstruction. Use when user asks to perform flux balance analysis, sample feasible flux distributions using MCMC, create metabolic models from specific genes or pathways, or visualize biochemical networks as hypergraphs.
homepage: https://bioconductor.org/packages/release/bioc/html/BiGGR.html
---


# bioconductor-biggr

## Overview
BiGGR (Biochemical Gene GRaphs) is an R package designed for constraint-based modeling of metabolic networks. It provides an interface to the RECON1 curated human metabolic reconstruction and allows users to perform Flux Balance Analysis (FBA) and Markov Chain Monte Carlo (MCMC) sampling of the state space of feasible flux distributions. It is particularly useful for integrating gene expression data with metabolic models and visualizing complex biochemical pathways as hypergraphs.

## Core Workflow

### 1. Loading the Library and Data
BiGGR comes with a version of the RECON1 model.
```r
library(BiGGR)
data(reconstruction) # Loads the RECON1 model object
```

### 2. Creating a Metabolic Model
You can create a specific model by selecting a subset of reactions from the reconstruction based on pathways or genes.
```r
# Example: Extracting a model for Glycolysis
model <- createMetabolicModel(reconstruction, 
                              reactions = c("GLUCl2", "HEX1", "PGI", "PFK"))

# Or create a model based on specific genes
model <- createMetabolicModel(reconstruction, 
                              genes = c("627", "3098", "5211"))
```

### 3. Flux Balance Analysis (FBA)
FBA finds a flux distribution that maximizes or minimizes a specific objective function (usually biomass production or a specific reaction) under steady-state constraints.
```r
# Define the objective function (reaction ID)
obj <- "biomass_growth"

# Run FBA
fba_result <- runFBA(model, objective = obj, maximize = TRUE)

# Access fluxes
fluxes <- fba_result$fluxes
```

### 4. Sampling Feasible Fluxes
When the system is underdetermined, use MCMC sampling to explore the distribution of possible fluxes.
```r
# Sample the solution space
samples <- sampleFluxEnsemble(model, iterations = 10000)

# Summarize results
summary(samples)
```

### 5. Visualization
BiGGR uses hypergraphs to represent metabolic networks where nodes are metabolites and edges (hyperedges) are reactions.
```r
# Visualize the model
plotMetabolicNetwork(model)

# Map FBA results onto the network
plotMetabolicNetwork(model, fluxes = fba_result$fluxes)
```

## Key Functions
- `buildSBMLFromBiGGR`: Exports the model to SBML format.
- `extractPathways`: Retrieves specific metabolic pathways from the reconstruction.
- `getReactionEquations`: Returns the chemical equations for specified reaction IDs.
- `getGenes`: Returns genes associated with specific reactions.

## Tips for Success
- **Reaction IDs**: Always verify reaction IDs against the `reconstruction` object before building a model. Use `grep` on `reconstruction$abbreviation` to find specific reactions.
- **Constraints**: You can modify lower and upper bounds of fluxes within the model object to simulate knockouts (set bounds to 0) or specific nutrient availability.
- **Hypergraphs**: For large models, the hypergraph visualization can become cluttered. It is best to visualize sub-networks or specific pathways rather than the entire RECON1.

## Reference documentation
- [BiGGR Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/BiGGR.html)
- [RECON1 Database](https://vmh.life/)