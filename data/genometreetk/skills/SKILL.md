---
name: genometreetk
description: genometreetk is a toolkit designed for the refinement, rooting, pruning, and decoration of phylogenomic trees. Use when user asks to root trees, prune specific taxa, decorate trees with metadata, or calculate bootstrap support values.
homepage: http://pypi.python.org/pypi/genometreetk/
---


# genometreetk

## Overview

genometreetk is a specialized toolkit designed for the refinement and analysis of phylogenomic trees. It provides a suite of command-line utilities to handle common tree-processing tasks that are often required after initial tree reconstruction. Use this skill to automate workflows for rooting trees (via outgroup or midpoint), pruning specific taxa to create sub-trees, calculating bootstrap support, and "decorating" trees with metadata or internal node labels for downstream visualization in tools like iTOL or FigTree.

## Command-Line Usage and Best Practices

### Core Commands

*   **Rooting Trees**: Use `genometreetk root` to establish the evolutionary direction of a tree.
    *   *Outgroup rooting*: `genometreetk root --input <in.tree> --output <out.tree> --outgroup <taxa_list_file>`
    *   *Midpoint rooting*: `genometreetk root --input <in.tree> --output <out.tree> --method midpoint`
*   **Pruning Taxa**: Use `genometreetk prune` to remove specific leaves while maintaining the relative topology of the remaining nodes.
    *   `genometreetk prune --input <in.tree> --output <out.tree> --taxa <taxa_to_remove_file>`
*   **Decorating Trees**: Use `genometreetk decorate` to add taxonomic information or custom labels to internal nodes based on a mapping file.
    *   `genometreetk decorate --input <in.tree> --output <decorated.tree> --taxonomy <gtdb_taxonomy.tsv>`
*   **Bootstrap Analysis**: Use `genometreetk bootstrap` to map bootstrap support values from multiple replicate trees onto a target consensus tree.
    *   `genometreetk bootstrap --target <consensus.tree> --bootstraps <replicates_dir> --output <final.tree>`

### Expert Tips

*   **Input Formats**: Ensure trees are in Newick format. If working with GTDB-Tk outputs, genometreetk is natively compatible with the resulting `.tree` files.
*   **Taxa Lists**: When pruning or rooting by outgroup, provide taxa names exactly as they appear in the Newick file (including underscores or specific accessions).
*   **Memory Management**: For very large trees (e.g., >50,000 genomes), ensure the environment has sufficient RAM as the tool loads the entire tree structure into memory for processing.
*   **Label Handling**: When decorating, use the `--clear_labels` flag if you want to remove existing internal node support values before applying new taxonomic labels.



## Subcommands

| Command | Description |
|---------|-------------|
| derep_tree | Dereplicate tree to taxa of interest. |
| fill_ranks | Ensure taxonomy strings contain all 7 canonical ranks. |
| genometreetk append | Append taxonomy to extant tree labels. |
| genometreetk arb_records | Create an ARB records file from GTDB metadata. |
| genometreetk bootstrap | Bootstrap multiple sequence alignment. |
| genometreetk jk_markers | Jackknife marker genes. |
| genometreetk jk_taxa | Jackknife ingroup taxa. |
| genometreetk lsu_tree | Infer 23S tree spanning GTDB genomes. |
| genometreetk midpoint | Reroot tree at midpoint. |
| genometreetk pd | Calculate phylogenetic diversity of specified taxa. |
| genometreetk pd_clade | Calculate phylogenetic diversity of named groups. |
| genometreetk propagate | Propagate labels to all genomes in a cluster. |
| genometreetk strip | Remove taxonomic labels from a tree. |
| genometreetk_combine | Combine all support values into a single tree. |
| genometreetk_prune | Prune tree to a specific set of extant taxa. |
| genometreetk_pull | Create taxonomy file from a decorated tree. |
| outgroup | Reroot tree with outgroup. |
| rm_support | Remove support values from tree. |
| rna_dump | Dump all 5S, 16S, and 23S sequences to files. |
| rna_tree | Infer a concatenated 16S + 23S tree spanning GTDB genomes. |
| ssu_tree | Infer 16S tree spanning GTDB genomes. |

## Reference documentation
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genometreetk_overview.md)
- [PyPI Project Page](./references/pypi_org_project_genometreetk.md)