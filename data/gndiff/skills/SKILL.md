---
name: gndiff
description: gndiff is a specialized command-line utility designed for biological nomenclature.
homepage: https://github.com/gnames/gndiff
---

# gndiff

## Overview
gndiff is a specialized command-line utility designed for biological nomenclature. It allows researchers to compare a "query" file against a "reference" file to find matching scientific names. Unlike many taxonomic tools that require an internet connection, gndiff operates entirely offline. It uses sophisticated matching algorithms to resolve taxonomic discrepancies and can leverage optional family-level data to disambiguate homonyms (names that are spelled the same but refer to different taxa).

## Input File Requirements
The tool accepts three primary file formats for both the query and reference files:
- **Simple List**: A `.txt` file with one scientific name per line.
- **CSV/TSV**: Files containing a `ScientificName` column.
- **Optional Fields**: If the CSV/TSV includes `TaxonID` or `Family` columns, gndiff will ingest them. The `Family` field is highly recommended for resolving homonyms.

## Common CLI Patterns

### Basic Comparison
Compare a query list against a reference list. The first file is the query; the second is the reference.
```bash
gndiff query_names.csv reference_checklist.tsv
```

### Output Formatting
By default, gndiff outputs results in CSV format. Use the `-f` or `--format` flag to change the output type:
- `csv`: Comma-separated (default)
- `tsv`: Tab-separated
- `compact`: Single-line JSON
- `pretty`: Human-readable indented JSON

```bash
gndiff query.txt ref.csv --format=pretty
```

### Suppressing Logs
To show only the matching results and hide warning logs (which are sent to STDERR), use the quiet flag:
```bash
gndiff query.txt ref.txt -q
```

### Running as a Web Service
gndiff can expose a RESTful API on a local port for integration with other local services:
```bash
gndiff --port 8080
```

## Expert Tips
- **Disambiguation**: If your dataset contains homonyms (e.g., the genus *Echidna* which exists in both fish and mammal nomenclature), ensure your input files include a `Family` column. gndiff uses this as a disambiguation tool to ensure the query name matches the correct reference record.
- **File Flexibility**: You can mix and match input formats. For example, you can compare a plain `.txt` file against a `.csv` reference file without pre-conversion.
- **GNverifier Alternative**: Use gndiff specifically for local or private checklists. If you need to compare names against global databases like GBIF or Catalogue of Life, use `gnverifier` instead.

## Reference documentation
- [GNdiff GitHub Repository](./references/github_com_gnames_gndiff.md)
- [GNdiff Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gndiff_overview.md)