---
name: emboss-data
description: EMBOSS manages molecular biology sequence data and executes specialized bioinformatics tasks like alignment and restriction mapping. Use when user asks to manage sequence formats, configure database settings, or retrieve data from local and remote servers.
homepage: http://emboss.open-bio.org/
---


# emboss-data

## Overview
EMBOSS is a comprehensive collection of over 200 open-source tools designed for molecular biology. This skill enables the efficient management of sequence data across various formats and the execution of specialized bioinformatics tasks such as alignment, restriction mapping, and protein motif identification. It focuses on the native command-line environment, configuration of site-wide and user-specific settings, and the retrieval of data from local or remote servers.

## Installation and Setup
EMBOSS is most easily managed via Conda, though source compilation is required for custom development or specific patches.

- **Conda Installation**: `conda install bioconda::emboss`
- **Verification**: Run `embossversion` to confirm the installation is functional.
- **Environment**: Ensure the binary path (typically `/usr/local/emboss/bin`) is added to your `PATH` environment variable.

## Core CLI Patterns
All EMBOSS applications follow a consistent interface defined by AJAX Command Definition (ACD) files.

### Uniform Sequence Address (USA)
The USA is the standard way to specify sequence input.
- **File on disk**: `format::filename` (e.g., `fasta::sequence.fasta`)
- **Database entry**: `database:entry` (e.g., `swissprot:p12345`)
- **Specific range**: `database:entry[start:end]`
- **Standard Input**: `stdin`

### Common Global Qualifiers
These can be appended to almost any EMBOSS command:
- `-auto`: Turn off interactive prompting; use defaults for all optional parameters.
- `-stdout`: Write the primary output to the standard output stream.
- `-filter`: Read from stdin and write to stdout.
- `-help`: Display detailed help and all available qualifiers for the specific tool.
- `-ossave`: Save the specific options used in the command to a file.

## Configuration and Data Management
EMBOSS uses two primary configuration files to define database locations and global behaviors.

1. **Site-wide**: `emboss.default` (located in the EMBOSS `share` directory).
2. **User-specific**: `~/.embossrc` (overrides site-wide settings).

### Database Indexing
To use local flatfiles as searchable databases, use the extraction tools:
- **REBASE**: Run `rebaseextract` for restriction enzyme data.
- **PROSITE**: Run `prosextract` for protein patterns.
- **AAINDEX**: Run `aaindexextract` for amino acid indices.

## Expert Tips
- **Format Autodetection**: EMBOSS is excellent at detecting sequence formats automatically. If a tool fails, explicitly define the format using the `format::` prefix in the USA.
- **Memory Management**: EMBOSS handles large sequences dynamically. There are no hard-coded sequence length limits; it is only constrained by available system RAM.
- **Batch Processing**: Use the `-auto` qualifier in shell scripts to prevent the tools from hanging on interactive prompts.
- **Binary Patches**: If applying fixes from the source, always run `make clean` before `make install` to ensure no stale objects remain.

## Reference documentation
- [EMBOSS Administrators Guide - Building](./references/emboss_open-bio_org_html_adm_ch01s01.html.md)
- [EMBOSS Administrators Guide - Post-installation](./references/emboss_open-bio_org_html_adm_ch01s06.html.md)
- [EMBOSS Users Guide - Key Features](./references/emboss_open-bio_org_html_use_ch01s03.html.md)
- [EMBOSS Developers Guide - Configuration](./references/emboss_open-bio_org_html_dev_ch01s02.html.md)