---
name: nohuman
description: nohuman identifies and filters human-derived reads from sequencing datasets using a pangenome-based database. Use when user asks to filter human reads, download the HPRC database, or extract human-only sequences from a dataset.
homepage: https://github.com/mbhall88/nohuman
metadata:
  docker_image: "quay.io/biocontainers/nohuman:0.5.0--hbbf5808_0"
---

# nohuman

## Overview
nohuman is a specialized bioinformatics tool that identifies and filters human-derived reads from sequencing datasets. It utilizes Kraken2 to classify reads against a comprehensive database built from the Human Pangenome Reference Consortium (HPRC), ensuring high sensitivity across diverse human ancestries. It supports single-end and paired-end data from any sequencing technology and handles various compression formats automatically.

## Core Workflows

### 1. Database Management
Before processing reads, you must download the HPRC-based database.
- **Download latest**: `nohuman --download`
- **List versions**: `nohuman --list-db-versions`
- **Specific version**: `nohuman --download --db-version HPRC.r1`
- **Environment Variable**: Set `NOHUMAN_DB` to point to a shared database location to avoid passing `--db` in every command.

### 2. Basic Filtering
- **Single-end**: `nohuman -t 8 input.fq.gz` (Outputs to `input.nohuman.fq.gz`)
- **Paired-end**: `nohuman -t 8 input_1.fq input_2.fq`
- **Custom Output**: `nohuman -o clean.fq input.fq`
- **Custom Paired Output**: `nohuman --out1 clean_1.fq --out2 clean_2.fq in_1.fq in_2.fq`

### 3. Advanced Classification Control
- **Confidence Threshold**: Use `--conf` to set the Kraken2 minimum confidence score (0.0 to 1.0). Higher values increase precision but may reduce sensitivity.
  `nohuman --conf 0.5 input.fq`
- **Invert Selection**: Use `-H` or `--human` to output *only* the human reads (useful for human-specific studies or QC).
  `nohuman -H input.fq`
- **Reporting**: Generate standard Kraken2 outputs for auditing.
  `nohuman -k classification.out -r report.txt input.fq`

## Expert Tips
- **Dependency Check**: Always run `nohuman -c` after installation to verify that Kraken2 and other requirements are correctly in the PATH.
- **Compression**: The tool automatically detects compression based on file extensions (.gz, .zst, .bz2, .xz). If you need to force a specific format, use `-F` (e.g., `-F g` for Gzip).
- **Performance**: Match the `-t` (threads) parameter to your CPU availability; these threads are shared between Kraken2 and the compression/decompression streams.
- **Database Pathing**: If using a shared cluster, point to the database directly using `-D /path/to/db` if the environment variable is not set.

## Reference documentation
- [github_com_mbhall88_nohuman.md](./references/github_com_mbhall88_nohuman.md)