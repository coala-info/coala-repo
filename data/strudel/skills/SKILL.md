---
name: strudel
description: Strudel is a graphical tool for the comparative visualization and real-time exploration of genomic maps and syntenic relationships. Use when user asks to visualize homologous regions across species, compare genomic maps at multiple resolutions, or explore synteny between different genomes.
homepage: https://ics.hutton.ac.uk/strudel
metadata:
  docker_image: "quay.io/biocontainers/strudel:1.15.08.25--1"
---

# strudel

## Overview
Strudel is a high-performance graphical tool designed for the comparative visualization of genomic maps. It enables researchers to examine data at multiple resolutions—from whole-genome views down to individual markers—and explore syntenic relationships between different genomes in real-time. It is particularly effective for investigating homologous regions across species, such as comparing barley with rice or Brachypodium.

## Installation and Setup
Strudel is available via Bioconda and as a standalone installer for Windows, Linux, and macOS.

- **Conda Installation**:
  ```bash
  conda install bioconda::strudel
  ```
- **Memory Management**: For large datasets, modify the `.vmoptions` file located in the installation directory to increase the maximum heap size (e.g., `-Xmx4g`).

## Supported Data Formats
- **Native Format (.strudel)**: A tab-delimited text format. It supports defining specific colors for chromosomes and individual links.
- **MAF Support**: Basic support for Multiple Alignment Format (MAF) is included for cross-species comparisons.
- **Example Data**: The application typically ships with an example dataset to demonstrate the required file structures.

## Interactive Navigation and Shortcuts
Strudel is designed for real-time interaction. Use these shortcuts to navigate complex maps:

- **Zooming**: Use `Ctrl + Mouse Scroll` to zoom in and out. The zoom range spans from entire genomes to single features.
- **Chromosome Focus**: `Double-click` on a chromosome to automatically fill the screen with that specific map.
- **Link Discovery**: Hold `Ctrl + Shift` and drag the mouse on or near a map to discover links (homologies) in real-time.
- **Selection**:
  - `Right-click` after a region selection to "Show annotation for features in range."
  - Press `ESC` to clear the current selection.
- **Feature Search**: Use the "Show Feature Table" button to filter features by name or annotation.

## Expert Tips and Best Practices
- **Filtering**: Use the BLAST e-value filter to reduce noise when displaying thousands of homologies.
- **Comparative Layouts**: Use the "Configure Genomes" dialog to arrange multiple instances of the same dataset for all-by-all comparisons.
- **Visual Customization**: 
  - Enable "Full feature information on mouseover" in the settings panel for detailed annotation viewing without clicking.
  - If homologies are cluttered, use the "Force white" option for highlighted links; non-highlighted links will automatically dim to provide better contrast.
- **Performance**: If the interface lags with massive datasets, ensure antialiasing is set to the default "delayed" mode, which disables it during active animation/navigation but applies it once the view is static.

## Reference documentation
- [Strudel Overview](./references/ics_hutton_ac_uk_strudel.md)
- [Strudel Release Notes](./references/ics_hutton_ac_uk_strudel_download-strudel_strudel-release-notes.md)
- [Bioconda Strudel Page](./references/anaconda_org_channels_bioconda_packages_strudel_overview.md)