# Segmenting and normalizing multiplexed imaging data with simpleSeg

Alexander Nicholls1, Ellis Patrick1,2 and Nicolas Canete2

1School of Mathematics and Statistics, University of Sydney, Australia
2Westmead Institute for Medical Research, University of Sydney, Australia

#### 30 October 2025

# Contents

* [1 Installation](#installation)
* [2 Overview](#overview)
* [3 Load example data](#load-example-data)
* [4 Segmentation](#segmentation)
  + [4.1 Visualise separation](#visualise-separation)
  + [4.2 Visualise outlines](#visualise-outlines)
  + [4.3 Methods of Watershedding](#methods-of-watershedding)
  + [4.4 Methods of cell body identification](#methods-of-cell-body-identification)
  + [4.5 Parallel Processing](#parallel-processing)
* [5 Summarise cell features](#summarise-cell-features)
* [6 Normalising cells](#normalising-cells)
  + [6.1 QC normalisation](#qc-normalisation)
  + [6.2 Session Info](#session-info)

```
# load required packages
library(simpleSeg)
library(ggplot2)
library(EBImage)
library(cytomapper)
```

# 1 Installation

```
# Install the package from Bioconductor
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

BiocManager::install("simpleSeg")
```

# 2 Overview

The `simpleSeg` package extends existing bioconductor packages such as `cytomapper` and `EBImage` by providing a structured pipeline for creating segmentation masks from multiplexed cellular images in the form of tiff stacks. This allows for the single cell information of these images to be extracted in R, without the need for external segmentation programs. `simpleSeg` also facilitates the normalisation of cellular features after these features have been extracted from the image, priming cells for classification / clustering. These functions leverage the functionality of the [`EBImage`](https://bioconductor.org/packages/release/bioc/vignettes/EBImage/inst/doc/EBImage-introduction.html) package on Bioconductor. For more flexibility when performing your segmentation in R we recommend learning to use the `EBimage` package. A key strength of `simpleSeg` is that we have coded multiple ways to perform some simple segmentation operations as well as incorporating multiple automatic procedures to optimise key parameters when these aren’t specified.

# 3 Load example data

In the following we will reanalyse two MIBI-TOF images from [(Risom et al., 2022)](https://www.sciencedirect.com/science/article/pii/S0092867421014860?via%3Dihub#!) profiling the spatial landscape of ductal carcinoma in situ (DCIS), which is a pre-invasive lesion that is thought to be a precursor to invasive breast cancer (IBC). These images are stored in the “extdata” folder in the package. When the path to this folder is identified, we can read these images into R using `readImage` from `EBImage` and store these as a `CytoImageList` using the `cytomapper` package.

```
# Get path to image directory
pathToImages <- system.file("extdata", package = "simpleSeg")

# Get directories of images

imageDirs <- dir(pathToImages, "Point", full.names = TRUE)
names(imageDirs) <- dir(pathToImages, "Point", full.names = FALSE)

# Get files in each directory
files <- files <- lapply(
  imageDirs,
  list.files,
  pattern = "tif",
  full.names = TRUE
)

# Read files with readImage from EBImage
images <- lapply(files, EBImage::readImage, as.is = TRUE)

# Convert to cytoImageList
images <- cytomapper::CytoImageList(images)
mcols(images)$imageID <- names(images)
```

# 4 Segmentation

`simpleSeg` accepts an `Image`, `list` of `Image`’s, or `CytoImageList` as input and generates a `CytoImageList` of masks as output. Here we will use the histone H3 channel in the image as a nuclei marker for segmentation. By default, `simpleseg` will isolate individual nuclei by watershedding using a combination of the intensity of this marker and a distance map. Nuclei are dilated out by 3 pixels to capture the cytoplasm. The user may also specify simple image transformations using the `transform` argument.

```
masks <- simpleSeg::simpleSeg(images,
  nucleus = "HH3",
  transform = "sqrt"
)
```

## 4.1 Visualise separation

The `display` and `colorLabels` functions in `EBImage` make it very easy to examine the performance of the cell segmentation. The great thing about `display` is that if used in an interactive session it is very easy to zoom in and out of the image.

```
# Visualise segmentation performance one way.
EBImage::display(colorLabels(masks[[1]]))
```

![](data:image/png;base64...)

## 4.2 Visualise outlines

The `plotPixels` function in `cytomapper` make it easy to overlay the masks on top of the intensities of 6 markers. Here we can see that the segmentation appears to be performing reasonably.

```
# Visualise segmentation performance another way.
cytomapper::plotPixels(
  image = images[1],
  mask = masks[1],
  img_id = "imageID",
  colour_by = c("PanKRT", "GLUT1", "HH3", "CD3", "CD20"),
  display = "single",
  colour = list(
    HH3 = c("black", "blue"),
    CD3 = c("black", "purple"),
    CD20 = c("black", "green"),
    GLUT1 = c("black", "red"),
    PanKRT = c("black", "yellow")
  ),
  bcg = list(
    HH3 = c(0, 1, 1.5),
    CD3 = c(0, 1, 1.5),
    CD20 = c(0, 1, 1.5),
    GLUT1 = c(0, 1, 1.5),
    PanKRT = c(0, 1, 1.5)
  ),
  legend = NULL
)
```

![](data:image/png;base64...)

## 4.3 Methods of Watershedding

Watershedding is a method which treats images as topographical maps in order to identify individual objects and the borders between them.

The user may specify how watershedding is to be performed by using the `watershed` argument in `simpleSeg`.

| Method | Description |  |
| --- | --- | --- |
| “distance” | Performs watershedding on a distance map of the thresholded nuclei signal. With a pixels distance being defined as the distance from the closest background signal. |  |
| “intensity” | Performs watershedding using the intensity of the nuclei marker. |  |
| “combine” | Combines the previous two methods by multiplying the distance map by the nuclei marker intensity. |  |

## 4.4 Methods of cell body identification

The cell body can also be identified in `simpleSeg` using models of varying complexity, specified with the `cellBody` argument.

| Method | Description |  |
| --- | --- | --- |
| “dilation” | Dilates the nuclei by an amount defined by the user. The size of the dilatation in pixels may be specified with the `discDize` argument. |  |
| “discModel” | Uses all the markers to predict the presence of dilated ‘discs’ around the nuclei. The model therefore learns which markers are typically present in the cell cytoplasm and generates a mask based on this. |  |
| “marker” | The user may specify one or multiple dedicated cytoplasm markers to predict the cytoplasm. This can be done using `cellBody = "marker name"/"index"` |  |
| “None” | The nuclei mask is returned directly. |  |

## 4.5 Parallel Processing

`simpleSeg` also supports parallel processing, with the `cores` argument being used to specify how many cores should be used.

```
masks <- simpleSeg::simpleSeg(images,
  nucleus = "HH3",
  cores = 1
)
```

# 5 Summarise cell features

In order to characterise the phenotypes of each of the segmented cells, `measureObjects` from `cytomapper` will calculate the average intensity of each channel within each cell as well as a few morphological features. The channel intensities will be stored in the `counts assay` in a `SingleCellExperiment`. Information on the spatial location of each cell is stored in `colData` in the `m.cx` and `m.cy` columns. In addition to this, it will propagate the information we have store in the `mcols` of our `CytoImageList` in the `colData` of the resulting `SingleCellExperiment`.

```
cellSCE <- cytomapper::measureObjects(masks, images, img_id = "imageID")
```

# 6 Normalising cells

Once cellular features have been extracted into a SingleCellExperement or dataframe, these features may then be normalised using the `normalizeCells`function, transformed by any number of transformations (e.g., `asinh`, `sqrt`) and normalisation methods.

`mean`(Divides the marker cellular marker intensities by their mean), `minMax` (Subtracts the minimum value and scales markers between 0 and 1.), `trim99` (Sets the highest 1% of values to the value of the 99th percentile.), `PC1` (Removes the 1st principal component) can be performed with one call of the function, in the order specified by the user.

| Method | Description |  |
| --- | --- | --- |
| “mean” | Divides the marker cellular marker intensities by their mean. |  |
| “minMax” | Subtracts the minimum value and scales markers between 0 and 1. |  |
| “trim99” | Sets the highest 1% of values to the value of the 99th percentile.` |  |
| “PC1” | Removes the 1st principal component) can be performed with one call of the function, in the order specified by the user. |  |

```
# Transform and normalise the marker expression of each cell type.
# Use a square root transform, then trimmed the 99 quantile
cellSCE <- normalizeCells(cellSCE,
  assayIn = "counts",
  assayOut = "norm",
  imageID = "imageID",
  transformation = "sqrt",
  method = c("trim99", "minMax")
)
```

## 6.1 QC normalisation

We could check to see if the marker intensities of each cell require some form of transformation or normalisation. Here we extract the intensities from the `counts` assay. Looking at PanKRT which should be expressed in the majority of the tumour cells, the intensities are clearly very skewed.

```
# Extract marker data and bind with information about images
df <- as.data.frame(cbind(colData(cellSCE), t(assay(cellSCE, "counts"))))

# Plots densities of PanKRT for each image.
ggplot(df, aes(x = PanKRT, colour = imageID)) +
  geom_density() +
  labs(x = "PanKRT expression") +
  theme_minimal()
```

![](data:image/png;base64...)

We can see that the normalised data stored in the norm assay appears more bimodal, not perfect, but likely sufficient for clustering.

```
# Extract normalised marker information.
df <- as.data.frame(cbind(colData(cellSCE), t(assay(cellSCE, "norm"))))

# Plots densities of normalised PanKRT for each image.
ggplot(df, aes(x = PanKRT, colour = imageID)) +
  geom_density() +
  labs(x = "PanKRT expression") +
  theme_minimal()
```

![](data:image/png;base64...)

## 6.2 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] cytomapper_1.22.0           SingleCellExperiment_1.32.0
#>  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
#>  [5] GenomicRanges_1.62.0        Seqinfo_1.0.0
#>  [7] IRanges_2.44.0              S4Vectors_0.48.0
#>  [9] BiocGenerics_0.56.0         generics_0.1.4
#> [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
#> [13] EBImage_4.52.0              ggplot2_4.0.0
#> [15] simpleSeg_1.12.0            BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] bitops_1.0-9             deldir_2.0-4             gridExtra_2.3
#>  [4] rlang_1.1.6              magrittr_2.0.4           svgPanZoom_0.3.4
#>  [7] shinydashboard_0.7.3     otel_0.2.0               compiler_4.5.1
#> [10] spatstat.geom_3.6-0      png_0.1-8                systemfonts_1.3.1
#> [13] fftwtools_0.9-11         vctrs_0.6.5              pkgconfig_2.0.3
#> [16] SpatialExperiment_1.20.0 fastmap_1.2.0            magick_2.9.0
#> [19] XVector_0.50.0           labeling_0.4.3           promises_1.4.0
#> [22] rmarkdown_2.30           ggbeeswarm_0.7.2         tinytex_0.57
#> [25] xfun_0.53                cachem_1.1.0             jsonlite_2.0.0
#> [28] later_1.4.4              rhdf5filters_1.22.0      DelayedArray_0.36.0
#> [31] spatstat.utils_3.2-0     Rhdf5lib_1.32.0          BiocParallel_1.44.0
#> [34] jpeg_0.1-11              tiff_0.1-12              terra_1.8-70
#> [37] parallel_4.5.1           R6_2.6.1                 spatstat.data_3.1-9
#> [40] bslib_0.9.0              RColorBrewer_1.1-3       spatstat.univar_3.1-4
#> [43] jquerylib_0.1.4          Rcpp_1.1.0               bookdown_0.45
#> [46] knitr_1.50               httpuv_1.6.16            Matrix_1.7-4
#> [49] nnls_1.6                 tidyselect_1.2.1         dichromat_2.0-0.1
#> [52] abind_1.4-8              yaml_2.3.10              viridis_0.6.5
#> [55] codetools_0.2-20         lattice_0.22-7           tibble_3.3.0
#> [58] withr_3.0.2              shiny_1.11.1             S7_0.2.0
#> [61] evaluate_1.0.5           polyclip_1.10-7          pillar_1.11.1
#> [64] BiocManager_1.30.26      sp_2.2-0                 RCurl_1.98-1.17
#> [67] scales_1.4.0             xtable_1.8-4             glue_1.8.0
#> [70] tools_4.5.1              locfit_1.5-9.12          rhdf5_2.54.0
#> [73] grid_4.5.1               raster_3.6-32            beeswarm_0.4.0
#> [76] HDF5Array_1.38.0         vipor_0.4.7              cli_3.6.5
#> [79] textshaping_1.0.4        S4Arrays_1.10.0          viridisLite_0.4.2
#> [82] svglite_2.2.2            dplyr_1.1.4              gtable_0.3.6
#> [85] sass_0.4.10              digest_0.6.37            SparseArray_1.10.0
#> [88] rjson_0.2.23             htmlwidgets_1.6.4        farver_2.1.2
#> [91] htmltools_0.5.8.1        lifecycle_1.0.4          h5mread_1.2.0
#> [94] mime_0.13
```