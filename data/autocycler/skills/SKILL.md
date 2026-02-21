---
name: autocycler
description: Autocycler is a bioinformatics tool that automates the process of creating a "consensus" assembly for bacterial genomes.
homepage: https://github.com/rrwick/Autocycler
---

# autocycler

## Overview

Autocycler is a bioinformatics tool that automates the process of creating a "consensus" assembly for bacterial genomes. Rather than relying on a single assembler, it takes multiple candidate assemblies (generated from different tools or different subsets of long reads) and reconciles them. It uses a compacted De Bruijn graph approach to identify shared sequences, trim overlaps, and resolve structural ambiguities. This results in a more reliable, finished genome compared to using a single assembly run.

## Core Workflow

The Autocycler process typically follows a multi-step pipeline. While it can be run manually for fine-tuned control, the standard automated workflow involves:

### 1. Preparation and Subsampling
Before assembling, create multiple subsets of your long reads to provide the diversity needed for a consensus.
```bash
autocycler subsample --reads reads.fastq.gz --out_dir subsets/ --genome_size 5M
```

### 2. Generating Input Assemblies
Run various assemblers (e.g., Flye, Raven, Miniasm, Canu) on the subsets created in the previous step. Autocycler requires these "candidate" assemblies as input. 
*Note: Autocycler performs best when input assemblies are "complete" (one contig per replicon).*

### 3. Consensus Generation
The core logic is executed through a sequence of commands that process the candidate assemblies:

*   **Compress**: Consolidate all input assemblies into a single graph.
    ```bash
    autocycler compress --input assemblies/*.fasta --output compressed.gfa
    ```
*   **Cluster**: Group similar sequences (contigs) that represent the same replicon.
    ```bash
    autocycler cluster --input compressed.gfa --out_dir clusters/
    ```
*   **Trim**: Remove overlapping sequences at the ends of contigs to prepare for circularization.
    ```bash
    autocycler trim --cluster_dir clusters/
    ```
*   **Resolve**: Determine the best path through the graph for each replicon.
    ```bash
    autocycler resolve --cluster_dir clusters/
    ```
*   **Combine**: Generate the final consensus FASTA file.
    ```bash
    autocycler combine --cluster_dir clusters/ --output consensus.fasta
    ```

## Expert Tips and Best Practices

*   **The Helper Command**: For most users, `autocycler helper` is the most efficient way to manage the pipeline, as it can assist in generating the necessary commands or organizing the directory structure.
*   **Input Diversity**: The quality of the consensus depends on the diversity of the inputs. Using at least two different assembly algorithms (e.g., Flye and Raven) across multiple read subsets is highly recommended.
*   **Genome Size Estimation**: If the genome size is unknown, use `autocycler helper` with the `genome_size` sub-command to estimate it based on k-mer distribution before subsampling.
*   **Manual Intervention**: If the automated `resolve` step fails or produces warnings, you can inspect the cluster directories. Autocycler produces `.dot` files and `.gfa` files that can be visualized (e.g., in Bandage) to understand why a replicon didn't resolve cleanly.
*   **Linear vs. Circular**: By default, Autocycler tries to circularize contigs. If you are working with a linear replicon, ensure the contig headers are labeled appropriately or use the specific flags during the `resolve` step to prevent forced circularization.

## Reference documentation
- [Autocycler Wiki](./references/github_com_rrwick_Autocycler_wiki.md)
- [Autocycler GitHub Repository](./references/github_com_rrwick_Autocycler.md)