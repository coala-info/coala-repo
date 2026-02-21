---
name: mgcplotter
description: MGCplotter is a command-line utility that automates the creation of publication-quality circular genome maps.
homepage: https://github.com/moshi4/MGCplotter/
---

# mgcplotter

## Overview
MGCplotter is a command-line utility that automates the creation of publication-quality circular genome maps. It transforms GenBank files into visual representations, handling the complex configuration of Circos internally. You should use this skill to visualize the spatial distribution of genes, identify genomic islands via GC skew/content, or perform visual comparative genomics by mapping conserved sequences from query genomes against a reference.

## Core CLI Usage
The basic command requires a reference GenBank file and an output directory.

```bash
MGCplotter -r reference.gbk -o ./output_dir --assign_cog_color
```

### Comparative Genomics
To plot conserved regions from multiple query genomes, use the `--query_files` flag. MGCplotter uses MMseqs2 RBH (Reciprocal Best Hit) to identify these regions.

```bash
MGCplotter -r ref.gbk -o ./results --query_files query1.gbk query2.faa query3.fasta
```
*Note: Query tracks are added from the outside in, following the order provided in the command.*

## Expert Tips and Best Practices

### 1. Handling Multi-Contig Genomes
MGCplotter can process multi-record GenBank files (e.g., draft genomes with multiple contigs). It concatenates contigs and marks boundaries with alternating lightgrey/darkgrey colors in the outermost circle. Ensure your input GenBank file contains all contigs if you want a complete genome view.

### 2. Visual Hierarchy and Track Sizing
If a plot is too crowded, adjust the radial width of specific tracks using the `_r` options.
- **Conserved CDS**: If plotting many query genomes (e.g., >10), reduce `--conserved_cds_r` to `0.01` or `0.02` to prevent the plot from becoming excessively large.
- **Hiding Tracks**: Set a track radius to `0` to hide it (e.g., `--rrna_r 0 --trna_r 0`).

### 3. Color Customization
- **COG Colors**: Always use `--assign_cog_color` for functional insights. If you have specific branding requirements, provide a custom JSON mapping via `--cog_color_json`.
- **Standard Colors**: Use Matplotlib named colors (e.g., `skyblue`, `firebrick`) or Hex codes (e.g., `#FF5733`) for any feature track.
- **GC Skew**: Use `--gc_skew_p_color` and `--gc_skew_n_color` to highlight leading and lagging strand biases clearly.

### 4. Performance Optimization
For large comparative datasets, increase the thread count to speed up MMseqs2 searches:
```bash
MGCplotter -r ref.gbk -o ./out --query_files ./queries/*.gbk -t 8
```

### 5. Output Management
MGCplotter generates both `.png` and `.svg` files. Use the `.svg` for final publication adjustments in vector graphics software (like Inkscape or Illustrator) to ensure labels are perfectly placed.

## Reference documentation
- [MGCplotter GitHub Repository](./references/github_com_moshi4_MGCplotter.md)
- [MGCplotter Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mgcplotter_overview.md)