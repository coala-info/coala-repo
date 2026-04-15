---
name: sankoff
description: The sankoff tool performs ancestral state reconstruction by minimizing transition costs across a phylogeny using a parallelized implementation of Sankoff’s algorithm. Use when user asks to infer ancestral sequences, reconstruct internal nodes of a tree, or apply cost-based parsimony to DNA and amino acid data.
homepage: https://github.com/hzi-bifo/sankoff
metadata:
  docker_image: "quay.io/biocontainers/sankoff:0.2--h9948957_5"
---

# sankoff

## Overview
The `sankoff` tool is a high-performance, parallelized implementation of Sankoff’s algorithm designed for ancestral state reconstruction. It allows researchers to infer the sequences of internal nodes (ancestors) within a phylogeny by minimizing the total cost of transitions defined by a cost matrix. It is particularly effective for large datasets requiring multi-threaded execution and supports both DNA and amino acid data.

## Command Line Usage

### Basic Reconstruction
To run a standard reconstruction, you must provide a tree, an alignment of leaf sequences, and a cost matrix.

```bash
sankoff --tree input.tree --aln leaf_sequences.fasta --cost matrix.txt --out-as ancestral_states.txt
```

### Handling Internal Nodes
If your input tree has unnamed internal nodes, use the labeling option to ensure the output sequences can be mapped back to the phylogeny.

*   **Labeling nodes**: Use `--ilabel` to assign a prefix (e.g., `Node_`) to internal nodes.
*   **Saving the labeled tree**: Use `--out-tree` to export the tree with the new internal labels.

```bash
sankoff --tree input.tree --aln leaf_seqs.txt --cost matrix.txt --ilabel Node --out-tree labeled_tree.nwk --out-as results.txt
```

### Predefined Cost Parameters
Instead of providing a physical cost matrix file, you can use identity parameters for DNA or Amino Acids. This is useful for standard parsimony models.

**DNA Identity Costs:**
The order of parameters is: `[identical] [non-identical] [X-NA] [X-X] [X-GAP] [NA-GAP] [GAP-GAP]`
```bash
sankoff --tree tree.txt --aln aln.txt --cost-identity-dna 0 1 2 0 5 5 0 --out-as results.txt
```

**Amino Acid Identity Costs:**
The order of parameters is: `[identical] [non-identical] [X-AA] [X-X] [X-GAP] [AA-GAP] [GAP-GAP]`
```bash
sankoff --tree tree.txt --aln aln.txt --cost-identity-aa 0 2 3 0 10 10 0 --out-as results.txt
```

## Best Practices and Expert Tips

### Performance Optimization
`sankoff` supports parallel execution. Always specify the number of threads when working with long sequences or large trees to significantly reduce computation time.
```bash
sankoff --tree tree.txt --aln aln.txt --cost matrix.txt --nthread 8 --out-as results.txt
```

### Data Consistency
If your phylogenetic tree contains more samples than your sequence alignment file, the tool will fail unless you instruct it to prune the tree.
*   **Tip**: Use `--induce_tree_over_samples` to automatically remove taxa from the tree that are missing from the alignment file before processing.

### Cost Matrix Format
When creating a custom `--cost` file:
1.  The first row and first column must contain the characters (e.g., A, C, G, T).
2.  All transition values must be integers.
3.  The matrix should be square and represent the "distance" or "penalty" for changing from the row character to the column character.

### Input Formats
*   **Plain Tree**: Use `--tree` for standard Newick format.
*   **Nexus**: Use `--nexus` if your phylogeny is in Nexus format.

## Reference documentation
- [Sankoff Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_sankoff_overview.md)
- [Sankoff GitHub Documentation](./references/github_com_hzi-bifo_sankoff.md)