---
name: pylca
description: pylca provides Python implementations of the Lowest Common Ancestor algorithm for finding the shared ancestor furthest from the root for any two nodes in a tree. Use when user asks to find the lowest common ancestor, query shared ancestors in biological taxonomies, or perform batch processing of tree node pairs.
homepage: https://github.com/pirovc/pylca
metadata:
  docker_image: "quay.io/biocontainers/pylca:1.0.0--py_0"
---

# pylca

## Overview
The `pylca` library provides Python implementations of the Lowest Common Ancestor algorithm, originally developed by D. Eppstein. It allows for efficient querying of the shared ancestor furthest from the root for any two nodes in a tree. The tool is particularly useful when working with biological taxonomies or file systems where relationships are represented as parent pointers.

## Installation
Install the package via Bioconda or from source:
```bash
# Via Conda
conda install bioconda::pylca

# From Source
python setup.py install
```

## Core Classes and Usage
The library offers three primary implementations depending on your performance needs and query patterns.

### 1. LCA (Restricted Range Minimum Query)
Use this for general-purpose, efficient online queries.
```python
from pylca.pylca import LCA

# Define tree: {child: parent}
parent_map = {'b':'a', 'c':'a', 'd':'a', 'e':'b', 'f':'b', 'g':'f'}
L = LCA(parent_map)

# Query the LCA of two nodes
result = L('e', 'g') # Returns 'b'
```

### 2. LogLCA (Logarithmic Range Minimum Query)
A simpler implementation that is often sufficient for smaller datasets or when the overhead of the linear-space version is not justified.
```python
from pylca.pylca import LogLCA

L = LogLCA(parent_map)
print(L('e', 'f'))
```

### 3. OfflineLCA
Use this when all pairs of nodes to be queried are known in advance. This can be significantly faster for batch processing.
```python
from pylca.pylca import OfflineLCA

# Define the pairs you intend to query
queries = [('a', 'b'), ('e', 'g'), ('f', 'i')]
L = OfflineLCA(parent_map, queries)

# Access results via dictionary-style indexing
result = L['e']['g']
```

## Best Practices
- **Input Format**: Ensure your tree is represented as a Python dictionary where keys are child nodes and values are their respective parents.
- **Algorithm Selection**: 
    - Start with `LogLCA` for small to medium trees due to its simplicity.
    - Switch to `LCA` (RestrictedRangeMin) if you have a very large number of nodes and need to optimize for space and query time.
    - Always use `OfflineLCA` if your list of queries is static and pre-defined.
- **Tree Integrity**: The algorithm assumes a valid tree structure. Ensure there are no cycles in your parent map to avoid infinite loops or incorrect results.

## Reference documentation
- [pylca Overview](./references/anaconda_org_channels_bioconda_packages_pylca_overview.md)
- [pylca GitHub Repository](./references/github_com_pirovc_pylca.md)