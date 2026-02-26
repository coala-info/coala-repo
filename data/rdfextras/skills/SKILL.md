---
name: rdfextras
description: The rdfextras package provides a suite of legacy tools and a SPARQL 1.1 implementation to extend the functionality of RDFLib version 3.x. Use when user asks to perform SPARQL queries on legacy RDF stores, convert CSV files to RDF, generate Graphviz visualizations from RDF data, or translate between different RDF serializations.
homepage: https://github.com/RDFLib/rdfextras
---


# rdfextras

## Overview

The `rdfextras` package is a legacy suite of tools designed to extend the functionality of RDFLib version 3.x. While modern versions of RDFLib (4.0+) have integrated these features into their core, `rdfextras` remains essential for maintaining older semantic web pipelines. It provides a pure-Python SPARQL 1.1 implementation for in-memory stores and a set of command-line utilities for data transformation and visualization.

Use this skill when you need to:
- Perform SPARQL queries on RDFLib 3.x stores.
- Convert CSV files into RDF triples.
- Generate Graphviz DOT files from RDF or RDFS schemas for visualization.
- Pipe and translate RDF data between different serializations (XML, Turtle, N-Triples).

## CLI Usage Patterns

### csv2rdf
Converts tabular CSV data into RDF. This is useful for bootstrapping knowledge graphs from spreadsheets.
```bash
csv2rdf --base http://example.org/ --prop http://example.org/prop/ input.csv > output.ttl
```

### rdfpipe
A versatile tool for parsing and serializing RDF data. It can fetch remote RDF or read local files and output them in a different format.
```bash
# Convert RDF/XML to Turtle
rdfpipe -i xml -o turtle input.rdf > output.ttl

# Parse multiple files and merge them into N-Triples
rdfpipe file1.ttl file2.rdf -o nt > merged.nt
```

### rdf2dot and rdfs2dot
These tools generate Graphviz-compatible DOT files. `rdf2dot` is for instance data, while `rdfs2dot` is optimized for schema hierarchies.
```bash
# Generate a visualization of an RDF graph
rdf2dot input.ttl | dot -Tpng -o graph.png

# Visualize an RDFS schema
rdfs2dot schema.rdf | dot -Tpdf -o schema.pdf
```

### Graph Isomorphism Tester
Used to check if two RDF graphs are structurally identical regardless of blank node identifiers.
```bash
python -m rdfextras.tools.isomorphism file1.ttl file2.ttl
```

## Expert Tips

- **Version Constraint**: Always verify the environment is using RDFLib < 4.0. If the environment is newer, advise the user to use the built-in `rdflib.tools` or the core SPARQL engine instead of `rdfextras`.
- **SPARQL Implementation**: The SPARQL engine in `rdfextras` is pure Python. For very large datasets in legacy environments, performance may be a bottleneck compared to store-native SPARQL (like those found in Virtuoso or Fuseki).
- **Visualization**: When using `rdf2dot`, the output can become unreadable for large graphs. Filter the RDF data using `rdfpipe` or a SPARQL CONSTRUCT query before passing it to the visualization tool.
- **Dependencies**: Ensure `pyparsing` is installed, as it is a required dependency for the SPARQL parser in this package.

## Reference documentation
- [RDFExtras README](./references/github_com_RDFLib_rdfextras.md)
- [Project Commits (Tooling details)](./references/github_com_RDFLib_rdfextras_commits_master.md)