---
name: bioconductor-coregflux
description: Bioconductor-coregflux integrates gene regulatory networks and transcriptomic data into genome-scale metabolic models to predict metabolic fluxes. Use when user asks to predict phenotypes, perform dynamic Flux Balance Analysis, or simulate the metabolic effects of transcription factor knock-outs and over-expressions.
homepage: https://bioconductor.org/packages/3.9/bioc/html/CoRegFlux.html
---


# bioconductor-coregflux

name: bioconductor-coregflux
description: Integration of gene regulatory networks (GRN) and gene expression data into genome-scale metabolic models (GEM). Use when performing phenotype predictions, metabolic engineering simulations (TF/gene knock-outs or over-expression), or dynamic Flux Balance Analysis (dFBA) constrained by transcriptional activity.

# bioconductor-coregflux

## Overview

CoRegFlux is an R package designed to integrate reverse-engineered gene regulatory networks and transcriptomic data into metabolic models. It uses a linear model to predict gene states based on transcription factor (TF) influence and applies a softplus function to constrain metabolic fluxes. This allows for more accurate phenotype predictions in various conditions, including wild-type and mutant (knock-out/over-expression) strains.

## Core Workflow

### 1. Data Preparation
To use the full suite of tools, you need a metabolic model (sybil `modelOrg`), a gene regulatory network (`coregnet` object), and gene expression data.

```r
library(CoRegFlux)
library(sybil)
library(CoRegNet)

# Load example data
data("SC_GRN_1")    # GRN
data("iMM904")      # Metabolic model
data("SC_EXP_DATA") # Training expression matrix
data("SC_Test_data")# Condition-specific expression
data("aliases_SC")  # Gene aliases
```

### 2. Computing TF Influence and Gene States
Calculate the activity (influence) of regulators and use it to predict the expression state of metabolic genes.

```r
# Calculate TF influence
inf_matrix <- CoRegNet::regulatorInfluence(SC_GRN_1, SC_Test_data)
exp_influence <- inf_matrix[, 1]

# Predict gene states using a linear model
PredictedGeneState <- predict_linear_model_influence(
  network = SC_GRN_1,
  experiment_influence = exp_influence,
  train_expression = SC_EXP_DATA,
  model = iMM904,
  aliases = aliases_SC
)
```

### 3. Running Dynamic Simulations (dFBA)
The `Simulation` function performs dynamic Flux Balance Analysis, updating fluxes based on metabolite concentrations and regulatory constraints over time.

```r
metabolites <- data.frame(
  "names" = c("D-Glucose", "Ethanol"),
  "concentrations" = c(16.6, 0)
)

sim_results <- Simulation(
  model = iMM904,
  time = seq(1, 20, by = 1),
  metabolites = metabolites,
  initial_biomass = 0.45,
  aliases = aliases_SC,
  gene_state_function = function(a, b) { 
    data.frame("Name" = names(PredictedGeneState), "State" = unname(PredictedGeneState)) 
  }
)

# Access results
sim_results$biomass_history
sim_results$fluxes_history
```

### 4. Applying Specific Constraints (KO/OV)
Manually constrain the model for Transcription Factor or Gene Knock-Out (KO) and Over-Expression (OV).

```r
# TF KO/OV Table
regulator_table <- data.frame(
  "regulator" = "MET32",
  "influence" = -1.2,
  "expression" = 0, # 0 for KO, >1 for OV
  stringsAsFactors = FALSE
)

# Update model constraints
model_constrained <- update_fluxes_constraints_influence(
  model = iMM904,
  coregnet = SC_GRN_1,
  regulator_table = regulator_table,
  aliases = aliases_SC
)

# Solve using sybil
sol <- optimizeProb(model_constrained)
```

### 5. Mapping Growth Rates to Fluxes
Estimate internal fluxes or flux variability based on observed growth rates and uptake rates.

```r
# FBA fluxes from growth rate
fluxes_obs <- get_fba_fluxes_from_observations(iMM904, observed_growth_rate = 0.3)

# FVA intervals from growth rate
fluxes_intervals <- get_fva_intervals_from_observations(iMM904, observed_growth_rate = 0.3)
```

## Usage Tips

*   **Constraint Order:** When manually building a model, apply constraints in this order: (1) Uptake rates, (2) Gene expression integration, (3) TF KO/OV, (4) Gene KO/OV.
*   **Softplus Parameter:** The integration of gene expression into fluxes uses a softplus function. If the predicted growth rate is far from observed values, use `rBayesianOptimization` to calibrate the `gene_parameter` (theta).
*   **Gene Aliases:** Ensure the `aliases` data frame correctly maps the gene IDs used in the GRN to those used in the metabolic model (GPR rules).
*   **Sybil Integration:** Since CoRegFlux returns sybil `modelOrg` objects, you can use any sybil function (e.g., `fluxVar`, `doubleGeneDel`) on the constrained models.

## Reference documentation

- [CoRegFlux](./references/coregflux.md)