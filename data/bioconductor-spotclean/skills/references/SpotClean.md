# SpotClean adjusts for spot swapping in spatial transcriptomics data

Zijian Ni and Christina Kendziorski

#### 2026-02-05

#### Package

SpotClean 1.12.1

# Contents

* [1 Introduction](#introduction)
* [2 Quick Start](#quick-start)
  + [2.1 Installation](#installation)
  + [2.2 Short Demo](#short-demo)
  + [2.3 Working with the `SpatialExperiment` class](#working-with-the-spatialexperiment-class)
  + [2.4 Running Speed](#running-speed)
  + [2.5 Situations you should think twice about before applying SpotClean](#situations-you-should-think-twice-about-before-applying-spotclean)
  + [2.6 Recommended applications](#recommended-applications)
* [3 Detailed Steps](#detailed-steps)
  + [3.1 Load count matrix and slide information from 10x Space Ranger output](#load-count-matrix-and-slide-information-from-10x-space-ranger-output)
  + [3.2 Create the slide object](#create-the-slide-object)
  + [3.3 Visualize the slide object](#visualize-the-slide-object)
  + [3.4 Decontaminate the data](#decontaminate-the-data)
  + [3.5 Estimate contamination levels in observed data](#estimate-contamination-levels-in-observed-data)
  + [3.6 ARC score](#arc-score)
  + [3.7 Convert to Seurat object for downstream analyses](#convert-to-seurat-object-for-downstream-analyses)
* [4 Session Information](#session-information)
* [5 Citation](#citation)

# 1 Introduction

Spatial transcriptomics (ST), named [Method of the Year 2020](https://www.nature.com/articles/s41592-020-01033-y) by *Nature Methods* in 2020, is a powerful and widely-used experimental method for profiling genome-wide gene expression across a tissue. In a typical ST experiment, fresh-frozen (or FFPE) tissue is sectioned and placed onto a slide containing spots, with each spot containing millions of capture oligonucleotides with spatial barcodes unique to that spot. The tissue is imaged, typically via Hematoxylin and Eosin (H&E) staining. Following imaging, the tissue is permeabilized to release mRNA which then binds to the capture oligonucleotides, generating a cDNA library consisting of transcripts bound by barcodes that preserve spatial information. Data from an ST experiment consists of the tissue image coupled with RNA-sequencing data collected from each spot. A first step in processing ST data is tissue detection, where spots on the slide containing tissue are distinguished from background spots without tissue. Unique molecular identifier (UMI) counts at each spot containing tissue are then used in downstream analyses.

Ideally, a gene-specific UMI at a given spot would represent expression of that gene at that spot, and spots without tissue would show no (or few) UMIs. This is not the case in practice. Messenger RNA bleed from nearby spots causes substantial contamination of UMI counts, an artifact we refer to as spot swapping. On average, we observe that more than 30% of UMIs at a tissue spot did not originate from this spot, but from other spots contaminating it. Spot swapping confounds downstream inferences including normalization, marker gene-based annotation, differential expression and cell type decomposition.

We developed **SpotClean** to adjust for the effects of spot swapping in ST experiments. SpotClean is able to measure the per-spot contamination rates in observed data and decontaminate gene expression levels, thus increases the sensitivity and precision of downstream analyses. Our package `SpotClean` is built based on 10x Visium spatial transcriptomics experiments, currently the most widely-used commercial protocol, providing functions to load raw spatial transcriptomics data from 10x Space Ranger outputs, decontaminate the spot swapping effect, estimate contamination levels, visualize expression profiles and spot labels on the slide, and connect with other widely-used packages for further analyses. SpotClean can be potentially extended to other spatial transcriptomics data as long as the gene expression data in both tissue and background regions are available. `SpotClean` is compatible with the [`SpatialExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) class and supports downstream analyses via [`Seurat`](https://satijalab.org/seurat/).

As a computational tool for analyzing spatial transcriptomics data, `SpotClean` has been submitted to [Bioconductor](https://www.bioconductor.org/), making the R package well-documented and well-maintained for improved reproducibility and user experience.

# 2 Quick Start

## 2.1 Installation

Install from Bioconductor:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SpotClean")
```

Load package after installation:

```
library(SpotClean)
library(S4Vectors)
```

## 2.2 Short Demo

Here we quickly demonstrate the general SpotClean workflow on the built-in example data. A step-by-step illustration can be found in the next section.

Note: codes in this chunk are only for illustrative purpose and are not runnable. Runnable codes can be found in the next section.

```
# Not run

# Load 10x Visium data
mbrain_raw <- read10xRaw("/path/to/matrix/folder")
mbrain_slide_info <- read10xSlide("/path/to/tissue/csv",
                                  "/path/to/tissue/image",
                                  "/path/to/scale/factor")

# Visualize raw data
mbrain_obj <- createSlide(count_mat = mbrain_raw,
                          slide_info = mbrain_slide_info)
visualizeSlide(slide_obj = mbrain_obj)
visualizeHeatmap(mbrain_obj,rownames(mbrain_raw)[1])

# Decontaminate raw data
decont_obj <- spotclean(mbrain_obj)

# Visualize decontaminated gene
visualizeHeatmap(decont_obj,rownames(mbrain_raw)[1])

# Visualize the estimated per-spot contamination rate
visualizeHeatmap(decont_obj,metadata(decont_obj)$contamination_rate,
                 logged = FALSE, legend_title = "contamination rate",
                 legend_range = c(0,1))

# (Optionally) Transform to Seurat object for downstream analyses
seurat_obj <- convertToSeurat(decont_obj,image_dir = "/path/to/spatial/folder")
```

## 2.3 Working with the `SpatialExperiment` class

[`SpatialExperiment`](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) is another widely used S4 class for storing ST data, including the count matrix, cell and gene-level metadata, and tissue image. `spotclean()` can be directly applied to `SpatialExperiment` objects constructed from `SpatialExperiment::read10xVisium()`, which reads in the raw data from 10x Visium Space Ranger output. The visualization functions in our package currently do not support `SpatialExperiment` class, but there are alternative options such as [`ggspavis`](https://bioconductor.org/packages/release/bioc/html/ggspavis.html).

```
# Not run
library(SpatialExperiment)
slide_obj <- read10xVisium(samples = "/path/to/spaceranger/output/",
                         data = "raw") # must specify data = "raw"
decont_obj <- spotclean(slide_obj)
str(assays(decont_obj)$decont)
```

## 2.4 Running Speed

The computational speed is related to the size and structure of input datasets, mainly driven by the number of tissue spots. SpotClean does not require parallel computation, and thus does not use up too many CPU or memory resources. As a reference, SpotClean running on a medium-size dataset (around 30,000 genes and 2,000 tissue spots) under default gene filtering takes less than 15 minutes.

## 2.5 Situations you should think twice about before applying SpotClean

* **Too many tissue spots (not enough background spots)** While the observed data is a single matrix with a fixed number of columns (spots), the number of unknown parameters is proportional to the number of tissue spots. In the extreme case where all spots are covered by tissue, we have more unknown parameters than observed data values. In this case the contaminated expressions are confounded with true expressions, and SpotClean estimation becomes unreliable. We recommend that the input data have at least 25% spots not occupied by tissue, so that SpotClean has enough information from background spots to estimate contamination.
* **Lowly-expressed genes** Lowly-expressed genes typically contain relatively less information and relatively more noise than highly-expressed genes. SpotClean by default only keeps highly-expressed or highly-variable genes for decontamination (or both). It can be forced to run on manually-specified lowly-expressed genes. However, even in this case, expression for the lowly-expressed genes is typically not changed very much. Given the high sparsity in most lowly expressed genes, there is not enough information available to confidently reassign UMIs in most cases. However, we do not filter genes by sparsity because there can be interesting genes highly concentrated in a small tissue region. In cases like this, SpotClean is effective at adjusting for spot swapping in these regions. If the defaults are not appropriate, users can either adjust the expression cutoffs or manually specify genes to decontaminate.
* **Inference based on sequencing depth** SpotClean reassigns bled-out UMIs to their tissue spots of origin which changes the estimated sequencing depth of tissue spots after decontamination, since most estimations of sequencing depth rely on total expressions at every spot. As a result, decontamination can be considered as another type of normalization and might conflict with existing sequencing depth normalization methods.

## 2.6 Recommended applications

SpotClean leads to improved estimates of expression by correcting for spot swapping. In other words, SpotClean reduces noise by enhancing signal in highly expressed regions and reducing measured signal in unexpressed regions. Consequently, SpotClean will improve the accuracy of marker gene-based inferences including tissue type annotation, cell type decomposition, integration with single-cell RNA-seq data, and associated downstream analyses. SpotClean also improves the identification of spatially variable and differentially expressed (DE) genes. We note that in some cases, the p-values associated with known DE genes may increase slightly following SpotClean due to increased variability within the spot groups (i.e. truly expressed regions become more highly expressed; and signal is removed from unexpressed regions).

SpotClean will not alter clusters substantially in most datasets given that clusters are largely determined by relatively few highly expressed genes. While clusters may become slightly better defined, in most cases we do not see big differences in the number of clusters and/or relationships among clusters after applying SpotClean.

# 3 Detailed Steps

## 3.1 Load count matrix and slide information from 10x Space Ranger output

Currently, the most widely-used spatial transcriptomics protocol is 10x Visium. Public 10x datasets can be found [here](https://support.10xgenomics.com/spatial-gene-expression/datasets/). In this vignette, we illustrate the usage of `SpotClean` using the [V1\_Adult\_Mouse\_Brain](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.0.0/V1_Adult_Mouse_Brain) Visium data.

Two parts of 10x Space Ranger output files are required as input to `SpotClean`: the raw gene-by-spot count matrix, and the slide metadata. In this example, you can download and unzip the [Feature / cell matrix (raw)](https://cf.10xgenomics.com/samples/spatial-exp/1.0.0/V1_Adult_Mouse_Brain/V1_Adult_Mouse_Brain_raw_feature_bc_matrix.tar.gz) and [Spatial imaging data](https://cf.10xgenomics.com/samples/spatial-exp/1.0.0/V1_Adult_Mouse_Brain/V1_Adult_Mouse_Brain_spatial.tar.gz) from [V1\_Adult\_Mouse\_Brain](https://support.10xgenomics.com/spatial-gene-expression/datasets/1.0.0/V1_Adult_Mouse_Brain). You will get a folder `raw_feature_bc_matrix` containing `barcodes.tsv.gz`, `features.tsv.gz`, `matrix.mtx.gz`, and a folder `spatial` containing `aligned_fiducials.jpg`, `detected_tissue_image.jpg`, `tissue_hires_image.png`, `tissue_lowres_image.png`, `tissue_positions_list.csv`, `scalefactors_json.json`. The former folder contains the raw gene-by-spot count matrix, and the latter contains slide metadata like slide images and spot IDs and positions.

`SpotClean` provides functions `read10xRaw()` and `read10xSlide()` to directly read these 10x Space Ranger output files and generate a gene-by-spot count matrix and slide metadata in R. Here for the purpose of demonstration, we have provided the count matrix and slide metadata with our package. The count matrix is a built-in example object `mbrain_raw`, which is a subset of the gene-by-spot count matrix from `read10xRaw()`, containing the top 100 highest expressed genes. The slide metadata, located at `extdata/V1_Adult_Mouse_Brain_spatial`, contains the three basic files (`tissue_positions_list.csv`, `tissue_lowres_image.png`, `scalefactors_json.json`) to run SpotClean and other associated packages in this vignette.

```
# load count matrix
data(mbrain_raw)
str(mbrain_raw)
```

```
## Formal class 'dgCMatrix' [package "Matrix"] with 6 slots
##   ..@ i       : int [1:457217] 0 1 2 3 4 5 6 7 8 9 ...
##   ..@ p       : int [1:4993] 0 99 199 299 399 499 592 692 788 857 ...
##   ..@ Dim     : int [1:2] 100 4992
##   ..@ Dimnames:List of 2
##   .. ..$ : chr [1:100] "Bc1" "Gm42418" "mt-Co3" "mt-Atp6" ...
##   .. ..$ : chr [1:4992] "AAACAACGAATAGTTC-1" "AAACAAGTATCTCCCA-1" "AAACAATCTACTAGCA-1" "AAACACCAATAACTGC-1" ...
##   ..@ x       : num [1:457217] 141 266 217 202 106 102 84 50 56 44 ...
##   ..@ factors : list()
```

```
# read spatial metadata
spatial_dir <- system.file(file.path("extdata",
                                     "V1_Adult_Mouse_Brain_spatial"),
                           package = "SpotClean")
list.files(spatial_dir)
```

```
## [1] "scalefactors_json.json"    "tissue_lowres_image.png"
## [3] "tissue_positions_list.csv"
```

```
mbrain_slide_info <- read10xSlide(tissue_csv_file=file.path(spatial_dir,
                                       "tissue_positions_list.csv"),
             tissue_img_file = file.path(spatial_dir,
                                       "tissue_lowres_image.png"),
             scale_factor_file = file.path(spatial_dir,
                                       "scalefactors_json.json"))
str(mbrain_slide_info)
```

```
## List of 2
##  $ slide:'data.frame':   4992 obs. of  8 variables:
##   ..$ barcode : chr [1:4992] "ACGCCTGACACGCGCT-1" "TACCGATCCAACACTT-1" "ATTAAAGCGGACGAGC-1" "GATAAGGGACGATTAG-1" ...
##   ..$ tissue  : Factor w/ 2 levels "0","1": 1 1 1 1 1 1 1 1 1 1 ...
##   ..$ row     : int [1:4992] 0 1 0 1 0 1 0 1 0 1 ...
##   ..$ col     : int [1:4992] 0 1 2 3 4 5 6 7 8 9 ...
##   ..$ imagerow: num [1:4992] 63.8 70 63.8 70 63.8 ...
##   ..$ imagecol: num [1:4992] 61.8 65.3 68.8 72.3 75.8 ...
##   ..$ height  : int [1:4992] 600 600 600 600 600 600 600 600 600 600 ...
##   ..$ width   : int [1:4992] 576 576 576 576 576 576 576 576 576 576 ...
##  $ grob :List of 12
##   ..$ raster     : 'raster' chr [1:600, 1:576] "#81837E" "#80837E" "#81837E" "#81837E" ...
##   ..$ x          : 'simpleUnit' num 0.5npc
##   .. ..- attr(*, "unit")= int 0
##   ..$ y          : 'simpleUnit' num 0.5npc
##   .. ..- attr(*, "unit")= int 0
##   ..$ width      : 'simpleUnit' num 1npc
##   .. ..- attr(*, "unit")= int 0
##   ..$ height     : 'simpleUnit' num 1npc
##   .. ..- attr(*, "unit")= int 0
##   ..$ just       : chr "centre"
##   ..$ hjust      : NULL
##   ..$ vjust      : NULL
##   ..$ interpolate: logi TRUE
##   ..$ name       : chr "GRID.rastergrob.11"
##   ..$ gp         : list()
##   .. ..- attr(*, "class")= chr "gpar"
##   ..$ vp         : NULL
##   ..- attr(*, "class")= chr [1:3] "rastergrob" "grob" "gDesc"
```

## 3.2 Create the slide object

In the following, we will show the `SpotClean` workflow using the built-in example data.

We combine count matrix and slide metadata together as one single slide object with class `SummarizedExperiment`:

```
slide_obj <- createSlide(mbrain_raw, mbrain_slide_info)
slide_obj
```

```
## class: SummarizedExperiment
## dim: 100 4992
## metadata(2): slide grob
## assays(1): raw
## rownames(100): Bc1 Gm42418 ... Rps25 Rps20
## rowData names(0):
## colnames(4992): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ...
##   TTGTTTGTATTACACG-1 TTGTTTGTGTAAATTC-1
## colData names(0):
```

As shown above, the raw count matrix is stored in the `raw` assay slot, and slide and image information are stored in `slide` and `grob` metadata slots.

## 3.3 Visualize the slide object

Our package provides multiple visualization functions in the 2-D slide space. Function `visualizeSlide()` shows the input slide imaging file (if given) in R:

```
visualizeSlide(slide_obj)
```

![](data:image/png;base64...)

Function `visualizeLabel()` shows the spot labels. You can specify the column name of character labels in the `slide` metadata, or manually provide a vector of character labels corresponding to each spot. For example, we can plot their tissue/background labels, which has been pre-stored in the input slide information:

```
visualizeLabel(slide_obj,"tissue")
```

![](data:image/png;base64...)

Function `visualizeHeatmap()` draws a heatmap of values at every spot in the 2-D slide space. Similar to `visualizeLabel()`, you can specify the column name of numerical values in the `slide` metadata, or manually provide a vector of numerical values corresponding to each spot. For example, we can plot the total UMI counts in every spot,:

```
metadata(slide_obj)$slide$total_counts <- Matrix::colSums(mbrain_raw)
visualizeHeatmap(slide_obj,"total_counts")
```

![](data:image/png;base64...)

You can also provide a certain gene name appearing in the raw count matrix in input slide object to `visualizeHeatmap()`. For example, the expression of the Mbp gene can be visualized:

```
visualizeHeatmap(slide_obj,"Mbp")
```

![](data:image/png;base64...)

`visualizeLabel()` and `visualizeHeatmap()` both support manual label/value inputs, subsetting spots to plot, title and legend name modification. `visualizeHeatmap()` also supports different color palettes (rainbow vs. viridis) and log-scaling options. These visualization functions return `ggplot2` objects, which can be further modified by users.

## 3.4 Decontaminate the data

`spotclean()` is the main function for performing decontamination. It takes the slide object of raw data as input together with some parameters for controlling optimization and convergence, and returns a slide object with decontaminated gene expressions and other model-related parameters and statistics appending to the slide information. Detailed parameter explanations can be found by running `?spotclean`. Here we set `maxit=10` and `candidate_radius=20` to save computation time. In practice, `spotclean()` by default evaluates a series of candidate radii and automatically chooses the best one. The default maximum number of iterations is 30, which can be extended if convergence has not been reached.

```
decont_obj <- spotclean(slide_obj, maxit=10, candidate_radius = 20)
```

Check the structure of output slide object:

```
decont_obj
```

```
## class: SummarizedExperiment
## dim: 100 2702
## metadata(10): slide grob ... contamination_rate ARC_score
## assays(1): decont
## rownames(100): Bc1 Gm42418 ... Rps25 Rps20
## rowData names(0):
## colnames(2702): AAACAAGTATCTCCCA-1 AAACAATCTACTAGCA-1 ...
##   TTGTTTCCATACAACT-1 TTGTTTGTGTAAATTC-1
## colData names(0):
```

```
names(metadata(decont_obj))
```

```
##  [1] "slide"                "grob"                 "bleeding_rate"
##  [4] "distal_rate"          "contamination_radius" "weight_matrix"
##  [7] "loglh"                "decontaminated_genes" "contamination_rate"
## [10] "ARC_score"
```

The metadata now contains more information including parameter estimates from the SpotClean model and measurements of contamination levels.

We can visualize the Mbp gene expressions after 10 iterations of decontamination:

```
visualizeHeatmap(decont_obj,"Mbp")
```

![](data:image/png;base64...)

## 3.5 Estimate contamination levels in observed data

Our model is able to estimate the proportion of contaminated expression at each tissue spot (i.e. expression at a tissue spot that originated from a different spot due to spot swapping):

```
summary(metadata(decont_obj)$contamination_rate)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## 0.04444 0.23049 0.29294 0.30955 0.36716 1.00000
```

This indicates around 30% of UMIs at a tissue spot in the observed data came from spot swapping contamination, averaging across all tissue spots.

## 3.6 ARC score

We also provide another subjective estimation of contamination level, called the ambient RNA contamination (ARC) score. It can be calculated using function `arcScore()`, and is also part of the decontamination outputs. Intuitively, the ARC score is a conserved lower bound of the proportion of contamination in observed tissue spots. The ARC score can also be applied in droplet-based single-cell data to estimate ambient RNA contamination when replacing background spots with empty droplets. Details can be found by running `?arcScore`.

```
arcScore(slide_obj)
```

```
## [1] 0.05160659
```

This indicates at least 5% expressions in observed data came from spot swapping contamination.

## 3.7 Convert to Seurat object for downstream analyses

`convertToSeurat()` can be used to convert our slide object to a Seurat spatial object. Note that Seurat requires input of the spatial folder.

```
seurat_obj <- convertToSeurat(decont_obj,image_dir = spatial_dir)
```

# 4 Session Information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
## [1] S4Vectors_0.48.0    BiocGenerics_0.56.0 generics_0.1.4
## [4] SpotClean_1.12.1    knitr_1.51          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] spatstat.utils_3.2-1        farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.7.1
##   [9] ROCR_1.0-12                 spatstat.explore_3.7-0
##  [11] tinytex_0.58                bmp_0.3.1
##  [13] S4Arrays_1.10.1             htmltools_0.5.9
##  [15] readbitmap_0.1.5            Rhdf5lib_1.32.0
##  [17] rhdf5_2.54.1                SparseArray_1.10.8
##  [19] sass_0.4.10                 sctransform_0.4.3
##  [21] parallelly_1.46.1           KernSmooth_2.23-26
##  [23] bslib_0.10.0                htmlwidgets_1.6.4
##  [25] ica_1.0-3                   plyr_1.8.9
##  [27] plotly_4.12.0               zoo_1.8-15
##  [29] cachem_1.1.0                igraph_2.2.1
##  [31] mime_0.13                   lifecycle_1.0.5
##  [33] pkgconfig_2.0.3             Matrix_1.7-4
##  [35] R6_2.6.1                    fastmap_1.2.0
##  [37] MatrixGenerics_1.22.0       fitdistrplus_1.2-6
##  [39] future_1.69.0               shiny_1.12.1
##  [41] digest_0.6.39               patchwork_1.3.2
##  [43] Seurat_5.4.0                tensor_1.5.1
##  [45] RSpectra_0.16-2             irlba_2.3.7
##  [47] GenomicRanges_1.62.1        labeling_0.4.3
##  [49] progressr_0.18.0            spatstat.sparse_3.1-0
##  [51] httr_1.4.7                  polyclip_1.10-7
##  [53] abind_1.4-8                 compiler_4.5.2
##  [55] withr_3.0.2                 S7_0.2.1
##  [57] tiff_0.1-12                 viridis_0.6.5
##  [59] fastDummies_1.7.5           MASS_7.3-65
##  [61] DelayedArray_0.36.0         rjson_0.2.23
##  [63] tools_4.5.2                 lmtest_0.9-40
##  [65] otel_0.2.0                  httpuv_1.6.16
##  [67] future.apply_1.20.1         goftest_1.2-3
##  [69] glue_1.8.0                  rhdf5filters_1.22.0
##  [71] nlme_3.1-168                promises_1.5.0
##  [73] grid_4.5.2                  Rtsne_0.17
##  [75] cluster_2.1.8.2             reshape2_1.4.5
##  [77] gtable_0.3.6                spatstat.data_3.1-9
##  [79] tidyr_1.3.2                 data.table_1.18.2.1
##  [81] XVector_0.50.0              sp_2.2-0
##  [83] spatstat.geom_3.7-0         RcppAnnoy_0.0.23
##  [85] ggrepel_0.9.6               RANN_2.6.2
##  [87] pillar_1.11.1               stringr_1.6.0
##  [89] spam_2.11-3                 RcppHNSW_0.6.0
##  [91] later_1.4.5                 splines_4.5.2
##  [93] dplyr_1.2.0                 lattice_0.22-7
##  [95] survival_3.8-6              deldir_2.0-4
##  [97] tidyselect_1.2.1            SingleCellExperiment_1.32.0
##  [99] miniUI_0.1.2                pbapply_1.7-4
## [101] gridExtra_2.3               bookdown_0.46
## [103] IRanges_2.44.0              Seqinfo_1.0.0
## [105] SummarizedExperiment_1.40.0 scattermore_1.2
## [107] xfun_0.56                   Biobase_2.70.0
## [109] matrixStats_1.5.0           stringi_1.8.7
## [111] lazyeval_0.2.2              yaml_2.3.12
## [113] evaluate_1.0.5              codetools_0.2-20
## [115] tibble_3.3.1                BiocManager_1.30.27
## [117] cli_3.6.5                   uwot_0.2.4
## [119] xtable_1.8-4                reticulate_1.44.1
## [121] jquerylib_0.1.4             dichromat_2.0-0.1
## [123] Rcpp_1.1.1                  globals_0.19.0
## [125] spatstat.random_3.4-4       png_0.1-8
## [127] spatstat.univar_3.1-6       parallel_4.5.2
## [129] ggplot2_4.0.2               dotCall64_1.2
## [131] jpeg_0.1-11                 listenv_0.10.0
## [133] SpatialExperiment_1.20.0    viridisLite_0.4.3
## [135] scales_1.4.0                ggridges_0.5.7
## [137] SeuratObject_5.3.0          purrr_1.2.1
## [139] rlang_1.1.7                 cowplot_1.2.0
```

# 5 Citation

`SpotClean` can be cited at:

Ni, Z., Prasad, A., Chen, S. et al. SpotClean adjusts for spot swapping in spatial transcriptomics data. *Nat Commun* 13, 2971 (2022). <https://doi.org/10.1038/s41467-022-30587-y>