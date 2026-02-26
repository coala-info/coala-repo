---
name: py2neo
description: py2neo is a Python client library and toolkit for interacting with the Neo4j graph database using object-oriented patterns or Cypher queries. Use when user asks to connect to Neo4j, map Python objects to graph entities, execute Cypher queries, or integrate graph data with Pandas.
homepage: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3
---


# py2neo

## Overview
py2neo is a comprehensive Python client library and toolkit designed for working with the Neo4j graph database. It allows developers to interact with Neo4j using both high-level object-oriented patterns (mapping Python objects to graph entities) and low-level Cypher query execution. It is particularly effective for data science workflows where Neo4j needs to be integrated with the Python data stack (e.g., Pandas, NumPy).

## Installation
To install the library using conda:
```bash
conda install conda-forge::py2neo
```
Alternatively, using pip:
```bash
pip install py2neo
```

## Core Usage Patterns

### Database Connection
The primary entry point is the `Graph` class.
```python
from py2neo import Graph

# Connect using the Bolt protocol (default)
graph = Graph("bolt://localhost:7687", auth=("neo4j", "password"))
```

### Graph Modeling
Use `Node` and `Relationship` objects to represent graph data.
```python
from py2neo import Node, Relationship

# Create nodes
alice = Node("Person", name="Alice")
bob = Node("Person", name="Bob")

# Create a relationship
knows = Relationship(alice, "KNOWS", bob)

# Push to the database
graph.create(knows)
```

### Executing Cypher Queries
For direct database interaction, use the `run` method.
```python
# Execute a query and iterate over results
results = graph.run("MATCH (p:Person) RETURN p.name AS name")
for record in results:
    print(record["name"])
```

### ETL and Pandas Integration
A common pattern involves extracting data from Excel/CSV via Pandas and loading it into Neo4j as triplets (Subject-Predicate-Object).
1. Load data into a Pandas DataFrame.
2. Iterate through rows to create `Node` and `Relationship` objects.
3. Use `graph.create()` or `Transaction` objects for batch processing.

## Expert Tips
- **Transactions**: For bulk updates, always use transactions to ensure atomicity and improve performance.
  ```python
  tx = graph.begin()
  tx.create(node_a)
  tx.create(node_b)
  tx.commit()
  ```
- **Node Matching**: Use `NodeMatcher` to find existing nodes instead of writing raw Cypher for simple lookups.
  ```python
  from py2neo import NodeMatcher
  matcher = NodeMatcher(graph)
  user = matcher.match("Person", name="Alice").first()
  ```
- **Performance**: When loading large datasets from Excel or CSV, pre-process the data into a matrix or cleaned DataFrame before initiating the py2neo push to minimize transaction overhead.

## Reference documentation
- [py2neo - conda-forge | Anaconda.org](./references/anaconda_org_channels_conda-forge_packages_py2neo_overview.md)
- [MazzaWill/neo4j-python-pandas-py2neo-v3](./references/github_com_MazzaWill_neo4j-python-pandas-py2neo-v3.md)