---
name: usher
description: The usher tool places new genetic samples onto an existing mutation-annotated tree. Use when user asks to place new samples, identify parsimonious sample placement, or update a mutation-annotated tree.
homepage: https://github.com/yatisht/usher
metadata:
  docker_image: "quay.io/biocontainers/usher:0.6.6--hdd55de9_4"
---

# usher

## Overview
The UShER (Ultrafast Sample Placement on Existing Trees) package is a specialized suite of tools designed for high-performance phylogenetics. It centers around the Mutation-Annotated Tree (MAT) data format, which stores a phylogeny by annotating branches with inferred mutations. This approach allows for the nearly instantaneous placement of new samples into massive trees (containing millions of sequences) using maximum parsimony. Beyond placement, the suite provides utilities for tree optimization, recombination detection, and comprehensive tree manipulation, making it a standard for real-time genomic epidemiology.

## Core Toolset and CLI Patterns

The UShER package consists of four primary executable programs.

### 1. usher
Used to place new samples (in VCF or fasta format) onto an existing MAT.
*   **Primary Input**: An existing MAT file (usually `.pb` or `.pb.gz`) and a VCF file containing the mutations of the new samples relative to the same reference.
*   **Key Function**: It identifies the most parsimonious placement for each new sample and outputs an updated MAT.

### 2. matUtils
The "Swiss Army Knife" for querying, interpreting, and manipulating MAT files.
*   **Summary**: Use `matUtils summary -i tree.pb` to get basic statistics about the tree (number of nodes, samples, etc.).
*   **Extraction**: Use `matUtils extract` to convert MAT files to other formats or isolate specific data.
    *   **Convert to Newick**: `matUtils extract -i tree.pb -t output.nwk`
    *   **Convert to VCF**: `matUtils extract -i tree.pb -v output.vcf`
    *   **Subtree Extraction**: Extract a subtree containing specific samples or clades for localized analysis.
*   **Annotation**: Use `matUtils annotate` to assign clade labels to internal nodes based on specific mutations or provided metadata.
*   **Masking**: Use `matUtils mask` to hide problematic sites or specific samples that may be causing phylogenetic noise.

### 3. matOptimize
A tool for refining the topology of an existing MAT.
*   **Mechanism**: It uses Subtree Pruning and Regrafting (SPR) moves within a user-defined radius to find a more parsimonious tree structure.
*   **Usage**: Run this after placing a large batch of new samples with `usher` to improve the overall tree quality.

### 4. RIPPLES
A specialized tool for detecting recombination events within a MAT.
*   **Usage**: Use this to identify nodes that may have inherited genetic material from multiple ancestors, which is critical for accurate viral evolution tracking.

## Expert Tips and Best Practices

*   **MAT vs. Newick**: Always prefer the MAT (`.pb`) format for internal workflows. Newick files lose the mutation information associated with branches, which UShER tools require for their speed. Only convert to Newick at the final step for visualization in tools like FigTree or Auspice.
*   **VCF Preparation**: Ensure that the VCF used for sample placement is called against the exact same reference genome used to build the starting MAT. Discrepancies in coordinates will lead to incorrect placements.
*   **Handling Large Batches**: When adding thousands of samples, it is often more efficient to use `usher` for initial placement followed by a round of `matOptimize` to resolve any parsimony ties or sub-optimal branch structures created during the rapid placement phase.
*   **Memory Management**: While UShER is highly optimized, working with trees containing millions of sequences (like the global SARS-CoV-2 tree) requires significant RAM. Use `matUtils summary` to check tree size before attempting complex extractions.
*   **Masking**: In viral genomics, certain sites are known to be prone to sequencing errors or recurrent mutations (homoplasies). Use `matUtils mask --mask-mutations` to exclude these sites from the parsimony calculation to prevent artificial clustering.

## Reference documentation
- [Ultrafast Sample Placement on Existing Trees (UShER)](./references/github_com_yatisht_usher.md)
- [usher - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_usher_overview.md)