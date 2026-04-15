---
name: omamer
description: OMAmer is a bioinformatics tool that uses an alignment-free k-mer approach to rapidly assign protein sequences to Hierarchical Orthologous Groups within the OMA ecosystem. Use when user asks to assign proteins to ancestral subfamilies, annotate new proteomes, or place sequences into a phylogenomic context using OMA databases.
homepage: https://github.com/DessimozLab/omamer
metadata:
  docker_image: "quay.io/biocontainers/omamer:2.1.2--pyhdfd78af_0"
---

# omamer

## Overview
OMAmer is a specialized bioinformatics tool designed for the rapid assignment of protein sequences to subfamilies within the OMA (Orthologous Matrix) ecosystem. Unlike traditional methods that rely on sequence alignment (e.g., DIAMOND or BLAST), OMAmer utilizes an alignment-free approach based on k-mers. This allows it to efficiently map proteins to ancestral subfamilies across thousands of genomes while maintaining the ability to reject non-homologous family-level assignments. It is particularly useful for annotating new proteomes or placing sequences into a phylogenomic context using pre-built ancestral databases.

## Installation and Requirements
OMAmer requires Python 3.8 through 3.11. Note that Python 3.12 is currently unsupported due to dependency constraints.

```bash
pip install omamer
```

## Core Workflow: Searching a Database
The primary function of OMAmer is the `search` command, which assigns query sequences to HOGs.

### Basic Usage
```bash
omamer search --db <database.h5> --query <sequences.fasta> --out <results.tsv>
```

### Key Parameters for Optimization
- **Specificity Control**: Use `--threshold` (default: 0.1). Lowering this value results in more specific (deeper) HOG assignments, while increasing it makes assignments more conservative (closer to the root).
- **Significance Filtering**: Use `--family_alpha` (default: 1e-6) to set the p-value threshold for family-level matches.
- **Performance**: 
  - `--nthreads <int>`: Set the number of CPU threads.
  - `--chunksize <int>`: Adjust the number of queries processed at once (default: 10,000).
- **Placement Depth**: Use `--family_only` if you only require high-level family assignments rather than specific sub-HOGs.

## Database Management
OMAmer relies on `.h5` database files representing different taxonomic scopes.

- **Pre-built Databases**: Standard databases (LUCA, Metazoa, Viridiplantae, Primates) are available from the OMA Browser.
- **Metadata Inspection**: Use `omamer info --db <database.h5>` to view the metadata and taxonomic root of a specific database file.
- **Custom Databases**: Use `omamer mkdb` to build databases from OrthoXML and FASTA files (experimental feature).

## Interpreting Results
The output is a TSV file. Key columns include:
- **hogid**: The Hierarchical Orthologous Group identifier (e.g., `HOG:0487954.3l.27l`). The dots represent nested sub-HOGs.
- **hoglevel**: The taxonomic level where the HOG is defined.
- **subfamily_score**: The OMAmer-score capturing similarity shared with the specific HOG, excluding ancestral conservation.
- **family_p**: The negative natural log of the p-value for the family-level match.

## Expert Tips
- **Memory Management**: Standard LUCA-level searches typically require approximately 16GB of RAM.
- **ID Uniqueness**: Ensure all protein IDs in your input FASTA are unique; OMAmer will error out if duplicates are detected.
- **Taxonomic Root**: When choosing a database, select the one whose root taxon most closely matches the expected breadth of your query sequences for the best balance of speed and accuracy.



## Subcommands

| Command | Description |
|---------|-------------|
| omamer mkdb | Build a database, by providing an OMA HDF5 database file [BROWSERBUILD] or OrthoXML + FASTA + Newick files [OXMLBUILD]. |
| omamer_info | Show metadata about an existing omamer database |
| omamer_search | Search for protein sequences, given in FASTA format, against an existing database. |

## Reference documentation
- [OMAmer GitHub README](./references/github_com_DessimozLab_omamer_blob_master_README.md)
- [OMAmer Changelog](./references/github_com_DessimozLab_omamer_blob_master_CHANGELOG.md)