---
name: schema-salad
description: Schema Salad is a schema language designed for describing JSON or YAML structured linked data.
homepage: https://github.com/common-workflow-language/schema_salad
---

# schema-salad

## Overview
Schema Salad is a schema language designed for describing JSON or YAML structured linked data. It provides a suite of tools for preprocessing, structural validation, and hyperlink checking. By bridging the gap between record-oriented data and the Semantic Web, it enables features like inheritance, object identifiers, and transformation to RDF. This skill guides the use of the `schema-salad-tool` for schema management and document processing.

## Core CLI Usage
The primary interface is the `schema-salad-tool` command.

### Validation
- **Validate a Schema**: Run `schema-salad-tool <schema.yml>` to ensure the schema itself is well-formed according to the SALAD metaschema.
- **Validate a Document**: Run `schema-salad-tool <schema.yml> <document.yml>` to verify a data file against a specific schema.
- **Validation Modes**: Use `--strict` to enforce rigorous validation (default) or `--non-strict` for more permissive checks.

### Documentation and Visualization
- **HTML Documentation**: Generate a human-readable reference using `schema-salad-tool --print-doc <schema.yml> > output.html`. Alternatively, use the standalone `schema-salad-doc <schema.yml>` command.
- **Inheritance Graphs**: Visualize relationships between classes using `schema-salad-tool --print-inheritance-dot <schema.yml> | dot -Tsvg > graph.svg`.
- **Field References**: Map field relationships with the `--print-fieldrefs-dot` flag.

### Code Generation
Generate classes for loading and manipulating documents in various languages.
- **Python**: `schema-salad-tool --codegen=python <schema.yml> > model.py`. Note that this requires the `[pycodegen]` extra during installation.
- **Supported Languages**: The tool supports `java`, `typescript`, `dotnet`, `cpp`, and `d`.
- **Customization**: Use `--codegen-package` to specify a dotted package name and `--codegen-copyright` to include copyright strings in the generated files.

### Semantic Web and RDF
- **JSON-LD Context**: Extract the JSON-LD context with `--print-jsonld-context`.
- **Preprocessing**: Convert a document to its preprocessed JSON-LD form using `--print-pre`.
- **RDF Conversion**: Output the document as RDF using `--print-rdf` or generate an RDF Schema using `--print-rdfs`.

## Expert Tips
- **Debugging**: Use the `--debug` flag to get detailed tracebacks and internal processing information when validation fails unexpectedly.
- **Metadata Extraction**: Use `--print-metadata` to extract and view schema-level metadata.
- **Indexing**: Use `--print-index` to see how the tool indexes object identifiers within a document, which is useful for debugging URI resolution.
- **Serialization**: Use `--rdf-serializer` to specify the format (e.g., xml, turtle) when printing RDF output.

## Reference documentation
- [Schema Salad GitHub Repository](./references/github_com_common-workflow-language_schema_salad.md)