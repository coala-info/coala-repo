---
name: tgv
description: The Terminal Genome Viewer (tgv) is a lightweight, command-line tool for navigating and visualizing genomic datasets using Vim-like keybindings. Use when user asks to browse genomes in the terminal, view BAM or VCF files, jump to specific genes or coordinates, or access remote genomic data from S3 buckets.
homepage: https://github.com/zeqianli/tgv
---

# tgv

## Overview
The Terminal Genome Viewer (tgv) provides a lightweight alternative to GUI-based browsers like IGV. It is designed for speed and efficiency, utilizing Vim-like keybindings to navigate through large genomic datasets. It supports local and remote files (including S3 buckets) and allows for rapid jumping between genes, exons, and specific chromosomal positions.

## Core Usage Patterns

### Basic Navigation
*   **Browse Human Genome (Online):** `tgv`
*   **Browse Specific Genome:** `tgv -g <genome_name>` (e.g., `tgv -g cat`)
*   **List Available Genomes:** `tgv list` or `tgv list --more`
*   **View Local Alignments:** `tgv sorted.bam`
*   **View Multiple Tracks:** `tgv sorted.bam -v variants.vcf -b intervals.bed`
*   **Remote S3 Access:** `tgv s3://bucket/file.bam -g hg19 -r TP53`

### In-App Controls (Normal Mode)
*   **Movement:** `h`/`j`/`k`/`l` (Left/Down/Up/Right)
*   **Fast Scroll:** `y` (Fast Left), `p` (Fast Right)
*   **Zooming:** `z` (Zoom In), `o` (Zoom Out)
*   **Genomic Jumps:**
    *   `W` / `B`: Next / Previous Gene
    *   `w` / `b`: Next / Previous Exon
*   **Command Mode:**
    *   `:q`: Quit
    *   `:ls`: Switch Chromosomes
    *   `:<gene_name>`: Jump to gene (e.g., `:TP53`)
    *   `:<chr>:<pos>`: Jump to coordinate (e.g., `:1:123456`)
*   **Multipliers:** Prefix movements with numbers (e.g., `20B` to move left by 20 genes).

## Expert Tips & Best Practices

### Performance Optimization
*   **Local Caching:** For frequently used genomes, download a local cache to significantly increase rendering speed:
    `tgv download hg38`
*   **Indexing:** Ensure all BAM, VCF, and BED files are properly indexed (`.bai`, `.tbi`) before opening. TGV relies on these indices for fast random access.
*   **No-Reference Mode:** If working with a non-standard assembly or a BAM without a matching reference in TGV, use the `--no-reference` flag:
    `tgv sample.bam -r 1:500 --no-reference`

### Remote Workflows
*   **SSH Sessions:** TGV is ideal for SSH. If the UI flickers, ensure your terminal emulator supports high-speed rendering (like Alacritty or Kitty) and that your `TERM` environment variable is set correctly (e.g., `xterm-256color`).
*   **Mouse Support:** TGV supports mouse interactions for scrolling and selection; ensure your terminal protocol allows mouse reporting if you prefer it over Vim keys.



## Subcommands

| Command | Description |
|---------|-------------|
| tgv download | Download command |
| tgv_list | Browse a genome: tgv -g <genome> (e.g. tgv -g rat) |

## Reference documentation
- [GitHub Repository Overview](./references/github_com_zeqianli_tgv.md)
- [Installation Guide](./references/github_com_zeqianli_tgv_wiki_Installation.md)
- [Usage and Keybindings](./references/github_com_zeqianli_tgv_wiki_Usage.md)