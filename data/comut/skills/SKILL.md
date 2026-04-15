---
name: comut
description: The comut tool provides guidance on using the CoMut Python library to create publication-quality comutation plots for visualizing genomic and clinical data. Use when user asks to generate comutation plots, visualize mutation distributions across cohorts, or integrate clinical metadata with genomic data layers.
homepage: https://github.com/vanallenlab/comut
metadata:
  docker_image: "quay.io/biocontainers/comut:0.0.3--pyhdfd78af_0"
---

# comut

## Overview
The `comut` skill provides guidance on using the CoMut Python library to generate publication-quality comutation plots. These plots are essential in cancer genomics for visualizing the distribution of mutations across a cohort of samples, integrated with additional data layers such as tumor mutational burden, clinical metadata (age, sex, response), and copy number variations.

## Installation
CoMut can be installed via pip or conda:

```bash
# Via pip
pip install comut

# Via bioconda
conda install bioconda::comut
```

## Core Workflow Patterns
Since `comut` is a Python library rather than a standalone CLI tool, usage involves scripting with pandas and matplotlib.

### 1. Initializing a Plot
The basic workflow involves creating a `CoMut` object and adding data layers.
- **Data Input**: Prepare your data as pandas DataFrames.
- **MAF Files**: While the library is often used with MAF files, you must first parse them into a format compatible with pandas.

### 2. Adding Data Layers
- **Categorical Data**: Use for mutations (e.g., Missense, Nonsense) or clinical categories (e.g., Gender, Stage).
- **Continuous Data**: Use for metrics like TMB (Tumor Mutational Burden) or gene expression levels.
- **Side Bar Data**: Use `add_side_bar_data` to add bar charts to the side of the main plot (e.g., to show mutation frequency per gene).

### 3. Customization and Layout
- **Sample Ordering**: You can manually specify sample order or allow the library to cluster samples based on mutation patterns.
- **Color Mapping**: Utilize the `palettable` library (a dependency) to define distinct color schemes for different mutation types or phenotypic traits.
- **Unified Legend**: CoMut can automatically generate a unified legend for all data layers added to the plot.

## Expert Tips
- **Pandas Compatibility**: If using pandas 2.0.0 or higher, be aware that certain methods like `add_side_bar_data` may require specific DataFrame formatting to avoid index-related errors.
- **Figure Export**: Since CoMut is built on matplotlib, use `plt.savefig()` to export plots. For publication, export to vector formats like `.pdf` or `.svg`.
- **White Space Management**: If you notice gaps between cells in categorical plots, check the `width` and `hspace`/`wspace` parameters in the underlying matplotlib gridspec.
- **Missing Data**: Ensure that samples missing specific data points are handled in your DataFrame (e.g., as `NaN` or a specific "Unknown" category) to prevent alignment issues across layers.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_vanallenlab_comut.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_comut_overview.md)
- [Known Issues and Workarounds](./references/github_com_vanallenlab_comut_issues.md)