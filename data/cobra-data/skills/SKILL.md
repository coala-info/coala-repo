---
name: cobra-data
description: This tool performs constraint-based reconstruction and analysis of metabolic networks using COBRApy. Use when user asks to load genome-scale models, perform flux balance analysis, simulate gene knockouts, or analyze metabolic flux variability.
homepage: https://opencobra.github.io/cobrapy
metadata:
  docker_image: "biocontainers/cobra-data:v0.14.1-1-deb-py2_cv1"
---

# cobra-data

## Overview
The `cobra-data` skill provides a specialized workflow for using COBRApy, the standard Python library for constraint-based reconstruction and analysis. This skill enables the simulation of metabolic flux within genome-scale models to predict growth rates, byproduct secretion, and the impact of environmental or genetic changes. It transforms raw biological network data into actionable insights regarding cellular metabolism.

## Core Workflows

### 1. Model Initialization and I/O
COBRApy supports multiple formats. Always prefer SBML (.xml) for interoperability or JSON for speed.

```python
import cobra

# Load a local model
model = cobra.io.read_sbml_model('path/to/model.xml')
# model = cobra.io.load_json_model('path/to/model.json')
# model = cobra.io.load_matlab_model('path/to/model.mat')

# Load from BiGG or BioModels (requires internet)
# This caches the model locally by default
from cobra.io import load_model
model = load_model("iJO1366") 
```

### 2. Running Simulations
The primary method for analyzing a model is Flux Balance Analysis (FBA).

```python
# Perform FBA
solution = model.optimize()

# Inspect results
print(solution.objective_value)
print(solution.status) # Should be 'optimal'

# Get a high-level overview of fluxes
model.summary()

# Get specific metabolite production/consumption
model.metabolites.atp_c.summary()
```

### 3. Genetic and Environmental Perturbations
Use context managers to perform "what-if" analysis without permanently altering the model object.

```python
# Simulate a gene knockout
with model:
    model.genes.get_by_id("b0001").knock_out()
    print(f"New growth rate: {model.optimize().objective_value}")

# Simulate a specific media/nutrient constraint
with model:
    model.medium = {"EX_glc__D_e": 10.0, "EX_o2_e": 20.0}
    solution = model.optimize()
```

### 4. Advanced Analysis
For more robust predictions than standard FBA, use Flux Variability Analysis (FVA) to find the range of possible fluxes for each reaction.

```python
from cobra.flux_analysis import flux_variability_analysis

# Run FVA on a subset of reactions to save time
fva_results = flux_variability_analysis(model, model.reactions[:10])
```

## Expert Tips
- **Solver Selection**: For large-scale models or MILP problems, use the `hybrid` solver (HIGHS/OSQP) if available in newer versions (0.29.0+).
- **Tolerances**: If a model is unexpectedly infeasible, check `model.tolerance`. The default is 1e-07.
- **Boundary Reactions**: Use `model.boundary` to quickly access exchange, demand, and sink reactions.
- **Validation**: Always run `cobra.io.sbml.validate_sbml_model("model.xml")` when working with new or manually edited SBML files to ensure consistency.

## Reference documentation
- [COBRApy Home](./references/opencobra_github_io_cobrapy.md)
- [COBRApy Releases and Features](./references/opencobra_github_io_cobrapy_releases.md)
- [COBRApy Ecosystem Packages](./references/opencobra_github_io_cobrapy_packages.md)