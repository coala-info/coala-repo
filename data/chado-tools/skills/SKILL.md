---
name: chado-tools
description: chado-tools is a command-line suite for managing and accessing biological data stored in CHADO databases. Use when user asks to initialize a GMOD schema, run SQL queries, extract organism metadata, or perform bulk data imports and exports.
homepage: https://github.com/sanger-pathogens/chado-tools/
metadata:
  docker_image: "quay.io/biocontainers/chado-tools:0.2.15--py_0"
---

# chado-tools

---

## Overview

chado-tools is a specialized command-line suite designed for managing and accessing biological data stored in CHADO databases (GMOD schema). It streamlines complex database operations into high-level commands, making it easier to perform administrative tasks, run pre-compiled or custom queries, and handle biological data formats like FASTA. This skill should be used to automate genomic database workflows, extract organism metadata, or perform bulk data imports and exports within a PostgreSQL environment.

## Database Connection

The `chado` command requires connection details for the PostgreSQL server. While these can be provided via a configuration file, using environment variables is the most efficient pattern for automated workflows:

- `CHADO_HOST`: Database server address (default: localhost)
- `CHADO_PORT`: Database port (default: 5432)
- `CHADO_USER`: Database username
- `CHADO_PASS`: Database password

To force a password prompt instead of using environment variables, use the `-p` flag.

## Common CLI Patterns

### Administrative Tasks
Use the `admin` command to initialize or back up your database.
- **Create a new database**: `chado admin create <dbname>`
- **Initialize with GMOD schema**: `chado admin setup -s gmod <dbname>`
- **Backup/Dump database**: `chado admin dump <dbname> <output_file.dump>`

### Data Extraction and Querying
- **List organisms**: `chado extract organisms <dbname>`
- **Run custom SQL**: `chado query -q "SELECT name FROM cvterm WHERE cvterm_id = 25" <dbname>`
- **Execute pre-compiled queries**: `chado extract <query_name> <dbname>`
- **Export FASTA sequences**: `chado export fasta -a <organism_name> -o <output.fasta> -t <feature_type> <dbname>`
  - *Example*: `chado export fasta -a Pfalciparum -o Pfalciparum.fasta -t contigs eukaryotes`

### Data Modification
- **Insert entities**: `chado insert <entity_type> <dbname>`
- **Delete entities**: `chado delete <entity_type> <dbname>`
- **Bulk Import**: `chado import <format> <file> <dbname>`

## Expert Tips

- **Help System**: Use `chado <command> -h` to see specific subcommands and required arguments for complex operations like `export` or `admin`.
- **Interactive Sessions**: Use `chado connect <dbname>` to open an interactive session directly with the database.
- **Testing**: When running integration tests or destructive commands, point the tool to a temporary database. The tool is designed to work with PostgreSQL 9.6+ and Python 3.6+.
- **Naming Conventions**: When using `chado extract`, ensure you use the correct entity names (e.g., `organisms`, `comments`) as defined in the tool's internal query library.

## Reference documentation
- [chado-tools GitHub README](./references/github_com_sanger-pathogens_chado-tools.md)
- [chado-tools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chado-tools_overview.md)