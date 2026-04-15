---
name: fastobo
description: fastobo is a high-performance library for parsing, editing, and serializing OBO 1.4 ontology files into a structured Abstract Syntax Tree. Use when user asks to load OBO files, edit ontology components, validate format compliance, or serialize ontology data back to the OBO format.
homepage: https://github.com/fastobo/fastobo-py
metadata:
  docker_image: "quay.io/biocontainers/fastobo:0.13.0--py39h77f74c3_0"
---

# fastobo

## Overview
fastobo is a high-performance library, implemented in Rust with Python bindings, designed to handle the OBO 1.4 file format. You should use this skill to load ontologies into a structured Abstract Syntax Tree (AST), edit ontology components (like terms, typedefs, and qualifiers), and serialize them back to the OBO format. It is particularly useful for bioinformatic workflows requiring strict format compliance and efficient handling of large ontology files, including compressed formats.

## Installation
Install the library using pip or conda:
- **Pip**: `pip install fastobo`
- **Conda**: `conda install bioconda::fastobo`

## Core Usage Patterns

### Loading Ontologies
The library provides two primary functions for reading OBO data:
- `fastobo.load(path)`: Parses an OBO file from a local file path or a binary file handle.
- `fastobo.loads(string)`: Parses an OBO document directly from a string.

### Handling Compressed Files
fastobo supports loading directly from gzipped files by passing a file handle:
```python
import fastobo
import gzip

with gzip.open("ontology.obo.gz", "rb") as handle:
    obodoc = fastobo.load(handle)
```

### Working with the AST
The parsed object is an `OboDoc` instance. It consists of a Header and a list of Frames (Terms, Typedefs, etc.).
- **Header**: Contains metadata like `format-version`, `data-version`, and `ontology`.
- **Frames**: Represent the entities in the ontology. Common frames include `TermFrame`, `TypedefFrame`, and `InstanceFrame`.
- **Clauses**: Each frame contains clauses (e.g., `NameClause`, `DefClause`, `XrefClause`).

### Serialization
To save changes or convert an AST back to a string, use the `str()` representation of the `OboDoc` or its components:
```python
# Serialize the entire document
with open("output.obo", "w") as f:
    f.write(str(obodoc))
```

## Expert Tips and Best Practices
- **Strict Parsing**: fastobo is a "faultless" parser, meaning it will raise an error if the input does not strictly follow the OBO 1.4 specification. Use this to validate ontology files.
- **Memory Efficiency**: For very large ontologies, prefer `fastobo.load` with a file handle over reading the entire file into a string for `fastobo.loads`.
- **Qualifier Support**: Use the `Qualifier` and `QualifierList` classes to handle trailing modifiers in entity clauses, which are often used for mapping or versioning metadata.
- **Type Checking**: When iterating through an `OboDoc`, use `isinstance` checks against `fastobo.term.TermFrame` or `fastobo.typedef.TypedefFrame` to process specific entity types.

## Reference documentation
- [fastobo-py Overview](./references/github_com_fastobo_fastobo-py.md)
- [Bioconda fastobo Package](./references/anaconda_org_channels_bioconda_packages_fastobo_overview.md)