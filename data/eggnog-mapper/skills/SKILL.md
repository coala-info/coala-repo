---
name: eggnog-mapper
description: eggnog-mapper (e-mapper) is a specialized tool designed for high-throughput functional annotation.
homepage: https://github.com/jhcepas/eggnog-mapper
---

# eggnog-mapper

## Overview
eggnog-mapper (e-mapper) is a specialized tool designed for high-throughput functional annotation. Unlike traditional BLAST-based homology searches that can erroneously transfer functions from paralogs, eggnog-mapper utilizes precomputed orthologous groups and phylogenies from the eggNOG database. This ensures that functional information is transferred only from fine-grained orthologs, significantly increasing annotation precision. It is the standard tool for processing large-scale genomic and metagenomic datasets where speed and accuracy are critical.

## Installation and Setup
The tool is primarily distributed via Bioconda. Before running annotations, the local database must be initialized.

**Installation:**
```bash
conda install -c bioconda eggnog-mapper
```

**Database Initialization:**
Use the provided utility script to download the required eggNOG data.
```bash
# Download the main database and DIAMOND index
download_eggnog_data.py
```

## Core CLI Usage
The primary entry point is `emapper.py`. It supports various input types and search algorithms.

### Basic Annotation Workflow
```bash
# Annotate protein sequences using DIAMOND (default)
emapper.py -i proteins.faa -o output_prefix --itype proteins

# Annotate a genome (predicts genes using Prodigal automatically)
emapper.py -i genome.fna -o output_prefix --itype genome
```

### Search Method Selection
Choose the search algorithm based on the required sensitivity and dataset size:
- **DIAMOND (Default):** Best for large datasets and general protein annotation.
- **HMMER:** Higher sensitivity for remote homologs; uses HMM profiles.
- **MMseqs2:** High-speed alternative for massive metagenomic datasets.

```bash
# Using HMMER search mode
emapper.py -i input.faa -o output --method hmmer
```

## Expert Tips and Best Practices
- **Memory Management:** For large DIAMOND searches, use `--dmnd_iterate` to process the database in chunks if RAM is limited.
- **CPU Optimization:** Always specify `--cpu` to match your environment's available cores to maximize throughput.
- **Input Types:** Use `--itype` explicitly. For metagenomic assemblies, `metagenome` mode uses Prodigal's procedure optimized for fragmented genes.
- **Taxonomic Filtering:** If you know your samples are restricted to a specific clade (e.g., Bacteria), use `--tax_scope Bacteria` to speed up the search and improve specificity.
- **Output Files:** The tool generates several files; the `.emapper.annotations` file is the primary tab-delimited output containing the functional assignments.

## Reference documentation
- [eggnog-mapper Overview](./references/anaconda_org_channels_bioconda_packages_eggnog-mapper_overview.md)
- [eggnog-mapper GitHub Repository](./references/github_com_eggnogdb_eggnog-mapper.md)
- [eggnog-mapper Wiki](./references/github_com_eggnogdb_eggnog-mapper_wiki.md)