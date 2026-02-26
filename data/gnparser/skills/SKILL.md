---
name: gnparser
description: The gnparser tool transforms unstructured biological scientific names into structured data by identifying components like genus, specific epithet, and authority information. Use when user asks to parse taxonomic names, clean taxonomic lists, or convert scientific names into JSON, CSV, or TSV formats.
homepage: https://parser.globalnames.org/
---


# gnparser

## Overview
The `gnparser` skill provides a specialized workflow for handling biological scientific names. It transforms unstructured taxonomic strings into structured data by identifying the specific components of a name, such as the genus, specific epithet, and authority information. This is essential for cleaning taxonomic lists, resolving nomenclature discrepancies, and preparing data for biodiversity databases.

## Usage Patterns

### Basic Parsing
To parse a single name or a list of names, use the following CLI patterns:

- **Standard Output**: `gnparser "Aus bus L."`
- **Format Selection**: Use the `-f` or `--format` flag to specify output.
  - JSON (default): `gnparser -f json "Aus bus"`
  - CSV: `gnparser -f csv "Aus bus"`
  - TSV: `gnparser -f tsv "Aus bus"`

### Batch Processing
For large datasets, pipe a file containing one name per line into the tool:
`cat names.txt | gnparser > parsed_names.json`

### Advanced Configuration
- **Nomenclatural Codes**: While `gnparser` is code-agnostic by default, you can optimize for specific codes (e.g., Botanical, Zoological, Bacterial) if the context is known.
- **Details**: Use the `-d` or `--details` flag to get the most granular breakdown of the name components, including stem information and quality scores.
- **Capitalization**: The tool automatically handles normalization of capitalization (e.g., "AUS BUS" to "Aus bus").

## Expert Tips
- **Web API Alternative**: If the CLI is unavailable, `gnparser` supports a RESTful API. Use `GET` requests with vertical line separated names: `/api/v1/Name+One|Name+Two`.
- **Ambiguity**: If a name is "canonical" but lacks authorship, `gnparser` will still extract the semantic elements. Use the `quality` field in the JSON output to assess the reliability of the parse.
- **Performance**: When processing millions of names, use the native Go binary via CLI rather than the API for significantly higher throughput.

## Reference documentation
- [GNparser Overview](./references/anaconda_org_channels_bioconda_packages_gnparser_overview.md)
- [API Documentation](./references/parser_globalnames_org_doc_api.md)
- [Web Interface and Options](./references/parser_globalnames_org_index.md)