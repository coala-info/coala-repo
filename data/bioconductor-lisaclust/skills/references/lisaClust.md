# Introduction to Clustering of Local Indicators of Spatial Assocation (LISA) curves

Nicolas Canete1\*, Ellis Patrick1,2\*\* and Alex Run Qin1,2\*\*\*

1Westmead Institute for Medical Research, University of Sydney, Australia
2School of Mathematics and Statistics, University of Sydney, Australia

\*nicolas.canete@sydney.edu.au
\*\*ellis.patrick@sydney.edu.au
\*\*\*alex.qin@sydney.edu.au

#### 30 October 2025

#### Abstract

Identify and visualise regions of cell type colocalization in multiplexed imaging data that has been segmented at a single-cell resolution.

#### Package

lisaClust 1.18.0

# Contents

* [1 Installation](#installation)
* [2 Overview](#overview)
* [3 Quick start](#quick-start)
  + [3.1 Generate toy data](#generate-toy-data)
  + [3.2 Create Single Cell Experiment object](#create-single-cell-experiment-object)
  + [3.3 Running lisaCLust](#running-lisaclust)
  + [3.4 Plot identified regions](#plot-identified-regions)
    - [3.4.1 Generate LISA curves](#generate-lisa-curves)
    - [3.4.2 Perform some clustering](#perform-some-clustering)
* [4 Keren et al. breast cancer data.](#keren-et-al.-breast-cancer-data.)
  + [4.1 Read in data](#read-in-data)
  + [4.2 Generate LISA curves](#generate-lisa-curves-1)
  + [4.3 Examine cell type enrichment](#examine-cell-type-enrichment)
  + [4.4 Plot identified regions](#plot-identified-regions-1)
* [5 References](#references)
* **Appendix**
* [A sessionInfo()](#sessioninfo)

# 1 Installation

```
if (!require("BiocManager")) {
  install.packages("BiocManager")
}
BiocManager::install("lisaClust")
```

```
# load required packages
library(lisaClust)
library(spicyR)
library(ggplot2)
library(SingleCellExperiment)
library(SpatialDatasets)
```

# 2 Overview

Clustering local indicators of spatial association (LISA) functions is a
methodology for identifying consistent spatial organisation of multiple
cell-types in an unsupervised way. This can be used to enable the
characterization of interactions between multiple cell-types
simultaneously and can complement traditional pairwise analysis. In our
implementation our LISA curves are a localised summary of an L-function
from a Poisson point process model. Our framework `lisaClust` can be
used to provide a high-level summary of cell-type colocalization in
high-parameter spatial cytometry data, facilitating the identification
of distinct tissue compartments or identification of complex cellular
microenvironments.

# 3 Quick start

## 3.1 Generate toy data

To illustrate our `lisaClust` framework, we consider a very simple
toy example where two cell-types are completely separated spatially. We
simulate data for two different images.

```
set.seed(51773)
x <- round(c(
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3,
  runif(200) + 3, runif(200) + 2, runif(200) + 1, runif(200)
), 4) * 100
y <- round(c(
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3,
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3
), 4) * 100
cellType <- factor(paste("c", rep(rep(c(1:2), rep(200, 2)), 4), sep = ""))
imageID <- rep(c("s1", "s2"), c(800, 800))

cells <- data.frame(x, y, cellType, imageID)

ggplot(cells, aes(x, y, colour = cellType)) +
  geom_point() +
  facet_wrap(~imageID) +
  theme_minimal()
```

![](data:image/png;base64...)

## 3.2 Create Single Cell Experiment object

First we store our data in a `SingleCellExperiment` object.

```
SCE <- SingleCellExperiment(colData = cells)
SCE
## class: SingleCellExperiment
## dim: 0 1600
## metadata(0):
## assays(0):
## rownames: NULL
## rowData names(0):
## colnames: NULL
## colData names(4): x y cellType imageID
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

## 3.3 Running lisaCLust

We can then use the convenience function `lisaClust` to simultaneously
calculate local indicators of spatial association (LISA) functions and perform
k-means clustering. The number of clusters can be specified with the `k =` parameter.
In the example below, we’ve chosen `k = 2`, resulting in a total of 2 clusters. The cell type column can be specified using the `cellType =` argument. By default, `lisaClust` uses the column named `cellType`.

The clusters identified by `lisaClust` are stored in `colData` of the `SingleCellExperiment`
object as a new column called `regions`.

```
SCE <- lisaClust(SCE, k = 2)
colData(SCE) |> head()
## DataFrame with 6 rows and 5 columns
##           x         y cellType     imageID      region
##   <numeric> <numeric> <factor> <character> <character>
## 1     36.72     38.58       c1          s1    region_2
## 2     61.38     41.29       c1          s1    region_2
## 3     33.59     80.98       c1          s1    region_2
## 4     50.17     64.91       c1          s1    region_2
## 5     82.93     35.60       c1          s1    region_2
## 6     83.13      2.69       c1          s1    region_2
```

## 3.4 Plot identified regions

`lisaClust` also provides the convenient `hatchingPlot` function to
visualise the different regions that have been demarcated by the
clustering. `hatchingPlot` outputs a `ggplot` object where the regions
are marked by different hatching patterns. In a real biological dataset,
this allows us to plot both regions and cell-types on the same
visualization.

In the example below, we can visualise our stimulated data where our 2
cell types have been separated neatly into 2 distinct regions based on
which cell type each region is dominated by. `region_2` is dominated by
the red cell type `c1`, and `region_1` is dominated by the blue cell
type `c2`.

```
hatchingPlot(SCE, useImages = c("s1", "s2"))
```

![](data:image/png;base64...)
## Using other clustering methods.

While the `lisaClust` function is convenient, we have not implemented an exhaustive
suite of clustering methods as it is very easy to do this yourself. There are
just two simple steps.

### 3.4.1 Generate LISA curves

We can calculate local indicators of spatial association (LISA) functions
using the `lisa` function. Here the LISA curves are a
localised summary of an L-function from a Poisson point process model. The radii
that will be calculated over can be set with `Rs`.

```
lisaCurves <- lisa(SCE, Rs = c(20, 50, 100))

head(lisaCurves)
##           20_c1     20_c2     50_c1     50_c2    100_c1     100_c2
## cell_1 5.556700 -2.764143 15.631209 -6.910357 11.733097  -9.198914
## cell_2 4.833149 -2.764143 13.940407 -6.910357  9.532662  -8.543440
## cell_3 5.918476 -2.764143  9.008588 -6.910357  9.157887  -7.813862
## cell_4 4.109597 -2.764143 11.907928 -6.910357  8.404425  -8.140036
## cell_5 3.024270 -2.764143 10.159278 -6.910357  9.006286  -8.283564
## cell_6 7.986742 -2.764143  8.675070 -6.910357 12.859615 -13.820714
```

### 3.4.2 Perform some clustering

The LISA curves can then be used to cluster the cells. Here we use k-means
clustering. However, other clustering methods like SOM could also be used. We can store these
cell clusters or cell “regions” in our `SingleCellExperiment` object.

```
# Custom clustering algorithm
kM <- kmeans(lisaCurves, 2)

# Storing clusters into colData
colData(SCE)$custom_region <- paste("region", kM$cluster, sep = "_")
colData(SCE) |> head()
## DataFrame with 6 rows and 6 columns
##           x         y cellType     imageID      region custom_region
##   <numeric> <numeric> <factor> <character> <character>   <character>
## 1     36.72     38.58       c1          s1    region_2      region_2
## 2     61.38     41.29       c1          s1    region_2      region_2
## 3     33.59     80.98       c1          s1    region_2      region_2
## 4     50.17     64.91       c1          s1    region_2      region_2
## 5     82.93     35.60       c1          s1    region_2      region_2
## 6     83.13      2.69       c1          s1    region_2      region_2
```

# 4 Keren et al. breast cancer data.

Next, we apply our `lisaClust` framework to two images of breast cancer obtained by Keren et al. ([2018](#ref-keren2018)).

## 4.1 Read in data

We will start by reading in the data from the `SpatialDatasets` package
as a `SingleCellExperiment` object. Here the data is in a format consistent with
that outputted by CellProfiler.

```
kerenSPE <- SpatialDatasets::spe_Keren_2018()
```

## 4.2 Generate LISA curves

This data includes annotation of the cell-types of each cell. Hence, we can
move directly to performing k-means clustering on the local indicators of
spatial association (LISA) functions using the `lisaClust` function, remembering
to specify the `imageID`, `cellType`, and `spatialCoords`
columns in `colData`. For the purpose of demonstration, we will be using
only images 5 and 6 of the `kerenSPE` dataset.

```
kerenSPE <- kerenSPE[,kerenSPE$imageID %in% c("5", "6")]

kerenSPE <- lisaClust(kerenSPE,
  k = 5
)
```

These regions are stored in `colData` and can be extracted.

```
colData(kerenSPE)[, c("imageID", "region")] |>
  head(20)
## DataFrame with 20 rows and 2 columns
##           imageID      region
##       <character> <character>
## 21154           5    region_4
## 21155           5    region_4
## 21156           5    region_4
## 21157           5    region_3
## 21158           5    region_3
## ...           ...         ...
## 21169           5    region_3
## 21170           5    region_3
## 21171           5    region_1
## 21172           5    region_3
## 21173           5    region_1
```

## 4.3 Examine cell type enrichment

`lisaClust` also provides a convenient function, `regionMap`, for examining which
cell types are located in which regions. In this example, we use this to check
which cell types appear more frequently in each region than expected by chance.

Here, we clearly see that healthy epithelial and mesenchymal tissue are highly
concentrated in region 1, immune cells are concentrated in regions 2 and 4,
whilst tumour cells are concentrated in region 3.

We can further segregate these cells by increasing the number of clusters, i.e.,
increasing the parameter `k =` in the `lisaClust()` function. For the purposes
of demonstration, let’s take a look at the `hatchingPlot` of these regions.

```
regionMap(kerenSPE,
  type = "bubble"
)
```

![](data:image/png;base64...)

## 4.4 Plot identified regions

Finally, we can use `hatchingPlot` to construct a `ggplot` object where
the regions are marked by different hatching patterns. This allows us to
visualize the 5 regions and 17 cell-types simultaneously.

```
hatchingPlot(kerenSPE, nbp = 300)
```

![](data:image/png;base64...)

# 5 References

Keren, L, M Bosse, D Marquez, R Angoshtari, S Jain, S Varma, S Yang, et al. 2018. “A Structured Tumor-Immune Microenvironment in Triple Negative Breast Cancer Revealed by Multiplexed Ion Beam Imaging.” *Cell* 174 (6): 1373–1387.e19.

# Appendix

# A sessionInfo()

```
sessionInfo()
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
##  [1] SpatialDatasets_1.7.3       SpatialExperiment_1.20.0
##  [3] ExperimentHub_3.0.0         AnnotationHub_4.0.0
##  [5] BiocFileCache_3.0.0         dbplyr_2.5.1
##  [7] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [9] Biobase_2.70.0              GenomicRanges_1.62.0
## [11] Seqinfo_1.0.0               IRanges_2.44.0
## [13] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [15] generics_0.1.4              MatrixGenerics_1.22.0
## [17] matrixStats_1.5.0           ggplot2_4.0.0
## [19] spicyR_1.22.0               lisaClust_1.18.0
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] later_1.4.4                 splines_4.5.1
##   [3] bitops_1.0-9                filelock_1.0.3
##   [5] svgPanZoom_0.3.4            tibble_3.3.0
##   [7] polyclip_1.10-7             lifecycle_1.0.4
##   [9] httr2_1.2.1                 Rdpack_2.6.4
##  [11] rstatix_0.7.3               lattice_0.22-7
##  [13] MASS_7.3-65                 MultiAssayExperiment_1.36.0
##  [15] backports_1.5.0             magrittr_2.0.4
##  [17] sass_0.4.10                 rmarkdown_2.30
##  [19] jquerylib_0.1.4             yaml_2.3.10
##  [21] otel_0.2.0                  httpuv_1.6.16
##  [23] doRNG_1.8.6.2               ClassifyR_3.14.0
##  [25] sp_2.2-0                    dcanr_1.26.0
##  [27] spatstat.sparse_3.1-0       DBI_1.2.3
##  [29] minqa_1.2.8                 RColorBrewer_1.1-3
##  [31] abind_1.4-8                 purrr_1.1.0
##  [33] RCurl_1.98-1.17             tweenr_2.0.3
##  [35] rappdirs_0.3.3              spatstat.utils_3.2-0
##  [37] terra_1.8-70                pheatmap_1.0.13
##  [39] goftest_1.2-3               simpleSeg_1.12.0
##  [41] spatstat.random_3.4-2       svglite_2.2.2
##  [43] codetools_0.2-20            DelayedArray_0.36.0
##  [45] ggforce_0.5.0               tidyselect_1.2.1
##  [47] raster_3.6-32               farver_2.1.2
##  [49] viridis_0.6.5               lme4_1.1-37
##  [51] spatstat.explore_3.5-3      jsonlite_2.0.0
##  [53] Formula_1.2-5               survival_3.8-3
##  [55] iterators_1.0.14            systemfonts_1.3.1
##  [57] foreach_1.5.2               tools_4.5.1
##  [59] ggnewscale_0.5.2            Rcpp_1.1.0
##  [61] glue_1.8.0                  gridExtra_2.3
##  [63] SparseArray_1.10.0          BiocBaseUtils_1.12.0
##  [65] xfun_0.53                   mgcv_1.9-3
##  [67] ggthemes_5.1.0              EBImage_4.52.0
##  [69] HDF5Array_1.38.0            dplyr_1.1.4
##  [71] shinydashboard_0.7.3        scam_1.2-20
##  [73] withr_3.0.2                 numDeriv_2016.8-1.1
##  [75] BiocManager_1.30.26         fastmap_1.2.0
##  [77] ggh4x_0.3.1                 rhdf5filters_1.22.0
##  [79] boot_1.3-32                 digest_0.6.37
##  [81] mime_0.13                   R6_2.6.1
##  [83] textshaping_1.0.4           tensor_1.5.1
##  [85] jpeg_0.1-11                 dichromat_2.0-0.1
##  [87] spatstat.data_3.1-9         RSQLite_2.4.3
##  [89] h5mread_1.2.0               tidyr_1.3.1
##  [91] data.table_1.17.8           class_7.3-23
##  [93] htmlwidgets_1.6.4           httr_1.4.7
##  [95] S4Arrays_1.10.0             pkgconfig_2.0.3
##  [97] gtable_0.3.6                blob_1.2.4
##  [99] S7_0.2.0                    XVector_0.50.0
## [101] htmltools_0.5.8.1           carData_3.0-5
## [103] bookdown_0.45               fftwtools_0.9-11
## [105] scales_1.4.0                ggupset_0.4.1
## [107] png_0.1-8                   spatstat.univar_3.1-4
## [109] reformulas_0.4.2            knitr_1.50
## [111] reshape2_1.4.4              rjson_0.2.23
## [113] nlme_3.1-168                curl_7.0.0
## [115] nloptr_2.2.1                bdsmatrix_1.3-7
## [117] rhdf5_2.54.0                cachem_1.1.0
## [119] stringr_1.5.2               BiocVersion_3.22.0
## [121] vipor_0.4.7                 parallel_4.5.1
## [123] concaveman_1.2.0            AnnotationDbi_1.72.0
## [125] pillar_1.11.1               grid_4.5.1
## [127] vctrs_0.6.5                 coxme_2.2-22
## [129] promises_1.4.0              ggpubr_0.6.2
## [131] car_3.1-3                   xtable_1.8-4
## [133] beeswarm_0.4.0              evaluate_1.0.5
## [135] tinytex_0.57                magick_2.9.0
## [137] cli_3.6.5                   locfit_1.5-9.12
## [139] compiler_4.5.1              rlang_1.1.6
## [141] crayon_1.5.3                rngtools_1.5.2
## [143] ggsignif_0.6.4              labeling_0.4.3
## [145] ggbeeswarm_0.7.2            plyr_1.8.9
## [147] stringi_1.8.7               viridisLite_0.4.2
## [149] nnls_1.6                    deldir_2.0-4
## [151] BiocParallel_1.44.0         cytomapper_1.22.0
## [153] lmerTest_3.1-3              Biostrings_2.78.0
## [155] tiff_0.1-12                 spatstat.geom_3.6-0
## [157] V8_8.0.1                    Matrix_1.7-4
## [159] bit64_4.6.0-1               Rhdf5lib_1.32.0
## [161] shiny_1.11.1                KEGGREST_1.50.0
## [163] rbibutils_2.3               igraph_2.2.1
## [165] broom_1.0.10                memoise_2.0.1
## [167] bslib_0.9.0                 bit_4.6.0
```