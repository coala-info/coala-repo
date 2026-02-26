---
name: bracken
description: Bracken is a statistical tool that reestimates taxonomic abundance from Kraken classification results to provide more accurate quantification of species or other taxonomic levels. Use when user asks to estimate taxonomic abundance, redistribute reads from higher-level clades to species, or generate precise metagenomic quantification from Kraken reports.
homepage: https://github.com/jenniferlu717/Bracken
---


# bracken

## Overview

Bracken (Bayesian Reestimation of Abundance with KrakEN) is a statistical tool designed to improve the accuracy of metagenomic abundance estimates. While Kraken classifies individual reads to the lowest possible taxonomic node (often resulting in many reads assigned to higher-level clades like Genus or Family), Bracken uses these classifications to estimate the true distribution of species in a sample. It is essential for researchers who need precise quantification of taxa rather than just a list of identified reads.

## Core Workflow

### 1. Database Preparation
Before running abundance estimation, you must generate a Bracken-specific distribution file for your Kraken database based on your expected read length.

```bash
bracken-build -d ${KRAKEN_DB} -t ${THREADS} -k ${KMER_LEN} -l ${READ_LEN}
```

*   **-d**: Path to the built Kraken/Kraken2 database.
*   **-t**: Number of threads (10-20 recommended for speed).
*   **-k**: K-mer length (Default: 35 for Kraken 2, 31 for Kraken 1).
*   **-l**: The read length of your sequencing data (e.g., 100, 150).

### 2. Generate Kraken Report
Bracken requires a standard Kraken report file (`.kreport`) as input.

```bash
# For Kraken 2
kraken2 --db ${KRAKEN_DB} --threads ${THREADS} --report ${SAMPLE}.kreport ${SAMPLE}.fq > ${SAMPLE}.kraken
```

### 3. Run Bracken Abundance Estimation
Execute the reestimation script on the generated report.

```bash
bracken -d ${KRAKEN_DB} -i ${SAMPLE}.kreport -o ${SAMPLE}.bracken -r ${READ_LEN} -l ${LEVEL} -t ${THRESHOLD}
```

*   **-i**: The input Kraken report file.
*   **-o**: The output Bracken file.
*   **-r**: The read length (must match a length used in `bracken-build`).
*   **-l**: The taxonomic level for estimation (Default: 'S' for Species. Options: K, P, C, O, F, G, S).
*   **-t**: Threshold; species with fewer than this many assigned reads will not be used for estimation (Default: 10).

## Expert Tips and Best Practices

*   **Read Length Sensitivity**: Bracken is highly sensitive to read length. If your sample has variable read lengths (e.g., after heavy trimming), choose the average read length or the length that represents the majority of your data.
*   **Multiple Read Lengths**: You can run `bracken-build` multiple times on the same database folder for different read lengths (e.g., 50, 100, 150). It will generate separate `.kmer_distrib` files without overwriting the main database.
*   **Taxonomic Levels**: While Species ('S') is the most common target, you can estimate at the Genus ('G') or Family ('F') level. Note that Bracken only redistributes reads from higher levels *down* to your target level; it does not move reads *up* from lower levels.
*   **Kraken Compatibility**: Bracken requires the default report format from Kraken/Kraken2. It is **not** compatible with "mpa-style" reports.
*   **Memory Management**: The `bracken-build` step is memory-intensive. Ensure your environment has sufficient RAM (similar to what was required to build the original Kraken database).

## Reference documentation
- [Bracken Overview](./references/anaconda_org_channels_bioconda_packages_bracken_overview.md)
- [Bracken GitHub Documentation](./references/github_com_jenniferlu717_Bracken.md)