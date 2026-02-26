---
name: radte
description: RADTE estimates divergence times for gene trees by reconciling them with a dated species tree to calibrate duplication and speciation nodes. Use when user asks to estimate gene tree node ages, date gene duplication events, or perform reconciliation-assisted divergence time estimation.
homepage: https://github.com/kfuku52/radte
---


# radte

## Overview
RADTE (Reconciliation-Assisted Divergence Time Estimation) is a specialized phylogenetic tool that addresses the challenge of dating gene trees in the presence of gene duplications. While standard molecular clock methods often struggle with non-speciation events, RADTE uses a "reconciliation-assisted" approach. It maps nodes in a gene tree to a dated species tree, transfers the known divergence times to the corresponding speciation nodes in the gene tree, and then uses these as calibration points to estimate the ages of duplication nodes. This tool is essential for researchers studying the timing of gene family expansions and functional diversification.

## Installation and Setup
The most reliable way to install RADTE is via Bioconda:
```bash
conda install bioconda::radte
```
Alternatively, the tool can be run as a standalone R script (`radte.r`) provided the R dependencies `ape` and `treeio` are installed.

## Data Preparation Requirements
Successful execution of RADTE requires strict adherence to naming and formatting conventions:

*   **Species Tree**: Must be ultrametric (branch lengths = time) and in Newick format. All internal nodes must have unique labels.
*   **Gene Tree**: Must be a rooted Newick tree. Leaf labels must follow the format `GENUS_SPECIES_GENEID` (e.g., `Homo_sapiens_ENSG00000102144`).
*   **Reconciliation Input**: RADTE requires output from either NOTUNG or GeneRax to understand the relationship between gene nodes and species nodes.

## Common CLI Patterns

### Workflow 1: Using NOTUNG Reconciliation
When using NOTUNG, you must provide the reconciled tree and the `.parsable.txt` file.
```bash
radte.r \
  --species_tree=species_tree.nwk \
  --gene_tree=gene_tree.nwk.reconciled \
  --notung_parsable=gene_tree.nwk.reconciled.parsable.txt \
  --max_age=1000 \
  --chronos_lambda=1 \
  --chronos_model=discrete \
  --pad_short_edge=0.001
```

### Workflow 2: Using GeneRax NHX
If using GeneRax, the NHX format contains the reconciliation data, simplifying the command.
```bash
radte.r \
  --species_tree=species_tree.nwk \
  --generax_nhx=gene_tree.nhx \
  --max_age=1000 \
  --chronos_lambda=1 \
  --chronos_model=discrete
```

## Expert Tips and Best Practices

*   **Labeling Internal Nodes**: If your species tree lacks internal node labels, use this R one-liner to generate them before running RADTE:
    ```bash
    R -q -e "library(ape); t=read.tree('species_tree_noLabel.nwk'); t[['node.label']]=paste0('s',1:Nnode(t)); write.tree(t, 'species_tree.nwk')"
    ```
*   **Handling Deep Duplications**: If a duplication event occurred before the root of your species tree, use the `--max_age` parameter to set a hard upper limit for the gene tree's root age.
*   **GeneRax Compatibility**: When generating inputs with GeneRax, use the `--rec-model UndatedDL` model. The `UndatedDTL` model (which includes transfers) may cause compatibility issues with RADTE.
*   **Chronos Tuning**: RADTE uses the `chronos` function from the `ape` package. If the estimation fails to converge, try adjusting `--chronos_lambda` (smoothing parameter) or switching the `--chronos_model` between `discrete`, `correlated`, or `clock`.
*   **Interpreting Outputs**: 
    *   `radte_gene_tree_output.nwk`: The primary result containing timed branches.
    *   `radte_*.pdf`: Visualizations where blue nodes represent transferred speciation constraints and red nodes represent estimated duplication ages.

## Reference documentation
- [RADTE GitHub Repository](./references/github_com_kfuku52_RADTE.md)
- [Bioconda RADTE Package Overview](./references/anaconda_org_channels_bioconda_packages_radte_overview.md)