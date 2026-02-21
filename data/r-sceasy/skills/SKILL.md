---
name: r-sceasy
description: R package sceasy (documentation from project home).
homepage: https://cran.r-project.org/web/packages/sceasy/index.html
---

# r-sceasy

## Overview
`sceasy` is an R package designed for seamless conversion between various single-cell data formats. It is particularly useful for preparing R-based objects (Seurat or SingleCellExperiment) for use in Python-based tools like `cellxgene` or `scanpy` by converting them to AnnData (.h5ad) format.

## Installation
To install the package from GitHub:
```R
if (!requireNamespace("devtools", quietly = TRUE)) install.packages("devtools")
devtools::install_github("cellgeni/sceasy")

# Required dependencies
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("LoomExperiment", "SingleCellExperiment"))
install.packages('reticulate')
```

## Usage
The primary function is `convertFormat`. Because many conversions rely on Python libraries (like `anndata` or `loompy`), you must configure `reticulate` before use.

### Setup
```R
library(sceasy)
library(reticulate)

# Ensure a conda environment with anndata and loompy is available
# use_condaenv('EnvironmentName') 
loompy <- reticulate::import('loompy')
```

### Common Workflows

**Seurat to AnnData (.h5ad)**
```R
sceasy::convertFormat(seurat_object, from="seurat", to="anndata", outFile='filename.h5ad')
```

**AnnData to Seurat**
```R
sceasy::convertFormat('filename.h5ad', from="anndata", to="seurat", outFile='filename.rds')
```

**SingleCellExperiment (SCE) to AnnData**
```R
sceasy::convertFormat(sce_object, from="sce", to="anndata", outFile='filename.h5ad')
```

**Seurat to SingleCellExperiment**
```R
sceasy::convertFormat(seurat_object, from="seurat", to="sce", outFile='filename.rds')
```

**Loom Conversions**
```R
# SCE to Loom
sceasy::convertFormat(sce_object, from="sce", to="loom", outFile='filename.loom')

# Loom to AnnData
sceasy::convertFormat('filename.loom', from="loom", to="anndata", outFile='filename.h5ad')

# Loom to SCE
sceasy::convertFormat('filename.loom', from="loom", to="sce", outFile='filename.rds')
```

## Tips
- **Python Environment**: Ensure `anndata` and `loompy` are installed in the Python environment used by `reticulate`.
- **File Paths**: When converting "to" a format that results in a file (like `anndata` or `loom`), provide the `outFile` argument.
- **Memory**: Large datasets may require significant RAM during conversion as objects are often duplicated in memory during the process.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)