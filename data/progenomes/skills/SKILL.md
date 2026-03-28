---
name: progenomes
description: The progenomes tool enables researchers to access, download, and inspect high-quality annotated prokaryotic genomes from the proGenomes dataset. Use when user asks to download genomic datasets, view proGenomes database content, or retrieve prokaryotic metadata for bioinformatics pipelines.
homepage: https://github.com/BigDataBiology/progenomes-cli
---

# progenomes

## Overview
The `progenomes` CLI is a specialized tool designed for researchers to access and explore the proGenomes dataset, which contains over 2 million accurately and consistently annotated high-quality prokaryotic genomes. It simplifies the process of retrieving genomic data and performing initial inspections of the downloaded files, serving as a bridge between the proGenomes web database and local bioinformatics pipelines.

## Installation
The tool is available via Python's package manager or Conda.

```bash
# Via pip
pip install progenomes

# Via bioconda
conda install -c bioconda progenomes
```

## Command Usage and Best Practices

### Downloading Data
The `download` subcommand is the primary way to retrieve genomic information. 

- **Update Check**: Ensure you are using version 0.3.0 or later, as server locations for the proGenomes dataset changed after the initial paper publication.
- **Command Pattern**:
  ```bash
  progenomes download [options]
  ```
- **Tip**: Always check the specific dataset version or habitat mapping you require (e.g., soil, human gut) if the CLI supports filtering by environment.

### Inspecting Data
Once data is retrieved, use the `view` subcommand to verify the integrity and content of the files.

- **Command Pattern**:
  ```bash
  progenomes view [options]
  ```
- **Data Handling**: The tool utilizes `polars` and `pyarrow` internally, making it efficient at handling large-scale genomic metadata. If you are processing the output further in Python, these formats are preferred for performance.

### Getting Help
To see all available flags for specific subcommands (such as filtering by taxonomic ID or quality scores):
```bash
progenomes --help
progenomes download --help
progenomes view --help
```

## Expert Tips
- **Citation**: If using data retrieved via this tool for publication, cite the proGenomes4 paper (Fullam et al., 2025, Nucleic Acids Research).
- **Environment Management**: Since the tool depends on specific versions of data-science libraries like `pandas` and `polars`, it is best practice to install it within a dedicated virtual environment or Conda environment to avoid dependency conflicts with other bioinformatics tools.



## Subcommands

| Command | Description |
|---------|-------------|
| progenomes view | View datasets within the Progenomes database. |
| progenomes_download | Download datasets from Progenomes |

## Reference documentation
- [proGenomes-cli README](./references/github_com_BigDataBiology_progenomes-cli_blob_main_README.md)
- [proGenomes-cli ChangeLog](./references/github_com_BigDataBiology_progenomes-cli_blob_main_ChangeLog.md)
- [proGenomes-cli pyproject.toml](./references/github_com_BigDataBiology_progenomes-cli_blob_main_pyproject.toml.md)