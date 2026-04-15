---
name: clusterfunk
description: Clusterfunk provides a suite of subcommands for manipulating phylogenetic trees and integrating them with metadata. Use when user asks to annotate or relabel tree tips, prune or graft trees, perform ancestral reconstruction, assign phylotypes, or extract taxa and annotations.
homepage: https://github.com/cov-ert/clusterfunk
metadata:
  docker_image: "quay.io/biocontainers/clusterfunk:0.0.2--pyh3252c3a_0"
---

# clusterfunk

## Overview
The `clusterfunk` utility provides a specialized set of subcommands designed to bridge the gap between phylogenetic trees and metadata. It is particularly useful for genomic epidemiology and large-scale viral surveillance workflows where trees need to be decorated with traits, filtered based on specific taxa, or merged (grafted) to maintain updated evolutionary contexts. This skill guides the execution of these phylogenetic "funk" operations via the command line.

## Core CLI Patterns

### Tip Annotation and Relabeling
One of the most common tasks is mapping CSV/TSV metadata onto tree tips.
- **Annotate Tips**: Adds metadata as NEXUS metacomments without changing taxon names.
  ```bash
  clusterfunk annotate_tips \
    --in-metadata metadata.csv \
    --index-column sequence_name \
    --trait-columns location date lineage \
    --input input.tree \
    --output annotated.tree
  ```
- **Relabel Tips**: Physically changes the taxon labels in the tree file to include metadata.
  ```bash
  clusterfunk relabel_tips \
    --in-metadata metadata.csv \
    --index-column sequence_name \
    --trait-columns location \
    --input input.tree \
    --output relabeled.tree
  ```

### Tree Manipulation
- **Pruning**: Remove or keep specific taxa. You can provide a list via a fasta, text file, or metadata.
  ```bash
  clusterfunk prune --extract --fasta sequences.fasta --input full.tree --output subset.tree
  ```
- **Grafting**: Insert "scion" trees into a "guide" tree at the MRCA of shared tips.
  ```bash
  clusterfunk graft --input guide.tree --scion scion.tree --output merged.tree
  ```

### Analysis and Reconstruction
- **Ancestral Reconstruction**: Uses the Fitch parsimony algorithm to infer internal node states for a given trait.
  ```bash
  clusterfunk ancestral_reconstruction --trait location --input annotated.tree --output reconstructed.tree
  ```
- **Phylotyping**: Assign clusters based on a branch length threshold.
  ```bash
  clusterfunk phylotype --threshold 0.001 --input tree.nwk --output phylotypes.csv
  ```
- **Label Transitions**: Identify and count where traits change across the tree branches.
  ```bash
  clusterfunk label_transitions --trait host --input reconstructed.tree --output transitions.tree
  ```

### Data Extraction
- **Get Taxa**: Quickly list all tip labels.
  ```bash
  clusterfunk get_taxa --input tree.nwk > taxa_list.txt
  ```
- **Extract Annotations**: Convert tree metacomments back into a flat CSV format.
  ```bash
  clusterfunk extract_tip_annotations --traits location lineage --input annotated.tree --output extracted_metadata.csv
  ```

## Expert Tips
- **Format Consistency**: When grafting, ensure the guide tree and all scion trees are in the same format (e.g., all NEXUS or all Newick).
- **Trait Pushing**: Use `push_annotations_to_tips` to propagate internal node labels (like lineage assignments) down to all descendant tips.
- **Basal Taxon**: Use `return_basal` to identify a representative taxon from the base of a cluster, which is useful for rooting or outgroup selection.



## Subcommands

| Command | Description |
|---------|-------------|
| clusterfunk | A suite of tools for manipulating and annotating phylogenetic trees. |
| clusterfunk | A tool for manipulating and annotating phylogenetic trees. |
| clusterfunk | A tool for phylogenetic tree manipulation and annotation. The provided help text indicates an invalid subcommand choice and lists available subcommands. |
| clusterfunk | A tool for manipulating and annotating phylogenetic trees. Available subcommands include phylotype, ancestral_reconstruction, prune, graft, and others. |
| clusterfunk | A suite of tools for manipulating and annotating phylogenetic trees. |
| clusterfunk | A tool for tree manipulation and annotation |
| clusterfunk | A suite of tools for manipulating and annotating phylogenetic trees. |
| clusterfunk | A tool for manipulating and annotating phylogenetic trees. |
| clusterfunk | A suite of tools for manipulating and annotating phylogenetic trees. |
| clusterfunk | A suite of tools for manipulating and annotating phylogenetic trees. |
| clusterfunk | A tool for phylogenetic tree manipulation and annotation. |
| clusterfunk | A tool for phylogenetic tree manipulation and annotation. It provides various subcommands to process, prune, graft, and annotate trees. |
| clusterfunk ancestral_reconstruction | Reconstruct ancestral states on a phylogenetic tree using ACCTRAN or DELTRAN rules. |
| clusterfunk annotate | Annotate tips and nodes in a phylogenetic tree using taxon labels, metadata files, or MRCA rules. |
| clusterfunk annotate_tips_from_nodes | Annotate tips of a tree from its nodes based on specified traits. |
| clusterfunk at | A tool for annotating and manipulating phylogenetic trees. Note: The provided help text indicates 'at' is an invalid subcommand choice. |
| clusterfunk extract_annotations | Extract tip annotations from a phylogenetic tree file into a CSV. |
| clusterfunk get_taxa | Extract taxa from a tree file. |
| clusterfunk graft | Graft incoming trees onto an input guide tree. |
| clusterfunk label_transitions | Label transitions of a trait on a phylogenetic tree and optionally output exploded trees for each transition. |
| clusterfunk phylotype | Assign phylotypes to a tree based on branch length thresholds. |
| clusterfunk prune | Prune or extract subtrees from a phylogenetic tree based on taxa sets, metadata, or traits. |

## Reference documentation
- [Clusterfunk README](./references/github_com_snake-flu_clusterfunk_blob_master_README.md)
- [Clusterfunk Overview](./references/github_com_snake-flu_clusterfunk.md)