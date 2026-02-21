---
name: magcluster
description: MagCluster is a specialized bioinformatics pipeline designed to streamline the discovery and analysis of magnetosome gene clusters.
homepage: https://github.com/runjiaji/magcluster
---

# magcluster

## Overview

MagCluster is a specialized bioinformatics pipeline designed to streamline the discovery and analysis of magnetosome gene clusters. Unlike general-purpose tools that rely solely on sequence identity, MagCluster leverages the biological reality that magnetosome genes are physically clustered on the chromosome. It provides a three-stage workflow: automated annotation using a curated magnetosome protein database, heuristic-based screening of GenBank files to isolate putative clusters, and interactive visualization for comparative genomics.

## Core Workflow and CLI Patterns

### 1. Genome Annotation (prokka)
The `prokka` module performs batch annotation of genome files. It uses a mandatory internal reference file of magnetosome proteins to ensure consistent naming.

*   **Standard Usage**:
    ```bash
    magcluster prokka --evalue 1e-05 ./genomes_folder
    ```
*   **Best Practices**:
    *   **E-value**: Always set `--evalue 1e-05` as recommended by the developers for optimal sensitivity/specificity balance in MGC detection.
    *   **Input**: You can provide individual `.fasta`, `.fna`, or `.fa` files, or a directory containing them.
    *   **Output**: By default, the tool uses the genome filename for the output directory, prefix, and locus tags to maintain organization during batch processing.

### 2. MGC Screening (mgc_screen)
This module identifies putative clusters by searching for the keyword "magnetosome" in the product names of the GenBank files generated in the previous step.

*   **Standard Usage**:
    ```bash
    magcluster mgc_screen --threshold 3 --contiglength 2000 --windowsize 10000 ./gbk_folder
    ```
*   **Key Parameters**:
    *   `-l, --contiglength`: Minimum length of contigs to consider (Default: 2000 bp). Increase this if working with high-quality finished genomes to filter out small fragments.
    *   `-w, --windowsize`: The sliding window size for screening (Default: 10,000 bp).
    *   `-th, --threshold`: The minimum number of magnetosome genes required within the window to flag a cluster (Default: 3).
*   **Outputs**:
    *   A GenBank file containing only the putative MGC contigs.
    *   A CSV file summarizing all identified magnetosome protein sequences.

### 3. Alignment and Visualization (clinker)
MagCluster utilizes `clinker` to align identified MGCs and generate interactive figures.

*   **Standard Usage**:
    ```bash
    magcluster clinker -p MGC_comparison.html ./mgc_screen_results/*.gbk
    ```
*   **Expert Tip**: The `-p` flag is essential as it generates an interactive HTML page. This allows you to manually adjust the alignment, hide/show specific genes, and export publication-quality SVG files directly from the browser.

## Expert Tips and Troubleshooting

*   **Manual Validation**: Automated identification is efficient but not infallible. Always manually inspect the output GenBank files or the interactive visualization to confirm the biological relevance of the identified clusters.
*   **Environment Management**: If `conda` takes too long to solve the environment during installation, use `mamba` for significantly faster dependency resolution.
*   **Windows Support**: MagCluster does not natively support Windows. Use Windows Subsystem for Linux (WSL2) if a Linux environment is not available.
*   **Keyword Dependency**: Since `mgc_screen` relies on text-mining the keyword "magnetosome", ensure that the annotation step used the correct protein database (which is the default behavior of `magcluster prokka`).

## Reference documentation
- [MagCluster GitHub Repository](./references/github_com_runjiaji_magcluster.md)
- [MagCluster Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_magcluster_overview.md)