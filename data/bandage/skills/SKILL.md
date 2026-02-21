---
name: bandage
description: Bandage (Bioinformatics Application for Navigating De novo Assembly Graphs Easily) is a specialized tool for inspecting the graph structures that underlie genome assemblies.
homepage: https://github.com/rrwick/Bandage
---

# bandage

## Overview
Bandage (Bioinformatics Application for Navigating De novo Assembly Graphs Easily) is a specialized tool for inspecting the graph structures that underlie genome assemblies. Unlike standard FASTA viewers that only show finished contigs, Bandage visualizes the connections between contigs, allowing you to identify repeats, misassemblies, and branching paths. While primarily known for its GUI, it provides a powerful command-line interface for automated assembly statistics and image generation.

## Installation
The recommended way to install Bandage is via Bioconda:
```bash
conda install bioconda::bandage
```

## Common CLI Patterns

### Generating Assembly Statistics
To quickly extract assembly metrics (e.g., N50, total length, node count) from a graph file:
```bash
Bandage info assembly_graph.gfa
```

### Creating Assembly Images
You can generate static visualizations of the graph without opening the GUI. This is useful for automated QC pipelines.
```bash
Bandage image assembly_graph.gfa output_map.png
```

### Customizing Image Output
Enhance the visualization by adding labels or adjusting the scale:
*   **Add Node Labels**: Use `--lengths` to show contig sizes or `--depth` to show coverage.
*   **Adjust Dimensions**: Use `--width` and `--height` to set the output resolution.
*   **Coloring**: Use `--colour` to specify schemes (e.g., rainbow, depth, or custom CSV-based colors).

Example of a detailed command-line image generation:
```bash
Bandage image graph.gfa assembly_plot.png --lengths --depth --width 2000 --height 2000
```

## Expert Tips and Best Practices
*   **Format Support**: While Bandage supports Velvet, SPAdes, and MEGAHIT output files, the Graphical Fragment Assembly (GFA) format is the most robust and portable option for modern bioinformatics workflows.
*   **Large Graphs**: For extremely large or complex metagenomic graphs, the GUI may become unresponsive. Use the `image` command with the `--names` or `--lengths` flags to generate a high-resolution overview for offline inspection.
*   **Sequence Extraction**: In the GUI, you can search for specific sequences (BLAST) and extract the paths between nodes. This is critical for resolving gaps in draft genomes.
*   **Troubleshooting**: If a command-line image fails to render correctly on a headless server, ensure that basic X11 libraries or a virtual framebuffer (like `xvfb-run`) are available, as Bandage relies on the Qt framework.

## Reference documentation
- [Bandage GitHub Repository](./references/github_com_rrwick_Bandage.md)
- [Bandage Wiki Home](./references/github_com_rrwick_Bandage_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bandage_overview.md)