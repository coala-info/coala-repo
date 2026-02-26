---
name: scelvis
description: SCelVis provides interactive, web-based visualization and exploration of single-cell transcriptomics data. Use when user asks to launch a visualization server, explore cell clusters and gene expression patterns, or convert data formats like MTX and Loom into AnnData files.
homepage: https://github.com/bihealth/scelvis
---


# scelvis

## Overview
SCelVis is a specialized tool designed for the interactive, web-based visualization of single-cell transcriptomics data. It allows researchers to explore cell clusters, gene expression patterns, and metadata through a browser-based dashboard. Use this skill to quickly set up the environment, convert raw data formats (like MTX or Loom) into compatible AnnData files, and host a local or containerized visualization server.

## Installation
SCelVis can be installed via multiple package managers or run directly as a container:

- **Conda (Recommended):**
  ```bash
  conda install -c bioconda scelvis
  ```
- **Pip:**
  ```bash
  pip install scelvis
  ```
- **Docker:**
  ```bash
  docker run -p 8050:8050 ghcr.io/bihealth/scelvis:0.8.9-0
  ```

## Common CLI Patterns

### Launching the Visualization Server
The primary use case is starting the web server to view your data.
```bash
# Run the server pointing to a directory containing your datasets
scelvis run --data-dir /path/to/your/data/
```
By default, the server usually listens on port 8050. You can access the interface at `http://localhost:8050`.

### Data Conversion and Preparation
SCelVis works best with `.h5ad` (AnnData) files. If your data is in other formats, use the conversion utilities:

- **From MTX:** Convert sparse matrix files to the internal format.
- **From Loom:** Convert Loom files to H5AD. Note that there is a known warning during Loom to H5AD conversion that may require checking the output integrity.
- **Downsampling:** When dealing with extremely large datasets, use the downsampling flag during conversion to improve web interface responsiveness.

### Checking Version and Help
```bash
scelvis --version
scelvis --help
```

## Expert Tips
- **Coordinate Mapping:** Ensure your dimensionality reduction coordinates (UMAP, t-SNE) are stored in `ad.obsm` within your H5AD files. SCelVis relies on these for spatial rendering of cell clusters.
- **Data Directory Structure:** When using `--data-dir`, SCelVis scans the directory for compatible files. Organizing your files with clear naming conventions helps the tool populate the dataset selection dropdown effectively.
- **Memory Management:** For large-scale atlases, running SCelVis via Docker with resource limits can prevent the web server from consuming excessive system memory during high-concurrency access.
- **Troubleshooting Conda:** If you encounter dependency issues during conda installation (specifically regarding `loompy`), ensure your channels are prioritized with `conda-forge` and `bioconda`.

## Reference documentation
- [SCelVis GitHub Repository](./references/github_com_bihealth_scelvis.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_scelvis_overview.md)
- [Known Issues and TODOs](./references/github_com_bihealth_scelvis_issues.md)