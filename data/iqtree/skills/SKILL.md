---
name: iqtree
description: IQ-TREE infers high-quality phylogenetic trees from molecular sequences using maximum likelihood. Use when user asks to construct phylogenetic trees, perform automatic model selection, or calculate branch support values.
homepage: http://www.iqtree.org
metadata:
  docker_image: "quay.io/biocontainers/iqtree:3.0.1--h503566f_0"
---

# iqtree

## Overview
IQ-TREE is a high-performance tool designed to infer evolutionary relationships from molecular sequences. It is particularly valued for its "ModelFinder" feature, which automatically determines the best-fit substitution model, and its "Ultra-fast Bootstrap" (UFBoot) algorithm, which provides reliable branch support values significantly faster than traditional bootstrapping methods. Use this skill to construct high-quality phylogenetic trees from multiple sequence alignments (MSA).

## Common CLI Patterns

### Basic Tree Inference
To run a standard analysis with automatic model selection and tree inference:
```bash
iqtree -s alignment.phy
```

### Model Selection and Branch Support
The most common "best-practice" command for publication-quality trees:
```bash
iqtree -s alignment.phy -m MFP -bb 1000 -alrt 1000
```
- `-m MFP`: ModelFinder Plus (finds best model and then infers the tree).
- `-bb 1000`: Performs 1000 replicates of Ultra-fast Bootstrap.
- `-alrt 1000`: Performs 1000 replicates of SH-like approximate likelihood ratio test.

### Partitioned Analysis
For multi-gene datasets, use a partition file to allow different models for different loci:
```bash
iqtree -s alignment.phy -p partition.txt -m MFP+MERGE
```
- `-p`: Specifies the partition file (Nexus or RAxML format).
- `+MERGE`: Automatically merges partitions to reduce over-parameterization.

### Constraining Topology
To test a specific hypothesis by forcing a certain grouping:
```bash
iqtree -s alignment.phy -g constraint_tree.nwk
```

## Expert Tips
- **CPU Usage**: Use `-nt AUTO` to let IQ-TREE determine the optimal number of threads for your hardware.
- **Resuming Runs**: If a run is interrupted, use `-redo` to overwrite or IQ-TREE will typically attempt to resume from the last checkpoint if the prefix matches.
- **Interpreting Support**: For UFBoot (`-bb`), a value $\ge$ 95% is generally considered strong support. For SH-aLRT (`-alrt`), a value $\ge$ 80% is considered strong.
- **Data Formats**: IQ-TREE accepts Phylip, Fasta, Nexus, and Clustal formats. It automatically detects the format based on content.

## Reference documentation
- [IQ-TREE Overview](./references/anaconda_org_channels_bioconda_packages_iqtree_overview.md)
- [IQ-TREE Homepage](./references/www_iqtree_org_index.md)