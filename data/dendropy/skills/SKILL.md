---
name: dendropy
description: DendroPy is a sophisticated Python library designed for phylogenetic scripting and data manipulation.
homepage: https://github.com/jeetsukumaran/DendroPy
---

# dendropy

## Overview
DendroPy is a sophisticated Python library designed for phylogenetic scripting and data manipulation. It provides a robust object-oriented framework for handling the complexities of phylogenetic data, such as tree topologies, branch lengths, and taxon sets. Use this skill to automate the processing of large-scale tree distributions, perform simulations under various evolutionary models, or bridge the gap between different phylogenetic software tools by converting data formats.

## Installation and Setup
DendroPy 5.x requires Python 3. It can be installed via standard Python package managers:

- **Pip**: `python -m pip install dendropy`
- **Conda**: `conda install -c conda-forge dendropy`

## Core Python Usage Patterns

### Reading and Writing Trees
DendroPy uses a "schema" argument to handle various formats (newick, nexus, nexml, phylip, fasta).

```python
import dendropy

# Load a tree from a file
tree = dendropy.Tree.get(
    path="input.tre", 
    schema="newick"
)

# Load a tree from a string
tree = dendropy.Tree.get(
    data="(A:0.1,B:0.2,(C:0.3,D:0.4):0.5);", 
    schema="newick"
)

# Write a tree to a file
tree.write(
    path="output.nex", 
    schema="nexus"
)
```

### Managing Taxon Sets
To ensure consistency across multiple trees or data matrices, always use a `TaxonNamespace`. This prevents the creation of redundant taxon objects.

```python
tns = dendropy.TaxonNamespace()
tree1 = dendropy.Tree.get(path="tree1.tre", schema="newick", taxon_namespace=tns)
tree2 = dendropy.Tree.get(path="tree2.tre", schema="newick", taxon_namespace=tns)
```

### Tree Manipulation
- **Rerooting**: Use `tree.reroot_at_node(node)` or `tree.reroot_at_edge(edge)`. Note that rerooting at an edge may require careful handling of edge labels/annotations.
- **Pruning**: Use `tree.prune_taxa_with_labels(["taxon_a", "taxon_b"])` to remove specific tips.
- **Iterating**: Use `tree.preorder_node_iter()`, `tree.postorder_node_iter()`, or `tree.leaf_node_iter()` for traversal.

## Application Scripts
DendroPy installs several CLI utilities for common tasks:

- **sumtrees**: Used for summarizing non-parametric bootstrap or MCMC tree samples. It can calculate consensus trees and map support values onto a target tree.
- **dendropy-convert**: A quick CLI tool for converting between phylogenetic data formats.

## Expert Tips
- **Memory Management**: When working with very large tree samples (e.g., from BEAST or MrBayes), use the `tree_yielder` to process trees one at a time rather than loading the entire file into memory.
- **Annotations**: DendroPy supports rich metadata via the `annotations` attribute on most objects. These can be read from and written to NeXML or specially formatted Nexus/Newick comments (e.g., FigTree format).
- **Validation**: When reading data, use `preserve_underscores=True` if your taxon labels contain underscores that should not be converted to spaces, a common issue in Nexus/Newick parsing.

## Reference documentation
- [DendroPy GitHub Repository](./references/github_com_jeetsukumaran_DendroPy.md)
- [Bioconda DendroPy Overview](./references/anaconda_org_channels_bioconda_packages_dendropy_overview.md)