---
name: minimod
description: Minimod extracts and analyzes DNA and RNA base modification probabilities from SAM/BAM files by integrating aligned reads with a reference genome. Use when user asks to summarize modification codes, extract per-read modification data, or calculate site-level modification frequencies in formats like bedMethyl.
homepage: https://github.com/warp9seq/minimod
---


# minimod

## Overview

Minimod is a specialized tool for handling DNA and RNA base modifications. It bridges the gap between complex SAM/BAM modification tags (MM/ML) and standard genomic formats. By integrating aligned reads with a reference genome, it allows for the precise extraction of modification probabilities at specific sequence contexts (like CpG sites). It is highly efficient, written in C, and supports multi-threaded processing for large-scale methylome analysis.

## Common CLI Patterns

### 1. Initial Data Assessment
Before running full analysis, use the `summary` command to identify which modification codes are present in your BAM file and their respective counts.
```bash
minimod summary reads.bam > summary.tsv
```

### 2. Extracting Per-Read Modifications
To get a detailed TSV of every modified base for every read (useful for single-molecule analysis or custom filtering):
```bash
# Default: 5mC (m) in CG context
minimod view ref.fa reads.bam > mods.tsv

# Specific modifications (e.g., 5mC and 5hmC)
minimod view -c mh ref.fa reads.bam > mods.tsv
```

### 3. Calculating Modification Frequencies
To generate site-level statistics, use the `freq` command. This is the standard way to produce "methylation calls."
```bash
# Output TSV format (default threshold 0.8)
minimod freq ref.fa reads.bam > modfreqs.tsv

# Output bedMethyl format (standard for genome browsers)
minimod freq -b ref.fa reads.bam > modfreqs.bedmethyl
```

### 4. Advanced Context and Thresholding
You can specify multiple modifications with independent contexts and probability thresholds.
```bash
# 5mC in CG context (threshold 0.8) and 5hmC in CG context (threshold 0.7)
minimod freq -c m[CG],h[CG] -m 0.8,0.7 ref.fa reads.bam > multi_mods.tsv
```

## Expert Tips and Best Practices

*   **Thread Optimization**: Use the `-t` flag to specify processing threads. For large BAM files, 8-16 threads are typically optimal depending on your I/O throughput.
*   **Handling Insertions**: By default, modifications in inserted sequences (relative to the reference) are ignored. Use the `--insertions` flag to include them in the output.
*   **Haplotype-Aware Analysis**: If your BAM file has been phased (e.g., using Whatshap), use the `--haplotypes` flag to include haplotype information in the `view` output.
*   **Probability Logic**: Note that as of version 0.5.0, minimod uses the conversion formula `p = (N+0.5)/256.0` to transform the 8-bit integer in the ML tag to a float probability.
*   **Secondary Alignments**: By default, minimod ignores secondary alignments to prevent double-counting. If your workflow requires them, enable them with `--allow-secondary`.
*   **Context Matching**: When providing a context (e.g., `-c m[CG]`), minimod ensures the modified read base matches the aligned reference base. To bypass this check (e.g., for transcriptome data), use the wildcard context `*` (e.g., `-c a[*]`).



## Subcommands

| Command | Description |
|---------|-------------|
| freq | Calculate modification frequencies from reads aligned to a reference |
| view | View modifications in reads using a reference genome and BAM file |

## Reference documentation
- [Minimod README](./references/github_com_warp9seq_minimod_blob_main_README.md)
- [Major Changes and Version Notes](./references/github_com_warp9seq_minimod_blob_main_docs_changes.md)