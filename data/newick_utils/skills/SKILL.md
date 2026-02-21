---
name: newick_utils
description: The `newick_utils` skill enables efficient command-line manipulation of phylogenetic data.
homepage: http://cegg.unige.ch/newick_utils
---

# newick_utils

## Overview
The `newick_utils` skill enables efficient command-line manipulation of phylogenetic data. This suite of tools is designed for high-throughput tree processing, allowing you to programmatically alter tree topology, filter taxa, and generate visual representations without manual editing. It is particularly useful for bioinformaticians needing to automate tree normalization or prepare figures for publication.

## Common CLI Patterns

### Tree Visualization
*   **ASCII Display**: Use `nw_display` to quickly inspect a tree in the terminal.
    ```bash
    nw_display tree.nwk
    ```
*   **SVG Rendering**: Generate publication-quality graphics.
    ```bash
    nw_display -s tree.nwk > tree.svg
    ```

### Topology Manipulation
*   **Re-rooting**: Use `nw_reroot` to set a specific outgroup.
    ```bash
    nw_reroot tree.nwk Outgroup_Node
    ```
*   **Pruning**: Remove specific leaves from a tree.
    ```bash
    nw_prune tree.nwk Leaf_A Leaf_B
    ```
*   **Subtree Extraction**: Isolate a clade based on a common ancestor or specific labels.
    ```bash
    nw_clade tree.nwk Node_Label
    ```

### Tree Refinement
*   **Condensing**: Collapse nodes with low support values (e.g., bootstrap < 70).
    ```bash
    nw_condense 70 tree.nwk
    ```
*   **Trimming**: Remove nodes or simplify the tree structure based on specific criteria using `nw_trim`.

## Expert Tips
*   **Piping**: Newick Utilities are designed to work with Unix pipes. You can chain operations (e.g., rerooting then pruning then displaying) in a single command line to avoid creating intermediate files.
*   **Label Handling**: Ensure your Newick files use standard labeling; special characters or spaces in leaf names may require quoting or pre-processing.
*   **Support Values**: When condensing trees, ensure the support values are correctly positioned in the Newick string (usually as node labels) for the tool to parse them accurately.

## Reference documentation
- [newick_utils - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_newick_utils_overview.md)
- [EZlab | Computational Evolutionary Genomics group](./references/www_ezlab_org_index.md)