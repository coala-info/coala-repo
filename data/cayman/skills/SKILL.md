---
name: cayman
description: Cayman quantifies carbohydrate-active enzyme families in metagenomic samples by mapping shotgun reads to annotated gene catalogs. Use when user asks to quantify CAZyme abundances, profile carbohydrate-degrading potential in microbial communities, or calculate RPKM values for metagenomic gene catalogs.
homepage: https://github.com/zellerlab/cayman
---


# cayman

## Overview

Cayman (Carbohydrate active enzymes profiling of metagenomes) is a specialized bioinformatics tool designed to quantify CAZyme families within metagenomic samples. It maps shotgun reads against annotated gene catalogs (such as the Global Microbial Gene Catalog) using BWA and calculates normalized abundances in Reads-Per-Kilobase-Million (RPKM). This allows for a standardized comparison of carbohydrate-degrading potential across different microbial communities.

## Core Workflow

### 1. Reference Preparation
Before profiling, you must prepare a BWA index for your chosen gene catalog (e.g., GMGC).

```bash
# Generate BWA index
# Use a higher -b (blocksize) if memory allows (e.g., 100000000) to speed up generation
bwa index -p <index_name> -b 100000000 /path/to/dataset.fasta
```

### 2. Running the Profile Command
As of version 0.10.0, all profiling tasks are invoked via the `profile` subcommand.

```bash
cayman profile \
    <input_options> \
    /path/to/annotation_db.bed \
    /path/to/bwa_index_prefix \
    --out_prefix results/sample_name \
    --cpus_for_alignment 8
```

### 3. Input Library Configurations
Cayman handles different sequencing layouts with specific counting logic:

*   **Paired-end**: Use `-1 <R1.fq> -2 <R2.fq>`. Each read in a pair counts as 0.5 (total 1.0 per fragment).
*   **Single-end**: Use `--singles <reads.fq>`. Each read counts as 1.0.
*   **Orphaned reads**: Use `--orphans <orphans.fq>`. These are paired-end reads that lost their mate during QC; each counts as 0.5.
*   **Multiple files**: Provide space-separated lists (e.g., `-1 lane1_R1.fq lane2_R1.fq -2 lane1_R2.fq lane2_R2.fq`). Ensure the file order matches exactly between R1 and R2.

## Parameters and Best Practices

| Parameter | Default | Expert Tip |
| :--- | :--- | :--- |
| `--min_identity` | 0.97 | Lower this (e.g., 0.95) only if working with highly divergent or poorly characterized environments. |
| `--min_seqlen` | 45 | Ensure your read trimming settings in upstream QC do not drop reads below this threshold. |
| `--out_prefix` | "cayman" | **Critical**: If providing a directory path without a filename prefix (e.g., `/path/to/dir/`), the resulting files will start with `.` and be hidden in Unix systems. Always include a prefix like `/path/to/dir/sample1`. |

## Interpreting Results
The primary output is `<out_prefix>.cazy.txt`.

*   **uniq_raw / uniq_rpkm**: Abundance based only on reads that map uniquely to a single CAZyme domain.
*   **combined_raw / combined_rpkm**: Abundance including multi-mapping reads distributed across targets.
*   **Header Metadata**: The first few lines contain `total_reads` (aligned) and `filtered_reads` (meeting identity/length criteria), which are essential for assessing mapping quality.

## Reference documentation
- [Cayman GitHub Repository](./references/github_com_zellerlab_cayman.md)
- [Bioconda Cayman Package Overview](./references/anaconda_org_channels_bioconda_packages_cayman_overview.md)