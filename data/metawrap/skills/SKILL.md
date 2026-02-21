---
name: metawrap
description: MetaWRAP is a modular wrapper suite designed to streamline the complex workflow of genome-resolved metagenomics.
homepage: https://github.com/bxlab/metaWRAP
---

# metawrap

## Overview

MetaWRAP is a modular wrapper suite designed to streamline the complex workflow of genome-resolved metagenomics. It simplifies the transition from raw sequencing reads to refined, annotated environmental genomes. Its primary strength lies in its "Bin Refinement" and "Reassembly" modules, which consolidate results from multiple binning tools (like MetaBAT2, MaxBin2, and CONCOCT) to produce genomic bins with higher completion and lower contamination than individual tools can achieve alone.

## Core Modules and CLI Patterns

MetaWRAP is executed using the syntax `metawrap [module] [options]`.

### 1. Pre-processing and Assembly
*   **Read QC**: Trim adapters and remove host (e.g., human) contamination.
    `metawrap read_qc -1 reads_1.fastq -2 reads_2.fastq -t 16 -x host_index -o output_dir`
*   **Assembly**: Assemble reads using metaSPAdes or MegaHit.
    `metawrap assembly -1 reads_1.fastq -2 reads_2.fastq -m 64 -t 16 --megahit -o assembly_dir`
*   **Taxonomic Profiling**: Run Kraken or Kraken2 on reads or contigs.
    `metawrap kraken2 -t 16 -o kraken_dir -d kraken_db assembly.fasta`

### 2. Binning and Refinement
*   **Initial Binning**: Run multiple binners simultaneously.
    `metawrap binning -a assembly.fasta -o binning_dir --metabat2 --maxbin2 --concoct reads_*.fastq`
*   **Bin Refinement**: Consolidate multiple bin sets into a superior set. This is the most critical module for high-quality results.
    `metawrap bin_refinement -o refined_dir -A metabat2_bins/ -B maxbin2_bins/ -C concoct_bins/ -c 70 -x 10`
    *Note: `-c` sets minimum completion %; `-x` sets maximum contamination %.*
*   **Reassemble Bins**: Improve N50 and completion by reassembling reads belonging to specific bins.
    `metawrap reassemble_bins -o reassembled_dir -1 reads_1.fastq -2 reads_2.fastq -b refined_bins/ -t 16`

### 3. Downstream Analysis
*   **Quantification**: Estimate bin abundance across samples.
    `metawrap quant_bins -b refined_bins/ -o quant_dir -a assembly.fasta reads_*.fastq`
*   **Annotation**: Functionally annotate genes within a bin set using Prokka.
    `metawrap annotate_bins -o fun_annotate -b refined_bins/ -t 16`
*   **Classification**: Assign taxonomy to bins.
    `metawrap classify_bins -b refined_bins/ -o taxonomy_dir -t 16`

## Expert Tips and Best Practices

*   **Resource Management**: MetaWRAP is resource-intensive. Ensure at least 8 cores and 64GB+ RAM, especially for the `assembly` and `kraken` modules.
*   **Database Configuration**: Before running, ensure the `config-metawrap` file (located in the `bin/` directory of the installation) is correctly edited to point to your local databases (CheckM, Kraken, NCBI, etc.).
*   **Bin Refinement Flexibility**: The `bin_refinement` module is standalone. You can feed it bins generated outside of MetaWRAP as long as they are in FASTA format.
*   **Mamba Preference**: Use `mamba` instead of `conda` for installation and dependency management to significantly speed up the environment setup.
*   **Contig Naming**: Ensure contig names in your assembly FASTA do not contain special characters or spaces, as this can break downstream tools like CheckM.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [MetaWRAP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metawrap_overview.md)