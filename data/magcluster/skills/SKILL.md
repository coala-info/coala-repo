---
name: magcluster
description: MagCluster is a bioinformatics pipeline designed to identify, annotate, and visualize magnetosome gene clusters in genomic sequences. Use when user asks to annotate genomes with magnetosome protein databases, screen for magnetosome gene clusters using physical proximity logic, or visualize gene cluster alignments.
homepage: https://github.com/runjiaji/magcluster
---


# magcluster

## Overview

MagCluster is a specialized bioinformatics pipeline designed to streamline the discovery of magnetosome gene clusters. It addresses the difficulty of identifying these clusters by combining sequence identity with physical proximity on the chromosome. The tool automates the workflow from raw genome sequences to annotated GenBank files and comparative visualizations, leveraging a mandatory magnetosome protein database for high-accuracy annotation.

## Installation and Setup

MagCluster is primarily supported on Linux and macOS. For Windows users, WSL is required.

```bash
# Recommended: Installation via Bioconda
conda create -n magcluster
conda activate magcluster
conda install -c conda-forge -c bioconda magcluster
```

## Command Line Usage

MagCluster operates through three primary modules: `prokka`, `mgc_screen`, and `clinker`.

### 1. Genome Annotation (`prokka`)
Annotates genomes using a specialized magnetosome protein database.

*   **Input**: Multiple genome files (.fasta, .fna, .fa) or a directory containing genomes.
*   **Best Practice**: Use an e-value of `1e-05` for MGC annotation.

```bash
# Annotate multiple genomes in a folder
magcluster prokka --evalue 1e-05 ./MTB_genomes_folder

# Annotate specific files
magcluster prokka --evalue 1e-05 genome1.fasta genome2.fasta
```

### 2. MGC Screening (`mgc_screen`)
Retrieves MGC-containing contigs from GenBank files generated in the previous step. It uses a text-mining strategy (keyword: "magnetosome") and physical clustering logic.

*   **Key Parameters**:
    *   `-l` / `--contiglength`: Minimum contig length (default: 2000 bp).
    *   `-win` / `--windowsize`: Screening window size (default: 10,000 bp).
    *   `-th` / `--threshold`: Minimum number of magnetosome genes in a window (default: 3).

```bash
# Screen GenBank files with custom thresholds
magcluster mgc_screen -l 5000 -win 15000 -th 4 -o ./output_mgc genome1.gbk genome2.gbk
```

### 3. Alignment and Visualization (`clinker`)
Uses the `clinker` tool to align and visualize the identified putative MGCs.

```bash
# Visualize identified clusters
magcluster clinker [options]
```

## Expert Tips

*   **Naming Consistency**: By default, MagCluster uses the genome filename as the output folder name, file prefix, and GenBank locus tag to prevent confusion during batch processing.
*   **Standardization**: The `--compliant` flag is enabled by default in the `prokka` module to ensure the resulting GenBank files meet standard specifications for downstream tools.
*   **Performance**: If Conda environment resolution is slow, use `mamba` as a faster alternative for installation.



## Subcommands

| Command | Description |
|---------|-------------|
| clinker | magcluster clinker |
| mgc_screen | Analyzes .gbk/.gbf files to identify potential MGCs based on magnetosome gene content within specified windows. |
| prokka | Prokka: rapid prokaryotic genome annotation |

## Reference documentation
- [MagCluster GitHub README](./references/github_com_RunJiaJi_MagCluster_blob_main_README.md)
- [MagCluster Repository Overview](./references/github_com_RunJiaJi_MagCluster.md)