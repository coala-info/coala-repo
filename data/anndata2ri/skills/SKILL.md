---
name: anndata2ri
description: `anndata2ri` acts as a bridge between the two primary ecosystems for single-cell RNA sequencing analysis.
homepage: https://github.com/theislab/anndata2ri
---

# anndata2ri

## Overview
`anndata2ri` acts as a bridge between the two primary ecosystems for single-cell RNA sequencing analysis. It automates the translation of complex data structures—including expression matrices, metadata, and dimensionality reductions—between Python's `AnnData` and R's `SingleCellExperiment`. This allows researchers to leverage the strengths of both Scanpy and Bioconductor within a single environment, eliminating the need for intermediate file exports like `.h5ad` or `.rds`.

## Installation
Install the package using pip or conda:

```bash
pip install anndata2ri
# OR
conda install -c bioconda anndata2ri
```

## Core Usage Patterns

### 1. Python Context Manager
Use the `localconverter` to enable conversion within a specific code block. This is the recommended approach for scripts to avoid global conversion side effects.

```python
import anndata2ri
from rpy2.robjects import r
from rpy2.robjects.conversion import localconverter

# Activate the converter within this context
with localconverter(anndata2ri.converter):
    # Example: Convert an R object to AnnData
    adata = r('as(some_r_sce_data, "SingleCellExperiment")')
```

### 2. Jupyter Notebook Integration
For interactive workflows, use the IPython magic configuration to automatically convert objects passed between Python and R cells.

```python
import anndata2ri
%load_ext rpy2.ipython
anndata2ri.set_ipython_converter()

# Transfer Python AnnData to R as SingleCellExperiment
%%R -i adata_paul
print(class(adata_paul)) # Output: "SingleCellExperiment"

# Transfer R SingleCellExperiment back to Python as AnnData
%%R -o adata_allen
data(allen, package = 'scRNAseq')
adata_allen <- as(allen, 'SingleCellExperiment')
```

## Expert Tips and Troubleshooting

- **R Version Compatibility**: Ensure your environment uses R ≥ 3.6, as required by the underlying `rpy2` dependency.
- **String Categories**: When converting pandas `Category` series to R factors, ensure the categories are strings. Conversion may fail if categories are numeric or mixed types.
- **Sparse Matrix Support**: As of version 2.0, the tool has improved support for sparse arrays (`sparrays`). Ensure you are using the latest version when handling large, sparse count matrices to optimize memory usage.
- **Metadata Constraints**: Be aware that `int32` columns in AnnData `.obs` can sometimes cause issues during the round-trip conversion or when writing the resulting object to disk in R. Converting these to `int64` or factors in Python before conversion is a safer practice.
- **Dependency Debugging**: If you encounter installation or import errors, check the `rpy2` stack trace first. Most `anndata2ri` failures are rooted in `rpy2` configuration or R environment pathing issues.

## Reference documentation
- [anndata2ri GitHub Repository](./references/github_com_theislab_anndata2ri.md)
- [anndata2ri Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_anndata2ri_overview.md)
- [anndata2ri Issues and Troubleshooting](./references/github_com_theislab_anndata2ri_issues.md)