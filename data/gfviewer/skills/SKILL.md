---
name: gfviewer
description: gfviewer generates automated genomic visualization plots from tabular gene family data and sequence length information. Use when user asks to visualize gene family distributions, identify gene clusters or tandem duplications, and plot chromosome maps with centromeric regions.
homepage: https://github.com/sakshar/GFViewer
---


# gfviewer

## Overview
The `gfviewer` skill enables the automated generation of genomic visualization plots. It transforms tabular gene family data and sequence length information into Matplotlib-based diagrams. This tool is particularly useful for identifying gene clusters, tandem duplications, and the spatial distribution of specific gene families across different chromosomes. It supports custom color mapping, pagination for large genomes, and the inclusion of centromeric regions to provide a comprehensive genomic context.

## Input Requirements
To use `gfviewer` effectively, ensure the following input files are correctly formatted:

### 1. Gene-family Data File (`-d`)
Supported formats: `.xlsx`, `.csv`, `.tsv`.
The header row must strictly follow this naming convention:
`gene_id`, `gene_family`, `chromosome`, `start`, `end`, `strand`

*   **Centromeres**: To plot centromeres, add a row where `gene_family` is "centromere" and `strand` is "0".

### 2. Genome/Chromosome Lengths File (`-g`)
*   **FASTA**: `.fasta`, `.fna`, or `.fa` files.
*   **Text**: A `.txt` file with `seq_id,seq_length` per line (e.g., `chr_1,1500000`).

### 3. Color Map File (`-c`)
Optional text file to define specific colors for gene families.
*   **Predefined Palette**: `gf_id,color_code` (e.g., `family_1,1` for red, `family_2,2` for green).
*   **Custom RGB**: `gf_id,R,G,B` where values are between 0 and 1 (e.g., `family_1,0.5,0.2,0.8`).

## Common CLI Patterns

### Basic Visualization
Generate a standard plot with default settings:
```bash
gfviewer -d data.csv -g genome.fasta -o results_dir
```

### Publication-Ready Single PDF
To create a single, concatenated PDF with one chromosome per page and legends included on every page:
```bash
gfviewer -d data.csv -g lengths.txt -o output -p 1 -lpp -conc
```

### Visualizing Centromeres and Custom Colors
Include centromere markers and apply a specific color map:
```bash
gfviewer -d data.tsv -g genome.fa -o output -c colors.txt -cen
```

## Expert Tips and Best Practices
*   **Legend Management**: If you have many gene families, use `-r` to increase the number of rows in the legend to prevent overlapping or cutoff text.
*   **Telomere Adjustment**: The default telomere length is 10,000 bp. For very small genomes or high-resolution plots, adjust this using `-t` to ensure the chromosome ends are visually distinct.
*   **Output Structure**: `gfviewer` creates a `plot/` subdirectory for images and a `tmp/` directory for intermediate GenBank files. Always specify a clean `--output_directory` to avoid file conflicts.
*   **Memory Efficiency**: For genomes with many chromosomes, avoid plotting all on one page. Use `-p` (default is 3) to maintain readability and prevent Matplotlib memory errors.

## Reference documentation
- [GFViewer GitHub Repository](./references/github_com_sakshar_GFViewer.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gfviewer_overview.md)