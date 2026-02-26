---
name: cobra
description: COBRApy is a Python library for constraint-based reconstruction and analysis of metabolic models. Use when user asks to simulate metabolic behavior, perform flux balance analysis, manipulate model constraints, or predict the effects of genetic and environmental perturbations.
homepage: https://opencobra.github.io/cobrapy
---


# cobra

## Overview
COBRApy is the industry-standard Python library for Constraint-Based Reconstruction and Analysis (COBRA). It provides a high-level, object-oriented interface to simulate the metabolic behavior of biological systems. Use this skill to manipulate metabolic models, define objectives, apply constraints (like media or knockouts), and solve optimization problems to understand cellular metabolism.

## Core Usage Patterns

### Model I/O
Load models from standard formats. SBML is the preferred format for interoperability.
```python
import cobra

# Load models
model = cobra.io.read_sbml_model('model.xml')
# model = cobra.io.load_json_model('model.json')
# model = cobra.io.load_matlab_model('model.mat')

# Quick access to BiGG or BioModels (requires internet)
# model = cobra.io.load_model("iJO1366")
```

### Running Simulations
The primary method for predicting growth and flux distributions.
```python
# Perform Flux Balance Analysis (FBA)
solution = model.optimize()

# Inspect results
print(solution.objective_value)
print(solution.status) # Should be 'optimal'

# Get a high-level overview of inputs and outputs
model.summary()
```

### Genetic and Environmental Perturbations
Simulate the effect of removing genes or changing the growth medium.
```python
# Simulate gene knockouts
# Returns a list of reactions affected and sets their bounds to zero
knockout_results = cobra.manipulation.knock_out_model_genes(model, ["b0001"])

# Change growth medium
# Setting a medium dictionary {reaction_id: lower_bound}
model.medium = {"EX_glc__D_e": -10, "EX_o2_e": -20}
```

### Advanced Analysis
Use Flux Variability Analysis (FVA) to find the range of possible fluxes for each reaction while maintaining a specific objective.
```python
from cobra.flux_analysis import flux_variability_analysis

# Run FVA on all reactions
fva_result = flux_variability_analysis(model, fraction_of_optimum=0.95)
```

## Expert Tips
- **Solvers**: COBRApy uses `optlang` to interface with solvers. You can change the solver via `model.solver = 'glpk'` (or 'gurobi', 'cplex' if installed).
- **Context Managers**: Use `with model:` when making temporary changes (like knocking out a gene or changing a bound) to ensure the model reverts to its original state automatically.
- **Tolerances**: If a model is numerically unstable, adjust the tolerance via `model.tolerance = 1e-7`.
- **Boundary Reactions**: Access exchange, demand, or sink reactions easily using `model.exchanges`, `model.demands`, or `model.sinks`.

## Reference documentation
- [COBRApy Overview](./references/opencobra_github_io_cobrapy.md)
- [COBRApy Releases and Features](./references/opencobra_github_io_cobrapy_releases.md)
- [Bioconda Cobra Package](./references/anaconda_org_channels_bioconda_packages_cobra_overview.md)