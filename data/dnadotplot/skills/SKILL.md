---
name: dnadotplot
description: dnadotplot generates dot plot alignments to visualize relationships and structural variations between DNA sequences. Use when user asks to visualize sequence alignments, identify structural variations like inversions or repeats, or generate dot plot images from FASTA files.
homepage: https://github.com/quadram-institute-bioscience/dnadotplot
metadata:
  docker_image: "quay.io/biocontainers/dnadotplot:0.1.4--hc1c3326_0"
---

# dnadotplot

## Overview
`dnadotplot` is a high-performance tool written in Rust that generates dot plot alignments to visualize the relationship between DNA sequences. It is particularly useful for identifying structural variations like inversions (via reverse complement matching), insertions, deletions, and repetitive elements. The tool supports direct image generation or a two-step matrix-to-render workflow for more flexible analysis.

## Command Line Usage

### Direct Plotting (FASTA to Image)
The `plot` command is the most common entry point for quick visualization.

*   **Self-alignment**: Compare a sequence against itself to find internal repeats or symmetry.
    ```bash
    dnadotplot plot -1 sequence.fa -o self_plot.png
    ```
*   **Pairwise Comparison**: Compare two different genomes or contigs.
    ```bash
    dnadotplot plot -1 genome_a.fa -2 genome_b.fa -o comparison.png
    ```
*   **Reverse Complement Matching**: Essential for identifying inversions.
    ```bash
    dnadotplot plot -1 genome_a.fa -2 genome_b.fa --revcompl -o comparison.png
    ```

### Matrix Workflow
For large sequences or iterative styling, use the `matrix` and `render` commands separately. This avoids recomputing the alignment when you only want to change the output format.

1.  **Generate Matrix**:
    ```bash
    dnadotplot matrix -1 seq1.fa -2 seq2.fa -o data.tsv -s 1000
    ```
2.  **Render Image**:
    ```bash
    dnadotplot render -i data.tsv -o final_plot.svg --svg
    ```

## Parameters and Tuning

*   **Image Resolution (`-s`, `--img-size`)**: 
    *   If > 1: Sets the absolute size in pixels (e.g., `-s 2000`).
    *   If < 1: Sets the size as a fraction of the sequence length (e.g., `-s 0.5`). Default is `0.3`.
*   **Sensitivity (`-w`, `--window`)**: Sets the window size for matching. Increasing this value reduces noise and highlights longer, more significant regions of homology. Default is `10`.
*   **Output Formats**:
    *   **PNG**: Best for large-scale genomic overviews. Uses grayscale (Black: match, White: no match, Gray: reverse complement match).
    *   **SVG**: Best for publications. Includes axes, labels, and color-coding (Red: forward match, Green: reverse complement).

## Expert Tips
*   **Publication Quality**: Always use the `.svg` extension or the `--svg` flag for final figures to ensure axes and labels are rendered correctly.
*   **Specific Sequences**: If your FASTA file contains multiple entries (e.g., a whole genome assembly), use `-f` (first name) and `-n` (second name) to target specific chromosomes or contigs.
*   **Memory Efficiency**: For very large genomes, the matrix TSV file can become quite large. Use the direct `plot` command if disk space is a concern.

## Reference documentation
- [dnadotplot - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dnadotplot_overview.md)
- [GitHub - quadram-institute-bioscience/dnadotplot](./references/github_com_quadram-institute-bioscience_dnadotplot.md)