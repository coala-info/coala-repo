---
name: multitax
description: multitax is a Python package that provides a unified interface to interact with, explore, and translate between diverse biological taxonomies like NCBI, GTDB, and SILVA. Use when user asks to retrieve taxonomic lineages, navigate parent-child relationships, filter or prune taxonomic trees, and translate identifiers between different classification systems.
homepage: https://github.com/pirovc/multitax
---


# multitax

## Overview
multitax is a Python package that provides a unified interface for interacting with diverse biological taxonomies. It abstracts the complexities of different database formats, allowing for seamless exploration of taxonomic lineages, parent-child relationships, and leaf nodes. Use this skill to automate the retrieval of taxonomy files, perform consistency checks on custom trees, and bridge the gap between different classification systems like NCBI and GTDB.

## Core Usage Patterns

### Initializing Taxonomies
The library supports several major databases. By default, initializing a class without arguments will download the latest version into memory.

```python
from multitax import NcbiTx, GtdbTx, SilvaTx, OttTx, GreengenesTx

# Download and parse NCBI taxonomy
tax = NcbiTx()

# Load from local files to save time/bandwidth
tax = GtdbTx(files=["bac120_taxonomy.tsv.gz", "ar122_taxonomy.tsv.gz"])

# Download and save to a specific path for persistence
tax = NcbiTx(output_prefix="data/taxonomy/")
```

### Exploring the Tree
Once loaded, use these methods to navigate the hierarchy:

*   **Lineage Retrieval**: `tax.lineage(node)` returns IDs; `tax.name_lineage(node)` returns names; `tax.rank_lineage(node)` returns ranks.
*   **Relationship Mapping**: Use `tax.parent(node)` and `tax.children(node)` for immediate steps, or `tax.leaves(node)` to find all terminal nodes in a branch.
*   **Rank-Specific Queries**: `tax.parent_rank(node, "phylum")` finds the ancestor at a specific level.
*   **Search**: `tax.search_name("Escherichia", exact=False)` helps find nodes when the exact ID is unknown.

### Filtering and Modification
You can reduce the memory footprint or focus on specific clades:

*   **Filtering**: `tax.filter(["node_id_1", "node_id_2"])` keeps only the specified nodes and their ancestors.
*   **Pruning**: `tax.prune("node_id")` removes an entire branch from the tree.
*   **Custom Nodes**: Use `tax.add("new_id", "parent_id", name="Name", rank="rank")` to extend existing taxonomies with custom data.

### Cross-Taxonomy Translation
One of the most powerful features is translating between systems (e.g., mapping GTDB to NCBI):

```python
from multitax import GtdbTx, NcbiTx

gtdb = GtdbTx()
ncbi = NcbiTx()

# Build the mapping
gtdb.build_translation(ncbi)

# Translate a GTDB genus to NCBI IDs
ncbi_ids = gtdb.translate("g__Escherichia")
```

## Expert Tips
*   **Performance**: For large-scale operations, call `tax.build_lineages()` after loading. This pre-computes lineages in memory, significantly speeding up subsequent `lineage()` calls.
*   **Memory Management**: If you only need a specific branch (e.g., Proteobacteria), use the `root_node` parameter during initialization: `NcbiTx(root_node="1224")`.
*   **Consistency**: When removing nodes manually, always set `check_consistency=True` to prevent orphaned branches that could crash downstream analysis.
*   **Custom Output**: The `tax.write()` method is highly flexible. Use the `cols` parameter to define exactly what data is exported (e.g., `cols=["node", "rank", "lineage"]`).

## Reference documentation
- [MultiTax GitHub Repository](./references/github_com_pirovc_multitax.md)
- [MultiTax Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_multitax_overview.md)