---
name: clusterfunk
description: clusterfunk is a specialized suite of tools for phylogenetic tree manipulation, often used in genomic epidemiology workflows.
homepage: https://github.com/cov-ert/clusterfunk
---

# clusterfunk

## Overview
clusterfunk is a specialized suite of tools for phylogenetic tree manipulation, often used in genomic epidemiology workflows. It excels at bridging the gap between tree structures (Newick/Nexus) and tabular metadata. Use this skill to automate the processing of large trees, specifically when you need to propagate traits across nodes, filter trees for specific taxa, or merge multiple trees into a single guide structure.

## Core CLI Patterns

### Tip Annotation and Relabeling
To map metadata from a CSV/TSV file onto the tips of a tree (using NEXUS metacomment format):
```bash
clusterfunk annotate_tips \
  --in-metadata metadata.csv \
  --index-column sequence_name \
  --trait-columns country date lineage \
  --input input.tree \
  --output annotated.tree
```
To rename the tips themselves using metadata fields:
```bash
clusterfunk relabel_tips \
  --in-metadata metadata.csv \
  --index-column sequence_name \
  --trait-columns lineage date \
  --input input.tree \
  --output relabeled.tree
```

### Pruning and Filtering
You can prune trees by providing a list of taxa to keep or remove, or by using metadata attributes.
- **By list:** `clusterfunk prune --input in.tree --output out.tree --taxa taxa_to_keep.txt`
- **By metadata:** Use the `--extract-tip-annotations` command first to identify targets if complex logic is needed, then prune.

### Ancestral State Reconstruction
To reconstruct traits on internal nodes using the Fitch parsimony algorithm:
```bash
clusterfunk ancestral_reconstruction \
  --trait country \
  --input annotated.tree \
  --output reconstructed.tree
```

### Tree Grafting
To merge "scion" trees onto a "guide" tree. The tool identifies the MRCA of shared tips and replaces the guide tree's clade with the scion:
```bash
clusterfunk graft \
  --input guide.tree \
  --scion scion.tree \
  --output merged.tree
```

### Phylotype Assignment
Assign clusters based on a branch length threshold:
```bash
clusterfunk phylotype \
  --threshold 0.0005 \
  --input input.tree \
  --output phylotyped.tree
```

## Expert Tips
- **Format Consistency:** Ensure all trees in a `graft` operation are in the same format (e.g., all Newick or all Nexus).
- **Trait Propagation:** Use `push_annotations_to_tips` after ancestral reconstruction if you need to label all descendants of a node that has reached a specific trait state.
- **Metadata Matching:** The `--index-column` in your metadata must exactly match the taxon labels in the tree file for annotations to succeed.
- **Extraction:** Use `extract_tip_annotations` to quickly generate a CSV of all current tree metadata for validation before performing complex prunes or grafts.

## Reference documentation
- [clusterfunk GitHub Repository](./references/github_com_snake-flu_clusterfunk.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_clusterfunk_overview.md)