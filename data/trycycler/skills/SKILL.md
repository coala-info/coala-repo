---
name: trycycler
description: Trycycler is a "meta-assembler" designed to produce a single, highly reliable consensus sequence from a collection of independent long-read assemblies.
homepage: https://github.com/rrwick/Trycycler
---

# trycycler

## Overview

Trycycler is a "meta-assembler" designed to produce a single, highly reliable consensus sequence from a collection of independent long-read assemblies. While individual assemblers often struggle with perfect circularization, spurious contigs, or medium-scale indels, Trycycler identifies the commonalities across multiple inputs to filter out errors. It is particularly effective for bacterial genomics where replicons (chromosomes and plasmids) are expected to be circular. The workflow is modular, requiring the user to cluster, reconcile, and align sequences before generating the final consensus.

## Core Workflow and CLI Patterns

The Trycycler pipeline follows a specific sequence of commands. Each step typically operates on a directory structure created in the previous step.

### 1. Input Preparation
Before using Trycycler, you must generate multiple assemblies (ideally 12 or more). You can do this by using different assemblers or by subsampling your long reads into different subsets.

### 2. Clustering Contigs
Group contigs from all input assemblies into clusters that represent the same replicon.
```bash
trycycler cluster --assemblies assemblies/*.fasta --readset reads.fastq --out_dir trycycler_out
```
*   **Tip**: Check the `contigs.png` or `cluster_00X` folders. If a cluster has very few contigs compared to the number of input assemblies, it may be a spurious assembly artifact.

### 3. Reconciling Contigs
Standardize the contigs within a cluster. This step handles circularization, ensuring all contigs in the cluster start and end at the same position and are oriented the same way.
```bash
trycycler reconcile --reads reads.fastq --cluster_dir trycycler_out/cluster_001
```
*   **Expert Tip**: If reconciliation fails, it often means the input contigs are too divergent. You may need to manually remove "outlier" contigs from the cluster folder before re-running.

### 4. Multiple Sequence Alignment (MSA)
Perform a multiple sequence alignment of the reconciled contigs.
```bash
trycycler msa --cluster_dir trycycler_out/cluster_001
```
*   **Note**: This step is computationally intensive for large chromosomes.

### 5. Partitioning Reads
Assign your original long reads to the specific clusters they belong to.
```bash
trycycler partition --reads reads.fastq --cluster_dirs trycycler_out/cluster_*
```

### 6. Generating Consensus
Calculate the final consensus sequence for each cluster.
```bash
trycycler consensus --cluster_dir trycycler_out/cluster_001
```

## Expert Tips and Best Practices

*   **Input Diversity**: For the best results, use a mix of assemblers (e.g., 4x Flye, 4x Raven, 4x Miniasm/Minipolish). This prevents the consensus from inheriting the systematic biases of a single algorithm.
*   **Manual Curation**: Trycycler is designed for a "hands-on" approach. Always inspect the `cluster_00X` directories. If a cluster represents a plasmid that only appeared in 2 out of 12 assemblies, it is likely a low-confidence replicon.
*   **Post-Consensus Polishing**: Trycycler focuses on fixing medium-to-large scale structural errors. It does not fix small-scale basecalling errors (like homopolymer indels). Always follow Trycycler with a polisher like **Medaka** (long-read) and then **Polypolish** or **Pilon** (short-read) to achieve Q60+ accuracy.
*   **Handling Linear Replicons**: While Trycycler excels at circular replicons, it can handle linear ones. Ensure you use the `--linear` flag during the reconcile step if you know a replicon is not circular.
*   **Memory Management**: For large bacterial genomes or high-depth datasets, the `msa` and `partition` steps can be RAM-heavy. Ensure you have at least 32GB-64GB of RAM available for complex assemblies.

## Reference documentation
- [Trycycler Wiki](./references/github_com_rrwick_Trycycler_wiki.md)
- [Trycycler GitHub Repository](./references/github_com_rrwick_Trycycler.md)