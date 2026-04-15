---
name: jclusterfunk
description: jclusterfunk processes and transforms phylogenetic trees by integrating tabular metadata and modifying tree structures. Use when user asks to annotate trees with metadata, reroot or reorder nodes, prune specific taxa, collapse branches, or scale branch lengths.
homepage: https://github.com/snake-flu/jclusterfunk
metadata:
  docker_image: "quay.io/biocontainers/jclusterfunk:0.0.25--hdfd78af_0"
---

# jclusterfunk

## Overview
jclusterfunk is a specialized tool for processing and transforming phylogenetic trees, commonly used in genomic epidemiology. It bridges the gap between tree files (Newick/Nexus) and tabular metadata (CSV), allowing for automated annotation, subsetting, and structural modification of large trees. It is particularly effective for preparing trees for visualization in FigTree or for downstream analysis where metadata must be mapped to internal nodes or tip labels.

## Core Usage Patterns
The general syntax is: `jclusterfunk <command> [options]`

### Global Options
- `-i, --input`: Path to the input tree file.
- `-o, --output`: Path for the output file or directory.
- `-f, --format`: Output format (`nexus` or `newick`).
- `-m, --metadata`: CSV file for commands requiring external data.

### Common Workflows

#### 1. Annotating Trees with Metadata
Map CSV columns to tree tips as internal attributes or label fields.
```bash
jclusterfunk annotate -i tree.nwk -m metadata.csv -c taxon_name --tip-attributes country,date -o annotated.nexus
```
- Use `--index-column` (`-c`) to specify which CSV column matches the tip labels.
- Use `--label-fields` to modify the actual tip strings.
- Use `--replace` to overwrite existing annotations instead of appending.

#### 2. Rerooting and Reordering
Standardize tree appearance for publication or analysis.
- **Midpoint root**: `jclusterfunk reroot -i tree.nwk --midpoint -o rooted.nwk`
- **Outgroup root**: `jclusterfunk reroot -i tree.nwk --outgroup taxon_A,taxon_B -o rooted.nwk`
- **Reorder**: `jclusterfunk reorder -i tree.nwk --increasing -o ordered.nwk` (orders nodes by clade size).

#### 3. Pruning and Subsetting
- **Prune**: Remove specific taxa. `jclusterfunk prune -i tree.nwk -t taxa_to_remove.csv -o pruned.nwk`
- **Keep**: Use `-k` with prune to keep only the specified taxa.
- **Context**: Extract a neighborhood (ancestors, siblings, children) around specific tips. `jclusterfunk context -i tree.nwk -t focal_taxa.csv -o subtree.nwk`

#### 4. Structural Modifications
- **Collapse**: Turn short branches into polytomies. `jclusterfunk collapse -i tree.nwk --threshold 0.0001 -o collapsed.nwk`
- **Scale**: Multiply branch lengths by a factor or scale to a specific root height. `jclusterfunk scale -i tree.nwk --factor 365 -o scaled.nwk`

### Expert Tips
- **Tip Label Parsing**: If tip labels contain multiple fields (e.g., `ID|Country|Date`), use `--index-field` (1-indexed) and `--field-delimiter` (default is `|`) to target a specific part of the label for metadata matching.
- **Format Conversion**: Use the `convert` command to switch between Nexus and Newick without altering the tree structure.
- **Batch Splitting**: Use `split --attribute <column>` to break a large tree into multiple subtrees based on a specific metadata value (e.g., creating separate files for each lineage).
- **Parsimony Reconstruction**: Use `reconstruct` to infer internal node states based on tip annotations using parsimony.

## Reference documentation
- [jclusterfunk GitHub Repository](./references/github_com_rambaut_jclusterfunk.md)