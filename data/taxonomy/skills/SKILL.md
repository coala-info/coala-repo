---
name: taxonomy
description: The taxonomy library manages and navigates hierarchical biological classification data with high performance. Use when user asks to load NCBI or Newick data, traverse lineages, find lowest common ancestors, or prune and edit taxonomic trees.
homepage: https://github.com/onecodex/taxonomy/
---


# taxonomy

## Overview
The `taxonomy` library is a high-performance tool (built in Rust with Python bindings) for managing hierarchical biological classification data. It excels at navigating complex tree structures, allowing you to traverse lineages, identify common ancestors, and modify tree topology. It is particularly useful for bioinformatics workflows that require standardizing taxonomic IDs (treated as strings) or filtering large datasets like the NCBI taxonomy into smaller, manageable subsets.

## Installation
Install the library via pip or conda:
```bash
pip install taxonomy
# OR
conda install bioconda::taxonomy
```

## Loading Taxonomies
The library supports multiple input formats. Note that all Taxonomy IDs are handled as strings to ensure interoperability.

- **NCBI Dumps**: Requires a directory containing `nodes.dmp` and `names.dmp`.
  ```python
  from taxonomy import Taxonomy
  tax = Taxonomy.from_ncbi("path/to/ncbi_folder/")
  ```
- **Newick**: Load from a Newick-encoded string.
  ```python
  tax = Taxonomy.from_newick("((A,B)C,D)E;")
  ```
- **JSON**: Supports "tree" and "node_link_data" formats.
  ```python
  tax = Taxonomy.from_json(json_string)
  ```

## Common Operations
Once a taxonomy is loaded as the object `tax`, use the following patterns for analysis:

### Traversal and Hierarchy
- **Get Lineage**: Returns a list of nodes from the root down to the specified ID.
  ```python
  nodes = tax.lineage("9606")
  ```
- **Find Parent at Rank**: Jump directly to a specific rank in a node's ancestry.
  ```python
  species_node = tax.parent("612", at_rank="species")
  ```
- **Lowest Common Ancestor (LCA)**: Find the shared ancestor of two nodes.
  ```python
  common = tax.lca("9606", "10090")
  ```

### Tree Manipulation
- **Pruning**: Create a subset of the tree.
  ```python
  # Keep only specific IDs and their ancestors
  new_tax = tax.prune(keep=["1234", "5678"])
  
  # Remove specific IDs and their descendants
  filtered_tax = tax.prune(remove=["999"])
  ```
- **Editing Nodes**: Modify names or ranks dynamically.
  ```python
  tax.edit_node("1234", name="New Name", rank="genus")
  ```

## Expert Tips and Best Practices
- **String IDs**: Always pass IDs as strings, even if they are numeric (e.g., use `"562"` instead of `562`).
- **Dictionary Access**: You can access nodes using square brackets `tax["id"]`, but this raises an exception if the ID is missing. Use `tax.node("id")` to return `None` instead.
- **Custom Metadata**: If loading from JSON, any additional data fields in the source file are accessible via indexing the node object: `node["my_custom_field"]`.
- **Memory Efficiency**: The underlying Rust implementation is optimized for low memory usage, making it suitable for loading the full NCBI taxonomy on standard machines.
- **Scientific Names**: When using `find_all_by_name()`, be aware that for NCBI data, this typically only matches primary scientific names, not synonyms.

## Reference documentation
- [One Codex Taxonomy GitHub Repository](./references/github_com_onecodex_taxonomy.md)
- [Bioconda Taxonomy Overview](./references/anaconda_org_channels_bioconda_packages_taxonomy_overview.md)