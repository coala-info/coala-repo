---
name: isonclust2
description: isONclust2 is a high-performance tool for the de novo clustering of long transcriptomic reads into gene families. Use when user asks to cluster long reads, group transcriptomic data into gene families, or process large-scale datasets from platforms like PromethION.
homepage: https://github.com/nanoporetech/isonclust2
---


# isonclust2

## Overview
isONclust2 is a high-performance C++ tool designed for the de novo clustering of long transcriptomic reads. It is particularly optimized for large-scale datasets from platforms like PromethION. The tool groups reads into gene families using a minimizer-based approach with optional pairwise alignment. Because it handles massive datasets by splitting them into batches, the tool requires a specific multi-step execution order: sorting, individual batch clustering, hierarchical merging, and final dumping.

## Core Workflow

### 1. Sorting and Batching
The first step is to sort the raw reads and partition them into manageable batches.

```bash
isonclust2 sort -B 50000 -v input_reads.fq -o isONclust2_batches
```
*   `-B`: Batch size in kilobases (default 50000).
*   `-M`: Maximum sequences per batch (default 3000).
*   `-x`: Mode selection. Use `fast` for minimizers only, `sahlin` (default) for minimizers + alignment, or `furious` for alignment only.

### 2. Initial Batch Clustering
Each generated batch (`.cer` file) must be clustered individually.

```bash
isonclust2 cluster -v -l isONclust2_batches/sorted/batches/isONbatch_0.cer -o b0.cer
isonclust2 cluster -v -l isONclust2_batches/sorted/batches/isONbatch_1.cer -o b1.cer
```

### 3. Merging Batches
Merge the clustered batches sequentially or hierarchically to reconcile clusters across the entire dataset.

```bash
# Merge two batches
isonclust2 cluster -v -l b0.cer -r b1.cer -o b_merged_0_1.cer

# Continue merging subsequent batches into the result
isonclust2 cluster -v -l b_merged_0_1.cer -r b2.cer -o b_final.cer
```

### 4. Extracting Results
Dump the final clustered data into a readable format using the index created during the sort step.

```bash
isonclust2 dump -v -i isONclust2_batches/sorted/sorted_reads_idx.cer -o results_dir b_final.cer
```

## Expert Tips and Parameters

### Clustering Modes (`-x`)
*   **sahlin (Default)**: Best balance of speed and accuracy. Uses minimizers for candidate selection and alignment for verification.
*   **fast**: Use when speed is critical and reads have high identity. Relies solely on minimizers.
*   **furious**: Use for maximum sensitivity at the cost of significant computation time.

### Quality and Filtering
*   **--min-qual (-q)**: Default is 7.0. Increase this if dealing with very noisy data to improve cluster reliability.
*   **--mapped-threshold (-r)**: Default 0.65. Controls the minimum fraction of a read that must map to a cluster representative to be included.
*   **--min-cls-size (-F)**: Use this during the `cluster` step to skip very small clusters (e.g., singletons) to speed up the merging process.

### Memory and Performance
*   **--batch-size (-B)**: If encountering memory issues on large datasets, reduce the batch size.
*   **--min-purge (-z)**: Use during clustering to remove the minimizer database from the output batch, saving disk space during intermediate steps.

## Reference documentation
- [isONclust2 GitHub Repository](./references/github_com_nanoporetech_isONclust2.md)