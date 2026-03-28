---
name: cayman
description: "Cayman quantifies the abundance of carbohydrate-active enzymes in metagenomic datasets by mapping shotgun reads to a reference gene catalog. Use when user asks to profile CAZyme abundance, quantify carbohydrate metabolism genes, or generate RPKM matrices from metagenomic reads."
homepage: https://github.com/zellerlab/cayman
---


# cayman

## Overview

Cayman (Carbohydrate active enzymes profiling of metagenomes) is a specialized bioinformatic tool designed to quantify the abundance of CAZymes within metagenomic datasets. It streamlines the process of mapping raw shotgun reads to a reference gene catalog—typically the Global Microbial Gene Catalog (GMGC)—and utilizes pre-defined CAZyme domain annotations to produce a matrix of Reads-Per-Kilobase-Million (RPKM) abundances. It is particularly useful for functional profiling of carbohydrate metabolism in complex microbial communities.

## Installation and Setup

Cayman requires Python (3.7–3.10) and a functional `bwa` installation.

- **Bioconda**: `conda install -c bioconda cayman`
- **PyPI**: `pip install cayman`
- **Docker**: `docker pull ghcr.io/zellerlab/cayman:latest`

### Reference Data Preparation
Before running a profile, you must index your reference gene catalog (e.g., GMGC) using BWA:
```bash
bwa index -p <index_name> [-b blocksize] /path/to/dataset.fasta
```
*Tip: Setting `-b 100000000` can speed up index generation if sufficient memory is available.*

## Command Line Usage

The primary entry point for the tool is the `cayman profile` command.

### Mandatory Parameters
```bash
cayman profile \
  <input_options> \
  <path/to/annotation_db> \
  <path/to/bwa_index>
```

- **Input Options**:
  - **Paired-end**: `-1 forward.fq -2 reverse.fq` (Each read counts as 0.5)
  - **Single-end**: `--singles reads.fq` (Each read counts as 1.0)
  - **Orphan reads**: `--orphans orphans.fq` (Each read counts as 0.5)
  - **Multiple files**: Provide space-separated lists (ensure order matches for paired-end).
- **Annotation DB**: A 4-column BED4 file (`contig`, `start`, `end`, `domain-type`) containing CAZy domain annotations.
- **BWA Index**: The prefix path to your BWA-indexed gene catalog.

### Optional Parameters and Tuning
- `--out_prefix <string>`: Prefix for output files (default: "cayman"). Include a directory path to save elsewhere.
- `--min_identity <float>`: Minimum sequence identity for alignment (default: 0.97).
- `--min_seqlen <int>`: Minimum alignment length in bp, excluding soft/hard-clipping (default: 45).
- `--cpus_for_alignment <int>`: Number of threads for BWA (default: 1).

## Best Practices and Tips

- **Input Quality**: Always use quality-filtered and host-removed reads for accurate RPKM calculations.
- **Read Counting Logic**: Cayman applies specific weights based on library layout. Paired reads and orphans are weighted at 0.5 to ensure a single fragment is not over-counted, whereas true single-end library reads are weighted at 1.0.
- **Output Interpretation**:
  - `<prefix>.cazy.txt`: The primary CAZy profile. Includes unique counts (`uniq_raw`), unique RPKM (`uniq_rpkm`), and combined counts (unique + ambiguous).
  - `<prefix>.gene_counts.txt`: Profiles for the individual genes in the catalog.
  - `<prefix>.aln_stats.txt`: Alignment statistics for QC.
- **Memory Requirements**: For standard GMGC datasets, a system with at least 16GB RAM is recommended.



## Subcommands

| Command | Description |
|---------|-------------|
| annotate_proteome | Annotate proteome with HMMs |
| cayman profile | Profile reads against an annotation database and BWA index. |

## Reference documentation
- [Cayman README](./references/github_com_zellerlab_cayman_blob_main_README.md)
- [Cayman Dockerfile](./references/github_com_zellerlab_cayman_blob_main_Dockerfile.md)