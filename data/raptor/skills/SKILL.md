---
name: raptor
description: Raptor is a bioinformatics tool that performs large-scale genomic sequence searches against indexed datasets using k-mer content. Use when user asks to prepare sequence data, layout hierarchical structures, build Interleaved Bloom Filter indexes, or search queries against genomic bins.
homepage: https://github.com/seqan/raptor
metadata:
  docker_image: "quay.io/biocontainers/raptor:3.0.1--haf24da9_4"
---

# raptor

## Overview
Raptor is a specialized bioinformatics tool designed to handle the "needle in a haystack" problem for genomic sequences. It allows users to determine which "bins" (samples, references, or genomes) contain a specific query sequence based on k-mer content. It is particularly effective for large-scale datasets where traditional alignment is too slow. The tool operates through a multi-step pipeline: optionally preprocessing data, defining a layout for hierarchical indexing, building the index, and finally searching against it.

## Core Workflows

### HIBF Workflow (Recommended)
The Hierarchical Interleaved Bloom Filter is the preferred index type for most datasets, especially those with unevenly sized bins.
1. **Prepare**: `raptor prepare --input <files.txt> --output <dir>` (Optional: filters k-mers by abundance).
2. **Layout**: `raptor layout --input <minimiser.list> --output layout.txt` (Determines the hierarchical structure).
3. **Build**: `raptor build --input layout.txt --output index.hibf`.
4. **Search**: `raptor search --index index.hibf --query <query.fasta> --output search.out`.

### IBF Workflow
Use the standard Interleaved Bloom Filter for small numbers of bins (≤ 128) or evenly sized datasets.
1. **Build**: `raptor build --input <files.txt> --output index.ibf`.
2. **Search**: `raptor search --index index.ibf --query <query.fasta> --output search.out`.

## Command Reference & Best Practices

### 1. Data Preparation (`raptor prepare`)
*   **Input Format**: A text file where each line contains paths to sequence data. Multiple paths on one line (separated by whitespace) are treated as a single bin.
*   **K-mer Cutoffs**: Use `--use-filesize-dependent-cutoff` to automatically apply Mantis-based filtering (e.g., 10x for 1GiB files) to remove sequencing errors.
*   **Persistence**: If a run crashes, rerunning the same command skips already processed files.

### 2. Index Layout (`raptor layout`)
*   **Tmax**: The maximum number of technical bins. A good default is approximately the square root of the number of samples, rounded to the next multiple of 64.
*   **Optimization**: Use `--determine-best-tmax` to let Raptor calculate the most efficient layout for your specific data distribution.

### 3. Index Building (`raptor build`)
*   **K-mer vs. Minimisers**: 
    *   Use `(w,k)` minimisers (default recommendation: `w-k=4`) for significantly smaller index sizes and faster runtimes.
    *   Use `(k,k)` canonical k-mers for exact thresholding when searching with a specific number of errors.
*   **False Positive Rate**: The default `--fpr 0.05` is balanced. Lowering this reduces false positives but increases the index size on disk.

### 4. Searching (`raptor search`)
*   **Thresholding**:
    *   `--error <N>`: Search allowing a specific number of errors (mutually exclusive with `--threshold`).
    *   `--threshold <0.0-1.0>`: Search requiring a specific ratio of k-mers to be present (e.g., `0.7` for 70%).
*   **Performance**: Use `--cache-thresholds` to save computed thresholds to disk, speeding up subsequent searches against the same index.
*   **Query Length**: If your queries have high variance in length, provide `--query_length` to ensure accurate threshold calculations.

## Expert Tips
*   **Memory Management**: If `raptor prepare` fails due to RAM limits, reduce the `--threads` count.
*   **HIBF vs IBF**: While IBF is simpler, HIBF is almost always superior in real-world scenarios where bin sizes vary significantly.
*   **K-mer Lemma**: When allowing errors (`e`), ensure `k` is small enough that `|query| - k + 1 - (k * e)` is still positive. For 100bp reads and 2 errors, `k=20` is a safe maximum.



## Subcommands

| Command | Description |
|---------|-------------|
| raptor build | Constructs a Raptor index. |
| raptor_subcommand | Please specify which sub-program you want to use: one of [build, layout, prepare, search, upgrade]. |

## Reference documentation
- [Quickstart Guide](./references/docs_seqan_de_raptor_main_usage_quickstart.html.md)
- [Raptor Prepare](./references/docs_seqan_de_raptor_main_usage_prepare.html.md)
- [Raptor Layout](./references/docs_seqan_de_raptor_main_usage_layout.html.md)
- [Raptor Build](./references/docs_seqan_de_raptor_main_usage_build.html.md)
- [Raptor Search](./references/docs_seqan_de_raptor_main_usage_search.html.md)