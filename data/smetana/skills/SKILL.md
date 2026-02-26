---
name: smetana
description: SMETANA quantifies metabolic exchange and community-level interactions within microbial consortia using genome-scale metabolic models. Use when user asks to analyze metabolite exchange between species, identify essential community dependencies, or simulate the impact of environmental perturbations on microbial metabolic niches.
homepage: https://github.com/cdanielmachado/smetana
---


# smetana

## Overview
SMETANA (Species METabolic interaction ANAlysis) is a specialized command-line tool designed to quantify the potential for metabolic exchange within microbial consortia. It transforms general genome-scale metabolic models into a structured analysis of community-level interactions. Use this skill to determine which metabolites are likely being exchanged between species, identify essential dependencies for community growth, and evaluate the metabolic niches of different community members.

## Installation and Setup
The tool is available via Python package managers and the Bioconda channel.

- **Conda (Recommended):** `conda install bioconda::smetana`
- **Pip:** `pip install smetana`

**Note on Solvers:** SMETANA requires a linear programming (LP) solver. While it supports multiple solvers, users often encounter issues with Gurobi or general LP solver configurations. Ensure a solver like GLPK, CPLEX, or Gurobi is properly installed and accessible in your environment path.

## Core Workflows and CLI Usage

### Basic Community Analysis
The primary input for SMETANA is a collection of genome-scale metabolic models in SBML format.
- Ensure all member models are in a single directory or provided as a list of files.
- The tool will automatically attempt to detect the external compartment for metabolite exchange.

### Advanced Simulation Modes
Based on recent updates, the tool supports specialized environmental and perturbation modes:
- **Environment Specification:** Explicitly define aerobic or anaerobic conditions to refine interaction predictions.
- **Abiotic Perturbations:** Use the `abiotic` or `abiotic2` modes to simulate how changes in the non-biological environment affect community metabolic flux.
- **Sequential Perturbations:** Analyze the stability of community interactions by applying perturbations in sequence.
- **Coupling Options:** Use the "no coupling" option if you need to disable the default flux coupling constraints during analysis.

## Expert Tips and Troubleshooting

### Model Consistency
- **External Compartments:** While SMETANA features automatic detection of external compartments, ensure your SBML models use consistent naming conventions (e.g., 'e' or 'ext') to avoid parsing errors.
- **Non-Growing Species:** The tool allows for the inclusion of species that may not show growth under specific conditions, which is useful for analyzing "cheater" or specialized niche dynamics.

### Common Errors
- **Solver Failures:** If you receive a `TypeError` regarding unexpected keyword arguments (like `update`) or `addConstr()` errors, it usually indicates a version mismatch between SMETANA and the underlying optimization library (e.g., `reframed` or `gurobipy`).
- **Minimal Media:** When calculating minimal growth media, photosynthetic organisms or those with metabolite-dependent bounds may require manual boundary adjustments if the tool fails to find a solution.
- **Output Formatting:** For downstream network analysis, be aware that you may need to re-order or post-process output files to strictly follow SIF (Simple Interaction File) formatting.

## Reference documentation
- [SMETANA GitHub Repository](./references/github_com_cdanielmachado_smetana.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_smetana_overview.md)
- [Project Issues and Troubleshooting](./references/github_com_cdanielmachado_smetana_issues.md)