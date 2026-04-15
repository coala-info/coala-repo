---
name: xpressplot
description: XPRESSplot is a Python toolkit for exploring and visualizing genomic expression data. Use when user asks to 'process gene-by-sample dataframes', 'visualize differential expression', or 'standardize gene identifiers'.
homepage: https://github.com/XPRESSyourself/XPRESSplot
metadata:
  docker_image: "quay.io/biocontainers/xpressplot:0.2.5--pyh4c3bd37_1"
---

# xpressplot

## Overview
XPRESSplot is a specialized Python toolkit designed to streamline the exploration of genomic expression data. It bridges the gap between raw expression matrices and biological insight by providing high-level plotting functions and data manipulation utilities. Use this skill when you need to process gene-by-sample dataframes, visualize differential expression, or standardize gene identifiers within a bioinformatics pipeline.

## Installation and Setup
XPRESSplot requires both Python (>=3.5) and R to be installed on the system.

```bash
# Installation via Conda (recommended)
conda install -c bioconda xpressplot

# Installation via pip
pip install xpressplot
```

## Core Usage Patterns

### Environment Configuration
When using XPRESSplot in interactive environments like Jupyter Notebooks or Atom Hydrogen, you must initialize the plotting backend immediately after importing.

```python
import XPRESSplot as xp
%matplotlib inline
```

### Data Structure Requirements
XPRESSplot expects pandas DataFrames formatted with genes as rows and samples as columns.
- **Rows (i):** Gene identifiers (e.g., Gene Symbols, Ensembl IDs).
- **Columns (j):** Sample names (e.g., GSM IDs, library names).

### Visualization: Volcano Plots
The `rna_volcano` function is a primary tool for visualizing differential expression. 
- **Marker Modulation:** You can adjust the size of highlighted markers to improve clarity in dense plots.
- **Data Export:** The tool allows for the export of the underlying data table used to generate the plot for downstream analysis.

### Data Cleaning and Conversion
- **Name Conversion:** Use the `convert_name` functions to standardize gene nomenclature. This is critical when merging datasets from different sources (e.g., GEO and internal RNA-seq).
- **Index Management:** Note that in newer versions of Pandas (1.0.0+), the syntax for removing index names has changed; ensure your dataframe indices are clean before passing them to XPRESSplot functions.

## Expert Tips
- **RPKM/TPM Handling:** If generating RPKM tables, verify the output format as the tool is designed to return modified forms suitable for immediate plotting.
- **Platform Compatibility:** While primarily tested on 64-bit Linux, it is compatible with Mac OS X. Ensure R is in your system PATH, as several underlying analytical modules rely on R-based calculations.
- **Interactive Exploration:** Use the provided `example_notebook.ipynb` in the repository as a template for rapid prototyping of new datasets.

## Reference documentation
- [XPRESSplot GitHub Repository](./references/github_com_XPRESSyourself_XPRESSplot.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_xpressplot_overview.md)