---
name: pydotplus
description: pydotplus is a Python library that provides an interface for parsing, creating, and rendering Graphviz DOT language diagrams. Use when user asks to parse DOT files, programmatically build graphs, visualize decision trees, or render data into image formats like PNG and SVG.
homepage: https://github.com/carlos-jenkins/pydotplus
metadata:
  docker_image: "quay.io/biocontainers/pydotplus:2.0.2--py36_0"
---

# pydotplus

## Overview

pydotplus is a Python library that provides a comprehensive interface for interacting with the Graphviz DOT language. It is an enhanced fork of the original pydot project, offering better compatibility with modern Python versions and improved parsing capabilities. The tool allows you to transform complex data structures into visual diagrams by either parsing existing DOT files or building graphs dynamically using Python objects. Once a graph is defined, pydotplus can render it into various formats such as PNG, SVG, PDF, or JPEG, provided that the Graphviz binaries are installed on the system.

## Core Usage Patterns

### Parsing DOT Data
To work with existing DOT definitions, use the factory functions to create a `Dot` object.

```python
import pydotplus

# From a string
dot_data = 'digraph G { Hello -> World }'
graph = pydotplus.graph_from_dot_data(dot_data)

# From a file
graph = pydotplus.graph_from_dot_file('path/to/file.dot')
```

### Programmatic Graph Creation
You can build graphs node-by-node and edge-by-edge for dynamic visualizations.

```python
# Initialize a directed graph
graph = pydotplus.Dot(graph_type='digraph')

# Create nodes
node_a = pydotplus.Node("Node A", label="Start", shape="box")
node_b = pydotplus.Node("Node B", label="End")

# Add nodes and edges
graph.add_node(node_a)
graph.add_node(node_b)
graph.add_edge(pydotplus.Edge(node_a, node_b, label="transition"))
```

### Exporting and Rendering
pydotplus relies on the system's Graphviz installation to render images.

```python
# Generate a PNG image
graph.write_png('output.png')

# Generate an SVG
graph.write_svg('output.svg')

# Get raw data in a specific format
pdf_data = graph.create_pdf()
```

## Expert Tips and Best Practices

- **Graphviz Dependency**: pydotplus is a wrapper. If you encounter "GraphViz's executables not found," ensure that the Graphviz software is installed on your OS and that its `bin` folder is in your system's PATH environment variable.
- **Scikit-Learn Integration**: pydotplus is the standard tool for visualizing Decision Trees. Use `sklearn.tree.export_graphviz` to generate DOT data, then pass it to `pydotplus.graph_from_dot_data()` for immediate rendering.
- **Handling Special Characters**: When setting labels that contain HTML-like syntax or special characters, ensure they are properly quoted or escaped within the DOT string to avoid parsing errors.
- **Memory Management**: For extremely large graphs, rendering to a file (`write_png`) is generally more memory-efficient than generating raw byte data in memory (`create_png`).
- **Attribute Customization**: You can pass any valid Graphviz attribute (e.g., `rankdir='LR'`, `color='red'`, `style='filled'`) as keyword arguments when initializing `Dot`, `Node`, or `Edge` objects.

## Reference documentation

- [PyDotPlus Main Repository](./references/github_com_carlos-jenkins_pydotplus.md)
- [Known Issues and Troubleshooting](./references/github_com_carlos-jenkins_pydotplus_issues.md)