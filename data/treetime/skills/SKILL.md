---
name: treetime
description: TreeTime is a specialized tool for maximum-likelihood phylogenetic analysis, focusing on the inference of molecular-clock phylogenies and ancestral state reconstruction.
homepage: https://github.com/neherlab/treetime
---

# treetime

## Overview
TreeTime is a specialized tool for maximum-likelihood phylogenetic analysis, focusing on the inference of molecular-clock phylogenies and ancestral state reconstruction. It allows users to scale phylogenetic trees such that branch lengths represent time, with terminal nodes aligned to their specific sampling dates. Beyond dating, it provides robust methods for inferring ancestral sequences, estimating substitution rates, and modeling the evolution of discrete traits (mugration).

## Command-Line Usage Patterns

### 1. Inferring a Timetree
To generate a time-scaled phylogeny where branch lengths reflect time rather than divergence:
`treetime --aln <input.fasta> --tree <input.nwk> --dates <dates.csv>`
This command performs a comprehensive analysis, including GTR model inference and ancestral sequence reconstruction.

### 2. Molecular Clock and Rerooting
To estimate the substitution rate and explore the temporal signal in your data:
`treetime clock --tree <input.nwk> --aln <input.fasta> --dates <dates.csv> --reroot least-squares`
*   **Expert Tip**: If you do not have an alignment file, you can substitute `--aln` with `--sequence-length <L>` to perform the estimation based on the input tree's branch lengths.

### 3. Ancestral Sequence Reconstruction
To reconstruct sequences at internal nodes of a tree:
`treetime ancestral --aln <input.fasta> --tree <input.nwk>`
This supports both marginal and joint maximum likelihood approaches.

### 4. Mugration Analysis
To model transitions between discrete states, such as geographic locations or host species:
`treetime mugration --tree <input.nwk> --states <states.csv> --attribute <column_name>`
The `<column_name>` must correspond to the header in your CSV file containing the discrete traits.

### 5. Homoplasy Analysis
To detect recurrent mutations which may indicate recombination or contamination:
`treetime homoplasy --aln <input.fasta> --tree <input.nwk>`

## Best Practices and Tips
- **Input Formats**: Trees can be provided in Newick, Nexus, or Phylip formats. Alignments should be in Fasta or Phylip.
- **Metadata**: Ensure your dates file is a clean CSV or TSV. While TreeTime is flexible, decimal years (e.g., 2021.5) are the most standard format for temporal inference.
- **Rerooting**: Proper rooting is essential for accurate clock estimation. Use `--reroot least-squares` or `--reroot best` to automatically find the root that maximizes the temporal signal.
- **Polytomies**: TreeTime can resolve polytomies (nodes with more than two descendants) by using sampling time constraints to find the most likely bifurcating structure.
- **Confidence Intervals**: For critical dating tasks, use the flags to estimate confidence intervals for node dates, though this increases computation time.

## Reference documentation
- [TreeTime GitHub Repository](./references/github_com_neherlab_treetime.md)
- [Bioconda TreeTime Overview](./references/anaconda_org_channels_bioconda_packages_treetime_overview.md)