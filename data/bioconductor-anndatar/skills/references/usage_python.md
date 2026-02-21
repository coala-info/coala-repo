# Python Integration with anndataR

#### 29 January 2026

#### Package

anndataR 1.0.1

# Contents

* [1 Introduction](#introduction)
  + [1.1 Prerequisites](#prerequisites)
* [2 Basic Integration with *scanpy*](#basic-integration-with-scanpy)
* [3 Conversion to R objects](#conversion-to-r-objects)
* [4 Multi-modal data with *mudata*](#multi-modal-data-with-mudata)
* [5 Session info](#session-info)
  + [5.1 R](#r)
  + [5.2 Python](#python)

# 1 Introduction

*[anndataR](https://bioconductor.org/packages/3.22/anndataR)* works with Python `AnnData` objects through *[reticulate](https://CRAN.R-project.org/package%3Dreticulate)*.
You can load Python objects, apply Python functions to them, and convert them to `Seurat` or `SingleCellExperiment` objects.

```
message(
  "Python packages scanpy and mudata are required to run this vignette. Code chunks will not be evaluated."
)
#> Python packages scanpy and mudata are required to run this vignette. Code chunks will not be evaluated.
```

## 1.1 Prerequisites

This vignette requires Python with the *scanpy* and *mudata* packages installed.
If these are not available, the code chunks will not be evaluated but the examples remain visible.

# 2 Basic Integration with *scanpy*

Install required Python packages if needed:

```
reticulate::py_require("scanpy")
```

```
library(anndataR)
library(reticulate)
sc <- import("scanpy")
```

Load a dataset directly from *scanpy*:

```
adata <- sc$datasets$pbmc3k_processed()
adata
```

Apply *scanpy* functions directly:

```
sc$pp$filter_cells(adata, min_genes = 200L)
sc$pp$normalize_total(adata, target_sum = 1e4)
sc$pp$log1p(adata)
```

# 3 Conversion to R objects

Convert to `SingleCellExperiment` (see `vignette("usage_singlecellexperiment")`):

```
sce_obj <- adata$as_SingleCellExperiment()
sce_obj
```

Convert to `Seurat` (see `vignette("usage_seurat")`):

```
seurat_obj <- adata$as_Seurat()
seurat_obj
```

# 4 Multi-modal data with *mudata*

Install required Python packages if needed:

```
reticulate::py_install("mudata")
```

```
md <- import("mudata")
```

Load a `MuData` object from file:

```
cache <- BiocFileCache::BiocFileCache(ask = FALSE)
h5mu_file <- BiocFileCache::bfcrpath(
  cache,
  "https://github.com/gtca/h5xx-datasets/raw/b1177ac8877c89d8bb355b072164384b4e9cc81d/datasets/minipbcite.h5mu"
)

mdata <- md$read_h5mu(h5mu_file)
```

Access individual modalities and convert them:

```
rna_mod <- mdata$mod[["rna"]]

rna_seurat <- rna_mod$as_Seurat()
print(rna_seurat)

rna_sce <- rna_mod$as_SingleCellExperiment()
print(rna_sce)
```

# 5 Session info

## 5.1 R

```
sessionInfo()
```

## 5.2 Python

```
reticulate::py_config()

reticulate::py_list_packages()
```