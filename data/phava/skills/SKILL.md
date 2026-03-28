---
name: phava
description: PhaVa is a bioinformatics tool that detects and quantifies invertible DNA segments using long-read sequencing data. Use when user asks to identify phase-variable regions, locate inverted repeats, or calculate the ratio of inverted reads in a reference genome.
homepage: https://github.com/patrickwest/PhaVa
---


# phava

## Overview

PhaVa (Phase Variation) is a bioinformatics tool designed to detect invertible DNA segments using long-read sequencing data (e.g., Oxford Nanopore or PacBio). It works by identifying inverted repeats (IRs) in a reference genome and then quantifying the ratio of reads that align in the "inverted" orientation compared to the reference. This allows for the discovery of phase-variable regions that may be missed by traditional short-read assemblies.

## Core Workflows

### 1. Complete Variation Workflow
For most users, the `variation_wf` command is the most efficient way to run the entire pipeline (locate, create, and ratio) in a single step.

```bash
phava variation_wf -i reference.fasta -r long_reads.fastq -d output_directory
```

### 2. Step-by-Step Analysis
Use the modular commands if you have multiple read sets for the same reference, as the first two steps only need to be performed once.

1.  **Locate**: Find Inverted Repeats (IRs) in the reference.
    ```bash
    phava locate -i reference.fasta -d output_dir
    ```
2.  **Create**: Generate the inverted reference sequences.
    ```bash
    phava create -d output_dir
    ```
3.  **Ratio**: Map reads and calculate inversion frequencies.
    ```bash
    phava ratio -r sample_reads.fastq -d output_dir
    ```

### 3. Incorporating Gene Annotations
To determine if inversions affect specific genes (e.g., promoter flipping or intragenic inversions), provide a GFF file during the `create` or `variation_wf` step.

```bash
phava variation_wf -i ref.fa -r reads.fq --genesFormat gff --genes annotation.gff -d output_dir
```

## Expert Tips and Best Practices

*   **Filtering Results**: PhaVa reports any region with at least 1 inverted read. For high-confidence calls, manually filter the output TSV for regions with at least **3 reverse reads** and a **minimum of 3% reverse orientation**.
*   **Output Directory**: Always use the same `-d` directory for a single project. PhaVa relies on the internal structure of this directory to pass data between steps.
*   **Intragenic Inversions**: If a gene annotation is provided, PhaVa (v0.2.2+) can predict the functional effect of inversions occurring within gene boundaries.
*   **Clustering**: If the output contains many redundant IRs, use the `cluster` command to group them based on flanking and internal sequence similarity.
*   **Verification**: Use `phava test` after installation to ensure all dependencies (EMBOSS, minimap2, mmseqs2) are correctly configured in your environment.



## Subcommands

| Command | Description |
|---------|-------------|
| phava cluster | Cluster PhaVa database |
| phava create | Create PhaVa data structures |
| phava ratio | Run the pipeline with short reads instead of long reads |
| phava summarize | Directory where data and output are stored |
| phava variation_wf | PhaVa variation workflow |
| phava_locate | Directory where data and output are stored *** USE THE SAME WORK DIRECTORY FOR ALL PHAVA OPERATIONS *** |
| phava_test | PhaVa tool for locating, creating, and analyzing inverted repeats. |

## Reference documentation

- [PhaVa GitHub Repository](./references/github_com_patrickwest_PhaVa_blob_main_README.md)
- [PhaVa Changelog and Version History](./references/github_com_patrickwest_PhaVa_blob_main_changelog.txt.md)