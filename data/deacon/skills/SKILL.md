---
name: deacon
description: Deacon is a high-performance bioinformatics tool used for the rapid classification, searching, and filtering of DNA sequences using SIMD-accelerated minimizer comparison. Use when user asks to build or fetch sequence indexes, perform host depletion, search for matching reads, or filter paired-end sequencing data.
homepage: https://github.com/bede/deacon
---


# deacon

## Overview

Deacon is a high-performance bioinformatics tool designed for the rapid classification and filtering of DNA sequences. It utilizes SIMD-accelerated minimizer comparison to match input reads against a query index. It operates in two primary modes: **search mode** (emitting matching sequences) and **deplete mode** (emitting sequences that do not match). Its efficiency makes it suitable for processing terabase-scale datasets on standard hardware, providing a faster alternative to traditional alignment-based filtering.

## Core Workflows

### 1. Index Management
Before filtering, you must either build an index from a reference FASTA or fetch a pre-built one.

*   **Fetch Pre-built Index**: Downloads validated indexes (e.g., the human pangenome).
    ```bash
    deacon index fetch panhuman-1
    ```
*   **Build Custom Index**: Create an index from your own reference sequences.
    ```bash
    deacon index build reference.fa > reference.idx
    ```
*   **Combine Indexes**: Merge multiple indexes into one.
    ```bash
    deacon index union index1.idx index2.idx > combined.idx
    ```

### 2. Sequence Filtering
Filtering is the primary operation for search or depletion.

*   **Host Depletion (Deplete Mode)**: Remove sequences matching the index (e.g., removing human reads).
    ```bash
    deacon filter -d reference.idx input.fq -o clean.fq
    ```
*   **Sequence Search (Search Mode)**: Keep only sequences matching the index.
    ```bash
    deacon filter reference.idx input.fq > matches.fq
    ```
*   **Paired-End Filtering**: Process R1 and R2 files simultaneously.
    ```bash
    deacon filter -d reference.idx r1.fq.gz r2.fq.gz -o clean.r1.fq.gz -O clean.r2.fq.gz
    ```

## Expert CLI Patterns

### Threshold Tuning
Sensitivity and specificity are controlled by absolute (`-a`) and relative (`-r`) match thresholds. A sequence matches if it exceeds **both**.
*   **Increase Sensitivity**: Lower the thresholds (e.g., `-a 1 -r 0.005`).
*   **Increase Specificity**: Raise the thresholds (e.g., `-a 5 -r 0.05`).
*   **Default**: `-a 2` (shared minimizers) and `-r 0.01` (1% of distinct minimizers).

### Performance Optimization
*   **Compression**: Deacon natively handles `.gz`, `.zst`, and `.xz`. Using `.gz` extensions for output triggers parallel compression.
*   **Streaming**: Use stdin/stdout for piping between tools.
    ```bash
    cat reads.fq | deacon filter reference.idx - > filtered.fq
    ```
*   **Process Substitution**: Use named pipes for complex inputs.
    ```bash
    deacon filter reference.idx <(zcat r1.fq.gz) -o filtered.fq
    ```

### Privacy and Metadata
*   **Anonymization**: Use `--rename` or `--rename-random` to replace read headers with incrementing or random integers, reducing file size and protecting privacy.
*   **Format Conversion**: Force FASTA output from FASTQ input using `-f` or `--fasta`.
*   **Summary Statistics**: Generate a JSON report of the filtering process.
    ```bash
    deacon filter --summary stats.json -d ref.idx input.fq -o output.fq
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| deacon index | Build, inspect, compose and fetch minimizer indexes |
| deacon server | Start/stop a server process for reduced latency filtering |
| filter | Retain or deplete sequence records with sufficient minimizer hits to an indexed query |

## Reference documentation
- [Deacon README](./references/github_com_bede_deacon_blob_main_README.md)
- [Changelog and Version History](./references/github_com_bede_deacon_blob_main_CHANGELOG.md)