---
name: pyfba
description: PyFBA is a Python platform that transforms genomic annotations into functional metabolic models using the ModelSEED biochemistry database. Use when user asks to convert functional roles into biochemical reactions, gapfill metabolic models to simulate growth on specific media, or run flux balance analysis from SBML files.
homepage: https://linsalrob.github.io/PyFBA/
---


# pyfba

## Overview
PyFBA is a Python-based platform designed to transform genomic annotations into functional metabolic models. It leverages the ModelSEED biochemistry database to map functional roles to reactions, allowing for the construction of stoichiometric matrices. The tool is primarily used to identify metabolic gaps in a genome and determine the minimum set of reactions required for a model to simulate growth on specific media.

## Environment Setup
PyFBA requires specific environment variables to locate its biochemistry tables and media definitions. Ensure these are set before running scripts:

- `ModelSEEDDatabase`: Path to the cloned ModelSEEDDatabase repository.
- `PYFBA_MEDIA_DIR`: (Optional) Path to the directory containing media definition files.

## Core Workflows

### 1. Converting Genome Annotations to Reactions
The first step in building a model is converting functional roles (e.g., from RAST or other annotations) into a list of biochemical reactions.

**From an assigned functions file (PEG and Role):**
```bash
python example_code/assigned_functions_to_reactions.py -a assigned_functions > reactions.list
```

**From a simple list of functional roles (one per line):**
```bash
python example_code/assigned_functions_to_reactions.py -r functional_roles > reactions.list
```

### 2. Gapfilling the Model
Most initial models will not "grow" (produce biomass) because of missing reactions in pathways. Gapfilling identifies the necessary reactions to complete these pathways based on a specific growth medium.

```bash
python scripts/gapfill_from_reactions.py -r reactions.list -m <media_file.txt> > gapfilled_model.txt
```
*Tip: Use the media files provided in the PyFBA distribution or define custom media in the `PYFBA_MEDIA_DIR`.*

### 3. Running FBA from SBML
If you already have a model in SBML format (e.g., exported from RAST/ModelSEED), you can run the flux analysis directly.

```bash
python scripts/run_fba_sbml.py <model_file.sbml>
```

## Expert Tips and Best Practices
- **Solver Consistency**: PyFBA typically uses the GLPK solver. Note that results may vary slightly from the ModelSEED online interface, which often uses commercial solvers like CPLEX or Gurobi.
- **Biochemistry Updates**: Since PyFBA relies on the ModelSEEDDatabase, ensure your local clone of that repository is up to date to include the latest reaction and compound schemas.
- **Media Definitions**: Media files are tab-separated text files. Ensure compound names match the ModelSEED nomenclature (e.g., `D-Glucose` vs `Alpha-D-Glucose`) to avoid uptake errors.
- **API Extensibility**: For complex simulations, use the `PyFBA.metabolism` classes (`Enzyme`, `Reaction`, `Compound`) within a Python script to manually manipulate the model before running the FBA module.

## Reference documentation
- [Getting started with PyFBA](./references/linsalrob_github_io_PyFBA_getting_started.html.md)
- [INSTALLING PyFBA](./references/linsalrob_github_io_PyFBA_installation.html.md)
- [PyFBA API Index](./references/linsalrob_github_io_PyFBA_genindex.html.md)