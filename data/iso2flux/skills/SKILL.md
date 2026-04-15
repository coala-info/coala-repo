---
name: iso2flux
description: iso2flux performs steady-state 13C metabolic flux analysis by integrating constraint-based models with experimental isotopic labeling data. Use when user asks to estimate internal metabolic fluxes, create 13C labeling models, solve flux distributions using mass isotopomer data, or integrate gene expression into flux analysis.
homepage: https://github.com/cfoguet/iso2flux
metadata:
  docker_image: "biocontainers/iso2flux:phenomenal-v0.7.1_cv2.1.60"
---

# iso2flux

## Overview
iso2flux is a Python-based suite designed for steady-state 13C Metabolic Flux Analysis (13CMFA). It allows for the estimation of internal metabolic fluxes by combining constraint-based models (SBML/COBRA) with experimental isotopic labeling data. The tool uses a global optimization approach via the PyGMO library to find flux distributions that best explain observed mass isotopomer distributions (MIDs).

## Core Workflow and CLI Usage

### 1. Model Initialization
Before running an analysis, you must generate an `.iso2flux` model file. This file bundles the metabolic network, labeling rules, and experimental data.

**Basic Command:**
```bash
create_iso2flux_model.py -c model.xml -l rules.txt -e experimental_data.csv -o my_analysis
```

**Expert Tips:**
*   **Validation First**: Always run with the `-v` or `--validate` flag initially. This checks if your label propagation rules are correctly coupled to the constraint-based model without generating the full model file.
*   **Reversible Turnover**: Use `-t` to set the maximum reversible reaction turnover (default is 20). High turnover values can significantly increase the complexity of the solution space.
*   **Equation Directory**: Use `-q` to specify a directory for generated equations if you need to inspect the underlying mathematics of the label propagation.

### 2. Solving the Flux Distribution (13CMFA)
This step performs the actual optimization to fit fluxes to the labeling data.

**Basic Command:**
```bash
solve_iso2flux_label.py -I my_analysis.iso2flux -n 4 -p 20 -g 200
```

**Optimization Parameters:**
*   **Islands (-n)**: Set this to the number of available CPU cores. iso2flux uses an "island model" where populations evolve in parallel.
*   **Population Size (-p)**: Larger populations (e.g., 50-100) explore the search space better but increase computation time.
*   **Generations (-g)**: Defines how long each island evolves before migrating individuals.
*   **Convergence (-m)**: Use `-m` to set the maximum cycles without improvement before the algorithm terminates.

### 3. Integrating Gene Expression (Optional)
You can bias the flux distribution based on transcriptomic data, penalizing fluxes through reactions where associated genes have low expression.

**Basic Command:**
```bash
integrate_gene_expression.py -i my_analysis.iso2flux -g expression_data.csv -o penalized_model
```

*   **Prefix/Suffix**: If your SBML model uses specific naming conventions for genes (e.g., `gene_1234_at`), use `-p` (prefix) and `-s` (suffix) to match them with your expression file IDs.
*   **Spontaneous Reactions**: Use `-r` to remove penalties for reactions known to be spontaneous (not associated with genes).

### 4. Parsimonious 13C MFA (p13CMFA)
After finding a solution that fits the labeling data, use p13CMFA to find the simplest flux distribution (minimizing total flux) that still satisfies the labeling constraints.

**Basic Command:**
```bash
p13cmfa.py -I my_analysis_solved.iso2flux -o parsimonious_results
```

## Input File Requirements
*   **Constraint-Based Model**: Standard SBML or COBRA-compatible file.
*   **Label Propagation Rules**: A text file defining how carbon atoms transition from reactants to products.
*   **Experimental Data**: A file containing the MIDs of metabolic products and the labeling patterns of the substrates used.

## Reference documentation
- [iso2flux README](./references/github_com_cfoguet_iso2flux.md)