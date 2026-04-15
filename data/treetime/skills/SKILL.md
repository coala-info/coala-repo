---
name: treetime
description: TreeTime transforms phylogenetic trees into time-scaled phylogenies using maximum likelihood methods to estimate node dates and ancestral states. Use when user asks to infer timetrees, reconstruct ancestral sequences or discrete traits, reroot trees to maximize temporal signal, or estimate substitution rates.
homepage: https://github.com/neherlab/treetime
metadata:
  docker_image: "quay.io/biocontainers/treetime:0.11.4--pyhdfd78af_0"
---

# treetime

## Overview
TreeTime is a specialized tool for transforming standard phylogenetic trees into time-scaled phylogenies. It uses maximum likelihood methods to estimate the positions of internal nodes on a time axis based on the sampling dates of terminal nodes (tips). Beyond dating, it provides robust routines for reconstructing ancestral states (both sequences and discrete traits), estimating substitution rates, and fitting coalescent models. It is designed to be computationally efficient, making it suitable for large datasets common in viral and bacterial epidemiology.

## CLI Usage and Common Patterns

### Timetree Inference
The primary command for creating a time-scaled tree. It requires an initial tree and an alignment (or GTR model).

```bash
# Basic timetree inference with dates in a CSV/TSV
treetime --tree tree.nwk --aln alignment.fasta --dates dates.csv --outdir output_results
```

### Ancestral Sequence Reconstruction
Infers the most likely sequences for internal nodes of the tree.

```bash
# Marginal reconstruction (default)
treetime ancestral --tree tree.nwk --aln alignment.fasta

# Joint reconstruction (more robust for specific node states)
treetime ancestral --tree tree.nwk --aln alignment.fasta --joint
```

### Rerooting and Temporal Signal
TreeTime can automatically find the root that best fits a linear clock model (root-to-tip regression).

```bash
# Reroot to maximize the temporal signal (correlation of root-to-tip distance vs time)
treetime --tree tree.nwk --dates dates.csv --reroot best
```

### Mugration Analysis
Infers the ancestral states of discrete traits (e.g., geographic location, host).

```bash
# Map a discrete trait from metadata onto the tree
treetime mugration --tree tree.nwk --states metadata.csv --attribute location
```

## Expert Tips and Best Practices

- **Input Tree Units**: Ensure the input tree branch lengths are in units of substitutions per site. If the tree is already time-scaled, TreeTime's clock inference will not function correctly.
- **Date Formats**: TreeTime is flexible with dates but prefers numerical years (e.g., 2023.45). If using strings, ensure they are consistent in the metadata file.
- **Polytomy Resolution**: Use the `--resolve-polytomies` flag when dealing with trees that have many identical sequences; TreeTime will attempt to break ties in a way that maximizes the temporal likelihood.
- **Fixed Rates**: If the substitution rate is known from previous studies, provide it using `--fixed-rate <value>` to reduce the parameter space and speed up convergence.
- **Coalescent Prior**: For datasets with strong population structure or sampling bias, consider using a coalescent prior (`--coalescent <value>`) to regularize branch length estimates.
- **Confidence Intervals**: To estimate the uncertainty of node dates, use the `--confidence` flag. Note that this increases computation time significantly.



## Subcommands

| Command | Description |
|---------|-------------|
| TreeTime: Maximum Likelihood Phylodynamics ancestral | Reconstructs ancestral sequences and maps mutations to the tree. The output consists of a file 'ancestral.fasta' with ancestral sequences and a tree 'annotated_tree.nexus' with mutations added as comments like A45G,G136T,..., number in SNPs used 1-based index by default. The inferred GTR model is written to stdout. |
| TreeTime: Maximum Likelihood Phylodynamics homoplasy | Reconstructs ancestral sequences and maps mutations to the tree. The tree is then scanned for homoplasies. An excess number of homoplasies might suggest contamination, recombination, culture adaptation or similar. |
| treetime_arg | Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the tree. It will reroot the tree to maximize the clock-like signal and recalculate branch length unless run with --keep_root. |
| treetime_clock | Calculates the root-to-tip regression and quantifies the 'clock-i-ness' of the tree. It will reroot the tree to maximize the clock-like signal and recalculate branch length unless run with --keep-root. |
| treetime_mugration | Reconstructs discrete ancestral states, for example geographic location, host, or similar. In addition to ancestral states, a GTR model of state transitions is inferred. |

## Reference documentation
- [TreeTime GitHub Repository](./references/github_com_neherlab_treetime.md)
- [TreeTime README and Overview](./references/github_com_neherlab_treetime_blob_master_README.md)
- [Bioconda TreeTime Package](./references/anaconda_org_channels_bioconda_packages_treetime_overview.md)