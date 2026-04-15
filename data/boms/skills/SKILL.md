---
name: boms
description: BOMS segments cells in imaging-based spatial transcriptomics datasets by clustering mRNA spots based on the similarity of local gene expression neighborhoods. Use when user asks to segment cells from mRNA spot coordinates, generate a cell-by-gene count matrix, or identify cell boundaries without relying solely on image stains.
homepage: https://github.com/ocimakamboj/boms
metadata:
  docker_image: "quay.io/biocontainers/boms:1.1.0--py39he10ea66_0"
---

# boms

## Overview

BOMS is a specialized tool for segmenting cells in imaging-based spatial transcriptomics datasets. Unlike traditional image-based segmentation that relies solely on DAPI or membrane stains, BOMS assumes that a cell body is transcriptionally homogeneous. It uses the similarity of local gene expression neighborhoods to cluster mRNA spots into distinct cellular units. This skill should be used when you have coordinates for mRNA spots and their gene labels and need to generate a cell-by-gene count matrix or identify cell boundaries.

## Installation

BOMS can be installed via Conda (Bioconda) or pip. It requires Python > 3.9.

```bash
# Using Conda
conda install bioconda::boms

# Using pip
pip install boms
```

## Core Workflow (Python API)

The primary way to interact with BOMS is through its Python interface. The algorithm requires three main inputs as numpy arrays: `x` (x-coordinates), `y` (y-coordinates), and `g` (gene labels/identities).

```python
from boms import run_boms

# Execute segmentation
modes, seg, count_mat, cell_loc, coords = run_boms(
    x, 
    y, 
    g, 
    epochs=30, 
    h_s=10, 
    h_r=0.3, 
    K=30
)
```

### Output Definitions
- **modes**: Final calculated modes for the mRNA spots.
- **seg**: The resulting segmentation labels for each spot.
- **count_mat**: The final (cells x genes) expression matrix.
- **cell_loc**: The (x, y) centroids for each identified cell.
- **coords**: The coordinates used for calculation (useful if FOV filtering was applied).

## Parameter Optimization & Best Practices

To achieve high-quality segmentation, tune the following parameters based on your specific tissue type and resolution:

- **Spatial Bandwidth (`h_s`)**: This is the most critical parameter. It should be set roughly equal to the expected **radius** of the cell bodies in your dataset (in the same units as your x/y coordinates).
- **Range Bandwidth (`h_r`)**: Controls the similarity threshold for gene expression profiles. Recommended values are between **0.3 and 0.5**.
- **Nearest Neighbors (`K`)**: Defines the size of the neighborhood used to form the Gene Expression Profile. The default is **30**, but this can be increased for high-density datasets to smooth the profiles.
- **Iterations (`epochs`)**: The number of iterations for the algorithm to converge. **30** is generally sufficient for most datasets.

## Expert Tips

- **Data Preparation**: Ensure your gene labels (`g`) are encoded as integers if they are not already.
- **Hybrid Segmentation**: While BOMS can run on gene spots alone, it is most powerful when incorporating flows obtained from Cellpose (DAPI/Membrane channels) to provide spatial constraints to the transcriptional clustering.
- **Memory Management**: For very large datasets (e.g., full tissue slides), process the data in Fields of View (FOVs) to avoid memory overhead, as the K-nearest neighbor calculation can be resource-intensive.

## Reference documentation
- [BOMS GitHub Repository](./references/github_com_sciai-lab_boms.md)
- [BOMS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_boms_overview.md)