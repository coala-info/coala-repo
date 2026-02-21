---
name: vpt
description: The Vizgen Post-processing Tool (VPT) provides a command-line interface for the advanced analysis of MERSCOPE spatial transcriptomics data.
homepage: https://github.com/Vizgen/vizgen-postprocessing
---

# vpt

## Overview
The Vizgen Post-processing Tool (VPT) provides a command-line interface for the advanced analysis of MERSCOPE spatial transcriptomics data. It enables users to re-segment cells using custom algorithms, assign transcripts to those new boundaries, and update visualization files (.vzg). VPT is designed for high-throughput processing and can be integrated into parallel computing environments to handle large-scale mosaic images and transcript lists.

## Core CLI Usage
VPT operations typically require two types of input:
1. **Command Line Arguments**: Define input/output paths and experiment-specific metadata.
2. **Algorithm JSON**: A configuration file defining the specific segmentation steps.

### Primary Commands
- `vpt run-segmentation`: The main entry point for executing a full segmentation workflow.
- `vpt prepare-segmentation`: Creates a template JSON file for defining segmentation logic.
- `vpt update-vzg`: Integrates new segmentation results and expression matrices back into the MERSCOPE Visualizer format.
- `vpt partition-transcripts`: Re-assigns detected transcripts to new cell boundaries to generate updated cell-by-gene matrices.
- `vpt derive-entity-metadata`: Calculates geometric attributes (area, centroid) for segmented entities.

### Image Processing
VPT includes utilities to handle large-scale microscopy data:
- `vpt convert-to-ome`: Converts raw 16-bit mosaic TIFFs into pyramidal OME-TIFFs for better performance.
- `vpt convert-to-rgb-ome`: Merges up to three channels into a single RGB OME-TIFF.

## Expert Tips & Best Practices
- **Tile-Based Parallelization**: For large datasets, execute `run-segmentation-on-tile` across a cluster, then use `compile-tile-segmentation` to merge results into a single, internally-consistent parquet file.
- **External Segmentation**: If using external tools like Cellpose or StarDist, use `vpt convert-geometry` to import GeoJSON or HDF5 boundaries into the VPT-compatible parquet format.
- **Reproducibility**: Always use the same segmentation algorithm JSON file when comparing multiple experiments to ensure identical processing logic.
- **Signal Quantification**: Use `vpt sum-signals` to find the intensity of mosaic images within specific cell boundaries, which is useful for protein staining or smFISH quantification.
- **Help Documentation**: Access detailed argument descriptions for any command using `vpt <command> --help`.

## Reference documentation
- [vpt Overview](./references/anaconda_org_channels_bioconda_packages_vpt_overview.md)
- [Vizgen Post-processing Tool GitHub](./references/github_com_Vizgen_vizgen-postprocessing.md)