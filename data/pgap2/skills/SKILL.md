---
name: pgap2
description: PGAP2 is a high-performance toolkit designed for the rapid construction and analysis of prokaryotic pan-genomes using a fine-grained feature network. Use when user asks to perform quality control on genomic data, construct pan-genome maps, identify orthologous groups, build phylogenetic trees, or conduct population clustering and evolutionary statistics.
homepage: https://github.com/bucongfan/PGAP2
---


# pgap2

## Overview
PGAP2 (Pan-Genome Analysis Pipeline 2) is a high-performance toolkit designed for the rapid construction and analysis of prokaryotic pan-genomes. It utilizes a Fine-Grained Feature Network to achieve significant speedups over traditional pipelines, capable of processing 1,000 genomes in approximately 20 minutes. The tool is modular, supporting initial quality control, core/pan-genome mapping, and various post-processing tasks such as phylogenetic tree construction, population clustering, and evolutionary statistics.

## Core Workflows

### 1. Preprocessing and Quality Control
Before running the main pipeline, use the `prep` module to perform quality checks and visualize input data.
```bash
pgap2 prep -i input_dir/ -o output_dir/
```
*   **Input**: Supports mixed formats (GFF, GBFF, FASTA).
*   **Output**: Generates an interactive HTML report and vector figures.
*   **Tip**: This step creates a pickle file that allows for quick restarts of the calculation.

### 2. Main Pan-Genome Construction
The `main` module identifies orthologous groups and constructs the pan-genome map.
```bash
pgap2 main -i input_dir/ -o output_dir/
```
*   **Input Formats**: 
    *   Prokka-style GFF files.
    *   GFF + FASTA (separate files).
    *   GenBank flat files (GBFF).
    *   Raw FASTA (requires `--annot` flag to trigger internal annotation).
*   **Key Options**:
    *   `--retrieve`: Use to retrieve missing gene loci (requires `miniprot` and `seqtk`).
    *   `--reannot`: Re-annotate genomes using `prodigal`.
    *   `--debug`: Enable for detailed logging during troubleshooting.

### 3. Postprocessing and Downstream Analysis
The `post` module contains several submodules. The input directory for these submodules should be the **output directory** of the `main` module.
```bash
pgap2 post [submodule] -i main_output_dir/ -o post_output_dir/
```

**Common Submodules:**
*   `profile`: Statistical analysis of the pan-genome. Can also be run independently using a PAV file: `pgap2 post profile --pav your_pav_file -o output_dir/`.
*   `singletree`: Constructs a phylogenetic tree based on single-copy core genes.
*   `baps`: Performs population clustering (requires `fastbaps`).
*   `tajima`: Conducts Tajima's D test for evolutionary analysis.

## Expert Tips and Best Practices
*   **Installation**: Use `mamba` for faster dependency resolution: `mamba install -c bioconda pgap2`.
*   **Mixed Inputs**: You can mix different file formats (e.g., some GBFF and some GFF) in the same input directory; PGAP2 automatically recognizes them by suffix.
*   **Performance**: For large datasets (>1000 genomes), PGAP2 automatically organizes subdirectories to maintain filesystem performance.
*   **Visualization**: Ensure `Rscript` is in your PATH and the necessary R libraries (`ggpubr`, `dplyr`, `patchwork`) are installed to generate the interactive HTML reports.
*   **Memory Management**: If running on low-resource environments, consider using `MMseqs2` as the clustering method over `CD-HIT` for better memory efficiency.

## Reference documentation
- [PGAP2 GitHub Repository](./references/github_com_bucongfan_PGAP2.md)
- [PGAP2 Wiki](./references/github_com_bucongfan_PGAP2_wiki.md)
- [Bioconda PGAP2 Overview](./references/anaconda_org_channels_bioconda_packages_pgap2_overview.md)