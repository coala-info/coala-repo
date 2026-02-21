---
name: pycistarget
description: pycistarget is a Python-based computational tool designed to identify enriched transcription factor motifs within specific genomic regions.
homepage: https://github.com/aertslab/pycistarget
---

# pycistarget

## Overview
pycistarget is a Python-based computational tool designed to identify enriched transcription factor motifs within specific genomic regions. It serves as a core component of the SCENIC+ ecosystem but can be used independently for regulatory genomics. The tool implements two primary analytical frameworks: **cisTarget (CTX)**, which utilizes pre-computed motif rankings to identify enrichment, and **Differential Enrichment of Motifs (DEM)**, which performs a statistical comparison between foreground and background region sets to find motifs specifically associated with a condition or cell type.

## Installation and Setup
The package is available via Bioconda and should be installed within a dedicated environment to manage dependencies like `pyranges` and `numba`.

```bash
# Recommended installation via Conda
conda install bioconda::pycistarget

# Alternative installation for SCENIC+ compatibility
git clone https://github.com/aertslab/scenicplus
cd scenicplus
pip install .
```

## Command Line Interface (CLI) Usage
pycistarget provides a CLI for running enrichment analyses without writing custom Python scripts.

### cisTarget (CTX) Mode
Use this mode when you have a set of regions and want to find motifs enriched based on pre-computed database rankings.
- **Key Argument**: Use `--fr_overlap_w_ctx_db` to specify the minimum fraction of overlap required between your input regions and the database regions (default is often 0.4).
- **Note**: Ensure the database species matches your data (e.g., `danio_rerio`, `mus_musculus`, `homo_sapiens`).

### Differential Enrichment (DEM) Mode
Use this mode to find motifs that are specifically enriched in a "foreground" set of regions compared to a "background" set.
- The CLI command is `pycistarget dem`.
- This is particularly useful for identifying motifs in cluster-specific peaks versus all other peaks.

## Python API Best Practices
For more complex workflows, use the Python API to interact with results directly.

### Running Enrichment
The `run_pycistarget` function is the primary entry point for integrated analysis.
```python
import pycistarget
# Check version
print(pycistarget.__version__)

# Common workflow involves:
# 1. Loading regions
# 2. Running CTX or DEM
# 3. Saving results to a MotifEnrichmentResult object
```

### Data Persistence
pycistarget uses HDF5 and Pickle formats for storing large-scale enrichment results.
- **HDF5**: Use `write_hdf5` and `read_hdf5` methods within the `MotifEnrichmentResult` class for interoperable storage.
- **Pickle**: SCENIC+ workflows often expect a `menr.pkl` file containing the serialized enrichment results.

### Handling Species and Annotations
- When specifying species in functions like `run_pycistarget`, use full scientific names (e.g., `danio_rerio`) if common abbreviations fail.
- If using custom databases, ensure the region coordinates are sorted to maintain determinism in functions like `get_foreground_and_background_regions`.

## Expert Tips
- **Memory Management**: Motif enrichment on large peak sets can be memory-intensive. Use the HDF5 reading capabilities to process data efficiently.
- **Parameter Sensitivity**: If you receive an error stating input does not overlap with the database, lower the `--fr_overlap_w_ctx_db` threshold or check your genome assembly version.
- **Deterministic Results**: In version 1.1 and later, regions are sorted internally in `get_foreground_and_background_regions` to ensure reproducible results across runs.

## Reference documentation
- [pycistarget Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pycistarget_overview.md)
- [pycistarget GitHub Repository](./references/github_com_aertslab_pycistarget.md)
- [pycistarget Issue Tracker (CLI Arguments)](./references/github_com_aertslab_pycistarget_issues.md)
- [pycistarget Commit History (Feature Refactoring)](./references/github_com_aertslab_pycistarget_commits_main.md)