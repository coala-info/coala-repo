---
name: phylovega
description: Phylovega is a Python library that creates interactive, web-based phylogenetic tree visualizations using the Vega grammar. Use when user asks to visualize Newick-formatted trees, customize tree styling parameters programmatically, or render interactive charts in JupyterLab.
homepage: https://github.com/Zsailer/phylovega
---


# phylovega

## Overview
Phylovega is a Python library designed to bridge the gap between phylogenetic data and interactive web-based visualizations. It leverages the Vega grammar to render trees, allowing for a declarative approach to styling. Use this skill when you need to visualize Newick-formatted trees with specific requirements for interactivity, or when you need to adjust visual parameters like node size, edge color, and label scaling programmatically.

## Installation
Phylovega can be installed via pip or conda:

```bash
# Using pip
pip install phylovega

# Using conda via bioconda
conda install bioconda::phylovega
```

## Core Usage Pattern
The primary interface is the `TreeChart` class. It is designed to work out-of-the-box in JupyterLab.

### Basic Visualization
To render a tree from a Newick file with default settings:

```python
from phylovega import TreeChart

chart = TreeChart.read_newick('path/to/tree.newick')
chart.display()
```

### Customizing Visual Attributes
Phylovega allows you to pass styling parameters directly into the `read_newick` method:

```python
chart = TreeChart.read_newick(
    'tree.newick',
    height_scale=200,      # Adjust vertical spacing between nodes
    node_size=200,         # Size of internal nodes
    node_color="#ccc",     # Hex color for nodes
    leaf_labels="id",      # Attribute to use for leaf text
    edge_width=2,          # Thickness of branches
    edge_color="#000"      # Color of branches
)
chart.display()
```

## Expert Tips and Best Practices
- **Label Overlap**: If leaf labels are overlapping or the tree looks cramped, increase the `height_scale` parameter. This expands the vertical distance between branches.
- **JupyterLab Integration**: Phylovega is optimized for JupyterLab. If the visualization does not appear in standard Jupyter Notebook, ensure you have `ipyvega` installed or use the JupyterLab environment.
- **Data Integration**: For complex data manipulation before visualization, use `PhyloPandas`. Phylovega is designed to work alongside Pandas-like structures for phylogenetic data.
- **Vega Specifications**: Since the output is a Vega specification, the resulting charts are highly portable and can be embedded in web applications that support Vega 4.

## Reference documentation
- [Phylovega GitHub Repository](./references/github_com_Zsailer_phylovega.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phylovega_overview.md)