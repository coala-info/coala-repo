---
name: phylommand
description: Phylommand is a modular suite of C++ programs designed for high-performance phylogenetic tree manipulation, construction, and comparison. Use when user asks to edit tree topologies, calculate Robinson-Foulds distances, generate distance matrices, or map clade support from tree distributions.
homepage: https://github.com/mr-y/phylommand
---

# phylommand

## Overview
Phylommand is a modular suite of C++ programs designed for high-performance phylogenetic workflows. It consists of four core tools—`treebender`, `treeator`, `contree`, and `pairalign`—that communicate via standard streams (stdin/stdout), allowing for complex piping operations. It is particularly effective for batch processing tree files, calculating clade credibility, and performing rapid sequence clustering based on MAD scores.

## Core Toolset & CLI Patterns

### 1. Treebender: Tree Manipulation
Use for editing topologies, renaming tips, and extracting statistics.
- **Format Conversion**: `treebender --output nexus input.tree > output.nex`
- **Rooting**: `treebender --midpoint input.tree` or `treebender --outgroup TaxonA,TaxonB input.tree`
- **Pruning**: `treebender --drop_tips TaxonA,TaxonB input.tree`
- **Clustering**: Create OTUs based on branch length: `treebender --cluster branch_length:0.03 input.tree`
- **Visualization**: Generate SVG output: `treebender --output svg input.tree > tree.svg`

### 2. Treeator: Tree Construction & Evaluation
Use for building trees from matrices or calculating evolutionary scores.
- **Neighbor-Joining**: `pairalign -A -j -n -m input.fasta | treeator -n`
- **Parsimony Score**: `treeator -f alignment.fasta -p < tree.tree`
- **Ancestral State Reconstruction**: `treeator -a dna -t tree.tree --get_state_at_nodes -l alignment.fasta`
- **Optimization**: If compiled with NLOPT, optimize substitution models using `-m`.

### 3. Contree: Tree Comparison
Use for comparing sets of trees or calculating support.
- **Robinson-Foulds Distance**: `contree -r -f trees_a.tree -d trees_b.tree`
- **Calculate Support**: Map support from a distribution onto a target tree:
  `contree -d distribution.trees -s target.tree`
- **Conflict Analysis**: Identify conflicting splits above a threshold: `contree -c 0.7 -d database.trees target.tree`
- **Decisiveness**: Estimate if gene sampling is decisive: `contree -D 'ITS,RPB2|ITS|RPB2' -i 1000`

### 4. Pairalign: Sequence Analysis
Use for pairwise alignments and distance matrices.
- **Distance Matrix**: Generate Jukes-Cantor distances: `pairalign -j -m input.fasta > matrix.txt`
- **Alignable Groups**: Identify groups based on MAD scores: `pairalign --group output_prefix input.fasta`

## Expert Tips & Best Practices
- **Piping**: Always prefer piping for multi-step workflows to avoid intermediate file overhead. 
  *Example*: `treebender --clear_internal_node_labels input.tree | contree -d distribution.trees -s`
- **Polytomies**: Phylommand arbitrarily resolves polytomies. If your analysis requires strictly bifurcating trees, ensure input trees are resolved or handle the arbitrary resolution with caution.
- **Tip Names**: Avoid special characters (`: ; , ( ) [ ]`) and whitespace in tip names. While Nexus handles whitespace better than Newick via translate tables, clean names prevent parsing errors.
- **Memory Efficiency**: For large tree files (e.g., MCMC outputs), use `--interval` in `treebender` to sub-sample trees or remove burn-in before passing to `contree`.
- **Empty Trees**: Be aware that `treebender` outputs `-1;` for empty trees (e.g., failed NNI swaps on terminal branches).



## Subcommands

| Command | Description |
|---------|-------------|
| contree | Contree is a command line program for comparing trees. It can compare trees in one file/input against each other or compare the trees in one file/input to the trees in another file/input. |
| pairalign | Perform pairwise alignment of DNA sequences given in fasta format. |
| treeator | Treeator is a command line program to construct trees using neighbor joining, parsimony, or maximum likelihood from similarity matrices or data matrices (fasta, nexus, or phylip). |
| treebender | A command line program for manipulating trees in newick or nexus format. |

## Reference documentation
- [Phylommand Wiki Home](./references/github_com_RybergGroup_phylommand_wiki.md)
- [Treebender CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_treebender.md)
- [Treeator CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_treeator.md)
- [Contree CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_contree.md)
- [Pairalign CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_pairalign.md)
- [Miscellaneous Usage Notes](./references/github_com_RybergGroup_phylommand_wiki_miscellaneous.md)