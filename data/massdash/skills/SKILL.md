---
name: massdash
description: MassDash is a platform for the visualization, exploration, and optimization of DIA mass spectrometry data. Use when user asks to launch a web-based dashboard for peak picking, visualize chromatograms or ion mobility plots, and programmatically analyze peptide precursors.
homepage: https://github.com/Roestlab/massdash
metadata:
  docker_image: "quay.io/biocontainers/massdash:0.1.1--pyhdfd78af_0"
---

# massdash

## Overview
MassDash is a specialized platform designed for the exploration and optimization of DIA mass spectrometry data. It provides a web-based dashboard for rapid visualization and a Python API for advanced analysis. It is ideal for researchers needing to validate peptide precursors, experiment with deep learning-based peak picking, or develop custom data analysis workflows.

## Installation and Environment
To ensure stability and avoid dependency conflicts, MassDash should be installed in a dedicated Python 3.9 environment.

```bash
# Recommended setup via Conda and Pip
conda create --name=massdash python=3.9
conda activate massdash
pip install massdash --upgrade
```

Alternatively, install via Bioconda:
```bash
conda install bioconda::massdash
```

## Command Line Usage
The primary interaction with the MassDash interface is through the command line.

- **Launch the Dashboard**: Use the following command to start the Streamlit-based web interface:
  ```bash
  massdash gui
  ```

## Expert Tips and Best Practices
- **On-the-Fly Optimization**: Use the GUI to adjust peak-picking parameters in real-time. This is the most efficient way to fine-tune settings before applying them to large-scale datasets or custom algorithms.
- **Visualization Selection**:
  - **Chromatograms**: Use these for detailed inspection of specific peptide precursors of interest.
  - **2D/3D Plots**: Utilize these specifically for ion mobility enhanced mass spectrometry to resolve overlapping signals.
- **Handling SQLite Errors**: If you encounter errors regarding SQLite objects and threading, ensure that database connections are being utilized within the same thread in which they were initialized.
- **Programmatic Access**: For complex applications or high-throughput prototyping, import the `massdash` Python package directly into your scripts to access its underlying data analysis algorithms and workflows without the GUI overhead.

## Reference documentation
- [MassDash Overview](./references/anaconda_org_channels_bioconda_packages_massdash_overview.md)
- [MassDash GitHub Repository](./references/github_com_Roestlab_massdash.md)