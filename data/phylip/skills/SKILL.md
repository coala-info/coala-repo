---
name: phylip
description: PHYLIP is a comprehensive suite of programs for inferring evolutionary relationships and constructing phylogenetic trees. Use when user asks to infer phylogenies, calculate distance matrices, perform bootstrapping, or generate consensus trees from DNA or protein sequences.
homepage: http://evolution.genetics.washington.edu/phylip/
---


# phylip

## Overview
PHYLIP (the Phylogeny Inference Package) is a comprehensive collection of over 30 programs designed to model evolutionary relationships. It is particularly effective for researchers needing a modular approach to phylogenetics, allowing for the transition from raw sequences to distance matrices, tree construction, and statistical validation via bootstrapping. This skill provides guidance on navigating its unique menu-driven interface and managing its specific input/output file naming conventions.

## Core Workflow and File Handling
PHYLIP programs traditionally use fixed filenames for input and output. To avoid overwriting data, always rename files between steps.

- **Input Data**: Usually expected in a file named `infile`.
- **Output Tree**: Usually written to `outtree`.
- **Output Analysis**: Usually written to `outfile`.

### Standard Execution Pattern
1. Prepare your alignment in PHYLIP format (interleaved or sequential).
2. Rename your data file to `infile`: `cp my_data.phy infile`.
3. Run the desired program (e.g., `dnapars`, `protml`, `neighbor`).
4. Interact with the text menu to set parameters (e.g., Toggle 'I' for interleaved, 'J' for jumble).
5. Once finished, rename the results: `mv outtree my_data_tree.tre`.

## Common Program Selection
- **DNA Sequences**: Use `dnapars` (Parsimony), `dnadist` (Distances), or `dnaml` (Maximum Likelihood).
- **Protein Sequences**: Use `protpars` (Parsimony), `protdist` (Distances), or `proml` (Maximum Likelihood).
- **Distance Methods**: Use `neighbor` (Neighbor-Joining or UPGMA) or `fitch` (Fitch-Margoliash).
- **Resampling**: Use `seqboot` to generate multiple datasets for bootstrapping.
- **Consensus**: Use `consense` to compute a majority-rule consensus tree from multiple bootstrap trees.

## Expert Tips
- **Bootstrapping Pipeline**: Run `seqboot` first -> Run your tree inference program (using the 'M' option for multiple datasets) -> Run `consense` on the resulting `outtree`.
- **Jumbling**: For parsimony and likelihood, always use the "Jumble" option (randomize input order) to avoid getting stuck in local optima.
- **Transition/Transversion Ratio**: When using `dnadist` or `dnaml`, ensure the T-ratio is calibrated to your specific organism (default is 2.0).
- **Search for PHYLIP**: If the commands are not in your path after conda installation, they are often located in the `bin` directory of your conda environment.

## Reference documentation
- [PHYLIP Overview](./references/anaconda_org_channels_bioconda_packages_phylip_overview.md)
- [PHYLIP Home and Documentation](./references/evolution_genetics_washington_edu_phylip.md)