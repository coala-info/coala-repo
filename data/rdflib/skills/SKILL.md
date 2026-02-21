---
name: rdflib
description: RDFLib is the industry-standard Python library for representing and manipulating information as RDF.
homepage: https://github.com/RDFLib/rdflib
---

# rdflib

## Overview
RDFLib is the industry-standard Python library for representing and manipulating information as RDF. It provides a "pythonic" API to interact with graphs, allowing you to treat RDF data as a collection of Subject-Predicate-Object triples. Whether you are building a knowledge graph, extracting metadata from web resources, or converting between different semantic formats, RDFLib offers the tools to manage the full lifecycle of linked data.

## Core Usage Patterns

### Initializing and Parsing
The `Graph` object is the primary entry point. You can load data from files, strings, or remote URLs.

```python
from rdflib import Graph

g = Graph()
# Parse from a URL
g.parse("http://dbpedia.org/resource/Python_(programming_language)")
# Parse a local file with a specific format
g.parse("data.ttl", format="turtle")
```

### Working with Terms and Namespaces
RDFLib uses specific classes for RDF terms: `URIRef` for resources, `Literal` for values, and `BNode` for blank nodes. Use the `Namespace` class to manage prefixes efficiently.

```python
from rdflib import URIRef, Literal, Namespace
from rdflib.namespace import FOAF, XSD

# Define a custom namespace
EX = Namespace("http://example.org/")

# Create terms
user = EX.jdoe
name = Literal("John Doe", datatype=XSD.string)

# Add a triple: (Subject, Predicate, Object)
g.add((user, FOAF.name, name))
```

### Querying with SPARQL
RDFLib supports SPARQL 1.1 for querying and updating graphs.

```python
query = """
SELECT ?name WHERE {
    ?p foaf:name ?name .
}
"""
results = g.query(query)
for row in results:
    print(f"Found name: {row.name}")
```

### Graph Navigation and Manipulation
For simple lookups, use built-in methods instead of full SPARQL queries:
- `g.value(subject, predicate)`: Returns one object for a triple pattern.
- `g.objects(subject, predicate)`: Returns a generator for all objects.
- `g.triples((s, p, o))`: Returns a generator for triples matching a pattern (use `None` as a wildcard).

### Serialization
Export your graph to various formats. Turtle is recommended for human readability, while N-Quads or JSON-LD are often used for data exchange.

```python
# Print graph in Turtle format
print(g.serialize(format="turtle"))

# Save to file in JSON-LD
g.serialize(destination="output.jsonld", format="jsonld")
```

## Expert Tips
- **Namespace Binding**: Always use `g.bind("prefix", NAMESPACE)` before serializing. This ensures the output uses readable prefixes instead of full URIs.
- **Performance**: For very large datasets, consider using a persistent store like `BerkeleyDB` instead of the default in-memory store.
- **Utility Methods**: Use `g.parse(data=string_variable, format="json-ld")` to parse RDF data already held in a Python string.
- **Type Checking**: When working with Literals, RDFLib automatically maps many Python types (like datetime or integers) to XSD datatypes, but explicit mapping via `datatype=XSD.int` is safer for strict schemas.

## Reference documentation
- [RDFLib README](./references/github_com_RDFLib_rdflib.md)
- [RDFLib Wiki](./references/github_com_RDFLib_rdflib_wiki.md)