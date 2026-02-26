---
name: progenomes
description: The progenomes tool programmatically fetches genomic assemblies, functional annotations, and metadata from the proGenomes database. Use when user asks to download bacterial or archaeal genomes, fetch functional annotations, or inspect genomic metadata.
homepage: https://github.com/BigDataBiology/progenomes-cli
---


# progenomes

## Overview

The `progenomes` command-line tool provides a streamlined interface for interacting with the proGenomes database, which contains over 2 million accurately annotated bacterial and archaeal genomes. It allows researchers to bypass manual web downloads by programmatically fetching genomic assemblies and functional annotations directly to a local environment.

## Installation

The tool can be installed via pip or conda:

```bash
# Using pip
pip install progenomes

# Using conda (bioconda channel)
conda install -c bioconda progenomes
```

## Core Commands

The CLI is structured around two primary subcommands: `download` and `view`.

### Downloading Genome Data
Use the `download` command to fetch specific datasets. This is the primary method for localizing proGenomes data.

```bash
progenomes download [options]
```

*   **Tip**: Ensure you are using version 0.3.0 or later, as this version updated server locations following a post-publication change.
*   **Context**: The tool supports specific habitat mappings (e.g., soil) and taxonomic groupings.

### Inspecting Data
Use the `view` command to inspect metadata or verify the contents of downloaded datasets.

```bash
progenomes view [options]
```

*   **Known Issue**: Be aware that `progenomes view functional-annotations` has been reported to fail in some environments; verify your local installation if this specific feature is required.

## Best Practices

1.  **Help Discovery**: The CLI is self-documenting. Use the `--help` flag at both the global and subcommand levels to see available filters and arguments.
    ```bash
    progenomes --help
    progenomes download --help
    ```
2.  **Version Management**: Because the proGenomes database is frequently updated and server locations may change, always verify your version with `pip show progenomes` or `conda list progenomes`.
3.  **Citation**: If using data retrieved via this tool for publication, cite the proGenomes4 paper (Fullam et al., 2025, Nucleic Acids Research).

## Reference documentation

- [proGenomes-cli GitHub Repository](./references/github_com_BigDataBiology_progenomes-cli.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_progenomes_overview.md)