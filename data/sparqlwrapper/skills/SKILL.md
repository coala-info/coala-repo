---
name: sparqlwrapper
description: The sparqlwrapper tool facilitates executing SPARQL queries and updates against remote triple stores from Python environments. Use when user asks to query Linked Data sources like DBpedia or Wikidata, convert RDF results into Python objects, or programmatically modify remote RDF graphs.
homepage: https://github.com/RDFLib/sparqlwrapper
---


# sparqlwrapper

## Overview

The `sparqlwrapper` skill enables AI agents to bridge the gap between Python environments and remote Triple Stores. It simplifies the creation of SPARQL query invocations and automates the conversion of results into manageable Python objects. Use this skill to extract data from Linked Data sources (like DBpedia or Wikidata), verify the existence of specific triples, or programmatically modify remote RDF graphs. It is particularly useful when working with RDFLib, as it can return query results directly as RDFLib Graph objects.

## Command Line Usage

The package installs a command-line utility called `rqw` (spaRQl Wrapper).

### Basic Query
Execute a query against a remote endpoint and output the results:
```bash
rqw --endpoint http://dbpedia.org/sparql --query "SELECT * WHERE { ?s ?p ?o } LIMIT 10"
```

### Output Formats
Specify the desired return format using the `-f` or `--format` flag:
```bash
rqw --endpoint http://dbpedia.org/sparql --format json --query @my_query.sparql
```

## Python API Best Practices

### Executing SELECT Queries
For data extraction, JSON is the most efficient format for Python processing.

```python
from SPARQLWrapper import SPARQLWrapper, JSON

sparql = SPARQLWrapper("http://dbpedia.org/sparql")
sparql.setReturnFormat(JSON)
sparql.setQuery("""
    SELECT ?label WHERE {
        <http://dbpedia.org/resource/Python_(programming_language)> rdfs:label ?label .
        FILTER (lang(?label) = 'en')
    }
""")

try:
    results = sparql.queryAndConvert()
    for result in results["results"]["bindings"]:
        print(result["label"]["value"])
except Exception as e:
    print(f"Query failed: {e}")
```

### Working with RDF Data (CONSTRUCT/DESCRIBE)
When using `CONSTRUCT` or `DESCRIBE`, `sparqlwrapper` returns an RDFLib `Graph` object, allowing for immediate triple manipulation.

```python
from SPARQLWrapper import SPARQLWrapper

sparql = SPARQLWrapper("http://dbpedia.org/sparql")
sparql.setQuery("DESCRIBE <http://dbpedia.org/resource/Asturias>")
# queryAndConvert() returns an rdflib.Graph object for RDF formats
graph = sparql.queryAndConvert()
print(graph.serialize(format="turtle"))
```

### Performing Updates
SPARQL UPDATE operations require the `POST` method and often involve authentication.

```python
from SPARQLWrapper import SPARQLWrapper, POST, DIGEST

sparql = SPARQLWrapper("https://example.org/sparql-update")
sparql.setHTTPAuth(DIGEST)
sparql.setCredentials("user", "password")
sparql.setMethod(POST)
sparql.setQuery("""
    INSERT DATA { GRAPH <http://example.org/g1> { <s1> <p1> <o1> } }
""")
results = sparql.query()
print(results.response.read())
```

## Expert Tips

- **SPARQLWrapper2**: Use the `SPARQLWrapper2` class if you are exclusively working with JSON SELECT results. It provides a more "Pythonic" object-oriented wrapper around the result bindings.
- **Return Formats**: Always explicitly set `setReturnFormat()`. Common constants include `JSON`, `XML`, `TURTLE`, and `N3`.
- **Timeout Management**: For large queries, ensure the endpoint supports timeouts and handle `HTTPError` exceptions for 504 Gateway Timeouts.
- **Graph Conversion**: If you need to convert a SELECT result into an RDFLib Graph manually, you must iterate through the bindings and add them to a Graph object, as `queryAndConvert()` only returns a Graph for RDF-native query types (CONSTRUCT/DESCRIBE).

## Reference documentation
- [SPARQL Endpoint interface to Python](./references/github_com_RDFLib_sparqlwrapper.md)