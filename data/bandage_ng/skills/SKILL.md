---
name: bandage_ng
description: "Bandage-NG visualizes and analyzes de novo assembly graphs to show the relationships between contigs. Use when user asks to visualize assembly graphs, generate images of GFA files, or extract assembly statistics like N50 and total length."
homepage: https://github.com/asl/BandageNG
---


# bandage_ng

## Overview
Bandage-NG (Bioinformatics Application for Navigating De novo Assembly Graphs Easily - Next Generation) is a tool that transforms the abstract connectivity of assembly graphs into interpretable visual maps. While traditional viewers focus on linear contigs, Bandage-NG visualizes the relationships between contigs, allowing users to identify misassemblies, resolve repetitive regions, and assess assembly completeness. This "NG" fork is maintained to support modern system libraries (Qt6) and adds specific features for high-throughput CLI usage.

## Installation
The tool is primarily distributed via Bioconda:
```bash
conda install bioconda::bandage_ng
```

## Common CLI Patterns
Bandage-NG can be used headlessly to generate images or extract statistics, which is essential for automated pipelines.

### Generating Assembly Images
To create a visual representation of a graph without opening the GUI:
```bash
Bandage image assembly_graph.gfa output.png
```
*   **SVG Output**: For publication-quality vector graphics, use the `.svg` extension.
*   **Text Rendering**: Use the `--render-text` flag when exporting to SVG to ensure node labels are treated as native text elements rather than paths.

### Extracting Graph Statistics
To get a summary of the assembly (N50, total length, node count):
```bash
Bandage info assembly_graph.gfa
```

### Visual Customization via CLI
*   **Node Labeling**: Use `--names` to label nodes with their IDs.
*   **Coloring**: Use the `--color` option to apply specific color schemes to the graph nodes based on metadata or depth.
*   **Sizing**: Use `--node-width` to adjust the thickness of the contig representations in the output image.

## Expert Tips & Best Practices
*   **Graph Formats**: While GFA is the standard, Bandage-NG is highly effective for inspecting SPAdes `assembly_graph_with_scaffolds.gfa` files to understand why certain contigs were not joined.
*   **Large Graphs**: For extremely large metagenomic assemblies, the GUI may become slow. Use the CLI `image` command with the `--width` and `--height` parameters to generate a high-resolution overview first.
*   **Interactivity**: If using the GUI, click the help icons (?) next to settings to see detailed descriptions of graph layout algorithms (like OGDF).
*   **Fork Compatibility**: Note that Bandage-NG is a fork of the original Bandage by Ryan Wick. While mostly compatible, it may contain specific bug fixes for Qt6 and new CLI flags (like `--scope`) not found in the original version.

## Reference documentation
- [Bandage-NG Overview](./references/anaconda_org_channels_bioconda_packages_bandage_ng_overview.md)
- [Bandage-NG GitHub Repository](./references/github_com_asl_BandageNG.md)
- [Bandage-NG CLI Issues and Features](./references/github_com_asl_BandageNG_issues.md)