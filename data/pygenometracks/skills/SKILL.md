---
name: pygenometracks
description: pyGenomeTracks creates highly customizable, publication-quality genomic visualizations by stacking multiple data types into a single image. Use when user asks to generate genomic track plots, create configuration files for visualization, or render signal tracks and gene models for specific coordinates.
homepage: //github.com/maxplanck-ie/pyGenomeTracks
---


# pygenometracks

## Overview
pyGenomeTracks is a specialized tool for rendering highly customizable genomic visualizations. It excels at stacking multiple data types—such as signal tracks, gene models, and chromatin interactions—into a single, cohesive image. Use this skill to assist with the creation of the required configuration files and the execution of the plotting command to produce SVG or PDF outputs for specific genomic coordinates.

## Core Workflow

### 1. Configuration File Generation
The primary input for pyGenomeTracks is a configuration file (usually `.ini` format). Each section in the file represents a track.

*   **Initialize a template:** Use `make_tracks_file` to automatically scan a directory of genomic files and create a starting configuration.
    ```bash
    make_tracks_file --trackFiles file1.bw file2.bed genes.gtf -o tracks.ini
    ```
*   **Manual Refinement:** Edit the `tracks.ini` to adjust colors, heights, line widths, and scaling (e.g., `min_value`, `max_value`, `type = fill`).

### 2. Plotting Regions
Once the configuration is set, use the main command to generate the image.

*   **Basic Plotting:**
    ```bash
    pyGenomeTracks --tracks tracks.ini --region chr1:1000000-1100000 -o plot.pdf
    ```
*   **Multi-region Plotting:** Provide a BED file to generate plots for multiple loci at once.
    ```bash
    pyGenomeTracks --tracks tracks.ini --BED regions_of_interest.bed -o output_folder
    ```

## Expert Tips & Best Practices
*   **Track Ordering:** The order of sections in the `.ini` file determines the top-to-bottom vertical order in the plot. Place reference tracks (like genes) at the bottom or top for orientation.
*   **Signal Normalization:** When comparing multiple BigWig tracks, manually set `min_value` and `max_value` to the same constants across tracks to ensure the vertical scales are comparable.
*   **Gene Visualization:** For GTF/BED files, use `style = genes` or `style = UCSC` to toggle between simplified boxes and detailed intron/exon representations.
*   **Image Quality:** Always prefer `.pdf` or `.svg` for publication to maintain vector scalability. Use `--dpi` if outputting to `.png` for presentations.
*   **Space Management:** Use the `height` parameter (in cm) within each track section to balance the visual weight of high-density signal tracks versus thin annotation tracks.

## Reference documentation
- [pygenometracks Overview](./references/anaconda_org_channels_bioconda_packages_pygenometracks_overview.md)