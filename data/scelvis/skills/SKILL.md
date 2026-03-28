---
name: scelvis
description: SCelVis is an interactive web-based tool for visualizing and exploring single-cell transcriptomics data. Use when user asks to start a visualization server, convert single-cell data formats to AnnData, or explore gene expression patterns through an interactive dashboard.
homepage: https://github.com/bihealth/scelvis
---

# scelvis

## Overview
SCelVis (Single-Cell Visualization) is a specialized tool for the interactive exploration of single-cell transcriptomics data. It provides a web-based environment—built on the Dash framework—that allows researchers to visualize cell clusters, examine gene expression patterns, and perform on-the-fly filtering and differential expression analysis. It is particularly useful for transitioning from static analysis files (like AnnData objects) to a shareable, interactive dashboard.

## Installation and Setup
SCelVis can be installed via standard Python package managers or run via containerization:

- **Pip**: `pip install scelvis`
- **Conda**: `conda install -c bioconda scelvis`
- **Docker**: `docker run -p 8050:8050 ghcr.io/bihealth/scelvis:0.8.8-0 scelvis run --data-source /data`

## Common CLI Patterns

### Running the Visualization Server
The primary command to start the web interface is `scelvis run`.

```bash
# Run with a local directory containing data files
scelvis run --data-source ./path/to/data_dir/

# Run pointing to a single AnnData (.h5ad) file
scelvis run --data-source ./experiment_data.h5ad

# Specify a custom port (default is usually 8050)
scelvis run --data-source ./data --port 8080
```

### Data Conversion
SCelVis includes utilities to prepare data for visualization, specifically converting various formats into the preferred `.h5ad` (AnnData) format.

```bash
# Convert a Loom file to H5AD
scelvis convert --input-file data.loom --output-file data.h5ad

# Convert MTX (Matrix Market) files
scelvis convert --input-file ./mtx_dir/ --output-file data.h5ad

# Enable downsampling during conversion for large datasets
scelvis convert --input-file large_data.h5ad --output-file small_data.h5ad --downsample 1000
```

### Working with Remote Data
SCelVis supports loading datasets from remote protocols, which is useful for centralized data repositories.

- **iRODS**: Use the iRODS URI scheme. If using tickets for access, append them to the query string:
  `scelvis run --data-source "irods:///zone/path/to/data?ticket=YOUR_TICKET"`
- **SFTP/FTP**: Load data directly via SFTP:
  `scelvis run --data-source "sftp://user:pass@host/path/to/data"`
- **HTTP/HTTPS**: Point to a hosted H5AD file:
  `scelvis run --data-source "https://example.com/data.h5ad"`

## Expert Tips and Best Practices

- **Metadata Embedding**: For a better user experience, embed an `about.md` file within your data directory or as metadata in the AnnData object. SCelVis will display this on the home screen to provide context for the dataset.
- **Sparse Matrices**: When preparing data, avoid converting sparse matrices to dense formats. SCelVis is optimized to handle sparse data to minimize memory consumption.
- **Categorical Data**: Ensure your cluster assignments and metadata are stored as `categorical` types in the AnnData object to ensure they are correctly parsed as discrete filters in the UI.
- **Gene Expression Source**: SCelVis prefers using the `ad.raw` attribute of an AnnData object if present. Ensure your normalized/log-transformed data is stored there for accurate visualization of expression levels.
- **Performance**: For very large datasets (>100k cells), use the downsampling feature during the `convert` step to maintain a responsive web interface.



## Subcommands

| Command | Description |
|---------|-------------|
| scelvis_convert | Convert scELVIS output to .h5ad format. |
| scelvis_run | Run the scelvis server. |

## Reference documentation
- [SCelVis GitHub Repository](./references/github_com_bihealth_scelvis.md)
- [SCelVis README](./references/github_com_bihealth_scelvis_blob_master_README.rst.md)
- [Version History and Features](./references/github_com_bihealth_scelvis_blob_master_HISTORY.rst.md)