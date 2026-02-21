---
name: pyfastg
description: pyfastg is a specialized Python library designed to bridge the gap between raw sequencing assembly files and the NetworkX graph analysis ecosystem.
homepage: https://github.com/fedarko/pyfastg
---

# pyfastg

## Overview

pyfastg is a specialized Python library designed to bridge the gap between raw sequencing assembly files and the NetworkX graph analysis ecosystem. It specifically targets the FASTG format, which represents the ambiguity in sequencing assemblies. The library converts FASTG "edges" into NetworkX "nodes" and FASTG "adjacencies" into NetworkX "edges," allowing you to apply standard graph theory algorithms to biological assembly data.

## Installation

Install via pip or conda:

```bash
pip install pyfastg
# OR
conda install -c bioconda pyfastg
```

## Core Usage

The primary entry point is the `parse_fastg()` function, which returns a `networkx.DiGraph` object.

```python
import pyfastg

# Load the assembly graph
g = pyfastg.parse_fastg("path/to/assembly_graph.fastg")

# The resulting object is a standard NetworkX DiGraph
print(f"Nodes: {len(g.nodes)}")
print(f"Edges: {len(g.edges)}")
```

## Data Structure and Attributes

Understanding the mapping from FASTG to NetworkX is critical for correct analysis:

1.  **Nodes**: Represent the sequences (edges in the original FASTG).
2.  **Edges**: Represent the connections/adjacencies between sequences.
3.  **Orientation**: Node names typically end in `+` (forward) or `-` (reverse complement).

### Accessing Sequence Metadata
Each node in the graph contains metadata parsed from the FASTG header:

```python
# Access attributes for a specific node (e.g., "15+")
node_data = g.nodes["15+"]
length = node_data['length']
coverage = node_data['cov']
gc_content = node_data['gc']
```

## Common Analysis Patterns

### Finding Connected Components
Since assembly graphs often contain multiple disjoint contigs or clusters, use NetworkX's connectivity functions:

```python
import networkx as nx

# Get weakly connected components (clusters of related sequences)
components = list(nx.weakly_connected_components(g))
for i, c in enumerate(components):
    print(f"Component {i}: {len(c)} nodes")
```

### Filtering by Coverage or Length
You can create subgraphs based on the metadata parsed by pyfastg:

```python
# Create a subgraph of only high-coverage nodes
high_cov_nodes = [n for n, d in g.nodes(data=True) if d['cov'] > 10.0]
h_graph = g.subgraph(high_cov_nodes)
```

## Expert Tips

-   **Dialect Support**: pyfastg is optimized for SPAdes and MEGAHIT outputs. If using MEGAHIT, it uses the first ID in the header (e.g., `NODE_1` from `NODE_1_..._ID_1`).
-   **Graph Topology**: Remember that pyfastg performs an "edge-to-node" conversion. If you are looking for a specific sequence from your assembly, it will be a **node** in the resulting NetworkX object.
-   **Reverse Complements**: The graph includes both orientations. A sequence and its reverse complement are represented as distinct nodes (e.g., `1+` and `1-`).

## Reference documentation
- [pyfastg GitHub Repository](./references/github_com_fedarko_pyfastg.md)
- [Bioconda pyfastg Overview](./references/anaconda_org_channels_bioconda_packages_pyfastg_overview.md)