---
name: schema-salad
description: Schema Salad is a schema language and toolset used to validate, process, and generate documentation or code for structured linked data. Use when user asks to validate schemas and documents, generate Python classes, create HTML documentation, or transform JSON and YAML into RDF or JSON-LD.
homepage: https://github.com/common-workflow-language/schema_salad
---


# schema-salad

## Overview
Schema Salad (Semantic Annotations for Linked Avro Data) is a schema language and toolset designed for structured linked data. It extends Apache Avro to support features like inheritance, object identifiers, and URI resolution within JSON or YAML documents. This skill provides the procedural knowledge to use the `schema-salad-tool` for validating schemas, checking document integrity, and generating auxiliary resources like documentation or implementation code.

## Core Workflows

### Schema and Document Validation
The primary use of the tool is to ensure that a schema is well-formed and that documents adhere to that schema.
- **Validate a Schema**: Run `schema-salad-tool <schema.yml>` to check for structural errors in your Salad definition.
- **Validate a Document**: Run `schema-salad-tool <schema.yml> <document.yml>` to verify that the data document matches the rules defined in the schema.

### Linked Data Processing
Schema Salad transforms standard JSON/YAML into Linked Data by resolving identifiers and mapping fields to URIs.
- **Generate JSON-LD Context**: Use `--print-jsonld-context` to extract the context mapping from a schema and document.
- **Pre-process for RDF**: Use `--print-pre` to output a document in a flattened, URI-resolved format suitable for JSON-LD processing.
- **Convert to RDF**: Use `--print-rdf` to transform the document into RDF triples based on the schema's semantic annotations.

### Code and Documentation Generation
Automate the creation of data models and human-readable references.
- **Generate Python Classes**: Run `schema-salad-tool --codegen=python <schema.yml> > model.py`. This requires the `[pycodegen]` extra and creates a type-safe API for loading and saving documents.
- **Generate HTML Documentation**: Use `--print-doc` to create a searchable HTML reference of the schema's types and fields.
- **Visualize Relationships**: Use `--print-inheritance-dot` or `--print-fieldrefs-dot` piped into Graphviz (`dot -Tsvg`) to generate visual diagrams of the data model.

## Expert Tips
- **Strict vs. Non-Strict**: Use the `--strict` flag during validation to catch foreign properties that are not defined in the schema.
- **Schema Debugging**: If inheritance is complex, use `--print-avro` to see how Schema Salad has compiled the high-level Salad schema into a flat Avro-compatible schema.
- **Metadata Extraction**: Use `--print-metadata` to quickly view the `$base` and `$namespaces` defined within a document.



## Subcommands

| Command | Description |
|---------|-------------|
| schema-salad-doc | Generates documentation from schema-salad schemas. |
| schema-salad-tool | Schema Salad Tool |

## Reference documentation
- [Schema Salad Specification](./references/www_commonwl_org_v1.2_SchemaSalad.html.md)
- [Schema Salad GitHub Repository](./references/github_com_common-workflow-language_schema_salad.md)