---
name: cirtap
description: cirtap is a command-line utility for mirroring, indexing, and managing large-scale genomic data from the PATRIC FTP server. Use when user asks to mirror the PATRIC database, select high-quality representative genomes, or extract specific sequence sets into consolidated FASTA files.
homepage: https://github.com/MGXlab/cirtap/
metadata:
  docker_image: "quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0"
---

# cirtap

## Overview

cirtap is a command-line utility designed to streamline the handling of large-scale genomic data from the PATRIC FTP server. It allows researchers to maintain a local, synchronized copy of the database and provides specialized subcommands to index, filter, and extract sequences. This tool is particularly useful for bioinformaticians who need to build local BLAST databases or select representative "best" genomes for comparative genomics without relying on external APIs.

## Core Workflows

### 1. Mirroring the PATRIC Database
The `mirror` command is the foundation of the cirtap workflow. It creates a local copy of the FTP data.

- **Start a new mirror**: Use the `-j` flag to specify parallel downloads.
  `cirtap mirror -j 8 /path/to/local_db`
- **Resume a failed job**: Use the `-r` flag to pick up where a previous mirror attempt stopped.
  `cirtap mirror -j 8 -r /path/to/local_db`
- **Notifications**: Send email alerts upon job launch or failure.
  `cirtap mirror -j 8 --notify user@example.com /path/to/local_db`

### 2. Indexing Local Data
Before using `collect` or `best`, you must generate a presence/absence index of the downloaded files.

- **Create an index**:
  `cirtap index -j 16 /path/to/genomes index.tsv`

### 3. Selecting High-Quality Genomes
The `best` module filters genomes based on assembly statistics (completeness and contamination) and outputs the top candidates per taxonomic rank.

- **Selection Logic**: By default, it uses the formula `completeness - 5 * contamination > 70`.
- **Run selection**:
  `cirtap best -i /path/to/index.tsv -d /path/to/local_db output_directory`
- **Custom Threshold**: Adjust the quality requirements using `--thresh`.
  `cirtap best --thresh 80 -i index.tsv -d /path/to/db output_dir`

### 4. Collecting Sequence Sets
Extract specific data types across the entire mirrored dataset to create consolidated FASTA files.

- **Extract Proteins**: Useful for building `blastp` databases.
  `cirtap collect -t proteins -i index.tsv /path/to/genomes all_proteins.fa.gz`
- **Extract 16S SSU**: Useful for building `blastn` databases.
  `cirtap collect -t SSU -i index.tsv /path/to/genomes SSU.fa.gz`
- **Cleanup**: Use `--cleanup` to remove intermediate files generated during parallel processing.

### 5. Packaging Genomes
Create a compressed archive from a specific list of genome IDs.

- **Pack genomes**:
  `cirtap pack -f genome_ids.txt /path/to/genomes archive.tar.gz`

## Expert Tips and Best Practices

- **Parallelization**: Always utilize the `-j` flag for `mirror`, `index`, and `collect`. For `collect`, note that the actual number of processes may be up to 4x the value provided due to internal implementation.
- **Taxonomy Database**: The `best` command relies on `ete3`. If you have a specific version of the NCBI taxonomy you wish to use, point to it with `--ncbi-db /path/to/taxa.sqlite`.
- **Data Integrity**: cirtap validates FASTA entries during collection (e.g., ensuring sequence length > 1) to filter out artifacts often found on the server side.
- **Directory Structure**: Ensure your local mirror directory contains both a `RELEASE_NOTES` directory and a `genomes` directory for the tool to function correctly.



## Subcommands

| Command | Description |
|---------|-------------|
| cirtap best | Select best genomes based on stats retrieved from genome_summary |
| cirtap collect | Create sequence sets based on the installed files |
| cirtap index | Create an index of contents for all directories |
| cirtap mirror | Mirror all data from ftp.patricbrc.org in the specified DB_DIR |
| cirtap pack | Create a gzipped tar archive from a list of genome ids in a file |

## Reference documentation
- [cirtap Overview](./references/github_com_MGXlab_cirtap.md)
- [Mirroring Guide](./references/github_com_MGXlab_cirtap_wiki_mirror.md)
- [Indexing Guide](./references/github_com_MGXlab_cirtap_wiki_index.md)
- [Best Genome Selection](./references/github_com_MGXlab_cirtap_wiki_best.md)
- [Sequence Collection](./references/github_com_MGXlab_cirtap_wiki_collect.md)
- [Genome Packaging](./references/github_com_MGXlab_cirtap_wiki_pack.md)