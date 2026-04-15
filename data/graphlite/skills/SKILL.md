---
name: graphlite
description: Graphlite is a Python-based graph engine that stores and queries directed relationships between integer identifiers using a specialized SQLite layer. Use when user asks to store graph edges, perform relationship traversals, or manage an embedded graph database for integer-based nodes.
homepage: https://github.com/eugene-eeo/graphlite
metadata:
  docker_image: "quay.io/biocontainers/graphlite:1.0.5--py35_1"
---

# graphlite

## Overview
Graphlite is a Python-based graph engine that builds a specialized graph layer on top of SQLite. Unlike general-purpose graph databases, Graphlite focuses strictly on storing and querying the relationships (edges) between nodes rather than the node data itself. It is highly efficient for local, embedded applications that need to perform traversals across integer-based identifiers without the overhead of a standalone database server.

## Core Usage Patterns

### Initialization and Connection
To start using Graphlite, define the types of relationships (graphs) your application will use.
```python
import graphlite as g

# Connect to a file-based or in-memory SQLite database
db = g.connect('my_graph.db', graphs=['knows', 'follows', 'blocked'])
```

### Storing Relationships
All write operations must occur within a transaction. Graphlite stores directed edges between integer IDs.
```python
with db.transaction() as t:
    # Store that node 1 knows node 2
    t.store(g.V(1).knows(2))
    # Store multiple relationships
    for person in [3, 4, 5]:
        t.store(g.V(1).knows(person))
```

### Querying and Traversals
Queries are lazy and generator-based. Use `.to(list)` or iterate over the result to consume it.
```python
# Find everyone node 1 knows
friends = db.find(g.V(1).knows).to(list)

# Complex traversal: Find friends of friends
# (Who does node 1 know, and who do they know?)
fof = db.find(g.V(1).knows).traverse(g.V.knows).to(list)
```

### Deleting Edges
Removing relationships follows the same pattern as storing them.
```python
with db.transaction() as t:
    t.delete(g.V(1).knows(2))
```

## Expert Tips and Best Practices

- **Integer Node IDs**: Graphlite only stores relationships between integers. If your entities have UUIDs or string slugs, you must maintain a mapping (e.g., in a separate SQLite table or a DBM) to convert them to integers before interacting with Graphlite.
- **External Metadata**: Since Graphlite does not store node properties (attributes), use it as a "relation index" alongside a primary data store like BerkeleyDB, LevelDB, or a standard SQL table where the primary key matches the Graphlite integer ID.
- **Transaction Batching**: For bulk imports, always wrap multiple `t.store()` calls in a single `with db.transaction()` block to significantly improve SQLite write performance.
- **Memory Mode**: Use `:memory:` as the connection string for high-performance, volatile graph processing or unit testing.
- **Lazy Evaluation**: Remember that `db.find()` returns a query object. Results are not fetched from the underlying SQLite database until you iterate over them or call a conversion method like `.to(list)` or `.to(set)`.

## Reference documentation
- [Graphlite README](./references/github_com_eugene-eeo_graphlite.md)