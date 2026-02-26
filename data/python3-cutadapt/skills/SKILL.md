---
name: python3-cutadapt
description: "Cutadapt removes adapter sequences, primers, and low-quality bases from high-throughput sequencing reads. Use when user asks to trim adapters, strip PCR primers, filter reads by quality or length, or demultiplex sequencing data."
homepage: https://cutadapt.readthedocs.io/
---


# python3-cutadapt

## Overview

Cutadapt is a specialized tool for cleaning high-throughput sequencing data by removing technical artifacts. Use this skill to process reads where the sequencing length exceeds the biological molecule (e.g., small-RNA), to strip PCR primers from amplicons, or to filter out low-quality sequences. It handles complex scenarios like linked adapters, nested adapters, and dual-indexed demultiplexing while maintaining read pairing.

## Core CLI Patterns

### Basic Adapter Trimming
*   **3' Adapter (Single-end):** `cutadapt -a SEQUENCE -o output.fastq input.fastq`
*   **5' Adapter (Single-end):** `cutadapt -g SEQUENCE -o output.fastq input.fastq`
*   **Paired-end Trimming:** Use uppercase flags for the second read (R2).
    `cutadapt -a ADAPT1 -A ADAPT2 -o out.1.fastq -p out.2.fastq in.1.fastq in.2.fastq`

### Anchoring and Specificity
*   **Anchored 5' Adapter:** Forces the adapter to appear at the very start of the read.
    `cutadapt -g ^ADAPTER -o out.fastq in.fastq`
*   **Anchored 3' Adapter:** Forces the adapter to appear at the very end.
    `cutadapt -a ADAPTER$ -o out.fastq in.fastq`
*   **Linked Adapters:** Used when both a 5' and 3' adapter are expected (e.g., amplicons).
    `cutadapt -a ^FRONT...BACK -o out.fastq in.fastq`

### Quality and Length Filtering
*   **Quality Trimming:** Trim low-quality ends before adapter removal.
    `cutadapt -q 20 -o out.fastq in.fastq` (3' end only)
    `cutadapt -q 15,10 -o out.fastq in.fastq` (5' and 3' ends respectively)
*   **Minimum Length:** Discard reads that are too short after trimming.
    `cutadapt -m 25 -o out.fastq in.fastq`
*   **Poly-A Trimming:** Specialized algorithm for removing poly-A tails (faster and more accurate than literal sequence matching).
    `cutadapt --poly-a -o out.fastq in.fastq`

## Expert Tips and Best Practices

### Performance Optimization
*   **Multi-core Processing:** Always use `-j` to specify CPU cores. Use `-j 0` to automatically detect all available cores.
*   **Compression:** Cutadapt detects `.gz` extensions automatically. For intermediate files, use the default compression (level 1) to save time, as compression is often the bottleneck.

### Advanced Matching Logic
*   **Error Tolerance:** The default error rate is 0.1 (10%). Adjust with `-e`. For example, `-e 0.15` allows more mismatches in long adapters.
*   **Wildcards:** Use `N` in your adapter sequences to match any base. Enable `--match-read-wildcards` if your reads contain `N`s that should match the adapter.
*   **Multiple Passes:** If a read might contain the same adapter multiple times, use `-n COUNT` (e.g., `-n 2`) to repeat the removal step.

### Handling Mixed Orientations
*   If your library contains reads in both forward and reverse-complement orientations, use the `--revcomp` flag. Cutadapt will check both orientations and output the one that matches the adapter better.

### Demultiplexing
*   To demultiplex based on barcodes, provide a FASTA file of adapters and use a template in the output filename:
    `cutadapt -g file:barcodes.fasta -o out-{name}.fastq in.fastq`

## Reference documentation
- [User guide](./references/cutadapt_readthedocs_io_en_stable_guide.html.md)
- [Recipes](./references/cutadapt_readthedocs_io_en_stable_recipes.html.md)
- [Reference guide](./references/cutadapt_readthedocs_io_en_stable_reference.html.md)
- [Algorithm details](./references/cutadapt_readthedocs_io_en_stable_algorithms.html.md)