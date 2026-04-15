---
name: py2neo
description: py2neo provides a high-level Python API for interacting with Neo4j graph databases and modeling graph entities as native objects. Use when user asks to connect to a Neo4j instance, ingest data from pandas DataFrames, execute Cypher queries, or convert graph results into matrices and DataFrames.
homepage: https://github.com/MazzaWill/neo4j-python-pandas-py2neo-v3
metadata:
  docker_image: "quay.io/biocontainers/py2neo:3.1.2--py34_0"
---

# py2neo

## Overview

The py2neo skill enables efficient interaction between Python applications and Neo4j graph databases. It provides a high-level API for graph modeling, allowing you to treat graph entities as native Python objects. This skill is particularly useful for automating data ingestion from structured formats like Excel or CSV into a graph structure, performing complex graph traversals, and converting graph results into matrices or DataFrames for downstream data science workflows.

## Core Workflows

### Database Connection
Establish a connection to the Neo4j instance using the `Graph` class.
```python
from py2neo import Graph

# Standard connection
graph = Graph("bolt://localhost:7687", auth=("neo4j", "password"))

# HTTP connection (often used in web interfaces)
graph = Graph("http://localhost:7474", username="neo4j", password="password")
```

### Data Ingestion from Pandas
A common pattern involves using pandas to clean data before loading it into Neo4j as triplets (Source-Relation-Target).

1. **Extract**: Load data into a DataFrame.
2. **Transform**: Generate lists of unique nodes and relationship dictionaries.
3. **Load**: Use py2neo to commit to the database.

```python
import pandas as pd
from py2neo import Node, Relationship

# Example: Creating nodes from a list
def create_nodes(graph, labels, names):
    for name in names:
        node = Node(labels, name=name)
        graph.create(node)

# Example: Creating relationships from a DataFrame
def create_relationships(graph, df):
    for _, row in df.iterrows():
        source_node = graph.nodes.match("Label", name=row['source']).first()
        target_node = graph.nodes.match("Label", name=row['target']).first()
        if source_node and target_node:
            rel = Relationship(source_node, row['relation'], target_node)
            graph.create(rel)
```

### Executing Cypher Queries
Use the `.run()` method to execute raw Cypher queries and return data in a format compatible with Python dictionaries.

```python
# Querying specific patterns
query = "MATCH (n:Person {name: $name})-[r]->(m) RETURN m.name AS friend"
data = graph.run(query, name="Alice").data()

# Converting query results directly to a pandas DataFrame
df = pd.DataFrame(graph.run("MATCH (n:Label) RETURN n.prop1, n.prop2").data())
```

### Graph to Matrix Conversion
For machine learning tasks, you may need to convert graph relationships into adjacency matrices.

```python
import numpy as np

def get_adjacency_matrix(graph, label):
    nodes = [n['n']['name'] for n in graph.run(f"MATCH (n:{label}) RETURN n").data()]
    size = len(nodes)
    matrix = np.zeros((size, size))
    
    # Map names to indices
    idx = {name: i for i, name in enumerate(nodes)}
    
    rels = graph.run(f"MATCH (a:{label})-[r]->(b:{label}) RETURN a.name, b.name").data()
    for r in rels:
        matrix[idx[r['a.name']]][idx[r['b.name']]] = 1
    return pd.DataFrame(matrix, index=nodes, columns=nodes)
```

## Best Practices
- **Batching**: When loading large datasets (e.g., from Excel), avoid individual `graph.create()` calls in a loop for thousands of records. Use `Transaction` objects or Cypher `UNWIND` for better performance.
- **Node Matching**: Always ensure properties used for matching (like `name` or `id`) have indexes or unique constraints in Neo4j to prevent performance degradation.
- **Data Types**: Ensure all data extracted from spreadsheets is explicitly cast to the correct type (e.g., `str(val)`) before passing to py2neo to avoid serialization errors with numpy/pandas types.
- **Regex Parsing**: When handling raw string representations of relationships, use regex patterns like `^\(|\{\}\]\-\>\(|\)\-\[\:|\)$` to clean and tokenize node/edge names.



## Subcommands

| Command | Description |
|---------|-------------|
| evaluate | Evaluate a Cypher statement |
| py2neo | A tool to run or evaluate Cypher statements against a Neo4j database. |
| run | Run a Cypher statement |

## Reference documentation
- [Neo4j Python Pandas py2neo V3 Overview](./references/github_com_MazzaWill_neo4j-python-pandas-py2neo-v3_blob_master_README.md)
- [Data Ingestion Script Example](./references/github_com_MazzaWill_neo4j-python-pandas-py2neo-v3_blob_master_invoice_neo4j.py.md)
- [Graph to Matrix Conversion Logic](./references/github_com_MazzaWill_neo4j-python-pandas-py2neo-v3_blob_master_neo4j_matrix.py.md)
- [Neo4j to DataFrame Interface](./references/github_com_MazzaWill_neo4j-python-pandas-py2neo-v3_blob_master_neo4j_to_dataframe.py.md)