---
name: sashimi-py
description: `trackplot` is a versatile Python utility for visualizing genomic data across various sequencing platforms.
homepage: https://github.com/ygidtu/sashimi.py
---

# sashimi-py

## Overview
`trackplot` is a versatile Python utility for visualizing genomic data across various sequencing platforms. It transforms complex NGS datasets—including RNA-seq, DNA-seq, and single-cell RNA-seq—into interpretable sashimi plots, heatmaps, and coverage diagrams. This skill provides the necessary command-line patterns to generate these visualizations, handle multi-track configurations, and customize aesthetic elements like focus regions and normalization.

## Core CLI Usage

The primary command for this tool is `trackplot`.

### Basic Plotting Syntax
To generate a standard sashimi plot, you must define the genomic region, the reference annotation, and the data sources.

```bash
trackplot \
  -e <chrom:start-end:strand> \
  -r <reference.gtf.gz> \
  --density <density_list.tsv> \
  -o <output.pdf>
```

### Input File Formats
*   **Reference (-r):** GTF or GFF3 files (preferably indexed with tabix).
*   **Density (--density):** A TSV file listing paths to BAM or BigWig files.
*   **Interval (--interval):** BED files for genomic intervals.
*   **Heatmap (--heatmap):** For Hi-C or matrix-style density plots.
*   **IGV (--igv):** For IGV-like track visualizations.

## Advanced Visualization Features

### Highlighting Specific Regions
Use `--focus` to highlight specific coordinates and `--stroke` to add colored borders to specific genomic windows.
*   `--focus 1272656-1272656:1275656-1277656`
*   `--stroke 1275656-1277656:1277856-1278656@blue`

### RNA-Seq & Splicing
*   **Show Junctions:** Use `--show-junction-num` to display the number of reads supporting a splice junction.
*   **Normalization:** Use `--normalize-format cpm` to normalize coverage by Counts Per Million.
*   **Protein Domains:** Add `--domain` to visualize protein domains based on the provided gene ID in the GTF.

### Single-Cell Analysis
When working with single-cell RNA/ATAC-seq:
*   **Barcode Demultiplexing:** Use `--barcode <barcode_list.tsv>` to group coverage by cell populations.
*   **UMI Handling:** Use `--remove-duplicate-umi` to ensure accurate quantification in scRNA-seq tracks.

## Expert Tips
*   **Performance:** For large datasets, use the `-p <threads>` flag to enable multi-processing. If you encounter segment faults during multi-processing, revert to `-p 1`.
*   **Output Quality:** Set `--dpi 300` for publication-quality images. Supported formats include PDF, PNG, and SVG.
*   **Coordinate Formatting:** Ensure the region string (`-e`) matches the chromosome naming convention in your BAM/GTF files (e.g., "chr1" vs "1").
*   **Web Interface:** If a GUI is preferred for exploration, `trackplot` can host a local server using `trackplot --start-server --plots ./plots_dir`.

## Reference documentation
- [trackplot GitHub Repository](./references/github_com_ygidtu_trackplot.md)