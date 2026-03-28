---
name: blast2galaxy
description: blast2galaxy bridges local environments and Galaxy servers to perform remote sequence alignments using high-performance computing resources. Use when user asks to run BLAST or DIAMOND searches on Galaxy instances, automate bioinformatics workflows via CLI or Python, or list available Galaxy tools and databases.
homepage: https://github.com/IPK-BIT/blast2galaxy
---


# blast2galaxy

## Overview

`blast2galaxy` is a specialized tool that acts as a bridge between local environments and Galaxy servers. It allows researchers to leverage the high-performance computing power of Galaxy instances (like usegalaxy.eu) to perform sequence alignments without manually using the Galaxy web interface. It is particularly useful for automating bioinformatics workflows, handling large-scale queries that exceed local resources, and integrating Galaxy's toolset into Python-based data science pipelines.

## Configuration and Setup

Before executing queries, the tool must be linked to a Galaxy account and a specific tool version.

### 1. Authentication
Create a `.blast2galaxy.toml` file in your home directory or project root:

```toml
[servers.default]
server_url = "https://usegalaxy.eu"
api_key = "your_galaxy_api_key_here"

[profiles.default]
server = "default"
tool = "toolshed.g2.bx.psu.edu/repos/devteam/ncbi_blast_plus/ncbi_blastn_wrapper/2.14.1+galaxy2"
```

### 2. Discovery Commands
Use these commands to find the correct IDs for your configuration:
- **List available tools**: `blast2galaxy list-tools` (Finds the `tool` ID for your profile).
- **List available databases**: `blast2galaxy list-dbs --tool <TOOL_ID>` (Finds the `db` string for your query).

## CLI Usage Patterns

### Standard BLAST Search
Run a nucleotide search against a specific database and save the results in tabular format (outfmt 6):
```bash
blast2galaxy blastn --query input.fasta --db nt --out results.txt --outfmt 6
```

### DIAMOND Protein Search
For high-throughput protein alignments, use the DIAMOND integration:
```bash
blast2galaxy diamond-blastp --query proteins.fasta --db uniprot_swissprot --out results.tsv --sensitive
```

### Direct Output
Omit the `--out` parameter to stream results directly to `stdout`, which is useful for piping into other CLI tools:
```bash
blast2galaxy blastp --query seq.fasta --db swissprot | grep "specific_hit"
```

## Python API Integration

The API is preferred for workflows where sequence data is generated dynamically or results need immediate processing in a DataFrame.

### Basic Query
```python
import blast2galaxy

# Results are returned as a string (default outfmt 6)
result = blast2galaxy.blastn(
    query='dna_sequence.fasta',
    db='database_id',
    outfmt='6'
)
```

### String-based Queries
Avoid writing temporary files by passing sequences directly as strings:
```python
query_str = ">seq1\nATGC..."
result = blast2galaxy.blastp(
    query_str=query_str,
    db='uniprot',
    profile='protein_profile'
)
```

## Best Practices
- **Profile Management**: Define multiple profiles in your TOML file (e.g., `[profiles.blastn]` and `[profiles.diamond]`) to switch between different Galaxy tools quickly using the `--profile` flag.
- **Error Handling**: When using the API, wrap calls in `try-except` blocks for `blast2galaxy.errors.Blast2galaxyError` to catch connection issues or invalid Galaxy API keys.
- **Task Specificity**: Use the `--task` flag in `blastn` to optimize for specific alignment types (e.g., `megablast` for highly similar sequences vs. `blastn-short` for short queries).



## Subcommands

| Command | Description |
|---------|-------------|
| blast2galaxy list-dbs | list available databases of a BLAST+ or DIAMOND tool installed on a Galaxy server |
| blast2galaxy list-tools | list available and compatible BLAST+ and DIAMOND tools installed on a Galaxy server |
| blastn | search nucleotide databases using a nucleotide query |
| blastp | search protein databases using a protein query |
| blastx | search protein databases using a translated nucleotide query |
| diamond-blastp | search protein databases using a protein query with DIAMOND |
| diamond-blastx | search protein databases using a translated nucleotide query with DIAMOND |
| tblastn | search translated nucleotide databases using a protein query |

## Reference documentation
- [CLI Reference](./references/blast2galaxy_readthedocs_io_en_latest_cli.md)
- [API Reference](./references/blast2galaxy_readthedocs_io_en_latest_api.md)
- [Configuration Guide](./references/blast2galaxy_readthedocs_io_en_latest_configuration.md)
- [Usage Tutorial](./references/blast2galaxy_readthedocs_io_en_latest_tutorial.md)