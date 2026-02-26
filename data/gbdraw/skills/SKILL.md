---
name: gbdraw
description: "gbdraw creates customizable circular or linear diagrams for the visual representation of microbial and organellar genomes. Use when user asks to generate genomic maps from GenBank or GFF3 files, visualize GC content and skew, or create comparative genomics diagrams using BLAST results."
homepage: https://github.com/satoshikawato/gbdraw
---


# gbdraw

## Overview
gbdraw is a specialized tool for the visual representation of microbial and organellar genomes. It transforms genomic annotation files into customizable circular or linear diagrams. Beyond simple feature mapping, it supports the integration of comparative genomics data (BLAST) and sequence composition metrics (GC content and skew). It is particularly useful for researchers needing to generate vector-based graphics (SVG, PDF, EPS) or raster images (PNG) for publications, with advanced control over label placement and feature styling.

## Core Capabilities
- **Input Formats**: Supports standard GenBank/DDBJ files and GFF3 + FASTA pairs.
- **Diagram Modes**: 
    - **Circular**: Ideal for whole-genome overviews of bacteria, viruses, and organelles.
    - **Linear**: Best for specific genomic regions, operons, or comparative alignments.
- **Comparative Genomics**: Can visualize sequence similarity between multiple genomes by incorporating BLAST results.
- **Compositional Tracks**: Supports dedicated tracks for GC content and GC skew.
- **Label Management**: Features a priority-based system for label placement, including the ability to use blacklists and whitelists to manage crowded regions.

## Usage Guidelines and Best Practices

### Installation
The tool is primarily distributed via Bioconda:
```bash
conda install bioconda::gbdraw
```

### Workflow Patterns
1. **Basic Visualization**: Provide a GenBank or GFF3+FASTA pair to generate a standard map.
2. **Comparative Mapping**: When comparing genomes, ensure you have the BLAST results ready to be passed to the tool to draw similarity links between tracks.
3. **Track Customization**:
    - Use the `above` and `below` options in linear mode to organize features relative to the main track.
    - Adjust the `Interval` parameter for linear canvases to control the spacing and scale of the genomic region.
4. **Output Optimization**:
    - For publications, prefer vector formats like **SVG** or **PDF** to maintain resolution.
    - If using **PNG**, specify the resolution (DPI) to ensure clarity for digital presentations.
5. **Label Refinement**:
    - If labels overlap in dense regions, utilize the priority rules or the whitelist/blacklist feature to highlight only essential genes.
    - The tool uses kerning-aware font measurements, so labels are generally well-placed, but manual adjustment of label angles or canvas dimensions may be necessary for very large genomes.

### Expert Tips
- **Dark Mode Aesthetics**: When features are assigned dark colors, ensure embedded labels are set to white for readability.
- **Relative Positioning**: Position ticks, labels, and GC tracks relative to the primary feature tracks to maintain a clean visual hierarchy.
- **Comparative Layouts**: In linear mode, use the comparative features to align multiple genomes, which is essential for visualizing synteny or horizontal gene transfer events.

## Reference documentation
- [gbdraw GitHub Repository](./references/github_com_satoshikawato_gbdraw.md)
- [gbdraw Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gbdraw_overview.md)
- [gbdraw Issue Tracker (Feature Requests)](./references/github_com_satoshikawato_gbdraw_issues.md)