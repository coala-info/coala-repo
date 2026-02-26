---
name: cladebreaker
description: Cladebreaker is a Nextflow-based pipeline that identifies closely related bacterial genomes using the WhatsGNU database and performs pangenome or reference-based comparative analysis. Use when user asks to identify related genomes, perform pangenome analysis with Roary, or execute reference-based alignments for bacterial isolates.
homepage: https://github.com/andriesfeder/cladebreaker
---


# cladebreaker

## Overview

Cladebreaker is a Nextflow-based bioinformatics pipeline designed to streamline the comparative genomics of bacterial isolates. It automates the identification of the most closely related genomes to a user's query set using the WhatsGNU database. Once related genomes are identified, the tool can perform a pangenome analysis using Roary or a reference-based alignment. This skill provides the necessary CLI patterns and configuration requirements to execute these workflows effectively.

## Installation and Requirements

Cladebreaker is best managed via Mamba or Conda to handle its complex dependencies.

```bash
# Recommended installation
mamba create -n cladebreaker -c bioconda cladebreaker
mamba activate cladebreaker

# Verify installation
cladebreaker --version
```

**Database Requirement**: You must provide a WhatsGNU database (in `.pickle` format). 
- For *Staphylococcus aureus*, use the ortholog-based database for enhanced analysis.
- For other species, use the basic WhatsGNU database.

## Common CLI Patterns

### 1. Pangenome Analysis (Default)
To identify the top 5 related genomes and perform a pangenome alignment using Roary:

```bash
cladebreaker \
  --input query_metadata.csv \
  --outdir ./results \
  --db ./path/to/WhatsGNU_database.pickle \
  --o \
  --topgenomes_count 5 \
  --coverage 100 \
  -profile conda
```

### 2. Reference-Based Alignment
To align query and related genomes against a specific reference genome instead of performing pangenome analysis, add the `--ref` flag:

```bash
cladebreaker \
  --input query_metadata.csv \
  --outdir ./results_ref \
  --db ./path/to/WhatsGNU_database.pickle \
  --ref ./path/to/reference_genome.fna \
  --o \
  -profile conda
```

## Parameter Reference

- `--input`: Path to a CSV file containing metadata for query genomes.
- `--db`: Path to the WhatsGNU database file.
- `--o`: Flag to indicate the use of an ortholog-based database (use `--b` for a basic database).
- `--topgenomes_count`: Integer specifying how many related genomes to pull for each query.
- `--coverage`: Coverage threshold for selecting related genomes.
- `--force`: Overwrites the output directory if it already exists.
- `-profile`: Specifies the execution profile (e.g., `conda`, `docker`, `singularity`).
- `-c`: Path to a custom Nextflow configuration file (useful for cluster resource management).

## Expert Tips

- **Input Format**: Ensure your input CSV follows the expected schema (metadata for each query genome) to avoid pipeline initialization errors.
- **Cluster Execution**: When running on high-performance computing (HPC) clusters, always provide a cluster configuration file via `-c` to define executors (e.g., Slurm, SGE) and resource limits.
- **Database Selection**: If you are not working with *S. aureus*, ensure you use the `--b` flag instead of `--o` to match the basic WhatsGNU database structure.
- **Reproducibility**: Always use the `-profile conda` (or docker/singularity) flag to ensure that the exact tool versions required by the pipeline are utilized.

## Reference documentation
- [Cladebreaker GitHub Repository](./references/github_com_andriesfeder_cladebreaker.md)
- [Cladebreaker Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cladebreaker_overview.md)