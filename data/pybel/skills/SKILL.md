---
name: pybel
description: PyBEL parses, validates, and manages Biological Expression Language (BEL) content to create structured biological network graphs. Use when user asks to parse BEL scripts, normalize biological entity identifiers, manipulate biological knowledge graphs, or export networks for machine learning applications.
homepage: https://pybel.readthedocs.io
---

# pybel

## Overview
PyBEL is a specialized Python framework designed to handle the full lifecycle of Biological Expression Language (BEL) content. It transforms BEL scripts into structured network graphs (using NetworkX), allowing for sophisticated biological data integration. It is particularly useful for researchers needing to validate biological statements, normalize entity identifiers across different namespaces (like GO, ChEBI, or HGNC), and prepare biological knowledge for downstream applications like pathway analysis or knowledge graph embedding.

## Core Workflows

### Parsing and Validation
To parse a BEL script and create a `BELGraph` object:

```python
import pybel

# Parse a BEL script from a file or URL
graph = pybel.from_path('example.bel')

# Check for parsing warnings/errors
for line_number, line, exception, annotations in graph.warnings:
    print(f"Line {line_number}: {exception}")
```

### Entity Grounding and Normalization
Use the grounding module to ensure identifiers are consistent and mapped to controlled vocabularies:

```python
from pybel.grounding import ground

# Normalizes namespaces and maps legacy identifiers
grounded_graph = ground(graph)
```

### Graph Manipulation and Filtering
PyBEL provides a DSL (Domain Specific Language) to programmatically build or modify graphs:

```python
from pybel.dsl import Protein, Gene, Abundance

# Create nodes
akt1 = Protein(namespace='hgnc', name='AKT1')
# Add edges
graph.add_directly_regulates(akt1, some_other_node, citation='123456', evidence='...')
```

### Exporting for Machine Learning
Convert biological networks into triples for use in knowledge graph embedding models (e.g., PyKEEN):

```python
import pybel

# Export to a triples file (TSV)
pybel.to_triples_file(graph, 'output_triples.tsv')

# Direct export to numpy array for ML pipelines
triples_array = pybel.to_triples(graph)
```

## Common CLI Patterns
PyBEL includes a command-line interface for quick operations:

- **Validate a BEL script**: `pybel compile path/to/file.bel`
- **Convert formats**: `pybel convert --path path/to/file.bel --json output.json`
- **Summarize a graph**: `pybel summary --path path/to/file.bel`

## Expert Tips
- **Pickling**: For large graphs, use `pybel.to_pickle(graph, 'file.bel.pickle.gz')` to save and load graphs significantly faster than re-parsing BEL scripts.
- **Jupyter Integration**: Use `pybel.to_jupyter(graph)` for interactive visualization within notebooks.
- **Namespace Management**: PyBEL uses the Bioregistry for prefix normalization. Ensure your environment has network access or a local cache of the Bioregistry for the best results during grounding.



## Subcommands

| Command | Description |
|---------|-------------|
| pybel compile | Compile a BEL script to a graph. |
| pybel insert | Insert molecules into a database. |
| pybel manage | Manage the database. |
| pybel neo | Upload to neo4j. |
| pybel post | Upload a graph to BEL Commons. |
| pybel summarize | Summarize a chemical file. |
| pybel_serialize | Serialize a graph to a file. |

## Reference documentation
- [PyBEL GitHub Repository](./references/github_com_pybel_pybel.md)
- [PyBEL Changelog and Version History](./references/github_com_pybel_pybel_blob_master_CHANGELOG.rst.md)
- [PyBEL ReadTheDocs Index](./references/pybel_readthedocs_io_en_latest_index.html.md)