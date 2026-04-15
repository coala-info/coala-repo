---
name: treebest
description: TreeBeST reconstructs and reconciles gene trees by leveraging species tree information to minimize gene duplication and loss events. Use when user asks to build phylogenetic trees from codon alignments, infer orthologs with bootstrap support, or back-translate protein alignments into codon-aware DNA alignments.
homepage: https://github.com/lh3/treebest
metadata:
  docker_image: "quay.io/biocontainers/treebest:1.9.2_ep78--hfc679d8_2"
---

# treebest

## Overview
TreeBeST (Tree Building guided by Species Tree) is a specialized phylogenetic tool designed to reconstruct gene trees by leveraging known species relationships. It is particularly effective for large-scale comparative genomics (like TreeFam or Ensembl Compara) because it reconciles sequence evolution with species evolution. It can merge multiple tree topologies—including synonymous/non-synonymous distance trees and Maximum Likelihood trees—into a single "best" tree that minimizes gene duplication and loss events.

## Core Workflows

### 1. Building the "Best" Gene Tree
The `best` command is the primary entry point for high-quality tree reconstruction. It performs a complex procedure involving multiple NJ and ML methods to determine the optimal topology.

```bash
treebest best -f species_tree.nh -o output_tree.nhx input_alignment.mfa
```

**Requirements:**
- **Input Alignment**: Must be a protein-guided codon alignment (nucleotides).
- **Species Tree**: New Hampshire format. Internal nodes must have taxon names.

### 2. Orthology Inference with Bootstraps
To get orthologs and within-species paralogs with bootstrap support, use the `nj` command.

```bash
treebest nj -vf species_tree.nh -t dm -c input_tree.nhx -o orthologs.txt input_alignment.mfa
```
- The results are delimited by `@begin full_ortholog` and `@end full_ortholog`.
- `-t dm`: Specifies the model/method (e.g., synonymous distance).

### 3. Preparing Alignments (Back-translation)
TreeBeST requires codon alignments for its `best` command. Use `backtrans` to convert a protein alignment and its corresponding DNA sequences into a codon-aware alignment.

```bash
treebest backtrans protein_align.fasta dna_sequences.fasta > codon_align.mfa
```

## CLI Best Practices

### Sequence Naming Convention
TreeBeST relies on a specific naming convention to identify species automatically. Use the Swiss-Prot rule: `SequenceID_SpeciesName`.
- **Example**: `12_HUMAN`, `11_MOUSE`.
- The underscore `_` is the mandatory separator.
- Species names should ideally match those in the species tree (max 5 characters for Swiss-Prot style, though taxon IDs are supported).

### Species Tree Management
- **View Default**: Run `treebest spec` to see the internal default species tree (TreeFam standard).
- **Custom Trees**: Always provide a custom species tree using `-f` if your dataset involves species not present in the default TreeFam set.
- **Sequencing Status**: In the species tree file, append an asterisk `*` to species names (e.g., `HUMAN*`) to indicate a completely sequenced genome. This allows TreeBeST to accurately count gene losses.

### Output Formats
- TreeBeST primarily outputs in **NHX (New Hampshire eXtended)** format.
- NHX files contain metadata about duplications (`D=Y` or `D=N`), taxon names, and bootstrap values that standard Newick viewers may ignore. Use `fltreebest` for visualization if available.

## Expert Tips
- **Rooting**: TreeBeST automatically roots the tree by minimizing duplications and losses. You do not need to provide an outgroup manually when using the species-tree guided commands.
- **Internal Nodes**: Ensure every internal node in your custom species tree has a name (e.g., `(RAT,MOUSE)Murinae`). This is critical for the reconciliation algorithm to function.
- **Bootstrap Values**: The `best` command performs 100 resamplings by default using an improved neighbor-joining algorithm.



## Subcommands

| Command | Description |
|---------|-------------|
| pwalign | PairWise ALIGNment tool for nt2nt, aa2aa, nt2aa, or splice alignments |
| treebest backtrans | Back-translate an amino acid alignment to a nucleotide alignment using nucleotide sequences. |
| treebest best | Estimate the best gene tree given a CDS alignment, using PHYML and species tree information. |
| treebest distmat | Calculate a distance matrix from a sequence alignment using various evolutionary models. |
| treebest estlen | Estimate branch lengths for a tree given a distance matrix and a tag. |
| treebest export | Export a tree to a graphical format |
| treebest filter | Filter alignments using TreeBest |
| treebest format | Format a tree using treebest |
| treebest leaf | TreeBest leaf command (Note: The provided help text indicates the tool failed to recognize the --help flag and instead attempted to open it as a file). |
| treebest mfa2aln | Convert MFA (Multi-FASTA) to alignment format |
| treebest mmerge | Merge multiple trees into a forest or reroot trees |
| treebest nj | Neighbor-joining tree building using various distance metrics and models. |
| treebest phyml | Estimate phylogenies by maximum likelihood using TreeFam extensions and the PhyML algorithm. |
| treebest root | Root a phylogenetic tree. (Note: The provided help text was an error message indicating the tool does not support --help and instead expected a file path.) |
| treebest sdi | TreeBest SDI (Speciation Duplication Inference) tool for rooting and comparing gene trees with species trees. |
| treebest simulate | Simulate gene trees given a species tree using a duplication-loss model. |
| treebest sortleaf | Sort leaves in a tree file |
| treebest subtree | Extract a subtree from a tree based on a list of nodes |
| treebest trans | Translate a nucleotide alignment |
| treebest treedist | Calculate the distance between two trees |
| treebest trimpoor | Trim poor branches from a tree based on a threshold. |

## Reference documentation
- [TreeBeST Manual](./references/treesoft_sourceforge_net_treebest.shtml.md)
- [TreeBeST GitHub Repository](./references/github_com_lh3_treebest.md)