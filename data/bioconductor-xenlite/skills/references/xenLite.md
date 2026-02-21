# xenLite: exploration of a class for Xenium demonstration data

Vincent J. Carey, stvjc at channing.harvard.edu

#### October 30, 2025

# Contents

* [1 Introduction](#introduction)
  + [1.1 Motivation](#motivation)
  + [1.2 Installation](#installation)
  + [1.3 Data](#data)
  + [1.4 A quick look](#a-quick-look)
    - [1.4.1 Hybrid example](#hybrid-example)
    - [1.4.2 Interactivity](#interactivity)
    - [1.4.3 Large disk-based example](#large-disk-based-example)
* [2 Session information](#session-information)

# 1 Introduction

## 1.1 Motivation

Numerous groups are working on methodology for analyzing
new data resources emerging from spatial transcriptomics experiments.
The “computing technology stack” necessary to work
with such data is complex. The following
[comment](https://spatialdata.scverse.org/en/latest/tutorials/notebooks/notebooks/examples/models1.html)
(Aug 16 2024) from the scverse group is characteristic:

> The SpatialData Zarr format, which is described in our design doc, is an extension of the OME-NGFF specification, which makes use of the OME-Zarr, the AnnData Zarr and the Parquet file formats. We need to use these combination of technologies because currently OME-NGFF does not provide all the fundamentals required for storing spatial omics dataset; nevertheless, we try to stay as close as OME-NGFF as possible, and we are contributing to ultimately make spatial omics support available in pure OME-NGFF.

In Bioconductor 3.19, we might be committed to all these technologies (which
include but do not mention HDF5) plus
R, reticulate, basilisk, and sf to have a widely functional solution.
Attaching the [Voyager](https://bioconductor.org/packages/Voyager)
package leads to loading over 100 associated packages.
The xenLite package is intended to explore the balance between functionality
and high dependency load specifically for the analysis of outputs
from 10x Xenium experiments. The XenSPEP class extends
[SpatialExperiment](https://bioconductor.org/packages/SpatialExperiment) to
include references to parquet
files that manage voluminous geometry data; geometry can also be handled as DataFrame for sufficiently
low volume experiments.

As of 0.0.7 of xenLite, a new class, XenSPEP, is provided to address
parquet representation of cell, nucleus and transcript coordinates.

## 1.2 Installation

To install in Bioconductor 3.20 or later:

```
BiocManager::install("xenLite")
```

## 1.3 Data

This package is based on publicly available datasets.

* **Human dermal melanoma** [FFPE Human pan tissue dataset](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-skin). For this dataset, we
  retrieved the `outs.zip` file from this site and ran `XenSCE::ingestXen`
  on the contents, producing a XenSPEP instance which was then saved
  in an HDF5-backed representation. This, along with the parquet
  files for cell, nucleus, and transcript coordinates, are zipped together
  and placed in an Open Storage Network bucket for retrieval via
  `cacheXenPdmelLite`.
* **Human prostate adenocarcinoma** [FFPE Human pan tissue dataset](https://www.10xgenomics.com/datasets/xenium-prime-ffpe-human-prostate). For this dataset, we
  retrieved the `outs.zip` file from this site and ran `XenSCE::ingestXen`
  on the contents, producing a XenSPEP instance which was then saved
  in an HDF5-backed representation. This, along with the parquet
  files for cell, nucleus, and transcript coordinates, are zipped together
  and placed in an Open Storage Network bucket for retrieval via
  `cacheXenProstLite`.
* **Human Lung** [FFPE Lung cancer preview](https://www.10xgenomics.com/datasets/preview-data-ffpe-human-lung-cancer-with-xenium-multimodal-cell-segmentation-1-standard),
  Use `example(cacheXenLuad)` to obtain this instance of XenSPEP.

## 1.4 A quick look

### 1.4.1 Hybrid example

In this example, transcript counts are in memory
in a sparse matrix, but geometry information is
handled in parquet. The `viewSegG2` function
allows selection of two gene symbols, and
cells are colored according to single or double
occupancy.

```
library(xenLite)
pa <- cacheXenLuad()
luad <- restoreZipXenSPEP(pa)
rownames(luad) <- make.names(SummarizedExperiment:::rowData(luad)$Symbol, unique = TRUE)
out <- viewSegG2(luad, c(5800, 6300), c(1300, 1800), lwd = .5, gene1 = "CD4", gene2 = "EPCAM")
legend(5800, 1390, fill = c("purple", "cyan", "pink"), legend = c("CD4", "EPCAM", "both"))
```

![](data:image/png;base64...)

```
out$ncells
```

```
## [1] 2074
```

### 1.4.2 Interactivity

In `inst/app4`, code is provided to work with the primary dermal melanoma
dataset. A map of the cell coordinates can drive focused exploration. The
region of interest is shown by a whitened rectangle in the upper left corner.

![Map based on cell centroids.](data:image/png;base64...)

Figure 1: Map based on cell centroids

Cells are colored by quintile of size. Points where FBL transcripts
are found are plotted as dots.

![Zoom to slider-specified subplot.](data:image/png;base64...)

Figure 2: Zoom to slider-specified subplot

More work is needed to identify useful exploratory visualizations.

### 1.4.3 Large disk-based example

#### 1.4.3.1 HDF5+parquet-backed example: *not ready in xenLite*

We want to be able to accommodate very large numbers of
cells and transcripts without heavy infrastructure
commitments.

We’ll use the prostate adenocarcinoma 5K dataset to demonstrate.
A 900MB zip file will be cached.

```
prost <- cacheXenProstLite()
```

`prost` is the path to a zip file in a BiocFileCache instance.

Create a folder to work in, and unzip.

```
dir.create(xpw <- file.path(tempdir(), "prost_work"))
unzip(prost, exdir = xpw)
dir(xpw)
```

Restore the SpatialExperiment component.

```
prostx <- HDF5Array::loadHDF5SummarizedExperiment(file.path(xpw, "xen_prost"))
prostx
```

# 2 Session information

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] xenLite_1.4.0    BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1            EBImage_4.52.0
##  [3] dplyr_1.1.4                 farver_2.1.2
##  [5] blob_1.2.4                  arrow_22.0.0
##  [7] filelock_1.0.3              S7_0.2.0
##  [9] bitops_1.0-9                fastmap_1.2.0
## [11] SingleCellExperiment_1.32.0 RCurl_1.98-1.17
## [13] BiocFileCache_3.0.0         promises_1.4.0
## [15] digest_0.6.37               mime_0.13
## [17] lifecycle_1.0.4             RSQLite_2.4.3
## [19] magrittr_2.0.4              compiler_4.5.1
## [21] rlang_1.1.6                 sass_0.4.10
## [23] tools_4.5.1                 yaml_2.3.10
## [25] knitr_1.50                  S4Arrays_1.10.0
## [27] htmlwidgets_1.6.4           bit_4.6.0
## [29] curl_7.0.0                  DelayedArray_0.36.0
## [31] RColorBrewer_1.1-3          abind_1.4-8
## [33] HDF5Array_1.38.0            withr_3.0.2
## [35] purrr_1.1.0                 BiocGenerics_0.56.0
## [37] grid_4.5.1                  stats4_4.5.1
## [39] xtable_1.8-4                Rhdf5lib_1.32.0
## [41] ggplot2_4.0.0               scales_1.4.0
## [43] tinytex_0.57                dichromat_2.0-0.1
## [45] SummarizedExperiment_1.40.0 cli_3.6.5
## [47] rmarkdown_2.30              generics_0.1.4
## [49] otel_0.2.0                  rjson_0.2.23
## [51] DBI_1.2.3                   cachem_1.1.0
## [53] rhdf5_2.54.0                assertthat_0.2.1
## [55] BiocManager_1.30.26         XVector_0.50.0
## [57] tiff_0.1-12                 matrixStats_1.5.0
## [59] vctrs_0.6.5                 Matrix_1.7-4
## [61] jsonlite_2.0.0              bookdown_0.45
## [63] IRanges_2.44.0              fftwtools_0.9-11
## [65] S4Vectors_0.48.0            bit64_4.6.0-1
## [67] magick_2.9.0                jpeg_0.1-11
## [69] h5mread_1.2.0               locfit_1.5-9.12
## [71] jquerylib_0.1.4             glue_1.8.0
## [73] gtable_0.3.6                later_1.4.4
## [75] GenomicRanges_1.62.0        tibble_3.3.0
## [77] pillar_1.11.1               rappdirs_0.3.3
## [79] htmltools_0.5.8.1           Seqinfo_1.0.0
## [81] rhdf5filters_1.22.0         R6_2.6.1
## [83] dbplyr_2.5.1                httr2_1.2.1
## [85] evaluate_1.0.5              shiny_1.11.1
## [87] lattice_0.22-7              Biobase_2.70.0
## [89] png_0.1-8                   SpatialExperiment_1.20.0
## [91] memoise_2.0.1               httpuv_1.6.16
## [93] bslib_0.9.0                 Rcpp_1.1.0
## [95] SparseArray_1.10.0          xfun_0.53
## [97] MatrixGenerics_1.22.0       pkgconfig_2.0.3
```