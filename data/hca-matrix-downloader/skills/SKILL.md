---
name: hca-matrix-downloader
description: This tool automates the retrieval and conversion of processed expression matrices from the Human Cell Atlas FTP service. Use when user asks to download HCA expression matrices, retrieve single-cell data by project UUID or title, or convert HCA-formatted matrices into 10X Genomics-compatible structures.
homepage: https://github.com/ebi-gene-expression-group/hca-matrix-downloader
metadata:
  docker_image: "quay.io/biocontainers/hca-matrix-downloader:0.0.4--py_0"
---

# hca-matrix-downloader

## Overview

The `hca-matrix-downloader` is a specialized CLI tool for bioinformaticians and researchers working with Human Cell Atlas data. It automates the retrieval of processed expression matrices from the HCA FTP service, bypassing manual browser downloads. It supports both single-species and Matrix Market (mtx) formats and includes utilities for converting HCA-formatted matrices into 10X Genomics-compatible structures.

## Installation

The tool is available via Bioconda:

```bash
conda install bioconda::hca-matrix-downloader
```

## Core Usage Patterns

### Identifying Projects
Before downloading, you must identify a project that supports matrix formatting:
1. Visit the [HCA Data Browser](https://data.humancellatlas.org/explore/projects).
2. Use the search bar to filter for "matrix".
3. Copy the **Project Title**, **Project Label**, or the **UUID** (found in the project URL).

### Downloading a Matrix
Use the `-p` argument to specify the project. The tool accepts the UUID, the full title, or the label.

**Using a UUID:**
```bash
hca-matrix-downloader -p cddab57b-6868-4be4-806f-395ed9dd635a
```

**Using a Project Title:**
```bash
hca-matrix-downloader -p "Single cell transcriptome analysis of human pancreas"
```

### Handling Multi-Species Datasets
For datasets containing data from more than one species, you must specify the species to avoid errors.

```bash
hca-matrix-downloader -p <project_id> --species "Homo sapiens"
```

## Expert Tips and Best Practices

*   **Format Selection**: By default, the tool attempts to retrieve available formats. If you require a specific format like Loom for downstream analysis in Seurat or Scanpy, ensure the project supports it in the HCA browser before attempting the download.
*   **10X Compatibility**: HCA Matrix Market files often have different naming conventions than standard 10X Genomics outputs. Use the bundled shell script `hca-mtx-to-10x` to rename and restructure the downloaded files for compatibility with tools like `CellRanger` or `Read10X()`.
*   **Project Indexing**: The tool loads a project index from the HCA FTP. If a very recent project is not found, verify that the project has been processed into the matrix service on the HCA portal.
*   **Help Command**: For a full list of available arguments and species naming conventions, use:
    ```bash
    hca-matrix-downloader -h
    ```

## Reference documentation
- [HCA Matrix Downloader Overview](./references/github_com_ebi-gene-expression-group_hca-matrix-downloader.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_hca-matrix-downloader_overview.md)