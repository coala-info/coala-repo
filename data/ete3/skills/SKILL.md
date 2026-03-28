---
name: ete3
description: The ETE Toolkit is a Python framework and command-line suite for the analysis, manipulation, and visualization of phylogenetic trees. Use when user asks to visualize trees, prune taxa, root trees, annotate nodes with NCBI taxonomy, or perform evolutionary analysis.
homepage: http://etetoolkit.org/
---


# ete3

## Overview
The ETE (Environment for Tree Exploration) Toolkit is a specialized Python framework and CLI suite designed for phylogenomics. It excels at handling hierarchical data structures, particularly biological trees. You should use this skill to automate repetitive tree-handling tasks, such as pruning specific taxa, rooting trees, or generating customized visual reports that combine phylogenetic trees with multiple sequence alignments (MSA).

## Core CLI Operations
The `ete3` command-line interface provides several sub-tools for common workflows:

### Visualization and Annotation
*   **Quick View**: Use `ete3 view -t tree.nw` to launch the interactive GUI.
*   **Image Rendering**: Generate publication-ready figures:
    ```bash
    ete3 view -t tree.nw --out my_tree.pdf --width 200
    ```
*   **Taxonomy Annotation**: Automatically link nodes to NCBI TaxIDs:
    ```bash
    ete3 annotate -t tree.nw --ncbi
    ```

### Tree Manipulation (`ete3 mod`)
*   **Pruning**: Keep only a specific subset of leaf names:
    ```bash
    ete3 mod -t tree.nw --prune leaf_A leaf_B leaf_C
    ```
*   **Rooting**: Root the tree by a specific outgroup or midpoint:
    ```bash
    ete3 mod -t tree.nw --root leaf_X
    ```

### Comparative Genomics
*   **Tree Comparison**: Calculate Robinson-Foulds distances between a reference and a test tree:
    ```bash
    ete3 compare -r reference.nw -t test.nw
    ```
*   **Evolutionary Analysis (`ete3 evol`)**: Run CodeML/PAML models to test for site or branch-specific selection.

## Python API Best Practices
When using the Python library (`from ete3 import Tree`), follow these patterns for efficiency:

### Tree Loading Formats
ETE uses a `format` argument (0-100) to handle various Newick flavors.
*   **Format 0 (Default)**: Flexible, supports distances and support values.
*   **Format 1**: Internal node names.
*   **Format 8**: All names (internal and leaves), no distances.
*   **Format 9**: Leaf names only.

### Efficient Traversal
Avoid converting to lists if only iterating. Use the built-in generators:
```python
from ete3 import Tree
t = Tree("((A,B),C);")

# Find specific nodes
target = t.search_nodes(name="A")[0]

# Fast traversal
for node in t.traverse("postorder"):
    if node.is_leaf():
        print(node.name)
```

### Programmatic Drawing
Customizing tree images requires `TreeStyle`, `NodeStyle`, and `Face` objects:
1.  **TreeStyle**: Global settings (circular vs. rectangular, scale).
2.  **NodeStyle**: Individual node aesthetics (colors, sizes).
3.  **Faces**: Adding external data (text, heatmaps, charts) to nodes.

## Expert Tips
*   **NCBI Database**: The first time you use NCBI features, ETE will download a local sqlite copy of the taxonomy database. Use `ete3 ncbiquery --update` to refresh it.
*   **Large Trees**: For trees with >10,000 leaves, use `tree.resolve_polytomy()` to handle multifurcations before certain analytical steps.
*   **Detaching vs. Deleting**: Use `node.detach()` to remove a subtree while keeping it in memory; use `node.delete()` to remove a node and connect its children to its parent (collapsing the node).



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotates a tree with information from external files. |
| ete3_split | Splits a tree file into several smaller tree files, one for each tree in the original file. |
| expand | Expand a tree with new sequences |
| ncbiquery | Query NCBI databases for sequences and retrieve them in Newick format. |

## Reference documentation
- [ETE's Reference Guide](./references/etetoolkit_org_docs_latest_reference_index.html.md)
- [The ETE tutorial](./references/etetoolkit_org_docs_latest_tutorial_index.html.md)
- [Working With Tree Data Structures](./references/etetoolkit_org_docs_latest_tutorial_tutorial_trees.html.md)
- [The Programmable Tree Drawing Engine](./references/etetoolkit_org_docs_latest_tutorial_tutorial_drawing.html.md)
- [Phylogenomic Tools Index](./references/etetoolkit_org_documentation_tools.md)