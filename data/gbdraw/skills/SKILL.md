---
name: gbdraw
description: gbdraw visualizes genomic data by creating circular and linear diagrams that incorporate feature maps, statistical tracks, and synteny comparisons. Use when user asks to generate publication-ready genome maps, plot GC content and skew, or visualize BLAST-based comparisons between multiple sequences.
homepage: https://github.com/satoshikawato/gbdraw
metadata:
  docker_image: "quay.io/biocontainers/gbdraw:0.8.0--pyhdfd78af_0"
---

# gbdraw

## Overview
gbdraw is a specialized bioinformatics visualization tool designed to transform genomic data into clear, publication-ready diagrams. It excels at representing microbial genomes and organelles in both circular and linear formats. Beyond simple feature mapping, it integrates statistical tracks like GC content and skew, and provides a powerful linear comparison mode to visualize synteny and similarity between multiple genomes using BLAST results.

## Core CLI Usage

### Circular Diagrams
Used for whole-genome visualization of bacteria, archaea, or organelles.
```bash
# Basic circular plot from a GenBank file
gbdraw circular --gbk genome.gb -o output_prefix

# Include GC content and GC skew tracks
gbdraw circular --gbk genome.gb --gc --skew -o genome_map

# Specify output format (SVG, PNG, PDF, EPS, PS)
gbdraw circular --gbk genome.gb -o map --format pdf
```

### Linear Diagrams
Ideal for gene clusters, operons, or comparing multiple genomic regions.
```bash
# Basic linear plot
gbdraw linear --gbk genome.gb -o linear_map

# Comparative genomics: Plot two genomes with BLAST results showing similarity
gbdraw linear --gbk ref.gb query.gb --blast blast_results.txt -o comparison
```

## Expert Tips & Best Practices

### Input Handling
*   **GFF3 Support**: If GenBank files are unavailable, use GFF3 and FASTA pairs: `gbdraw circular --gff genome.gff --fasta genome.fasta`.
*   **Multi-Record Files**: gbdraw can handle GenBank files containing multiple records; use the `--record_id` flag if you need to isolate a specific chromosome or plasmid.

### Visualization Tuning
*   **Track Layouts**: For circular diagrams, use `--track_layout` with options:
    *   `spreadout`: Maximizes space between tracks.
    *   `middle`: Standard balanced view.
    *   `tuckin`: Compact view for high-density information.
*   **Label Filtering**: Prevent diagram clutter by using label filters. You can exclude specific keywords or only show labels for high-priority features.
*   **Color Palettes**: Use `--palette` to apply predefined color schemes from the built-in `color_palettes.toml`.

### Advanced Comparison
*   **BLAST Integration**: When using `linear` mode with `--blast`, ensure the BLAST output is in tabular format (`-outfmt 6` or `7`).
*   **Window/Step Sizes**: For GC tracks, gbdraw auto-adjusts window sizes based on genome length (<1M, 1-10M, >10M bp), but these can be manually overridden for specific resolution needs.

## Common Workflow: Comparative Synteny
1.  Perform a BLAST search between two genomes: `blastn -query g1.fasta -subject g2.fasta -outfmt 6 > match.tsv`
2.  Generate the comparison diagram:
    ```bash
    gbdraw linear --gbk g1.gbk g2.gbk --blast match.tsv --gc -o synteny_plot
    ```



## Subcommands

| Command | Description |
|---------|-------------|
| gbdraw | Generate genome diagrams in PNG/PDF/SVG/PS/EPS. Diagrams for multiple entries are saved separately. |
| gbdraw | Generate plot in PNG/PDF/SVG/PS/EPS. |

## Reference documentation
- [Project Overview and Architecture](./references/github_com_satoshikawato_gbdraw_blob_main_CLAUDE.md)
- [Command Line Interface Details](./references/github_com_satoshikawato_gbdraw_blob_main_README.md)
- [Agent Guidance and Structure](./references/github_com_satoshikawato_gbdraw_blob_main_AGENTS.md)