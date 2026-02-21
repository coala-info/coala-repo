# R Package for Analyzing Tomo-seq Data

Ryosuke Matsuzawa

#### 30 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Installation and loading](#installation-and-loading)
* [3 Data preparation](#data-preparation)
  + [3.1 Tomo-seq data preparation](#tomo-seq-data-preparation)
  + [3.2 Tomo-seq data from Junker 2014](#tomo-seq-data-from-junker-2014)
  + [3.3 Mask data preparation](#mask-data-preparation)
  + [3.4 How to use Masker (tomoseqr mask maker)](#how-to-use-masker-tomoseqr-mask-maker)
* [4 Reconstruction of 3D expression patterns](#reconstruction-of-3d-expression-patterns)
* [5 Visualize result of reconstruction](#visualize-result-of-reconstruction)
* [6 Find axial peak gene](#find-axial-peak-gene)
* [7 SessionInfo](#sessioninfo)

# 1 Introduction

Tomo-seq is a genome-wide RNA tomography method that combines combining
high-throughput RNA sequencing with cryosectioning for spatially resolved
transcriptomics.
In 2014, [Junker et al.](https://doi.org/10.1016/j.cell.2014.09.038) published a method for reconstructing 3D gene
expression patterns from tomoseq data (iterative proportional fitting ([Fienberg, 1970](https://doi.org/10.1214/aoms/1177696968))). tomoseqr is a package to run
this method in R. tomoseqr also includes a 3D silhouette maker
for samples and tools to visualize the reconstruction results.

# 2 Installation and loading

Install the `tomoseqr` package with the following command.

```
# for bioconductor
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("tomoseqr")
```

Load the `tomoseqr` package with the following command.

```
library(tomoseqr)
```

# 3 Data preparation

`tomoseqr` requires Tomo-seq data in three directions (x, y, and z-axes) and a mask.

## 3.1 Tomo-seq data preparation

Tomo-seq data must meet the following conditions.

1. It is a data frame with a header.
2. The first column is the gene ID (string), and the second and subsequent
   columns are the expression levels (numeric) at each sections.
3. The order of the second and subsequent rows is the same as the order of
   the sections.
4. The second and subsequent rows are ordered from left to right
   (not right to left) of the intercept for each axis.
5. One row corresponds to one gene.

The `tomoseqr` package provides artificial tomoseq data as an example.

```
data(testx, testy, testz)
head(testx)
```

```
## # A tibble: 4 × 51
##   geneID    V1    V2    V3    V4    V5    V6    V7    V8    V9   V10   V11   V12
##   <chr>  <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
## 1 gene1      0     0     0     0     0     0     0     0     0     0     0     0
## 2 gene2    230   470   650   850  1010  1170  1370  1510  1650  1730  1910  2030
## 3 gene3      0     0     0     0     0     0     0     0     0     0   100   900
## 4 gene4  29770 29530 29350 29150 28990 28830 28630 28490 28350 28270 27990 27070
## # ℹ 38 more variables: V13 <dbl>, V14 <dbl>, V15 <dbl>, V16 <dbl>, V17 <dbl>,
## #   V18 <dbl>, V19 <dbl>, V20 <dbl>, V21 <dbl>, V22 <dbl>, V23 <dbl>,
## #   V24 <dbl>, V25 <dbl>, V26 <dbl>, V27 <dbl>, V28 <dbl>, V29 <dbl>,
## #   V30 <dbl>, V31 <dbl>, V32 <dbl>, V33 <dbl>, V34 <dbl>, V35 <dbl>,
## #   V36 <dbl>, V37 <dbl>, V38 <dbl>, V39 <dbl>, V40 <dbl>, V41 <dbl>,
## #   V42 <dbl>, V43 <dbl>, V44 <dbl>, V45 <dbl>, V46 <dbl>, V47 <dbl>,
## #   V48 <dbl>, V49 <dbl>, V50 <dbl>
```

## 3.2 Tomo-seq data from Junker 2014

You can download part of the Tomo-seq data published by [Junker et al.](https://www.sciencedirect.com/science/article/pii/S0092867414012264#mmc3) with following commands.

```
tomoCache <- downloadJunker2014()
junker2014 <- doadJunker2014(tomoCache)

sheldAV <- junker2014[["sheldAV"]]
sheldVD <- junker2014[["sheldVD"]]
sheldLR <- junker2014[["sheldLR"]]
mask <- junker2014[["mask"]]
```

## 3.3 Mask data preparation

Mask is a 3-dimensional matrix that represents the shape of the sample.
The value of each element indicates whether a voxel is included in the
sample or not. For example, if the voxel at coordinates (2, 3, 4) is
contained in the material, then The value of the element (2, 3, 4) in
the mask is 1. Conversely, the voxel at coordinates (10, 11, 12) is not
included in the sample, then the value of the mask element (10, 11, 12)
is 0.

The `tomoseqr` package provides artificial mask data as an example.

```
data(mask)
```

## 3.4 How to use Masker (tomoseqr mask maker)

The `tomoseqr` package provides a tool to create mask data,
which can be run with the following command.

```
masker()
```

![](data:image/png;base64...)

Interface of masker

You can create mask data using masker by create cross sections along
certain axes.

1. To create a new mask, select `new mask` under `How input`.
2. Set the number of sections for each axis in the
   `Number of intercept` field.
3. In `width of cells`, set the thickness of the intercept for each axis
   as a relative value.
   (This is only related to the appearance of the mask creation screen, so
   it does not have to be strict.)
4. Set along which axis you create the mask in the `Along which axis?`
   field.
5. Click `make table`, and a mask creation screen appears.
6. On the mask creation screen, create a cross-sectional view
   as if you were creating pixel art.
7. Click `Download as .rda` to output mask data as rda file.

# 4 Reconstruction of 3D expression patterns

Use the `estimate3dExpressions` function to reconstruct the 3D expression
pattern of the gene specified by `query` from Tomo-seq data.

```
tomoObj <- estimate3dExpressions(
    testx,
    testy,
    testz,
    mask = mask,
    query = c("gene1", "gene2", "gene3")
)
```

# 5 Visualize result of reconstruction

Visualize the reconstruction results using `imageViewer`.

```
imageViewer(tomoObj)
```

This command starts a shiny app `imageViewer`.

![](data:image/png;base64...)

Interface of ImageViewer (2D view)

![](data:image/png;base64...)

Interface of ImageViewer (3D view)

1. Select gene ID.
2. Edit labels of each axes.
3. Set the width of sections for each axis. it is used to calculate the
   aspect ratio of figures.
4. Use this tab to switch between 2D and 3D views.
5. Select which axis to look at the cross section perpendicular to.
6. Move the slider to select the location you want to see. Press the Auto Play button to view each section of the image
   frame by frame.
7. Edit figure titles and labels.
8. Specify the range of expression levels to be displayed (default is
   the full range).
9. Rendering area.
10. Obtain a cross-sectional view (png) or a frame-by-frame image (gif)
    of each fragment being displayed.
11. Threshold of expression level. Expression points with levels lower than
    this value are not plotted.
12. Toggle whether or not to plot points representing the mask.

# 6 Find axial peak gene

Detect genes with significant differences in expression levels between
sections from Tomo-seq data.

```
axialGeneTable <- findAxialGenes(testx)
print(axialGeneTable)
```

```
## # A tibble: 4 × 4
##   geneID   max meanExeptMax isPeakGene
##   <chr>  <dbl>        <dbl>      <dbl>
## 1 gene1   3100        551.           0
## 2 gene2   5560       2334.           0
## 3 gene3    900         22.4         12
## 4 gene4  29990      26898.           0
```

The results include these columns:

* GeneID: Gene ID.
* max: The maximum expression level of the gene.
* meanExeptMax: Average of expression levels excluding the maximum.
* index: Number of the section containing the maximum expression level.

You can also specify a vector of candidate gene IDs.

```
axialGeneTable <- findAxialGenes(testx, genes = c("gene1", "gene3"))
print(axialGeneTable)
```

```
## # A tibble: 2 × 4
##   geneID   max meanExeptMax isPeakGene
##   <chr>  <dbl>        <dbl>      <dbl>
## 1 gene1   3100        551.           0
## 2 gene3    900         22.4         12
```

# 7 SessionInfo

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
## [1] tomoseqr_1.14.0  BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
##  [4] ggplot2_4.0.0       httr2_1.2.1         htmlwidgets_1.6.4
##  [7] tzdb_0.5.0          vctrs_0.6.5         tools_4.5.1
## [10] generics_0.1.4      curl_7.0.0          tibble_3.3.0
## [13] RSQLite_2.4.3       blob_1.2.4          pkgconfig_2.0.3
## [16] data.table_1.17.8   dbplyr_2.5.1        RColorBrewer_1.1-3
## [19] S7_0.2.0            lifecycle_1.0.4     stringr_1.5.2
## [22] compiler_4.5.1      farver_2.1.2        httpuv_1.6.16
## [25] htmltools_0.5.8.1   sass_0.4.10         yaml_2.3.10
## [28] lazyeval_0.2.2      plotly_4.11.0       pillar_1.11.1
## [31] later_1.4.4         jquerylib_0.1.4     tidyr_1.3.1
## [34] cachem_1.1.0        mime_0.13           tidyselect_1.2.1
## [37] digest_0.6.37       stringi_1.8.7       dplyr_1.1.4
## [40] purrr_1.1.0         animation_2.8       bookdown_0.45
## [43] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
## [46] magrittr_2.0.4      utf8_1.2.6          dichromat_2.0-0.1
## [49] withr_3.0.2         readr_2.1.5         filelock_1.0.3
## [52] scales_1.4.0        promises_1.4.0      rappdirs_0.3.3
## [55] bit64_4.6.0-1       rmarkdown_2.30      httr_1.4.7
## [58] bit_4.6.0           otel_0.2.0          hms_1.1.4
## [61] memoise_2.0.1       shiny_1.11.1        evaluate_1.0.5
## [64] knitr_1.50          BiocFileCache_3.0.0 viridisLite_0.4.2
## [67] rlang_1.1.6         Rcpp_1.1.0          xtable_1.8-4
## [70] glue_1.8.0          DBI_1.2.3           BiocManager_1.30.26
## [73] jsonlite_2.0.0      R6_2.6.1
```