---
name: humann
description: HUMAnN profiles the presence and abundance of microbial pathways and gene families from metagenomic or metatranscriptomic sequencing data. Use when user asks to profile metabolic pathways, manage ChocoPhlAn or UniRef databases, normalize gene family abundances, or regroup features into functional namespaces.
homepage: http://huttenhower.sph.harvard.edu/humann
---


# humann

## Overview
HUMAnN is a pipeline designed to efficiently and accurately profile the presence and abundance of microbial pathways in a community. It works by mapping DNA or RNA reads against pangenomes (nucleotide-level) and protein databases (translated-level) to reconstruct metabolic potential or activity. Use this skill to configure runs, manage database dependencies (ChocoPhlAn and UniRef), and interpret the resulting gene family and pathway abundance tables.

## Core Workflow and CLI Patterns

### 1. Basic Execution
The primary command for running the pipeline is `humann`. At a minimum, it requires an input fastq/fasta file and an output directory.

```bash
humann --input sample.fastq --output output_dir
```

### 2. Database Management
HUMAnN requires specific nucleotide and protein databases. Use the configuration tool to install or update them.

- **Install Databases:**
  ```bash
  humann_databases --download chocophlan full /path/to/db
  humann_databases --download uniref uniref90_diamond /path/to/db
  ```
- **Check Configuration:**
  ```bash
  humann_config --print
  ```

### 3. Common CLI Options
- `--nucleotide-database <path>`: Path to the ChocoPhlAn database.
- `--protein-database <path>`: Path to the UniRef database.
- `--threads <int>`: Number of threads to use (crucial for Diamond and Bowtie2 steps).
- `--search-mode <uniref50|uniref90>`: Defines the granularity of the protein search.

### 4. Post-processing and Normalization
HUMAnN outputs are typically in RPK (Reads Per Kilobase). To compare across samples, normalize the data.

- **Renormalize to Relative Abundance:**
  ```bash
  humann_renorm_table --input gene_families.tsv --output gene_families_relab.tsv --units relab
  ```
- **Regrouping Features:** Convert UniRef IDs to other namespaces (e.g., KO, EC, or GO).
  ```bash
  humann_regroup_table --input gene_families.tsv --groups uniref90_ko --output gene_families_KO.tsv
  ```
- **Joining Tables:** Combine multiple sample outputs into a single matrix.
  ```bash
  humann_join_tables --input output_dir --output summary_table.tsv
  ```

## Expert Tips
- **Bypass Nucleotide Search:** If you know your samples contain organisms not in ChocoPhlAn, you can force translated search, though it is computationally more expensive.
- **Memory Management:** For large datasets, ensure the `--memory-use` flag is set appropriately to manage the Diamond search overhead.
- **Quality Control:** Always run `MetaPhlAn` (often integrated or run prior) to provide the taxonomic profile that HUMAnN uses to select pangenomes for the initial nucleotide mapping stage.

## Reference documentation
- [HUMAnN Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_humann_overview.md)