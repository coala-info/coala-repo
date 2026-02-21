---
name: metawrap-mg
description: MetaWRAP is a modular wrapper suite designed to streamline the transition from raw metagenomic reads to refined, annotated metagenome-assembled genomes (MAGs).
homepage: https://github.com/bxlab/metaWRAP
---

# metawrap-mg

## Overview

MetaWRAP is a modular wrapper suite designed to streamline the transition from raw metagenomic reads to refined, annotated metagenome-assembled genomes (MAGs). It simplifies the complex metagenomic workflow by providing a consistent interface for various industry-standard tools. Its primary strength lies in its "Bin Refinement" module, which consolidates multiple binning predictions into a superior set of bins, and its "Reassembly" module, which improves the N50 and completion of extracted bins by re-aligning reads and performing targeted assembly.

## Core Workflow and CLI Patterns

MetaWRAP is executed using the general syntax: `metawrap [module] [parameters]`.

### 1. Pre-processing and Assembly
*   **Read QC**: Trims adapters and removes host contamination (e.g., human reads).
    `metawrap read_qc -1 R1.fastq -2 R2.fastq -t 16 -o output_dir`
*   **Assembly**: Supports `metaspades` or `megahit`.
    `metawrap assembly -m megahit -1 R1.fastq -2 R2.fastq -t 24 -o assembly_dir`

### 2. Binning and Refinement
*   **Initial Binning**: Run multiple binners (MetaBAT2, MaxBin2, CONCOCT) simultaneously to provide input for refinement.
    `metawrap binning -a assembly.fasta -o binning_dir --metabat2 --maxbin2 --concoct R1.fastq R2.fastq`
*   **Bin Refinement**: The "killer feature" of MetaWRAP. It compares bin sets and picks the best version of each genome.
    `metawrap bin_refinement -o refined_dir -A folder_binset1 -B folder_binset2 -C folder_binset3 -c 70 -x 10`
    *   `-c`: Minimum completion percentage (default 70).
    *   `-x`: Maximum contamination percentage (default 10).

### 3. Bin Improvement and Analysis
*   **Reassemble Bins**: Drastically improves N50 and completion by reassembling reads belonging to specific bins using a non-metagenomic assembler.
    `metawrap reassemble_bins -o reassembled_dir -1 R1.fastq -2 R2.fastq -b refined_bins/ -t 16`
*   **Quantify Bins**: Estimates the abundance of bins across different samples.
    `metawrap quant_bins -b refined_bins/ -a assembly.fasta -o quant_dir R1.fastq R2.fastq`
*   **Classification**: Provides conservative taxonomic assignments for bins.
    `metawrap classify_bins -b refined_bins/ -o classification_dir -t 16`

## Expert Tips and Best Practices

*   **Hardware Requirements**: Metagenomic assembly and Kraken profiling are memory-intensive. Ensure at least 64GB of RAM and 8+ cores for standard datasets.
*   **Database Configuration**: Before running, ensure the `config-metawrap` file in the MetaWRAP `bin/` directory is correctly edited to point to your local databases (CheckM, Kraken, NCBI, etc.).
*   **Bin Refinement Input**: You are not limited to the binners wrapped in MetaWRAP. You can provide any set of bins (from different tools or different parameters) to the `bin_refinement` module to find the optimal consensus.
*   **Mamba over Conda**: Use `mamba` for installation and environment management to avoid the long dependency resolution times common with the `bioconda` and `ursky` channels.
*   **Python Version**: MetaWRAP traditionally relies on Python 2.7 for several core components; ensure you are running within a dedicated `metawrap-env` to avoid system-wide conflicts.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [Bioconda metawrap-mg Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-mg_overview.md)