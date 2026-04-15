---
name: bxtools
description: bxtools is a suite of command-line utilities designed for low-level, barcode-aware operations on 10X Genomics sequencing data. Use when user asks to split BAM files by barcode, generate barcode-level statistics, calculate tiled genome coverage, identify molecular footprints, or relabel reads with barcode metadata.
homepage: https://github.com/walaj/bxtools
metadata:
  docker_image: "quay.io/biocontainers/bxtools:0.1.0--h13024bc_6"
---

# bxtools

## Overview

bxtools is a specialized suite of lightweight command-line utilities designed for low-level operations on 10X Genomics sequencing data. While standard bioinformatics tools often ignore the metadata stored in BAM tags, bxtools treats the `BX` (barcode) and `MI` (molecular identifier) tags as primary attributes. This allows researchers to perform barcode-aware splitting, statistical analysis, and molecular footprinting that is otherwise difficult with general-purpose tools like samtools.

## Core Components and Usage

### 1. Splitting BAMs by Barcode
The `split` command is used to partition a large BAM file into smaller files based on the `BX` tag.

*   **Generate Barcode Counts:** Use the `-x` flag to simply count occurrences of each barcode.
    ```bash
    bxtools split input.bam -x | sort -n -k 2,2 > counts.tsv
    ```
*   **Physical Splitting:** Split a BAM into individual files (e.g., `prefix.<bx>.bam`), ignoring barcodes with fewer than 10 reads.
    ```bash
    bxtools split input.bam -a prefix -m 10
    ```

### 2. Barcode-Level Statistics
The `stats` command summarizes data at the barcode level. Output columns include: BX, read count, median insert size, median mapq, and median alignment score (AS).

*   **Standard Stats:**
    ```bash
    bxtools stats input.bam > stats.tsv
    ```
*   **Summarize by MI Tag:** Use the `-t` flag to group statistics by a different tag, such as the Molecular Identifier.
    ```bash
    bxtools stats -t MI input.bam
    ```

### 3. Tiled Genome Coverage
The `tile` command calculates barcode-level read counts across a tiled genome (default is 1kb tiles).

*   **Genome-wide Tiling:**
    ```bash
    bxtools tile input.bam > counts.bed
    ```
*   **Custom Window Size:** Use `-w` to adjust the tile size (e.g., 2kb).
    ```bash
    samtools view -h input.bam | bxtools tile - -w 2000 > bxcov.bed
    ```

### 4. Molecular Footprinting
The `mol` command identifies the minimum molecular footprint on the genome for each `MI` tag. It defines the footprint from the minimum start to the maximum end position of all reads sharing an `MI`.

*   **Generate Footprints:**
    ```bash
    bxtools mol input.bam > mol_footprint.bed
    ```
    *Note: This command will throw an error if it detects the same MI tag on multiple chromosomes.*

### 5. Barcode Relabeling
The `relabel` command moves the barcode from the `BX` tag directly into the read name (QNAME). This is useful for downstream tools that do not support BAM tags but can parse read names.

*   **Relabel Reads:**
    ```bash
    bxtools relabel input.bam > relabeled.bam
    ```

### 6. Sorting by Barcode (The Convert Hack)
Standard BAM files are sorted by coordinate or query name. The `convert` command swaps the alignment chromosome with the `BX` tag, allowing you to sort and index the BAM by barcode.

*   **Workflow for Barcode Lookup:**
    ```bash
    # Convert and sort
    bxtools convert input.bam | samtools sort - -o bx_sorted.bam
    samtools index bx_sorted.bam

    # Rapidly view all reads for a specific barcode
    samtools view bx_sorted.bam AGTCCAAGTCGGAAGT_1
    ```

## Expert Tips and Best Practices

*   **Piping with Samtools:** bxtools supports `stdin` (using `-`) for most commands. Always use `samtools view -h` when piping to ensure the header is preserved for bxtools to process.
*   **Filtering Noise:** Before running heavy operations like `tile`, filter out low-frequency "bad" tags to reduce noise and processing time.
    ```bash
    # Identify tags with < 100 reads
    bxtools split input.bam -x | awk '$2 < 100' | cut -f1 > excluded_list.txt
    # Filter and tile
    samtools view -h input.bam | grep -v -F -f excluded_list.txt | bxtools tile - > filtered_cov.bed
    ```
*   **Memory Management:** Commands like `convert` require two passes over the data and cannot be streamed from `stdin`. Ensure you have sufficient disk space for the intermediate files.



## Subcommands

| Command | Description |
|---------|-------------|
| bxtools convert | Convert a BAM to a BX sorted BAM by switching BX and chromosome |
| bxtools mol | Return span of molecules from 10X data (using MI tag) |
| bxtools relabel | Move BX barcodes from BX tag to qname |
| bxtools split | Split / count a BAM into multiple BAMs, one BAM per unique BX tag |
| bxtools stat | Gather BX-level statistics |
| bxtools tile | Gather BX counts on tiled ranges |

## Reference documentation
- [bxtools README](./references/github_com_walaj_bxtools_blob_master_README.md)