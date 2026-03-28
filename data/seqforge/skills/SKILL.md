---
name: seqforge
description: "SeqForge is a modular bioinformatics pipeline for microbial genomics that provides parallelized BLAST querying, motif mining, and FASTA file manipulation. Use when user asks to build BLAST databases, run parallelized sequence queries, perform regex-based motif searches, sanitize FASTA headers, or calculate assembly metrics."
homepage: https://github.com/ERBringHorvath/SeqForge
---

# seqforge

## Overview

SeqForge is a modular bioinformatics pipeline designed for scale and flexibility in microbial genomics. It streamlines the transition from raw FASTA data to searchable databases and filtered results. Its primary strength lies in its parallelized BLAST wrapper and specialized motif mining capabilities, which allow for the detection of conserved domains even in diverse or low-identity sequence families. Beyond searching, it provides a suite of utility functions for FASTA file "hygiene," such as sanitizing headers, splitting multi-FASTA files, and generating assembly statistics.

## Core Workflows

### 1. Genome Search & Database Management
SeqForge automates the creation and querying of BLAST databases.

*   **Build a Database**: Use `makedb` to prepare nucleotide or protein datasets.
    ```bash
    seqforge makedb -i <input_fasta_or_dir> -o <db_output_path> -dbtype <nucl|prot>
    ```
*   **Parallelized Querying**: Run queries against multiple databases simultaneously. The tool auto-detects the appropriate BLAST flavor based on input.
    ```bash
    seqforge query -d <DB_DIR> -q <Query_DIR> -o <RESULTS_DIR>
    ```
*   **Filtering Results**: Apply thresholds for identity, coverage, or e-value directly in the command.
    ```bash
    seqforge query -d <DB_DIR> -q <Query_DIR> --min-id 80 --min-cov 70 -o <RESULTS_DIR>
    ```

### 2. Advanced Motif Mining
For protein searches (`blastp`), SeqForge can perform regex-based motif searches across BLAST hits.

*   **Basic Motif Search**: Search for specific amino acid patterns (e.g., catalytic triads).
    ```bash
    seqforge query -d <DB_DIR> -q <Query_DIR> --motif "GHXXGE" "WXWXIP"
    ```
*   **Linked Query Search**: Restrict specific motifs to specific query files using brackets.
    ```bash
    seqforge query -d <DB_DIR> -q <Query_DIR> --motif "GHXXGE{AT_domain}" "TAXXSS{KS_domain}"
    ```
*   **Motif Extraction**: Export only the matching motif strings to a new FASTA file.
    ```bash
    seqforge query [args] --motif "GHXXGE" --motif-fasta-out --motif-only
    ```

### 3. Sequence Manipulation & Metrics
Use these utilities to clean and analyze FASTA data before or after searching.

*   **Sanitize Headers**: Remove problematic characters (like `|`) from FASTA headers to ensure compatibility with downstream tools.
    ```bash
    seqforge sanitize -i <input_file> -o <output_file>
    ```
*   **Assembly Metrics**: Generate N50, L50, and total base counts for genome assemblies.
    ```bash
    seqforge metrics -i <fasta_dir_or_file>
    ```
*   **Split Multi-FASTA**: Break a large file into individual sequences.
    ```bash
    seqforge split -i <multi_fasta> -o <output_directory>
    ```
*   **Unique Barcoding**: Generate unique, deterministic headers for sequences.
    ```bash
    seqforge barcode -i <input_fasta> -o <output_fasta>
    ```

## Expert Tips

*   **Input Flexibility**: SeqForge handles single files, directories, and compressed archives (.gz, .zip, .tar.gz) natively. You do not need to decompress files manually before running modules.
*   **Visualization**: Use the `--visualize` flag with the `query` module to generate heatmaps of percent identity across genomes or sequence logos for motif matches. PDF format is recommended for high-resolution publication-quality plots.
*   **Strongest Match**: When dealing with repetitive hits, use the flag to report only the strongest match per query per genome to simplify the output table.



## Subcommands

| Command | Description |
|---------|-------------|
| seqforge extract | Extract sequences based on SeqForge Query results. |
| seqforge extract-contig | Extract entire contigs containing matching sequences. |
| seqforge fasta-metrics | Compute FASTA statistics (e.g., N50, GC content). |
| seqforge makedb | Create a BLAST database from a FASTA file. |
| seqforge query | Run BLAST queries in parallel. |
| seqforge sanitize | Remove special characters from input file names (content unchanged; needed for BLAST+). |
| seqforge search | Extract metadata from GenBank or JSON files. |
| seqforge split-fasta | Split a multi-FASTA into per-record files or fixed-size fragments. |
| seqforge unique-headers | Append source and a unique suffix to FASTA headers (supports --deterministic). |

## Reference documentation
- [SeqForge README](./references/github_com_ERBringHorvath_SeqForge_blob_main_README.md)
- [SeqForge Project Overview](./references/github_com_ERBringHorvath_SeqForge.md)