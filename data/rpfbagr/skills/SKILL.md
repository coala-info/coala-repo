---
name: rpfbagr
description: rpfbagr identifies optimal gene knockout strategies and simulates metabolic trade-offs to enhance metabolite production in metabolic models. Use when user asks to simulate gene deletions for strain design, reduce models by removing specific genes, or analyze metabolic trade-offs with Pareto plots.
homepage: https://github.com/brsynth/rpfbagr
---


# rpfbagr

## Overview
The `rpfbagr` tool (also known as `straindesign`) is a specialized CLI for metabolic engineering. It allows researchers to integrate heterologous pathways into existing metabolic models to identify the most effective gene knockout strategies for overproducing a specific metabolite. It provides three primary workflows: simulating optimal deletions, reducing models by applying those deletions, and analyzing the trade-offs between biomass production and target yield.

## Command Line Usage

### 1. Simulating Gene Deletions
Use this command to identify which gene deletions will best optimize the production of a target compound.

```bash
python -m straindesign simulate-deletion \
  --input-model-file model.sbml \
  --input-pathway-file pathway.sbml \
  --input-medium-file medium.csv \
  --biomass-rxn-id "BIOMASS_reaction_ID" \
  --target-rxn-id "Target_reaction_ID" \
  --substrate-rxn-id "Substrate_reaction_ID" \
  --output-file results.csv
```

### 2. Reducing and Modifying Models
After identifying targets, use `reduce-model` to generate a new SBML file with the specified genes removed.

**Using a simulation results file:**
```bash
python -m straindesign reduce-model \
  --input-model-file model.sbml \
  --input-straindesign-file results.csv \
  --parameter-strategy-str yield-max \
  --output-file-sbml reduced_model.sbml
```

**Using specific gene IDs:**
```bash
python -m straindesign reduce-model \
  --input-model-file model.sbml \
  --input-gene-str "gene_id_1,gene_id_2" \
  --output-file-sbml reduced_model.sbml
```

**Reduction Strategies:**
- `yield-max`: Selects genes that resulted in the highest product yield.
- `gene-max`: Selects the combination with the maximum number of deleted genes.
- `gene-min`: Selects the combination with the minimum number of deleted genes.

### 3. Metabolic Trade-off Analysis (Pareto Plot)
Generate a Pareto plot to visualize the production envelope between the target metabolite and biomass.

```bash
python -m straindesign analyzing-model \
  --input-model-file model.sbml \
  --input-pathway-file pathway.sbml \
  --input-medium-file medium.csv \
  --biomass-rxn-id "BIOMASS_ID" \
  --target-rxn-id "Target_ID" \
  --substrate-rxn-id "Substrate_ID" \
  --output-pareto-png pareto_analysis.png
```

## Best Practices
- **ID Accuracy**: Ensure that the reaction IDs for biomass, target, and substrate exactly match the IDs defined within the SBML files.
- **Medium Definition**: The medium file (CSV/TSV) should define the boundary conditions (flux constraints) for the model's exchange reactions.
- **Heterologous Pathways**: When providing an `--input-pathway-file`, ensure it is a valid SBML representing the new metabolic steps being added to the host organism.

## Reference documentation
- [StrainDesign Library Overview](./references/github_com_brsynth_straindesign.md)