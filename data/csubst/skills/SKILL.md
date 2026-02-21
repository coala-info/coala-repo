---
name: csubst
description: `csubst` (Combinatorial SUBSTitutions) is a molecular evolution tool used to identify and statistically validate convergent amino acid substitutions within a phylogenetic framework.
homepage: https://github.com/kfuku52/csubst
---

# csubst

## Overview

`csubst` (Combinatorial SUBSTitutions) is a molecular evolution tool used to identify and statistically validate convergent amino acid substitutions within a phylogenetic framework. It moves beyond simple pair-wise comparisons by analyzing higher-order combinations of branches to find sites where independent lineages have converged on the same functional state. Use this skill to guide the preparation of genomic data, execution of convergence pipelines, and interpretation of site-specific evolutionary metrics.

## Core Workflows

### 1. Data Preparation
`csubst` requires two primary input files:
- **Alignment**: A FASTA file containing in-frame coding sequences (nucleotides).
- **Phylogeny**: A rooted Newick tree file. The leaf names must match the sequence IDs in the alignment.

To explore the required formats, generate a built-in example dataset:
```bash
csubst dataset --name PGK
```

### 2. Convergence Analysis (`analyze`)
The `analyze` subcommand is the primary entry point for calculating convergence metrics like $\omega_C$ (error-corrected rate of protein convergence).

**Basic execution:**
```bash
csubst analyze --alignment_file alignment.fa --rooted_tree_file tree.nwk --foreground foreground.txt
```

**Key Parameters:**
- `--foreground`: A text file listing the "foreground" branch IDs or clade names to be tested for convergence.
- `--output_stat`: (v1.8.0+) Limit the statistics computed to save time. Default includes `any2any`, `any2dif`, and `any2spe`.
- `--iqtree_exe`: Path to the IQ-TREE executable if not in your PATH (required for ancestral state reconstruction).

### 3. Site-wise Investigation (`site`)
After identifying convergent branch combinations, use the `site` command to extract specific substitutions and generate visualizations.

**Example for specific branches:**
```bash
csubst site --alignment_file alignment.fa --rooted_tree_file tree.nwk --branch_id 12,25
```

**Advanced Plotting:**
- Use `--pdb_file` to map convergent sites directly onto a protein structure.
- The tool generates `matplotlib` summary plots showing the tree alongside site-wise substitution patterns.

### 4. Simulation (`simulate`)
To test the sensitivity of your analysis or generate null distributions, use `simulate` to evolve sequences under specific convergent scenarios.

```bash
csubst simulate --alignment_file alignment.fa --rooted_tree_file tree.nwk --n_sites 1000
```

## Expert Tips & Best Practices

- **Rooting is Critical**: `csubst` requires a rooted tree. Using an unrooted tree will lead to incorrect ancestral reconstructions and invalid convergence metrics.
- **IQ-TREE Compatibility**: `csubst` works best with IQ-TREE 2.x/3.x outputs. If IQ-TREE 3 does not print codon frequencies in the `.iqtree` file, `csubst` will automatically estimate them from the alignment.
- **Foreground Selection**: You can specify foreground lineages using branch IDs (found in the `analyze` output) or by defining clades in the foreground text file.
- **Performance**: For large trees or higher-order convergence searches (3+ branches), use the `--threads` flag to enable parallel processing.
- **Memory Management**: In version 1.8.0 and later, use `--output_stat` to restrict calculations to only the metrics you need (e.g., `any2spe` for specific convergence), which significantly reduces memory overhead on large datasets.

## Reference documentation
- [csubst Main Documentation](./references/github_com_kfuku52_csubst.md)
- [csubst Wiki and Advanced Usage](./references/github_com_kfuku52_csubst_wiki.md)