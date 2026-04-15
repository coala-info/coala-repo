---
name: pyfba
description: PyFBA is a Python-based platform for flux balance analysis that converts genome annotations into functional metabolic models. Use when user asks to convert functional roles into biochemical reactions, gap-fill metabolic models for specific media, or run flux balance analysis to predict growth phenotypes.
homepage: https://linsalrob.github.io/PyFBA/
metadata:
  docker_image: "quay.io/biocontainers/pyfba:2.62--py38h3df17bf_5"
---

# pyfba

## Overview

PyFBA is a Python-based platform for flux balance analysis that allows researchers to move from a genome sequence to a functional metabolic model. It integrates closely with the ModelSEED biochemistry database and RAST/PATRIC annotations. Use this skill to automate the process of converting functional roles into biochemical reactions, identifying metabolic gaps that prevent growth in simulations, and calculating the flux through a metabolic network to predict growth phenotypes.

## Core Workflows

### 1. Converting Genome Annotations to Reactions
The first step in building a model is converting functional annotations (from RAST or PATRIC) into a list of biochemical reactions.

*   **From an assigned functions file** (format: `peg_id [tab] functional_role`):
    ```bash
    python example_code/assigned_functions_to_reactions.py -a assigned_functions > reactions.list
    ```
*   **From a raw list of functional roles** (one per line):
    ```bash
    python example_code/assigned_functions_to_reactions.py -r functional_roles.txt > reactions.list
    ```

### 2. Gap-filling the Model
Most initial models will not "grow" (produce biomass) because of missing reactions in the annotation. Gap-filling identifies the minimum set of reactions needed to complete the pathways for a specific media.

```bash
python scripts/gapfill_from_reactions.py -r reactions.list -m media_file.txt > gapfilled_model.txt
```
*   **Media Files**: These should define the chemical environment (e.g., `MOPS_NoC_Alpha-D-Glucose.txt`).
*   **Tip**: Gap-filling is media-specific. A model gap-filled for one carbon source may not grow on another.

### 3. Running Flux Balance Analysis
Once you have a complete reaction set or an SBML model, you can run FBA to calculate growth rates and reaction fluxes.

*   **Using an SBML file**:
    ```bash
    python example_code/run_fba_sbml.py -s model.sbml -m media_file.txt
    ```
*   **Using a reaction list**:
    ```bash
    python example_code/sbml_to_fba.py -r reactions.list -m media_file.txt
    ```

## Expert Tips and Best Practices

*   **Annotation Quality**: PyFBA relies heavily on the SEED functional role nomenclature. For best results, annotate your genome using the PATRIC or RAST pipeline before starting.
*   **Solver Selection**: PyFBA typically uses GLPK as the linear programming solver. If results differ slightly from ModelSEED online, it is often due to differences between GLPK and commercial solvers like CPLEX or Gurobi.
*   **Biomass Equation**: Ensure your reaction list includes a proper biomass objective function. PyFBA uses the ModelSEED biomass template by default.
*   **Flux Analysis**: After running FBA, use the `PyFBA.fba.fluxes` module in Python scripts to extract specific flux values for subsystems to understand which pathways are active.



## Subcommands

| Command | Description |
|---------|-------------|
| pyfba | Import a list of reactions and then compare growth on two media conditions to identify essential/non-essential media |
| pyfba | Import a list of reactions and then iterate through testing eachreaction to see if the model can still grow |
| pyfba | Run Flux Balance Analysis and calculate reaction fluxes |
| pyfba | Run Flux Balance Analysis and calculate reaction fluxes |
| pyfba | Run Flux Balance Analysis on a set of gapfilled functional roles |
| pyfba | Import a list of reactions and then iterate through our gapfilling steps to see when we get growth. You can specify a single --growth & --nogrowth media conditions |
| pyfba | List the compounds in a media formulation |
| pyfba | Import a list of reactions and then iterate through our gapfilling steps to see when we get growth. You can specify multiple --positive & --negative media conditions |
| pyfba | Get the roles associated with a file of reactions |
| pyfba | Get the roles associated with a file of reactions |
| pyfba | Convert a set of functions or roles to a list of reactions |
| pyfba_media | List of media components for pyfba |

## Reference documentation

- [Getting Started with PyFBA](./references/github_com_linsalrob_PyFBA_blob_master_GETTING_STARTED.md)
- [PyFBA README](./references/github_com_linsalrob_PyFBA_blob_master_README.md)
- [Installation Guide](./references/github_com_linsalrob_PyFBA_blob_master_INSTALLATION.md)