---
name: metasbt
description: "MetaSBT indexes large-scale microbial genomes into Sequence Bloom Trees for rapid taxonomic assignment and database management. Use when user asks to list or download public databases, index reference genomes, profile unknown sequences, update existing databases with new MAGs, or export data for Kraken2 integration."
homepage: https://github.com/cumbof/MetaSBT
---

# metasbt

## Overview

MetaSBT is a Python-based framework designed to handle the "microbial dark matter" at scale. It automates the process of indexing thousands of genomes into Sequence Bloom Trees, allowing for rapid taxonomic assignment and characterization of unknown genomes. You should use this skill to build reference baselines, update existing databases with new MAGs, or profile input sequences against established microbial databases.

## Core CLI Patterns

### Database Management
List and download pre-built public databases from the MetaSBT-DBs repository.

```bash
# List available public databases
metasbt db --list

# Download a specific database (e.g., Viruses) to a local folder
metasbt db --download Viruses --folder ~/my_databases/
```

### Indexing and Baseline Creation
Create a new database from a set of reference genomes. This requires a tab-separated file (`references.tsv`) where the first column is the file path and the second is the full taxonomic label (e.g., `k__Bacteria|p__...|s__...`).

```bash
metasbt index --workdir ~/project_dir \
              --database MyMicrobeDB \
              --references references.tsv \
              --dereplicate 0.01 \
              --completeness 50.0 \
              --contamination 5.0 \
              --nproc 16
```

### Profiling and Characterization
Identify the closest taxonomic cluster for an unknown input genome.

```bash
metasbt profile --workdir ~/project_dir \
                --database MyMicrobeDB \
                --input query_genome.fna \
                --nproc 8
```

### Updating Databases
Add new metagenome-assembled genomes (MAGs) to an existing MetaSBT index.

```bash
metasbt update --workdir ~/project_dir \
               --database MyMicrobeDB \
               --input new_mags_folder/ \
               --extension .fasta
```

### Kraken2 Integration
Export the MetaSBT database structure into a format compatible with Kraken2 for read-level profiling.

```bash
metasbt kraken --workdir ~/project_dir \
               --database MyMicrobeDB \
               --genomes genomes_list.txt \
               --ncbi-names names.dmp \
               --ncbi-nodes nodes.dmp
```

## Expert Tips

- **Filter Size Estimation**: If you plan to update your database frequently with new genomes, always use `--increase-filter-size 50.0` (or higher) during the `index` phase to prevent the Bloom filters from becoming saturated.
- **Quality Control**: Use the `--completeness` and `--contamination` flags during indexing to ensure only high-quality MAGs form your reference baseline.
- **Parallelization**: MetaSBT is resource-intensive. Always specify `--nproc` to match your available CPU cores to significantly speed up k-mer sketching and tree construction.
- **Dependencies**: Ensure `howdesbt` is compiled with the full Makefile (advanced sub-commands) if you are not using the Conda installation, as MetaSBT relies on non-standard SBT operations.



## Subcommands

| Command | Description |
|---------|-------------|
| db | List and retrieve public MetaSBT databases. |
| index | Index a set of reference genomes. This is used to build a first baseline of a MetaSBT database. Genomes must be known with a fully defined taxonomic label, from the kingdom up to the species level. |
| kraken | Export a MetaSBT database into a custom kraken database. |
| pack | Pack a MetaSBT database into a compressed tarball. |
| profile | Profile a set of genomes. This is used to report the closest kingdom, phylum, class, order, family, genus, species, and the closest genome in a specific database. |
| sketch | Sketch the input genomes. |
| summarize | Summarize the content of a MetaSBT database. |
| test | Check for software dependencies and run unit tests. |
| unpack | Unack a local MetaSBT tarball database. |
| update | Update a MetaSBT database with new genomes. |

## Reference documentation

- [Available features](./references/github_com_cumbof_MetaSBT_wiki_Available-features.md)
- [Getting started](./references/github_com_cumbof_MetaSBT_wiki_Getting-started.md)
- [Retrieving genomes from NCBI GenBank](./references/github_com_cumbof_MetaSBT_wiki_Retrieving-genomes-from-NCBI-GenBank.md)