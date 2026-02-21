---
name: recur
description: RECUR is a specialized phylogenetic tool that automates the identification of amino acid substitutions that have occurred multiple times independently across a tree.
homepage: https://github.com/OrthoFinder/RECUR
---

# recur

## Overview
RECUR is a specialized phylogenetic tool that automates the identification of amino acid substitutions that have occurred multiple times independently across a tree. It processes protein or codon MSAs to perform model selection, tree inference, and ancestral state reconstruction. Use this skill when you need to move beyond simple alignment analysis to understand the specific evolutionary history of amino acid changes and identify potential sites of functional convergence.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::recur
```

## Core Workflow
To use RECUR effectively, you must provide a Multiple Sequence Alignment (MSA) and define an outgroup to root the inferred phylogeny.

1.  **Input**: A protein or codon MSA in FASTA format.
2.  **Outgroup**: A defined species or clade to serve as the root.
3.  **Execution**: RECUR infers the phylogeny, reconstructs ancestral states, and generates site substitution matrices.
4.  **Output**: 
    *   `<input>.recur.tsv`: The primary list of detected recurrent substitutions.
    *   `.recur/` directory: Contains intermediate files including model selection results, inferred trees, and ancestral state reconstructions.

## CLI Usage and Best Practices

### Basic Command
```bash
recur -i alignment.fa -o Outgroup_Name
```

### Common Options and Flags
*   **Input/Output**:
    *   `-i`: Path to the input FASTA alignment (Protein or Codon).
    *   `-o`: Name of the outgroup species or clade as defined in the alignment headers.
    *   `-s`: Path to a specific species tree (if you wish to bypass internal tree inference).
*   **Model Control**:
    *   `-bm`: Specify or control the binary model used during analysis.
    *   `-nb`: Adjust parameters for indel estimation or specific model behaviors.
*   **Performance**:
    *   `-t`: Set the number of threads for parallel processing (utilizes IQ-TREE 3 by default for tree inference).

### Expert Tips
*   **Codon Alignments**: When working with closely related species, prefer codon alignments. RECUR defaults to `CODON1` models for these inputs to provide higher sensitivity in detecting substitutions.
*   **Outgroup Selection**: Ensure the outgroup name provided exactly matches the identifier in your FASTA headers. An incorrectly specified outgroup will lead to improper rooting and inaccurate recurrence detection.
*   **Intermediate Analysis**: If a specific site shows unexpected recurrence, check the ancestral state reconstruction files in the `.recur/` output directory to verify the inferred states at internal nodes.
*   **IQ-TREE Integration**: RECUR uses IQ-TREE for tree inference. If the process fails during the tree-building stage, ensure your alignment does not contain entirely empty columns or illegal characters.

## Reference documentation
- [RECUR GitHub Repository](./references/github_com_OrthoFinder_RECUR.md)
- [RECUR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_recur_overview.md)