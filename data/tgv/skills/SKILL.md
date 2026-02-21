---
name: tgv
description: The Terminal Genome Viewer (tgv) is a lightweight, high-performance tool designed for genomic data exploration within a terminal interface.
homepage: https://github.com/zeqianli/tgv
---

# tgv

## Overview

The Terminal Genome Viewer (tgv) is a lightweight, high-performance tool designed for genomic data exploration within a terminal interface. Built in Rust and utilizing the Ratatui library, it provides a "blazing fast" experience with navigation inspired by Vim. It allows researchers to view local or remote alignment files, jump to specific genes or loci, and manage reference genomes without leaving the command line.

## Installation

Install tgv using one of the following package managers:

- **Cargo**: `cargo install tgv --locked`
- **Homebrew**: `brew install zeqianli/tgv/tgv`
- **Conda**: `conda install bioconda::tgv`

## Core CLI Patterns

### Basic Browsing
- **Default (hg38)**: Simply run `tgv` to browse the human genome (requires internet for initial fetch).
- **Specific Genome**: Use `tgv -g <genome_name>` (e.g., `tgv -g cat`).
- **List Available Genomes**: Run `tgv list` or `tgv list --more` to see supported reference genomes.

### Visualizing Alignments
- **Local BAM**: `tgv sorted.bam`
- **With Variants and Intervals**: `tgv sorted.bam -v variants.vcf -b intervals.bed`
- **Remote Files**: `tgv s3://my-bucket/sorted.bam -g hg19`
- **No Reference Mode**: `tgv non_human.bam --no-reference -r 1:100-200`

### Navigation and Jump
- **Start at Region**: `tgv -r 1:2345`
- **Start at Gene**: `tgv -r TP53`

## Navigation Shortcuts (Vim-motion)

| Key | Action |
|---|---|
| **h / l** | Move left / right |
| **j / k** | Move down / up (tracks) |
| **y / p** | Faster move left / right |
| **W / B** | Jump to next / previous gene |
| **w / b** | Jump to next / previous exon |
| **z / o** | Zoom in / out |
| **_number_ + _key_** | Repeat movement (e.g., `20B` moves left by 20 genes) |

## Command Mode (:)

Press `:` to enter command mode for specific actions:
- `:q` : Quit the application.
- `:ls` : Open the chromosome selection menu.
- `:<gene_name>` : Jump to a specific gene (e.g., `:TP53`).
- `:<chr>:<pos>` : Jump to a specific coordinate (e.g., `:1:123456`).

## Expert Tips

- **Performance Caching**: If you use a specific reference genome frequently, download it locally to eliminate network latency: `tgv download hg38`. Caches are stored in `~/.tgv` by default.
- **Remote Indexing**: When viewing remote BAM files, ensure the index file (.bai) is also accessible at the same remote location.
- **Mouse Support**: tgv supports mouse interactions for scrolling and selection within the terminal UI.
- **Normal Mode**: If the interface seems unresponsive to commands, press `Esc` to ensure you are in "Normal Mode" before typing commands or motions.

## Reference documentation
- [Main Repository and Usage](./references/github_com_zeqianli_tgv.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tgv_overview.md)