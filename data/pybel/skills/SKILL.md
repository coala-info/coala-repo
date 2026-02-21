---
name: pybel
description: PyBEL is the primary Python framework for handling biological networks encoded in Biological Expression Language (BEL).
homepage: https://pybel.readthedocs.io
---

# pybel

## Overview

PyBEL is the primary Python framework for handling biological networks encoded in Biological Expression Language (BEL). It transforms human-readable BEL scripts into computable directed multi-graphs (`BELGraph`), enabling the integration of complex molecular relationships with their specific biological contexts. Use this skill to automate the curation of biological knowledge, validate the syntax and semantics of BEL documents, and facilitate data interchange between bioinformatics tools and graph databases.

## Core CLI Usage

The PyBEL command line interface provides tools for compiling, converting, and managing BEL content.

### Compiling and Validating
To parse a BEL script and check for semantic errors:
```bash
pybel compile path/to/script.bel
```
*   **--allow-naked-names**: Use if names are not qualified by namespaces (not recommended for production).
*   **--no-identifier-validation**: Skips checking if identifiers exist in the specified namespaces.

### Exporting Networks
To convert a BEL script into a specific data format:
```bash
pybel serialize path/to/script.bel --nodelink output.json
pybel serialize path/to/script.bel --tsv output.tsv
pybel serialize path/to/script.bel --sif output.sif
```

### Database Management
PyBEL uses a local SQL database to cache namespaces and store networks.
*   **List networks**: `pybel manage networks ls`
*   **Drop a network**: `pybel manage networks drop <network-id>`
*   **Clear cache**: `pybel manage drop` (Useful if namespace definitions become corrupted).

### Neo4J Integration
If the `[neo4j]` extra is installed, you can upload graphs directly:
```bash
pybel neo --connection http://localhost:7474/db/data --password your_password
```

## Python API Best Practices

### Working with BELGraph
The `BELGraph` object is the core data structure, subclassing `networkx.MultiDiGraph`.

```python
import pybel

# Loading a graph
graph = pybel.from_bel_script('example.bel')

# Basic Graph Operations
print(graph.summary())
print(graph.count.functions())

# Joining Graphs
# Use '+' for a full join (union)
# Use '&' for an outer join (only overlapping components)
combined_graph = graph1 + graph2
```

### Using Constants
Avoid hard-coding strings for functions or relations. Use `pybel.constants`.

```python
from pybel.constants import FUNCTION, PROTEIN, INCREASES

# Accessing node data safely
for node, data in graph.nodes(data=True):
    if data[FUNCTION] == PROTEIN:
        print(node.name)
```

### Filtering and Pipelines
PyBEL uses a functional approach to filter nodes and edges.

```python
from pybel.struct.filters import get_nodes_by_function
from pybel.constants import PATHOLOGY

# Get all pathology nodes
pathologies = get_nodes_by_function(graph, PATHOLOGY)

# Building a transformation pipeline
from pybel import Pipeline
from pybel.struct.mutation import remove_associations

pipeline = Pipeline()
pipeline.append(remove_associations)
new_graph = pipeline.run(graph)
```

## Expert Tips

1.  **Provenance Requirement**: PyBEL strictly enforces that all statements must have a Citation and Evidence (SupportingText). Statements lacking these are excluded during parsing to maintain data integrity.
2.  **Namespace Patterns**: For large namespaces like dbSNP, use the `PATTERN` syntax in your BEL script: `DEFINE NAMESPACE dbSNP AS PATTERN "rs[0-9]+"`.
3.  **Extras**: Install specific dependencies for advanced features:
    *   `pip install pybel[neo4j]` for graph database support.
    *   `pip install pybel[indra]` for BioPAX/SBML conversion.
    *   `pip install pybel[jupyter]` for inline visualization in notebooks.
4.  **Memory Management**: When handling very large BEL documents, use `pybel.from_bel_script_url` or stream the file to avoid loading the entire raw text into memory before parsing.

## Reference documentation
- [PyBEL Overview](./references/pybel_readthedocs_io_en_latest_introduction_overview.html.md)
- [Data Model Reference](./references/pybel_readthedocs_io_en_latest_reference_struct_datamodel.html.md)
- [Installation and Extras](./references/pybel_readthedocs_io_en_latest_introduction_installation.html.md)
- [Filter and Predicate API](./references/pybel_readthedocs_io_en_latest_reference_struct_filters.html.md)