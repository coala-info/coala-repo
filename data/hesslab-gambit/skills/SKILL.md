---
name: hesslab-gambit
description: GAMBIT rapidly classifies bacterial genome assemblies by comparing them against a large reference database. Use when user asks to identify bacterial isolates, perform taxonomic classification of genome assemblies, or run queries against the GAMBIT reference database.
homepage: https://github.com/hesslab-gambit/gambit
metadata:
  docker_image: "quay.io/biocontainers/hesslab-gambit:0.5.1--py39hbcbf7aa_1"
---

# hesslab-gambit

## Overview
GAMBIT (Genomic Approximation Method for Bacterial Identification and Tracking) is a high-performance bioinformatics tool designed for the rapid classification of bacterial isolates. It excels at identifying genome assemblies across the entire bacterial kingdom in seconds by comparing query sequences against a massive, curated database of approximately 50,000 reference genomes. This skill provides the necessary command-line patterns to execute taxonomic queries and manage the required reference databases.

## Installation and Environment
The package is available via Bioconda. Note that while the legacy name is `hesslab-gambit`, the current active package and command is simply `gambit`.

```bash
# Install via conda
conda install -c bioconda gambit
```

### Database Setup
GAMBIT requires two specific database files: `.gdb` (the database itself) and `.gs` (the genomic signatures).
1. Download `gambit-refseq-curated-1.0.gdb` and `gambit-refseq-curated-1.0.gs`.
2. Set the environment variable to avoid repeating the path in every command:
   ```bash
   export GAMBIT_DB_PATH=/path/to/database/directory/
   ```

## Common CLI Patterns

### Basic Identification
To identify one or more unknown bacterial assemblies (FASTA format):
```bash
gambit query genome1.fasta genome2.fasta
```

### Saving Results
Output the taxonomic identification results to a CSV file for downstream analysis:
```bash
gambit query -o identification_results.csv sample_A.fna sample_B.fna
```

### Manual Database Specification
If the environment variable is not set, use the `-d` flag *before* the subcommand:
```bash
gambit -d /path/to/db_dir/ query sample.fasta
```

## Expert Tips
- **Input Quality**: GAMBIT is designed for genome assemblies. Ensure your input FASTA files contain contigs or scaffolds rather than raw unmapped reads.
- **Performance**: Because GAMBIT uses an approximation method based on genomic distance, it is significantly faster than traditional alignment-based methods (like BLAST) for species-level identification.
- **Database Consistency**: Always ensure the `.gdb` and `.gs` files are kept in the same directory, as the tool expects them to be co-located to function correctly.

## Reference documentation
- [GAMBIT GitHub Repository](./references/github_com_jlumpe_gambit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hesslab-gambit_overview.md)