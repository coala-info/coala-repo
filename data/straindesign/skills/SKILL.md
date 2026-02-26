---
name: straindesign
description: The straindesign tool identifies optimal gene knockouts and heterologous pathway integrations to maximize metabolite production in metabolic models. Use when user asks to predict gene deletions for metabolic engineering, reduce models based on specific yield strategies, or perform Pareto analysis to visualize growth and production trade-offs.
homepage: https://github.com/brsynth/straindesign
---


# straindesign

## Overview
The `straindesign` tool is a command-line interface designed for metabolic engineering workflows. It allows you to integrate heterologous pathways into existing metabolic models and identify the optimal gene deletions required to maximize the production of a specific target metabolite. It is particularly useful when you need to simulate the impact of genetic modifications on flux distributions using Flux Balance Analysis (FBA) principles.

## Command Line Usage

### 1. Predicting Gene Knockouts
Use the `simulate-deletion` module to identify which gene combinations will best optimize your target reaction.

```bash
python -m straindesign simulate-deletion \
    --input-model-file model.sbml \
    --input-pathway-file pathway.sbml \
    --input-medium-file medium.csv \
    --biomass-rxn-id R_BIOMASS \
    --target-rxn-id R_TARGET \
    --substrate-rxn-id R_GLC \
    --output-file results.csv
```

### 2. Reducing and Modifying Models
After identifying targets, use `reduce-model` to generate a new SBML model with specific genes removed. You can provide a specific gene string or a results file from a previous simulation.

**Strategies for selection:**
*   `yield-max`: Selects genes that provide the highest theoretical yield.
*   `gene-max`: Selects the combination with the maximum number of genes.
*   `gene-min`: Selects the combination with the minimum number of genes.

```bash
python -m straindesign reduce-model \
    --input-model-file model.sbml \
    --input-straindesign-file results.csv \
    --parameter-strategy-str yield-max \
    --output-file-sbml modified_model.sbml
```

### 3. Pareto Analysis
To visualize the production envelope and the trade-off between growth (biomass) and production (target), use the `analyzing-model` module.

```bash
python -m straindesign analyzing-model \
    --input-model-file model.sbml \
    --input-pathway-file pathway.sbml \
    --input-medium-file medium.csv \
    --biomass-rxn-id R_BIOMASS \
    --target-rxn-id R_TARGET \
    --substrate-rxn-id R_GLC \
    --output-pareto-png pareto_plot.png
```

## Best Practices
*   **Reaction IDs**: Ensure that the Reaction IDs provided for biomass, target, and substrate exactly match the IDs defined within the SBML files.
*   **Medium Files**: Use CSV or TSV formats to define the chemical environment. Ensure the exchange reaction IDs in the medium file correspond to the model's exchange reactions.
*   **Heterologous Pathways**: When providing an `--input-pathway-file`, ensure it is a valid SBML representing the new enzymatic steps leading to your target compound.
*   **Environment**: It is recommended to run these commands within a Conda environment where `straindesign` and its dependency `cameobrs` are installed to ensure solver compatibility.

## Reference documentation
- [straindesign GitHub Repository](./references/github_com_brsynth_straindesign.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_straindesign_overview.md)