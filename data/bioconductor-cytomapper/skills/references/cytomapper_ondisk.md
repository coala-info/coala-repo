# On disk storage and handling of images

Nils Eling1,2\*

1Department for Quantitative Biomedicine, University of Zurich
2Institute for Molecular Health Sciences, ETH Zurich

\*nils.eling@dqbm.uzh.ch

#### 29 October 2025

#### Abstract

To scale the functionality of the `cytomapper` package, images can
be stored on disk. For this, images are written onto disk as arrays in
hdf5 format. Writing and accessing these arrays is facilitated by the
`HDF5Array` and `DelayedArray` Bioconductor packages. The functionality
of `cytomapper`remains the same, the only change is how images are read
in. This vignette will give an overview on how to work with images
stored on disk.

#### Package

cytomapper 1.22.0

# 1 Introduction

*[HDF5Array](https://bioconductor.org/packages/3.22/HDF5Array)* and *[DelayedArray](https://bioconductor.org/packages/3.22/DelayedArray)* are
convenient Bioconductor packages to work with arrays “on disk” instead of “in
memory”. The `cytomapper` package builds upon these tools to allow storing image
data on disk. While this facilitates the handling of hundreds to thousand of
images in parallel, little changes are experienced from the user perspective.
Here, we explain which `cytomapper` function are effected by storing images on
disk.

# 2 Reading in data to disk

The `loadImages` function takes extra arguments to specify if images should be
stored on disk (`on_disk`) and where to store them (`h5FilesPath`). When images
should be stored for longer than the current R session, the `h5FilesPath` needs
to be set to a permanent directory. The `HDF5Array` package provides the
`getHDF5DumpDir` function, which initialize a temporary directory, which will be
deleted once the session closes. This is what we will use here for demonstration
purposes.

```
library(HDF5Array)

# Define output directory
cur_dir <- getHDF5DumpDir()

path.to.images <- system.file("extdata", package = "cytomapper")
image.list <- loadImages(path.to.images, pattern = "mask.tiff",
                             on_disk = TRUE, h5FilesPath = cur_dir)

# Show list
image.list
```

```
## CytoImageList containing 3 image(s)
## names(3): E34_mask G01_mask J02_mask
## Each image contains 1 channel
```

```
# Scale images
image.list <- scaleImages(image.list, value = 2^16 - 1)
image.list$E34_mask
```

```
## <100 x 100> DelayedMatrix object of type "double":
##          [,1]   [,2]   [,3] ...  [,99] [,100]
##   [1,]    824    824    824   .   1265   1265
##   [2,]    824    824    824   .   1265      0
##   [3,]    824    824    824   .      0      0
##   [4,]    824    824    824   .      0   1295
##   [5,]    824    824    824   .      0   1295
##    ...      .      .      .   .      .      .
##  [96,]    835      0    876   .      0      0
##  [97,]    835      0    876   .      0      0
##  [98,]    835      0    876   .   1293   1293
##  [99,]      0      0    876   .   1293   1293
## [100,]      0      0      0   .   1293   1293
```

This function call reads in the .tiff images before writing them as .h5 files to
the indicated directory. It generates a `CytoImageList` object that contains
`HDF5Array` or `DelayedArray` objects (instead of `Image` objects) in each slot,
which references the data in the .h5 files. The name of the array within the .h5
file is automatically set as the original filename and cannot be changed easily
from within R. Writing the images to disk is slow and therefore less efficient
compared to keeping images in memory. However, when working with hundreds of
images in parallel, all images remain accessible from within the R session if
they are stored on disk. In conclusion: when working with small image sets it is
recommended reading them into memory (`on_disk = FALSE`, default), while large
image sets should be written to disk (`on_disk = TRUE`). When reading in the
same images multiple times, the .h5 files will always be replaced.

Please follow the [main
vignette](https://bioconductor.org/packages/release/bioc/vignettes/cytomapper/inst/doc/cytomapper.html)
for instructions on how to work with multi-channel images in R.

# 3 Converting from on disk to memory and back

Existing `CytoImageList` objects, which contain individual `Image` objects in
memory can be converted into `CytoImageList` objects storing `DelayedArray` or
`HDF5Array` objects on disk. For this the following function calls can be used:

```
data("pancreasImages")

pancreasImages_onDisk <- CytoImageList(pancreasImages,
                                        on_disk = TRUE,
                                        h5FilesPath = cur_dir)

# Image object
pancreasImages$E34_imc
```

```
## Image
##   colorMode    : Grayscale
##   storage.mode : double
##   dim          : 100 100 5
##   frames.total : 5
##   frames.render: 5
##
## imageData(object)[1:5,1:6,1]
##           [,1]      [,2]         [,3]      [,4]         [,5]         [,6]
## [1,] 2.2357869 0.2537275 1.269632e+00 0.9991982 1.990020e+00 0.000000e+00
## [2,] 2.8855283 1.9900196 2.264642e+00 0.0000000 1.410924e+00 5.654589e-16
## [3,] 3.4009433 0.9950098 9.950098e-01 2.1800663 4.152935e-17 1.990020e+00
## [4,] 3.2238317 3.1750760 1.128341e+00 4.4866042 7.371460e-16 0.000000e+00
## [5,] 0.9987666 1.9900196 2.644036e-15 0.0000000 0.000000e+00 1.523360e+00
```

```
# HDF5Array object
pancreasImages_onDisk$E34_imc
```

```
## <100 x 100 x 5> HDF5Array object of type "double":
## ,,H3
##             [,1]      [,2]      [,3] ...     [,99]    [,100]
##   [1,] 2.2357869 0.2537275 1.2696325   .  7.265561  1.975094
##   [2,] 2.8855283 1.9900196 2.2646422   .  2.985029  2.885528
##    ...         .         .         .   .         .         .
##  [99,]  2.985029  3.636569 22.976585   . 25.371881 12.045588
## [100,]  3.061645  2.985029  1.990020   . 13.353615  5.636652
##
## ...
##
## ,,CDH
##             [,1]      [,2]      [,3] ...    [,99]   [,100]
##   [1,]  0.940284 19.651394 43.284626   . 2.704231 0.000000
##   [2,]  8.393239 29.353861 22.249359   . 7.345311 5.781126
##    ...         .         .         .   .        .        .
##  [99,] 0.9897148 7.3378549 0.0000000   . 0.000000 1.667201
## [100,] 5.8091230 2.2515676 1.9969171   . 4.344125 0.000000
```

```
# Seed of HDF5Array object
seed(pancreasImages_onDisk$E34_imc)
```

```
## An object of class "HDF5ArraySeed"
## Slot "filepath":
## [1] "/tmp/Rtmpn8TzrA/HDF5Array_dump/E34_imc.h5"
##
## Slot "name":
## [1] "/E34_imc"
##
## Slot "as_sparse":
## [1] FALSE
##
## Slot "type":
## [1] NA
##
## Slot "dim":
## [1] 100 100   5
##
## Slot "chunkdim":
## [1] 100 100   5
##
## Slot "first_val":
## [1] 2.235787
```

```
# Size in memory
format(object.size(pancreasImages), units = "auto")
```

```
## [1] "1.2 Mb"
```

```
format(object.size(pancreasImages_onDisk), units = "auto")
```

```
## [1] "11.8 Kb"
```

Images can also be moved back to in memory representation:

```
pancreasImages_inMemory <- CytoImageList(pancreasImages_onDisk,
                                        on_disk = FALSE)

# Compare the image data to the original representation
identical(as.list(pancreasImages_inMemory), as.list(pancreasImages))
```

```
## [1] TRUE
```

# 4 Effects on package functionality

While most functions of the `cytomapper` package natively support images stored
on disk, there are three exceptions: the `normalize`, `setChannels` and
`mergeChannels` functions.

The `normalize` function will store the normalized images as a second dataset in
the same .h5 file as the original data.

```
# Size of object in memory
format(object.size(pancreasImages_onDisk), units = "auto")
```

```
## [1] "11.8 Kb"
```

```
# Size of object on disk in kB
file.info(paste0(cur_dir, "/E34_imc.h5"))[,"size"] / 1000
```

```
## [1] 148.147
```

```
pancreasImages_norm <- normalize(pancreasImages_onDisk)

seed(pancreasImages_norm$E34_imc)
```

```
## An object of class "HDF5ArraySeed"
## Slot "filepath":
## [1] "/tmp/Rtmpn8TzrA/HDF5Array_dump/E34_imc.h5"
##
## Slot "name":
## [1] "/E34_imc_norm"
##
## Slot "as_sparse":
## [1] FALSE
##
## Slot "type":
## [1] NA
##
## Slot "dim":
## [1] 100 100   5
##
## Slot "chunkdim":
## [1] 100 100   5
##
## Slot "first_val":
## [1] 0.01235403
```

```
# Size of object in memory
format(object.size(pancreasImages_norm), units = "auto")
```

```
## [1] "11.8 Kb"
```

```
# Size of object on disk in kB
file.info(paste0(cur_dir, "/E34_imc.h5"))[,"size"] / 1000
```

```
## [1] 414.936
```

As we can see, the size in memory does not increase when normalizing images.
However, the size on disk increases since a second, normalized dataset is stored
in the .h5 file. The original dataset can be overwritten by setting `overwrite = TRUE` to save space on disk. This will however break the links to the original
data in all R objects. It is therefore recommended leaving the default
`overwrite = FALSE`. Furthermore, the normalization of images stored on disk is
slower compared to normalizing images in memory since normalized images need to
be written to disk.

The `setChannels` function replaces the same channels in all images by a user
defined channel. There is no problem with this when keeping images in memory.
However, the `DelayedArray` framework stores the replacement value in
subassignemt operations in memory. This means that when using the `setChannels`
function, the size of the object increases in memory usage:

```
cur_Images1 <- pancreasImages_onDisk
cur_Images2 <- getChannels(pancreasImages_onDisk, 2)
channelNames(cur_Images2) <- "CD99_2"

setChannels(cur_Images1, 1) <- cur_Images2
format(object.size(cur_Images1), units = "auto")
```

```
## [1] "27.2 Kb"
```

The `mergeChannels` function merges multiple user-defined channels. As this
operation creates a completely new image object, one needs to store the merged
channels in a different location:

```
channels1 <- getChannels(pancreasImages_onDisk, 1:2)
channels2 <- getChannels(pancreasImages_onDisk, 3:4)

dir.create(file.path(cur_dir, "test"))
cur_path_2 <- file.path(cur_dir, "test")

channels3 <- mergeChannels(channels1, channels2,
                            h5FilesPath = cur_path_2)

seed(channels3$E34_imc)
```

```
## An object of class "HDF5ArraySeed"
## Slot "filepath":
## [1] "/tmp/Rtmpn8TzrA/HDF5Array_dump/test/E34_imc.h5"
##
## Slot "name":
## [1] "/E34_imc"
##
## Slot "as_sparse":
## [1] FALSE
##
## Slot "type":
## [1] NA
##
## Slot "dim":
## [1] 100 100   4
##
## Slot "chunkdim":
## [1] 100 100   4
##
## Slot "first_val":
## [1] 2.235787
```

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
##  [1] HDF5Array_1.38.0            h5mread_1.2.0
##  [3] rhdf5_2.54.0                DelayedArray_0.36.0
##  [5] SparseArray_1.10.0          S4Arrays_1.10.0
##  [7] abind_1.4-8                 Matrix_1.7-4
##  [9] ggplot2_4.0.0               cowplot_1.2.0
## [11] cytomapper_1.22.0           SingleCellExperiment_1.32.0
## [13] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [15] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [17] IRanges_2.44.0              S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0         generics_0.1.4
## [21] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [23] EBImage_4.52.0              BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] bitops_1.0-9             gridExtra_2.3            rlang_1.1.6
##  [4] magrittr_2.0.4           svgPanZoom_0.3.4         shinydashboard_0.7.3
##  [7] otel_0.2.0               compiler_4.5.1           png_0.1-8
## [10] systemfonts_1.3.1        fftwtools_0.9-11         vctrs_0.6.5
## [13] pkgconfig_2.0.3          SpatialExperiment_1.20.0 fastmap_1.2.0
## [16] magick_2.9.0             XVector_0.50.0           labeling_0.4.3
## [19] promises_1.4.0           rmarkdown_2.30           ggbeeswarm_0.7.2
## [22] xfun_0.53                cachem_1.1.0             jsonlite_2.0.0
## [25] later_1.4.4              rhdf5filters_1.22.0      Rhdf5lib_1.32.0
## [28] BiocParallel_1.44.0      jpeg_0.1-11              tiff_0.1-12
## [31] terra_1.8-70             parallel_4.5.1           R6_2.6.1
## [34] bslib_0.9.0              RColorBrewer_1.1-3       jquerylib_0.1.4
## [37] Rcpp_1.1.0               bookdown_0.45            knitr_1.50
## [40] httpuv_1.6.16            nnls_1.6                 tidyselect_1.2.1
## [43] dichromat_2.0-0.1        yaml_2.3.10              viridis_0.6.5
## [46] codetools_0.2-20         lattice_0.22-7           tibble_3.3.0
## [49] shiny_1.11.1             withr_3.0.2              S7_0.2.0
## [52] evaluate_1.0.5           gridGraphics_0.5-1       pillar_1.11.1
## [55] BiocManager_1.30.26      sp_2.2-0                 RCurl_1.98-1.17
## [58] scales_1.4.0             xtable_1.8-4             glue_1.8.0
## [61] tools_4.5.1              locfit_1.5-9.12          grid_4.5.1
## [64] raster_3.6-32            beeswarm_0.4.0           vipor_0.4.7
## [67] cli_3.6.5                textshaping_1.0.4        viridisLite_0.4.2
## [70] svglite_2.2.2            dplyr_1.1.4              gtable_0.3.6
## [73] sass_0.4.10              digest_0.6.37            rjson_0.2.23
## [76] htmlwidgets_1.6.4        farver_2.1.2             htmltools_0.5.8.1
## [79] lifecycle_1.0.4          mime_0.13
```

# 5 References