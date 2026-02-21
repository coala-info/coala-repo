# 1 Introduction

The *[imcdatasets](https://bioconductor.org/packages/3.22/imcdatasets)* package provides access to publicly available
datasets generated using imaging mass cytometry (IMC) (**???**).

IMC is a technology that enables measurement of up to 50 markers from tissue
sections at a resolution of 1 \(\mu m\) (**???**). In classical processing
pipelines, such as the [ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)
or [steinbock](https://bodenmillergroup.github.io/steinbock/latest/), the
multichannel images are segmented to generate cells masks. These masks are then
used to extract single cell features from the multichannel images.

Each dataset in `imcdatasets` is composed of three elements that can be
retrieved separately:
1. Single-cell data in the form of a `SingleCellExperiment` or
`SpatialExperiment` class object (named `sce.rds`).
2. Multichannel images in the form of a `CytoImageList` class object (named
`images.rds`).
3. Cell segmentation masks in the form of a `CytoImageList` class object (named
`masks.rds`).

# 2 Available datasets

The `listDatasets()` function returns all available datasets in `imcdatasets`,
along with associated information. The `FunctionCall` column gives the name of
the R function that enables to load the dataset.

```
datasets <- listDatasets()
datasets <- as.data.frame(datasets)
datasets$FunctionCall <- sprintf("`%s`", datasets$FunctionCall)
knitr::kable(datasets)
```

| FunctionCall | Species | Tissue | NumberOfCells | NumberOfImages | NumberOfChannels | Reference |
| --- | --- | --- | --- | --- | --- | --- |
| `Damond_2019_Pancreas()` | Human | Pancreas | 252059 | 100 | 38 | (**???**) |
| `HochSchulz_2022_Melanoma()` | Human | Metastatic melanoma | 325881 | 50 | 41 | (**???**) |
| `JacksonFischer_2020_BreastCancer()` | Human | Primary breast tumour | 285851 | 100 | 42 | (**???**) |
| `Zanotelli_2020_Spheroids()` | Human | Cell line spheroids | 229047 | 517 | 51 | (**???**) |
| `IMMUcan_2022_CancerExample()` | Human | Primary tumor | 46825 | 14 | 40 | None |

# 3 Retrieving data

Users can import the datasets by calling a single function and specifying the
type of data to retrieve. The following examples highlight accessing an example
dataset linked to the [IMMUcan](https://immucan.eu/) project.

**Importing single-cell expression data and metadata**

```
sce <- IMMUcan_2022_CancerExample("sce")
sce
```

```
## class: SingleCellExperiment
## dim: 40 47794
## metadata(5): color_vectors cluster_codes SOM_codes delta_area
##   filterSpatialContext
## assays(2): counts exprs
## rownames(40): MPO H3 ... DNA1 DNA2
## rowData names(17): channel metal ... ilastik deepcell
## colnames(47794): 1_1 1_2 ... 14_2844 14_2845
## colData names(43): sample_id ObjectNumber ... cell_x cell_y
## reducedDimNames(8): UMAP TSNE ... seurat UMAP_seurat
## mainExpName: IMMUcan_2022_CancerExample_v1
## altExpNames(0):
```

**Importing multichannel images**

```
images <- IMMUcan_2022_CancerExample("images")
images
```

```
## CytoImageList containing 14 image(s)
## names(14): Patient1_001 Patient1_002 Patient1_003 Patient2_001 Patient2_002 Patient2_003 Patient2_004 Patient3_001 Patient3_002 Patient3_003 Patient4_005 Patient4_006 Patient4_007 Patient4_008
## Each image contains 40 channel(s)
## channelNames(40): MPO H3 SMA CD16 CD38 HLA_DR CD27 CD15 CD45RA CD163 B2M CD20 CD68 IDO1 CD3e LAG3 CD11c PD_1 PDGFRB CD7 GZMB PD_L1 TCF7 CD45RO FOXP3 ICOS CD8a CA9 CD33 Ki67 VISTA CD40 CD4 CD14 CDH1 CD303 CD206 c_PARP DNA1 DNA2
```

**Importing cell segmentation masks**

```
masks <- IMMUcan_2022_CancerExample("masks")
masks
```

```
## CytoImageList containing 14 image(s)
## names(14): Patient1_001 Patient1_002 Patient1_003 Patient2_001 Patient2_002 Patient2_003 Patient2_004 Patient3_001 Patient3_002 Patient3_003 Patient4_005 Patient4_006 Patient4_007 Patient4_008
## Each image contains 1 channel
```

**On disk storage**

Objects containing multi-channel images and segmentation masks can furthermore
be stored on disk rather than in memory. Nevertheless, they need to be loaded
into memory once before writing them to disk. This process takes longer than
keeping them in memory but reduces memory requirements during downstream
analysis.

To write images or masks to disk, set `on_disk = TRUE` and specify a path
where images/masks will be stored as .h5 files:

```
# Create temporary location
cur_path <- tempdir()

masks <- IMMUcan_2022_CancerExample(data_type = "masks", on_disk = TRUE,
    h5FilesPath = cur_path)
masks
```

```
## CytoImageList containing 14 image(s)
## names(14): Patient1_001 Patient1_002 Patient1_003 Patient2_001 Patient2_002 Patient2_003 Patient2_004 Patient3_001 Patient3_002 Patient3_003 Patient4_005 Patient4_006 Patient4_007 Patient4_008
## Each image contains 1 channel
```

# 4 Dataset info and metadata

Additional information about each dataset is available in the help page:

```
?IMMUcan_2022_CancerExample
```

The metadata associated with a specific data object can be displayed as
follows:

```
IMMUcan_2022_CancerExample(data_type = "sce", metadata = TRUE)
IMMUcan_2022_CancerExample(data_type = "images", metadata = TRUE)
IMMUcan_2022_CancerExample(data_type = "masks", metadata = TRUE)
```

# 5 Usage

The `SingleCellExperiment` class objects can be used for data analysis. For
more information, please refer to the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)*
package and to the [Orchestrating Single-Cell Analysis with Bioconductor](http://bioconductor.org/books/release/OSCA/) workflow.

The `CytoImageList` class objects can be used for plotting cell and pixel
information. Some typical use cases are given below. For more information,
please see the *[cytomapper](https://bioconductor.org/packages/3.22/cytomapper)* package and the
[associated vignette](https://www.bioconductor.org/packages/devel/bioc/vignettes/cytomapper/inst/doc/cytomapper.html).

**Subsetting the images and masks**

```
cur_images <- images[1:5]
cur_masks <- masks[1:5]
```

**Plotting pixel information**

The `images` objects can be used to display pixel-level data.

```
plotPixels(
    cur_images,
    colour_by = c("CD8a", "CD68", "CDH1"),
    bcg = list(
        CD8a = c(0,4,1),
        CD68 = c(0,5,1),
        CDH1 = c(0,5,1)
    )
)
```

![](data:image/png;base64...)

**Plotting cell information**

The `masks` and `sce` objects can be combined to display cell-level data.

```
plotCells(
    cur_masks, object = sce,
    img_id = "image_number", cell_id = "cell_number",
    colour_by = c("CD8a", "CD68", "CDH1"),
    exprs_values = "exprs"
)
```

![](data:image/png;base64...)

**Outlining cells on images**

Cell information can be displayed on top of images by combining the `images`,
`masks` and `sce` objects.

```
plotPixels(
    cur_images, mask = cur_masks, object = sce,
    img_id = "image_number", cell_id = "cell_number",
    outline_by = "cell_type",
    colour_by = c("CD8a", "CD68", "CDH1"),
    bcg = list(
        CD8a  = c(0,5,1),
        CD68 = c(0,5,1),
        CDH1 = c(0,5,1)
    )
)
```

![](data:image/png;base64...)

# Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] imcdatasets_1.18.0          SpatialExperiment_1.20.0
##  [3] cytomapper_1.22.0           EBImage_4.52.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3            bitops_1.0-9         httr2_1.2.1
##   [4] gridExtra_2.3        rlang_1.1.6          magrittr_2.0.4
##   [7] svgPanZoom_0.3.4     shinydashboard_0.7.3 otel_0.2.0
##  [10] RSQLite_2.4.3        compiler_4.5.1       png_0.1-8
##  [13] systemfonts_1.3.1    fftwtools_0.9-11     vctrs_0.6.5
##  [16] crayon_1.5.3         pkgconfig_2.0.3      fastmap_1.2.0
##  [19] dbplyr_2.5.1         magick_2.9.0         XVector_0.50.0
##  [22] promises_1.5.0       rmarkdown_2.30       ggbeeswarm_0.7.2
##  [25] tinytex_0.57         purrr_1.1.0          bit_4.6.0
##  [28] xfun_0.54            cachem_1.1.0         jsonlite_2.0.0
##  [31] blob_1.2.4           later_1.4.4          rhdf5filters_1.22.0
##  [34] DelayedArray_0.36.0  Rhdf5lib_1.32.0      BiocParallel_1.44.0
##  [37] jpeg_0.1-11          tiff_0.1-12          terra_1.8-70
##  [40] parallel_4.5.1       R6_2.6.1             bslib_0.9.0
##  [43] RColorBrewer_1.1-3   jquerylib_0.1.4      Rcpp_1.1.0
##  [46] bookdown_0.45        knitr_1.50           httpuv_1.6.16
##  [49] Matrix_1.7-4         nnls_1.6             tidyselect_1.2.1
##  [52] dichromat_2.0-0.1    abind_1.4-8          yaml_2.3.10
##  [55] viridis_0.6.5        codetools_0.2-20     curl_7.0.0
##  [58] lattice_0.22-7       tibble_3.3.0         withr_3.0.2
##  [61] KEGGREST_1.50.0      shiny_1.11.1         S7_0.2.0
##  [64] evaluate_1.0.5       BiocFileCache_3.0.0  Biostrings_2.78.0
##  [67] ExperimentHub_3.0.0  filelock_1.0.3       pillar_1.11.1
##  [70] BiocManager_1.30.26  sp_2.2-0             RCurl_1.98-1.17
##  [73] BiocVersion_3.22.0   ggplot2_4.0.0        scales_1.4.0
##  [76] xtable_1.8-4         glue_1.8.0           tools_4.5.1
##  [79] AnnotationHub_4.0.0  locfit_1.5-9.12      rhdf5_2.54.0
##  [82] grid_4.5.1           AnnotationDbi_1.72.0 raster_3.6-32
##  [85] beeswarm_0.4.0       HDF5Array_1.38.0     vipor_0.4.7
##  [88] cli_3.6.5            rappdirs_0.3.3       textshaping_1.0.4
##  [91] S4Arrays_1.10.0      viridisLite_0.4.2    svglite_2.2.2
##  [94] dplyr_1.1.4          gtable_0.3.6         sass_0.4.10
##  [97] digest_0.6.37        SparseArray_1.10.1   rjson_0.2.23
## [100] htmlwidgets_1.6.4    farver_2.1.2         memoise_2.0.1
## [103] htmltools_0.5.8.1    lifecycle_1.0.4      httr_1.4.7
## [106] h5mread_1.2.0        mime_0.13            bit64_4.6.0-1
```

# 6 References