---
name: askocli
description: askocli is a command-line interface for ingesting genomic and tabular data into an AskOmics server. Use when user asks to integrate files into AskOmics, upload GFF or BED data, perform bulk data ingestion, or configure data visibility and metadata for an AskOmics instance.
homepage: https://github.com/askomics/askocli
---


# askocli

## Overview

`askocli` is a specialized command-line interface that enables seamless data ingestion into a distant AskOmics server. It transforms the manual process of web-based data integration into a scriptable workflow, allowing for the bulk upload of genomic features and tabular data. This skill provides the necessary patterns to handle various file formats, specify metadata like taxons and entities, and manage data visibility.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Bioconda
conda install bioconda::askocli

# Via Pip
pip install askocli
```

## Core Usage Patterns

The primary command for all operations is `askocli integrate`. You must always provide the AskOmics instance URL (`-a`) and your API key (`-k`).

### Basic Integration
For standard CSV or TTL files where default settings are sufficient:
```bash
askocli integrate -a http://your-askomics-url:6543 -k your_api_key path/to/file.csv
```

### Genomic Data (GFF/BED)
When integrating GFF or BED files, you should specify the entities and the taxon to ensure the data is correctly indexed in the AskOmics triplestore.
```bash
# GFF integration with specific entities and taxon
askocli integrate -a http://localhost:6543 -k my_key -e gene transcript -t "Homo sapiens" path/to/file.gff

# BED integration
askocli integrate -a http://localhost:6543 -k my_key path/to/file.bed
```

### Advanced Tabular Configuration
For TSV/CSV files that require specific handling of columns or headers:
- **Custom Headers**: Use `--headers` if the file lacks a header row.
- **Force Column Types**: Use `-c` or `--columns` to define types manually.
- **Skip Columns**: Use `--disabled-columns` to ignore specific columns during integration.
- **Key Columns**: Use `--key-columns` to define which columns serve as unique identifiers.

```bash
askocli integrate -a http://localhost:6543 -k my_key --headers "id,name,value" --disabled-columns "value" path/to/file.tsv
```

### Data Visibility and URIs
- **Public Data**: To make the integrated data accessible to all users on the instance, add the `--public` flag.
- **Custom URIs**: Use `--uri` to specify a custom URI base for the entities being integrated.

```bash
askocli integrate -a http://localhost:6543 -k my_key --public --uri "http://my-org.org/data/" path/to/file.ttl
```

## Expert Tips

1. **API Key Security**: Always use the `-k` (API key) method. Older versions supported passwords, but API keys are the standard for secure, non-interactive CLI access.
2. **Taxon Formatting**: When using the `-t` flag for taxons with spaces (e.g., *Drosophila melanogaster*), ensure the string is quoted.
3. **Virtual Environments**: If installing from source or pip, always use a virtual environment (`python3 -m venv venv`) to avoid dependency conflicts with other bioinformatics tools.
4. **Compatibility**: Ensure your `askocli` version is 0.5 or higher for compatibility with AskOmics versions 19.01.2 and later.

## Reference documentation
- [Askocli GitHub Repository](./references/github_com_askomics_askocli.md)
- [Askocli Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_askocli_overview.md)