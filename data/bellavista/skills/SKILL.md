---
name: bellavista
description: BellaVista is a Python-based visualization tool that transforms spatial transcriptomics data into interactive, multi-layered maps using the napari rendering engine. Use when user asks to install the software, load Xenium datasets, visualize large-scale spatial transcriptomics data, or generate figures for publication.
homepage: https://github.com/pkosurilab/BellaVista
---


# bellavista

## Overview
BellaVista is a Python-based visualization tool specifically engineered for the spatial transcriptomics community. It transforms complex imaging data into interactive, multi-layered maps using the napari rendering engine. You should use this skill to assist users in setting up their environment, loading large-scale spatial datasets (like Xenium mouse brain samples), and navigating the visual interface to produce reproducible, paper-ready figures.

## Installation and Environment Setup
BellaVista requires Python 3.9 or above and relies on a GPU for efficient rendering.

### Recommended Conda Setup
```bash
conda create -n bellavista_env python=3.12
conda activate bellavista_env
conda install bioconda::bellavista
```

### Alternative Pip Installation
```bash
pip install bellavista
```

## Command Line Usage
The primary way to interact with BellaVista is through its CLI.

### Loading Xenium Data
To load a standard 10x Genomics Xenium output folder:
```bash
bellavista --xenium-sample /path/to/xenium_data_folder
```

### Handling Large Datasets (Memory Optimization)
If the system encounters memory errors due to the size of the transcriptomics data, use the "lite" mode to visualize a subset:
```bash
bellavista --xenium-sample-lite /path/to/xenium_data_folder
```

## Interactive Visualization Tips
Once the napari window opens and the "Data Loaded!" message appears in the terminal, use these shortcuts for efficient exploration:

- **Single Layer Focus**: To isolate a specific gene or boundary layer, **Option/Alt-click** the visibility icon (the eye) next to the layer name. This hides all other layers instantly.
- **Gene Colors**: Colors are assigned randomly by default upon launch. For reproducible figure generation, users should refer to a predefined JSON configuration (if available in their local `sample_json` directory).
- **Output Management**: BellaVista automatically creates a `BellaVista_output` folder within the provided data path to store processed files and cache.

## Troubleshooting and Best Practices
- **GPU Rendering**: Ensure your environment has access to a compatible GPU; otherwise, the napari canvas may fail to render high-density transcript points.
- **Python Version**: Avoid Python 3.13 for now, as certain dependencies like `numba` (required by napari) may not yet be fully supported. Stick to Python 3.12.
- **Data Integrity**: Ensure the input directory contains the standard subfolders (e.g., cell boundaries and transcript HDF5 files). If no HDF5 files are detected, the tool will throw an exception.

## Reference documentation
- [BellaVista GitHub Repository](./references/github_com_pkosurilab_BellaVista.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bellavista_overview.md)