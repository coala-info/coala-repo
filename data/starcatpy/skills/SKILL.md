---
name: starcatpy
description: starcatpy (also known as starCAT or starCellAnnoTator) is a specialized tool for the annotation of scRNA-Seq data by mapping cells onto established gene expression programs.
homepage: https://github.com/immunogenomics/starCAT
---

# starcatpy

## Overview
starcatpy (also known as starCAT or starCellAnnoTator) is a specialized tool for the annotation of scRNA-Seq data by mapping cells onto established gene expression programs. Unlike traditional clustering, it utilizes a reference-based approach to determine the "usage" of specific biological programs within each cell. This provides a more nuanced view of cell states, offering both continuous usage scores and discrete multinomial labels for cell classification.

## Installation
The package can be installed via pip or conda:
```bash
pip install starcatpy
# OR
conda install bioconda::starcatpy
```

## Command Line Interface (CLI) Usage
The CLI is the most direct way to process count matrices.

### Basic Annotation
To run starCAT with the default T-cell reference (TCAT.V1):
```bash
starcat --reference TCAT.V1 --counts path/to/counts.h5ad --output-dir ./results --name my_experiment
```

### Argument Reference
- `--reference`: Name of a pre-built reference (e.g., `TCAT.V1`, `HSC`) or a local filepath to a GEP-by-gene matrix (.tsv, .csv, or .txt).
- `--counts`: Path to the input cell-by-gene counts matrix. Supported formats include Matrix Market (.mtx.gz), tab-delimited text, or AnnData (.h5ad).
- `--output-dir`: Directory where results will be saved (defaults to current directory).
- `--name`: Prefix for the output files (defaults to 'starCAT').
- `--scores`: Optional path to a configuration file for calculating additional score add-ons.

## Python API Workflow
For integration into computational notebooks (Jupyter/Scanpy), use the following pattern:

```python
from starcat import starCAT

# 1. Initialize with a reference
tcat = starCAT(reference='TCAT.V1')

# 2. Load counts (expects raw counts)
# starCAT handles the loading of various formats into AnnData
adata = tcat.load_counts('data_counts.h5ad')

# 3. Run the annotation
# usage: continuous program usage; scores: classification and metadata
usage, scores = tcat.fit_transform(adata)
```

## Expert Tips and Best Practices
- **Input Requirements**: starCAT expects **raw counts**. Ensure the data is stored in `adata.X` rather than in a specific layer like `adata.layers['counts']`.
- **Reference Selection**: Use `starcat.available_refs` in Python to see the list of currently supported pre-built references.
- **Memory Management**: For datasets exceeding 50,000 cells or 700 MB, use the local Python package rather than the web-based implementation to avoid timeouts or memory errors.
- **Output Interpretation**: 
    - The `usage` matrix provides the relative contribution of each gene program to each cell.
    - The `scores` matrix includes `Multinomial_Label`, which is the primary classification for the cell based on the reference.
- **Custom References**: You can build custom references from cNMF (consensus Non-negative Matrix Factorization) runs. The reference file should be a gene-by-program matrix.

## Reference documentation
- [starCAT GitHub Repository](./references/github_com_immunogenomics_starCAT.md)
- [starcatpy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_starcatpy_overview.md)