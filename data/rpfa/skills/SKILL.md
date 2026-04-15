---
name: rpfa
description: The rpfa tool identifies optimal gene deletions and integrates heterologous pathways to maximize target compound production in metabolic models. Use when user asks to simulate gene deletions, reduce SBML models by applying deletions, or generate Pareto plots to analyze metabolic trade-offs.
homepage: https://github.com/brsynth/rpFbaAnalysis
metadata:
  docker_image: "quay.io/biocontainers/rpfa:1.0.1--pyh5e36f6f_0"
---

# rpfa

## Overview
The `rpfa` tool (also known as `straindesign`) is a command-line interface for metabolic engineering. It allows researchers to integrate heterologous pathways into host organisms and identify the optimal gene deletions required to maximize the production of a target compound. This skill provides the necessary syntax for simulating deletions, modifying SBML models, and analyzing metabolic trade-offs.

## Command Line Usage

### 1. Simulating Gene Deletions
Identify the best combination of gene knockouts to optimize a specific target reaction.

```bash
python -m straindesign simulate-deletion \
  --input-model-file <model.sbml> \
  --input-pathway-file <pathway.sbml> \
  --input-medium-file <medium.csv> \
  --biomass-rxn-id <biomass_id> \
  --target-rxn-id <target_id> \
  --substrate-rxn-id <substrate_id> \
  --output-file <results.csv>
```

### 2. Reducing Models (Applying Deletions)
Create a modified SBML model by deleting specific genes. You can provide a manual list or use the output from a simulation.

```bash
python -m straindesign reduce-model \
  --input-model-file <model.sbml> \
  --input-straindesign-file <results.csv> \
  --parameter-strategy-str <strategy> \
  --output-file-sbml <modified_model.sbml>
```

**Deletion Strategies:**
- `yield-max`: Selects genes based on the highest predicted yield.
- `gene-max`: Selects the combination with the maximum number of genes.
- `gene-min`: Selects the combination with the minimum number of genes.

To delete a specific gene string directly:
```bash
python -m straindesign reduce-model \
  --input-model-file <model.sbml> \
  --input-gene-str "GENE_ID" \
  --output-file-sbml <modified_model.sbml>
```

### 3. Analyzing Models (Pareto Plots)
Generate a Pareto plot to visualize the trade-off between biomass production and the target compound production.

```bash
python -m straindesign analyzing-model \
  --input-model-file <model.sbml> \
  --input-pathway-file <pathway.sbml> \
  --input-medium-file <medium.csv> \
  --biomass-rxn-id <biomass_id> \
  --target-rxn-id <target_id> \
  --substrate-rxn-id <substrate_id> \
  --output-pareto-png <plot.png>
```

## Best Practices
- **ID Consistency**: Ensure that the `biomass-rxn-id`, `target-rxn-id`, and `substrate-rxn-id` exactly match the IDs defined within your SBML files.
- **Medium Definition**: Use CSV or TSV files to define the exchange reaction bounds for the growth medium to ensure reproducible simulations.
- **Pathway Integration**: When using an heterologous pathway, ensure the `target-rxn-id` refers to the specific reaction in the pathway file that produces the desired compound.

## Reference documentation
- [StrainDesign GitHub Repository](./references/github_com_brsynth_straindesign.md)
- [rpfa Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rpfa_overview.md)