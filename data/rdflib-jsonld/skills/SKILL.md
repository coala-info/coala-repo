---
name: rdflib-jsonld
description: This tool enables the parsing and serialization of JSON-LD data within the RDFLib ecosystem for legacy Python and RDFLib environments. Use when user asks to parse JSON-LD documents into an RDF graph, serialize existing graphs to JSON-LD format, or convert between JSON-LD and other RDF formats using rdfpipe.
homepage: https://github.com/RDFLib/rdflib-jsonld
metadata:
  docker_image: "biocontainers/rdflib-jsonld:v0.4.0-4-deb-py3_cv1"
---

# rdflib-jsonld

## Overview
The `rdflib-jsonld` skill provides the procedural knowledge required to handle JSON-LD data within the RDFLib ecosystem. It enables the conversion of JSON-LD documents into a programmatic RDF graph and the serialization of existing graphs back into structured JSON-LD. 

**Important Version Note**: This standalone plugin is deprecated for modern environments. If you are using RDFLib 6.0.1 or higher, JSON-LD support is built-in and this plugin is not required. Use this skill specifically for Python <= 3.6 or RDFLib <= 5.0.0 environments.

## Installation
To enable JSON-LD support in older RDFLib environments:
```bash
pip install rdflib-jsonld
```

## Python Usage Patterns

### Parsing JSON-LD into a Graph
Once the plugin is installed, RDFLib automatically registers the `json-ld` format.
```python
from rdflib import Graph

g = Graph()
# Parsing from a string
json_data = '{"@id": "http://example.org/about", "http://purl.org/dc/terms/title": "Home"}'
g.parse(data=json_data, format='json-ld')

# Parsing from a file or URL
g.parse("path/to/file.jsonld", format='json-ld')
```

### Serializing a Graph to JSON-LD
To output RDF data as JSON-LD, use the `serialize` method.
```python
# Basic serialization
print(g.serialize(format='json-ld', indent=4))

# Serialization with a specific @context
context = {
    "@vocab": "http://purl.org/dc/terms/",
    "@language": "en"
}
print(g.serialize(format='json-ld', context=context, indent=4))
```

## CLI Usage via rdfpipe
If you have `rdflib` installed, you can use the `rdfpipe` command-line tool to convert files to and from JSON-LD using this plugin.

**Convert Turtle to JSON-LD:**
```bash
rdfpipe -i turtle -o json-ld input.ttl > output.jsonld
```

**Convert JSON-LD to N-Triples:**
```bash
rdfpipe -i json-ld -o ntriples input.jsonld > output.nt
```

## Best Practices and Expert Tips
- **Context Management**: Always provide a `@context` during serialization if you want "compact" JSON-LD. Without a context, the output will use full IRIs as keys, which is often harder for standard JSON parsers to consume.
- **Encoding**: Ensure your input strings are properly encoded (UTF-8) before passing them to the parser to avoid `AttributeError` or decoding issues in older Python versions.
- **Validation**: Use the `indent` parameter during serialization to produce human-readable JSON-LD for debugging; omit it for production to save bandwidth.
- **Legacy Support**: If forced to use Python 3.6 or earlier, pin your requirements to `rdflib-jsonld<=0.5.0` and `rdflib==5.0.0`.

## Reference documentation
- [RDFLib JSON-LD Plugin README](./references/github_com_RDFLib_rdflib-jsonld.md)