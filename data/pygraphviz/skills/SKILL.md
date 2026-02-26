---
name: pygraphviz
description: Pygraphviz provides a Python interface to the Graphviz package for creating, manipulating, and rendering graph data structures and DOT files. Use when user asks to create graph visualizations, apply layout algorithms to diagrams, or programmatically edit DOT files.
homepage: https://github.com/pygraphviz/pygraphviz
---


# pygraphviz

## Overview
Pygraphviz provides a Pythonic interface to the Graphviz graph layout and visualization package. It allows for the creation and modification of graph data structures, including nodes, edges, and subgraphs, and provides methods to apply layout algorithms and render the results into various image formats. Use this skill to automate the generation of complex diagrams, convert data into visual representations, or manipulate existing DOT files within a Python environment.

## Usage Guidelines

### Core Graph Operations
The primary interface is the `AGraph` class. You can create graphs from scratch or load them from existing DOT files.

```python
import pygraphviz as pgv

# Initialize a new graph
G = pgv.AGraph(strict=True, directed=True)

# Add nodes and edges
G.add_node("start", shape="box", color="blue")
G.add_edge("start", "process", label="initialize")
G.add_edge("process", "end")

# Accessing attributes
node = G.get_node("start")
node.attr["fontsize"] = "12"
```

### Layout and Rendering
Pygraphviz requires the Graphviz binaries to be installed on the system to perform layouts and drawing.

*   **Layout**: Use `G.layout(prog='...')` where `prog` is one of the Graphviz engines (e.g., `dot`, `neato`, `fdp`, `sfdp`, `twopi`, `circo`).
*   **Drawing**: Use `G.draw('filename.ext')` to render the graph. Supported extensions typically include `.png`, `.pdf`, `.svg`, and `.jpg`.

```python
# Apply layout and save to file
G.layout(prog="dot")
G.draw("workflow.png")
```

### Working with DOT Files
Pygraphviz is highly effective for reading and writing the DOT language format.

*   **Writing**: `G.write("output.dot")` saves the current graph structure to a text file.
*   **Reading**: `G = pgv.AGraph("input.dot")` loads a graph from a file.
*   **String Representation**: Printing the graph object (`print(G)`) outputs the DOT source code.

### Subgraphs and Clusters
To group nodes together, use subgraphs. If the name starts with `cluster`, Graphviz will treat it as a visual cluster (drawing a bounding box).

```python
# Create a cluster
G.add_subgraph(["node1", "node2"], name="cluster_0", label="Group A", color="red")
```

## Best Practices
*   **Strict Graphs**: Use `strict=True` during initialization to prevent the creation of duplicate edges between the same pair of nodes.
*   **Attribute Management**: Attributes can be set globally for the graph, or specifically for nodes and edges. Use the `.attr` dictionary on the graph, node, or edge objects for fine-grained control.
*   **HTML Labels**: Pygraphviz supports HTML-like labels for complex node formatting. Ensure the label string is wrapped in `< >` instead of quotes.
*   **NetworkX Integration**: If you are performing heavy graph analysis, use NetworkX for the logic and convert to Pygraphviz for the visualization using `networkx.drawing.nx_agraph.to_agraph()`.

## Reference documentation
- [Pygraphviz Main Repository](./references/github_com_pygraphviz_pygraphviz.md)