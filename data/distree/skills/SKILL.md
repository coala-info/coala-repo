---
name: distree
description: The `distree` tool is a high-performance Rust-based utility designed to process large phylogenetic trees.
homepage: https://github.com/PathoGenOmics-Lab/distree
---

# distree

## Overview
The `distree` tool is a high-performance Rust-based utility designed to process large phylogenetic trees. It solves the problem of memory exhaustion when dealing with thousands of taxa by streaming output row-by-row. Use this skill to calculate evolutionary distances (patristic), node-based distances (topological), or ancestral depths (LMM/var-covar) for downstream applications like clustering, PCoA, or phylogenetic comparative methods.

## CLI Usage Patterns

### Basic Distance Extraction
To compute the standard patristic distance (sum of branch lengths) between all pairs of leaves:
```bash
distree input_tree.nwk -o distances.tsv
```

### Working with Large Trees
For massive trees, leverage the parallel processing capabilities. The tool automatically uses multiple CPU cores to compute rows:
```bash
# Stream directly to a compressed file to save disk space
distree phylogeny.nwk | gzip > distances.tsv.gz
```

### Specialized Matrix Types
*   **Topological Distances**: Use when branch lengths are unreliable or only the tree structure matters (counts the number of edges between taxa).
    ```bash
    distree --topology phylogeny.nwk -o topo_matrix.tsv
    ```
*   **LMM (Variance-Covariance) Matrix**: Use for Phylogenetic Generalized Least Squares (PGLS) or other comparative methods. This outputs the depth of the Most Recent Common Ancestor (MRCA) for each pair.
    ```bash
    distree --lmm phylogeny.nwk -o mrca_depths.tsv
    ```

### Rooting Adjustments
If the input tree is unrooted or requires a balanced perspective for distance calculations, use the midpoint rooting flag:
```bash
distree --midpoint phylogeny.nwk -o midpoint_distances.tsv
```

## Expert Tips & Best Practices
*   **Unique Labels**: Ensure all leaf labels in the Newick file are unique and do not contain tabs or newlines, as these will break the TSV output format.
*   **Memory Efficiency**: Because `distree` streams output, you can process trees that would otherwise exceed your system RAM when represented as a full matrix in memory.
*   **Downstream Integration**: The output is a standard TSV. For machine learning (t-SNE/UMAP) or clustering (Neighbor-Joining), you can load this matrix directly into R (using `read.table`) or Python (using `pandas.read_csv`).
*   **Format Support**: Currently, only Newick format is supported. If your tree is in Nexus or PhyloXML, convert it to Newick first using tools like `gotree` or `biopython`.

## Reference documentation
- [Extracts a distance matrix from a phylogeny (parallel, low-memory)](./references/github_com_PathoGenOmics-Lab_distree.md)
- [distree - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_distree_overview.md)