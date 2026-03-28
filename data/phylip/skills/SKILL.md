---
name: phylip
description: PHYLIP is a comprehensive suite of programs used for inferring evolutionary phylogenies and performing phylogenetic analysis. Use when user asks to build neighbor-joining trees, perform maximum likelihood analysis, generate consensus trees from bootstrapped data, or compute genetic distances.
homepage: http://evolution.genetics.washington.edu/phylip/
---


# phylip

## Overview
PHYLIP is a comprehensive suite of over 30 programs for inferring phylogenies. This skill provides guidance on navigating the package's unique menu-driven interface and managing its specific file naming conventions. It is designed to help users execute common workflows such as building neighbor-joining trees, performing maximum likelihood analysis, and generating consensus trees from bootstrapped data.

## Core Workflow and File Handling
PHYLIP programs typically expect input files to be named `infile` and produce output named `outfile` (and often `outtree`). 

1.  **Input Preparation**: Ensure sequences are in PHYLIP format (interleaved or sequential).
2.  **Execution**: Run the specific program (e.g., `dnapars`, `protdist`).
3.  **Menu Navigation**: PHYLIP programs are interactive. To automate or bypass the menu, pipe a text file containing the desired menu options into the command:
    `dnapars < input_options.txt`
4.  **File Management**: Immediately rename `outfile` and `outtree` after a run to prevent them from being overwritten by the next program in the pipeline.

## Common CLI Patterns

### DNA Maximum Likelihood
To run a DNA Maximum Likelihood analysis with default settings:
1. Rename your data to `infile`.
2. Run `dnaml`.
3. Press `Y` and `Enter` when prompted to accept settings.

### Bootstrapping Pipeline
A standard bootstrapping workflow requires running multiple programs in sequence:
1.  **Seqboot**: Generate multiple data sets (e.g., 100 replicates).
    - Input: `infile`
    - Output: `outfile` (Rename this to `intree_replicates`)
2.  **Analysis Program**: Run your chosen method (e.g., `dnapars`) on the replicates.
    - Set the "Multiple data sets" option (usually `M`) in the menu.
    - Input: `intree_replicates` (renamed to `infile`)
    - Output: `outtree` (Rename this to `intrees_for_consensus`)
3.  **Consense**: Generate the final consensus tree.
    - Input: `intrees_for_consensus` (renamed to `intree`)
    - Output: `outfile` (summary) and `outtree` (the consensus tree)

## Expert Tips
- **Interleaved vs. Sequential**: If your sequences are long, use Interleaved format. If you use Sequential, ensure you toggle the `I` option in the program menus.
- **Random Number Seed**: When running programs like `seqboot` or `dnaml` (with Jumble), use an odd integer for the random seed to ensure reproducibility.
- **Tree Visualization**: PHYLIP's `drawgram` and `drawtree` produce plot files. For modern workflows, it is often easier to take the `outtree` (Newick format) and visualize it in external tools like FigTree or iTOL.



## Subcommands

| Command | Description |
|---------|-------------|
| dnadist | Computes distances between sequences. |
| dnainvar | Calculates the number of DNA substitutions between pairs of sequences. |
| dnapars | Parses DNA sequences for phylogenetic analysis. |
| dolmove | Moves sequences between files. |
| neighbor | Neighbor-joining method for constructing phylogenetic trees. |
| phylip_drawtree | Draws trees in various formats. |
| phylip_retree | Tree Rearrangement |

## Reference documentation
- [PHYLIP Home Page](./references/evolution_genetics_washington_edu_phylip.md)