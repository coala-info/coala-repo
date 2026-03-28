---
name: intervene
description: Intervene automates the intersection and visualization of genomic interval data and gene lists to generate publication-quality figures. Use when user asks to create Venn diagrams, generate UpSet plots, or perform pairwise intersection heatmaps for genomic features and gene sets.
homepage: https://github.com/asntech/intervene
---

# intervene

## Overview

Intervene is a specialized bioinformatics tool designed to automate the intersection and visualization of genomic interval data and gene lists. It bridges the gap between raw intersection data (calculated via BedTools) and publication-quality figures (generated via R). Use this skill to compare ChIP-seq peaks, differentially expressed gene sets, or any other genomic features where understanding the overlap between multiple conditions or replicates is critical.

## Core Workflows

### 1. Venn Diagrams (Up to 6-way)
Use the `venn` subcommand for a classic visualization of overlaps between 2 to 6 sets.

*   **Basic Usage**: `intervene venn -i path/to/files/*.bed`
*   **Custom Labels**: Use `--names` to provide clear labels for the plot.
    *   `intervene venn -i file1.bed file2.bed file3.bed --names Treatment,Control,WildType`
*   **Output Control**: Specify a directory with `--output`.

### 2. UpSet Plots
Use the `upset` subcommand when dealing with more than 3-4 sets, as Venn diagrams become difficult to read. UpSet plots provide a scalable matrix-based visualization of intersections.

*   **Basic Usage**: `intervene upset -i path/to/files/*.bed`
*   **Project Naming**: Use `--project` to prefix output files.
*   **Gene Lists**: If working with text files containing gene IDs instead of genomic regions, Intervene handles them automatically based on file extension or content.

### 3. Pairwise Intersections and Heatmaps
Use the `pairwise` subcommand to perform an "all-vs-all" comparison of N genomic region sets. This generates a heatmap showing the degree of overlap.

*   **Basic Usage**: `intervene pairwise -i path/to/files/*.bed`
*   **Metric Selection**: Use `--type` to choose the intersection metric (e.g., `count`, `frac`, `jaccard`).
    *   `intervene pairwise -i *.bed --type jaccard`

## Expert Tips and Best Practices

*   **Verification**: Always run `intervene --test` (or `intervene venn --test`, etc.) after installation to ensure that Python dependencies, BedTools, and R packages (UpSetR, corrplot) are correctly configured in your environment.
*   **Input Formats**: While BED is standard, Intervene supports GTF and GFF. Ensure your files are tab-delimited and follow standard genomic coordinate formats.
*   **Labeling**: If your filenames are long or cryptic, always use the `--names` flag with a comma-separated list to ensure the resulting figures are interpretable.
*   **Plot Quality**: Intervene uses the Cairo R package by default to generate high-quality vector (PDF) and bitmap (PNG) figures. If you only need the raw intersection data without the plots, use the `--scriptonly` flag to generate the R scripts without executing them.
*   **Genomic vs. List**: If your input files are simple lists of IDs (one per line), Intervene treats them as "list sets." If they have at least three columns (Chr, Start, End), it treats them as "genomic regions."



## Subcommands

| Command | Description |
|---------|-------------|
| intervene pairwise | Pairwise intersection and heatmap of N genomic region sets in (BED/GTF/GFF) format or list/name sets. |
| intervene upset | Create UpSet diagram after intersection of genomic regions in (BED/GTF/GFF) or list sets. |
| intervene venn | Create Venn diagram upto 6-way after intersection of genomic regions in (BED/GTF/GFF) format or list sets. |

## Reference documentation
- [Intervene GitHub README](./references/github_com_asntech_intervene_blob_master_README.rst.md)
- [Intervene Documentation - How to Use](./references/intervene_readthedocs_io_en_latest_how_to_use.html.md)