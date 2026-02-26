---
name: phylommand
description: Phylommand is a modular toolkit for phylogenetic tree manipulation, construction, and statistical analysis. Use when user asks to edit tree topologies, build trees from alignments, compare different tree structures, or calculate sequence distances.
homepage: https://github.com/mr-y/phylommand
---


# phylommand

## Overview
Phylommand is a lightweight, modular toolkit designed for phylogenetic workflows. It excels at rapid tree manipulation and statistical analysis without the overhead of a GUI. The suite consists of four primary programs that can be piped together: `treebender` for tree editing and metrics, `treeator` for tree construction (NJ, Parsimony, ML), `contree` for comparing topologies and estimating decisiveness, and `pairalign` for sequence similarity and distance calculations.

## Core Tool Usage

### Tree Manipulation (treebender)
`treebender` is the primary tool for modifying existing trees. It accepts Newick or Nexus formats.

*   **Rooting and Ladderizing**:
    *   Midpoint root: `treebender -m input.tree`
    *   Outgroup root: `treebender -o TaxonA,TaxonB input.tree`
    *   Ladderize (right): `treebender -l r input.tree`
*   **Pruning and Filtering**:
    *   Drop specific tips: `treebender -d Taxon1,Taxon2 input.tree`
    *   Keep ONLY specific tips: `treebender -d Taxon1,Taxon2 -i input.tree`
*   **Branch Lengths**:
    *   Set all branches to a value: `treebender -s 1.0 input.tree`
    *   Multiply branch lengths: `treebender -u 0.5 input.tree`
*   **Statistics**:
    *   Get tip names: `treebender -t input.tree`
    *   Get tree depth: `treebender -D input.tree`
    *   Test monophyly: `treebender --is_monophyletic TaxonA,TaxonB input.tree`

### Tree Construction and Evaluation (treeator)
`treeator` builds trees from alignments or distance matrices.

*   **Neighbor-Joining**:
    *   Build NJ tree from a distance matrix: `treeator -n distance_matrix.txt`
*   **Parsimony**:
    *   Calculate parsimony score: `treeator -p -d alignment.fasta -t tree.newick`
    *   Stepwise addition: `treeator -s -d alignment.fasta`
*   **Likelihood**:
    *   Calculate likelihood: `treeator -l -d alignment.fasta -t tree.newick -m 0,1,0,2,1,2` (using a specific rate model)

### Tree Comparison (contree)
`contree` is used to find differences or support between multiple trees.

*   **Metrics**:
    *   Robinson-Foulds distance: `contree -r tree1.newick tree2.newick`
*   **Support**:
    *   Calculate split support from a file of trees: `contree -s -f all_trees.trees`
*   **Decisiveness**:
    *   Estimate gene sampling decisiveness: `contree -D -f decisiveness_data.txt -i 1000`

### Sequence Analysis (pairalign)
`pairalign` handles pairwise DNA sequence comparisons.

*   **Distances**:
    *   Jukes-Cantor distance: `pairalign -j < input.fasta`
    *   Proportion of different sites: `pairalign -p < input.fasta`
*   **Clustering**:
    *   Cluster sequences by similarity: `pairalign -g cluster:cut-off=0.97 < input.fasta`

## Expert Tips and Best Practices
*   **Piping**: All tools support `stdin` and `stdout`. You can chain commands:
    `treebender -m input.tree | treebender -l r > rooted_ladderized.tree`
*   **Format Handling**: If using standard input, `treebender` and `contree` assume Newick format. Use `--format nexus` explicitly if piping Nexus data.
*   **Taxon Lists**: When providing taxon names for arguments like `-d` or `-o`, do not include spaces after commas unless the space is part of the taxon name.
*   **Branch Numbers**: Use `treebender --get_branch_numbers` to identify specific internal branches before performing operations like NNI (`--nni`).
*   **Alphabet Files**: For non-standard data in `treeator`, provide a custom alphabet file using `-a`. Default alphabets are `dna`, `protein`, and `binary`.

## Reference documentation
- [Phylommand Wiki](./references/github_com_RybergGroup_phylommand_wiki.md)
- [Treebender CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_treebender.md)
- [Treeator CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_treeator.md)
- [Contree CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_contree.md)
- [Pairalign CLI Reference](./references/github_com_RybergGroup_phylommand_wiki_pairalign.md)