---
name: dammit
description: dammit is a de novo transcriptome annotator that automates functional annotation by integrating ORF finding, protein domain identification, and orthology searches. Use when user asks to annotate a transcriptome assembly, identify protein domains, or assess assembly completeness using BUSCO.
homepage: http://dib-lab.github.io/dammit/
---

# dammit

## Overview

`dammit` is a streamlined de novo transcriptome annotator designed to automate the often-tedious process of functional annotation. It integrates several industry-standard tools—including TransDecoder for ORF finding, HMMER for protein domain identification, and BUSCO for completeness assessment—into a single workflow. Use this skill when you need to transform raw transcriptome assemblies into annotated datasets with identified orthologs, protein domains, and non-coding RNA structures. It is particularly effective for non-model organism research where ease of installation and open-source tool integration are priorities.

## Database Management

Before annotation, databases must be prepared. By default, `dammit` stores these in `$HOME/.dammit/databases`.

### Installation and Setup
- **Standard Install**: Downloads Pfam-A, Rfam, OrthoDB, and the default BUSCO group.
  ```bash
  dammit databases --install
  ```
- **Full Pipeline**: Includes the massive Uniref90 database. Requires significant disk space and RAM.
  ```bash
  dammit databases --install --full
  ```
- **Specific BUSCO Groups**: Specify a group relevant to your organism (e.g., metazoa, eukaryota, arthropoda).
  ```bash
  dammit databases --install --busco-group eukaryota
  ```

### Handling Existing Databases
If you already have the databases downloaded, avoid redundant downloads by using the `--database-dir` flag or setting the `DAMMIT_DB_DIR` environment variable.
```bash
export DAMMIT_DB_DIR=/path/to/existing/dbs
dammit databases --install
```

## Annotation Workflow

The core command for processing a transcriptome is `dammit annotate`.

### Basic Usage
Run the standard pipeline on a FASTA file:
```bash
dammit annotate transcriptome.fasta --n_threads 8
```

### Advanced Options
- **User-Supplied Databases**: Incorporate your own protein databases for homology searches.
  ```bash
  dammit annotate transcriptome.fasta --user-databases custom_proteins.fasta
  ```
- **Custom BUSCO Group**: Ensure the annotation uses the same group installed during the database setup.
  ```bash
  dammit annotate transcriptome.fasta --busco-group metazoa
  ```

## Expert Tips and Best Practices

- **Memory Management**: The standard pipeline recommends at least 16GB of RAM. If you encounter memory issues, you can modify LAST parameters via a custom `config.json` file to reduce the memory footprint.
- **Soft-Linking**: If your databases are scattered across different directories, soft-link them into a single directory using their original names (e.g., `Pfam-A.hmm`) to allow `dammit` to recognize them without re-downloading.
- **Task Persistence**: `dammit` uses `pydoit` under the hood. If a run is interrupted, it will resume from the last successful task rather than starting over.
- **Developer Customization**: You can pass custom parameters to underlying tools (like TransDecoder) by providing a `config.json` file in the working directory.



## Subcommands

| Command | Description |
|---------|-------------|
| dammit annotate | The main annotation pipeline. Calculates assembly stats; runs BUSCO; runs LAST against OrthoDB (and optionally uniref90), HMMER against Pfam, Inferal against Rfam, and Conditional Reciprocal Best-hit Blast against user databases; and aggregates all results in a properly formatted GFF3 file. |
| dammit databases | Check for databases and optionally download and prepare them for use. By default, only check their status. |
| dammit migrate | Migrate dammit databases to a new location or format. |

## Reference documentation

- [About the Databases](./references/dib-lab_github_io_dammit_database-about.md)
- [Basic Database Usage](./references/dib-lab_github_io_dammit_database-usage.md)
- [Advanced Database Handling](./references/dib-lab_github_io_dammit_database-advanced.md)
- [System Requirements](./references/dib-lab_github_io_dammit_system_requirements.md)
- [Tutorial](./references/dib-lab_github_io_dammit_tutorial.md)