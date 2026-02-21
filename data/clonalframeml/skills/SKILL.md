---
name: clonalframeml
description: ClonalFrameML is a maximum likelihood tool designed to identify recombination in bacterial populations.
homepage: https://github.com/xavierdidelot/ClonalFrameML
---

# clonalframeml

## Overview
ClonalFrameML is a maximum likelihood tool designed to identify recombination in bacterial populations. It accounts for the impact of horizontal gene transfer on phylogenetic branch lengths, providing a more accurate evolutionary history than standard tree-building methods. Use this tool when you need to distinguish between mutation and recombination events across a phylogeny, especially for large genomic datasets where Bayesian methods like ClonalFrame are computationally prohibitive.

## Core Workflow

### 1. Preparation
Before running ClonalFrameML, you must have:
- **Starting Tree**: A Newick format tree (e.g., from RAxML, IQ-TREE, or PhyML).
- **Alignment**: A FASTA or XMFA file. Leaf names in the tree must match headers in the alignment.
- **Kappa Value**: The transition/transversion ratio (typically obtained from the output of your phylogenetic reconstruction software).

### 2. Standard Execution
The basic command structure is:
```bash
ClonalFrameML <tree.nwk> <alignment.fasta> <output_prefix> [OPTIONS]
```

**Common CLI Pattern:**
```bash
ClonalFrameML starting_tree.nwk alignment.fasta results_out -kappa 4.5 -emsim 100
```
- `-kappa`: Sets the transition/transversion bias.
- `-emsim`: Requests 100 pseudo-bootstrap replicates to estimate parameter uncertainty.

### 3. Handling Missing Data
To prevent uncalled sites or gaps from being misinterpreted as recombination:
- Use `-ignore_user_sites <file.txt>` where the file contains a list of positions (one per line) that were not callable or present in all genomes.

### 4. Advanced Models
**Per-branch Model**: Use this when you suspect recombination rates vary significantly across the tree.
```bash
ClonalFrameML tree.nwk alignment.fasta out -embranch true -embranch_dispersion 0.1 -initial_values "0.1 0.001 0.1"
```
- **Tip**: Run the standard model first to obtain point estimates, then use those as `-initial_values` for the per-branch run.

## Key Output Files
- `ML_sequence.fasta`: Reconstructed ancestral sequences for all internal nodes.
- `importation_status.txt`: A tab-delimited list of detected recombination events (Branch, Start, End).
- `em.txt`: Point estimates for R/theta (recombination rate), 1/delta (inverse mean length), and nu (divergence).
- `labelled_tree.newick`: The phylogeny with nodes labeled for cross-referencing with the importation status.

## Expert Tips
- **Branch Lengths**: If your starting tree has very short branches, adjust the prior mean for branch lengths using `-prior_mean`. The default is 0.0001.
- **Visualization**: Use the bundled R script `cfml_results.R` to generate a PDF summary of the recombination events across the phylogeny:
  ```bash
  Rscript cfml_results.R <output_prefix>
  ```
- **Performance**: ClonalFrameML is highly efficient and can handle hundreds of whole genomes in hours on standard hardware.

## Reference documentation
- [ClonalFrameML GitHub README](./references/github_com_xavierdidelot_ClonalFrameML.md)
- [ClonalFrameML Wiki - User Guide](./references/github_com_xavierdidelot_ClonalFrameML_wiki.md)