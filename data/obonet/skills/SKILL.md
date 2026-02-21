---
name: obonet
description: obonet is a specialized Python library designed to bridge the gap between OBO-formatted biological ontologies and the NetworkX graph library.
homepage: https://github.com/dhimmel/obonet
---

# obonet

## Overview
obonet is a specialized Python library designed to bridge the gap between OBO-formatted biological ontologies and the NetworkX graph library. It provides a simple, pythonic interface to transform hierarchical ontology data into a `MultiDiGraph`. This allows you to leverage the full suite of NetworkX algorithms to analyze relationships, find common ancestors, or calculate distances between biological terms.

## Usage Instructions

### Loading Ontologies
The primary entry point is `obonet.read_obo()`. It is highly flexible regarding input sources.

```python
import obonet

# From a local file
graph = obonet.read_obo('path/to/ontology.obo')

# From a URL (handles downloading automatically)
url = 'https://example.com/ontology.obo'
graph = obonet.read_obo(url)

# From a compressed file (compression is inferred from extension)
graph = obonet.read_obo('ontology.obo.xz')
```

### Working with the Graph
The resulting object is a `networkx.MultiDiGraph`. Nodes are identified by their OBO IDs (e.g., `GO:0008150`).

*   **Accessing Metadata**: Node data is stored in a dictionary format.
    ```python
    # Get name of a specific term
    node_data = graph.nodes['GO:0008150']
    print(node_data.get('name'))
    ```
*   **Relationship Direction**: In the generated graph, edges typically represent "is_a" or "part_of" relationships. By default, edges point from the **subterm** (more specific) to the **superterm** (more general).
*   **Hierarchy Navigation**:
    *   **Superterms (Parents/Ancestors)**: Use `networkx.descendants(graph, node)` because edges point "up" the hierarchy.
    *   **Subterms (Children/Descendants)**: Use `networkx.ancestors(graph, node)`.

### Validation and Analysis
Common tasks for ontology graphs:

```python
import networkx

# Verify the ontology is a Directed Acyclic Graph (DAG)
is_dag = networkx.is_directed_acyclic_graph(graph)

# Count total terms and relationships
num_terms = len(graph)
num_relationships = graph.number_of_edges()

# Create a mapping of ID to Name for easy lookup
id_to_name = {id_: data.get('name') for id_, data in graph.nodes(data=True)}
```

## Expert Tips
*   **Parallel Edges**: Because `obonet` returns a `MultiDiGraph`, there can be multiple edges between the same two nodes (e.g., both an `is_a` and a `part_of` relationship). If your analysis requires a simple `DiGraph`, use `networkx.DiGraph(graph)` to collapse them.
*   **Memory Efficiency**: For massive ontologies, `obonet` is more lightweight than full-featured ontology suites like `pronto`, but it still loads the entire graph into memory.
*   **Advanced Metrics**: If you need to compute semantic similarity or intrinsic ontology metrics, consider passing the `obonet` graph into the `nxontology` package, which is optimized for these specific calculations.

## Reference documentation
- [github_com_dhimmel_obonet.md](./references/github_com_dhimmel_obonet.md)
- [github_com_dhimmel_obonet_blob_main_examples_go-obonet.ipynb.md](./references/github_com_dhimmel_obonet_blob_main_examples_go-obonet.ipynb.md)