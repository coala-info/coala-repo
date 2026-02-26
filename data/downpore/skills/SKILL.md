---
name: downpore
description: Downpore is a suite of tools for the pre-processing and analysis of long-read genomic data. Use when user asks to trim adapters, de-multiplex barcodes, map reads to a reference, or detect overlaps between reads.
homepage: https://github.com/jteutenberg/downpore
---


# downpore

## Overview
`downpore` is a specialized suite of tools optimized for the pre-processing and analysis phases of genome assembly. Its primary utility lies in its ability to rapidly identify and remove adapter sequences or barcodes from long reads, handle chimeric reads by splitting them at internal adapter sites, and perform efficient mapping and overlap detection. It is built for speed and low-resource overhead, making it suitable for large-scale genomic datasets.

## Installation and Setup
Install via Bioconda for the most stable environment:
```bash
conda install bioconda::downpore
```

## Core Commands and Usage

### 1. Adapter Trimming (`trim`)
The `trim` command identifies and removes adapters from the ends or middle of reads.
*   **Basic Trimming**:
    ```bash
    downpore trim -i reads.fastq -f adapters_front.fasta -b adapters_back.fasta > trimmed.fastq
    ```
*   **High Performance**: Use `--himem true` to cache reads in memory and `--num_workers` to specify thread count.
    ```bash
    downpore trim -i reads.fastq -f front.fasta -b back.fasta --himem true --num_workers 32 > trimmed.fastq
    ```
*   **Internal Adapters**: By default, `downpore` splits reads at internal adapter sites. Use `-discard_middle true` if you wish to discard the resulting fragments instead of keeping them.

### 2. De-multiplexing
To separate reads based on barcodes:
*   **Requirement**: Barcode sequences in your FASTA file must have names starting with "Barcode" and must **not** contain underscores.
*   **Command**:
    ```bash
    downpore trim -i reads.fastq -f barcodes.fasta --demultiplex ./output_dir --require_pairs true
    ```

### 3. Mapping (`map`)
Used for aligning reads to a reference or indexing sequences.
*   **Basic Mapping**:
    ```bash
    downpore map -i reads.fastq -r reference.fasta > alignment.paf
    ```

### 4. Overlap Detection (`overlap`)
Finds overlaps between reads, essential for OLC (Overlap-Layout-Consensus) assembly.
*   **Basic Overlap**:
    ```bash
    downpore overlap -i reads.fastq > overlaps.paf
    ```

## Expert Tips and Best Practices
*   **Input Constraints**: `downpore` only accepts DNA sequences (A, C, G, T). Ensure your FASTA/FASTQ files do not have multi-line sequences; end-lines within a single sequence must be removed before processing.
*   **Memory Management**: For very large datasets, if you are not using `--himem true`, ensure your disk I/O is optimized as the tool will rely more heavily on file access.
*   **Barcode Precision**: If two barcodes are within 5% identity in a single read, `downpore` considers it ambiguous and will not label the read. Ensure your barcode sets are sufficiently distinct.
*   **Edge vs. Middle**: The tool uses different heuristics for adapters at the edges (first/last 150 bases) versus the middle. Edge detection has higher recall, while middle detection is tuned for higher precision to avoid false-positive read splitting.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_jteutenberg_downpore.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_downpore_overview.md)