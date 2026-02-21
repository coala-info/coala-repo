# Introduction to the SpatialExperiment class

Dario Righelli, Helena L. Crowell, Lukas M. Weber

#### Oct 30, 2025

# 1 Class structure

## 1.1 Introduction

The `SpatialExperiment` class is an R/Bioconductor S4 class for storing
data from spatial -omics experiments. The class
extends the `SingleCellExperiment` class for single-cell data to support
storage and retrieval of additional information from spot-based and
molecule-based platforms, including spatial coordinates, images, and
image metadata. A specialized constructor function is included for data
from the 10x Genomics Visium platform.

The following schematic illustrates the `SpatialExperiment` class
structure.

![Overview of the SpatialExperiment class structure.](data:image/png;base64...)

Figure 1: Overview of the SpatialExperiment class structure

As shown, an object consists of: (i) `assays` containing expression counts,
(ii) `rowData` containing information on features, i.e. genes, (iii)
`colData` containing information on spots or cells, including nonspatial
and spatial metadata, (iv) `spatialCoords` containing spatial coordinates,
and (v) `imgData` containing image data. For spot-based ST data (e.g. 10x
Genomics Visium), a single `assay` named `counts` is used. For molecule-based
ST data (e.g. seqFISH), two `assays` named `counts` and `molecules` can be used.

Additional details on the class structure are provided in our
[preprint](https://www.biorxiv.org/content/10.1101/2021.01.27.428431v3).

## 1.2 Load data

For demonstration of the general class structure, we load an example
`SpatialExperiment` (abbreviated as SPE) object (variable `spe`):

```
library(SpatialExperiment)
example(SpatialExperiment, echo = FALSE)
spe
```

```
## class: SpatialExperiment
## dim: 50 99
## metadata(4): resources spatialList resources spatialList
## assays(1): counts
## rownames(50): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000005886 ENSMUSG00000101476
## rowData names(3): ID Symbol Type
## colnames(99): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ...
##   AAAGTCGACCCTCAGT-1 AAAGTGCCATCAATTA-1
## colData names(4): in_tissue array_row array_col sample_id
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

## 1.3 `spatialCoords`

In addition to observation metadata stored inside the `colData` slot,
the `SpatialExperiment` class stores spatial coordinates as:

* `spatialCoords`, a numeric matrix of spatial coordinates (e.g. `x` and `y`)

`spatialCoords` are stored inside the `int_colData`, and are directly
accessible via the corresponding accessor:

```
head(spatialCoords(spe))
```

```
##                    pxl_col_in_fullres pxl_row_in_fullres
## AAACAACGAATAGTTC-1               2312               1252
## AAACAAGTATCTCCCA-1               8230               7237
## AAACAATCTACTAGCA-1               4170               1611
## AAACACCAATAACTGC-1               2519               8315
## AAACAGAGCGACTCCT-1               7679               2927
## AAACAGCTTTCAGAAG-1               1831               6400
```

The corresponding column names can be also accessed with `spatialCoordsNames()`:

```
spatialCoordsNames(spe)
```

```
## [1] "pxl_col_in_fullres" "pxl_row_in_fullres"
```

## 1.4 `imgData`

All image related data are stored inside the `int_metadata`’s
`imgData` field as a `DataFrame` of the following structure:

* each row corresponds to one image for a given sample
* for each image, columns specify:
  + which `sample_id` the image belongs to
  + a unique `image_id` in order to accommodate multiple images
    for a given sample (e.g. of different resolutions)
  + the image’s `data` (a `SpatialImage` object)
  + the `scaleFactor` that adjusts pixel positions of the original,
    full-resolution image to pixel positions in the image

The `imgData()` accessor can be used to retrieve
the image data stored within the object:

```
imgData(spe)
```

```
## DataFrame with 2 rows and 4 columns
##     sample_id    image_id   data scaleFactor
##   <character> <character> <list>   <numeric>
## 1    section1      lowres   ####   0.0510334
## 2    section2      lowres   ####   0.0510334
```

### 1.4.1 The `SpatialImage` class

Images are stored inside the `data` field of the `imgData` as a list of
`SpatialImage`s. Each image may be of one of the following sub-classes:

* `LoadedSpatialImage`
  + represents an image that is fully realized into memory as a `raster` object
  + `@image` contains a `raster` object: a matrix
    of RGB colors for each pixel in the image
* `StoredSpatialImage`
  + represents an image that is stored in a local file (e.g., as
    .png, .jpg or .tif), and loaded into memory only on request
  + `@path` specifies a local file from which to retrieve the image
* `RemoteSpatialImage`
  + represents an image that is remotely hosted
    (under some URL), and retrieved only on request
  + `@url` specifies where to retrieve the image from

A `SpatialImage` can be accessed using `getImg()`,
or retrieved directly from the `imgData()`:

```
(spi <- getImg(spe))
```

```
## 576 x 600 (width x height) StoredSpatialImage
## imgSource():
##   /tmp/RtmpM816Ov/Rinst3384c240b44bcb/SpatialExperiment/extdata/10xVisium/section1
##   /outs/spatial/tissue_lowres_image.png
```

```
identical(spi, imgData(spe)$data[[1]])
```

```
## [1] TRUE
```

Data available in an object of class `SpatialImage` may be
accessed via the `imgRaster()` and `imgSource()` accessors:

```
plot(imgRaster(spe))
```

![](data:image/png;base64...)

### 1.4.2 Adding or removing images

Image entries may be added or removed from a `SpatialExperiment`’s
`imgData` `DataFrame` using `addImg()` and `rmvImg()`, respectively.

Besides a path or URL to source the image from and a numeric scale factor,
`addImg()` requires specification of the `sample_id` the new image belongs to,
and an `image_id` that is not yet in use for that sample:

```
url <- "https://i.redd.it/3pw5uah7xo041.jpg"
spe <- addImg(spe,
    sample_id = "section1",
    image_id = "pomeranian",
    imageSource = url,
    scaleFactor = NA_real_,
    load = TRUE)
img <- imgRaster(spe,
    sample_id = "section1",
    image_id = "pomeranian")
plot(img)
```

![](data:image/png;base64...)

The `rmvImg()` function is more flexible in the specification
of the `sample_id` and `image_id` arguments. Specifically:

* `TRUE` is equivalent to *all*, e.g.
  `sample_id = "<sample>"`, `image_id = TRUE`
  will drop all images for a given sample
* `NULL` defaults to the first entry available, e.g.
  `sample_id = "<sample>"`, `image_id = NULL`
  will drop the first image for a given sample

For example, `sample_id = TRUE`, `image_id = TRUE` will specify all images;
`sample_id = NULL`, `image_id = NULL` corresponds to the first image entry in the `imgData`;
`sample_id = TRUE`, `image_id = NULL` equals the first image for all samples; and
`sample_id = NULL`, `image_id = TRUE` matches all images for the first sample.

Here, we remove `section1`’s `pomeranian` image added in the previous
code chunk; the image is now completely gone from the `imgData`:

```
imgData(spe <- rmvImg(spe, "section1", "pomeranian"))
```

```
## DataFrame with 2 rows and 4 columns
##     sample_id    image_id   data scaleFactor
##   <character> <character> <list>   <numeric>
## 1    section1      lowres   ####   0.0510334
## 2    section2      lowres   ####   0.0510334
```

# 2 Object construction

## 2.1 Manually

The `SpatialExperiment` constructor provides several arguments
to give maximum flexibility to the user.

In particular, these include:

* `spatialCoords`, a numeric `matrix` containing spatial coordinates
* `spatialCoordsNames`, a character vector specifying which
  `colData` fields correspond to spatial coordinates

`spatialCoords` can be supplied via `colData`
by specifying the column names that correspond to spatial coordinates
with `spatialCoordsNames`:

```
n <- length(z <- letters)
y <- matrix(nrow = n, ncol = n)
cd <- DataFrame(x = seq(n), y = seq(n), z)

spe1 <- SpatialExperiment(
    assay = y,
    colData = cd,
    spatialCoordsNames = c("x", "y"))
```

Alternatively, `spatialCoords` may be supplied separately
as a `matrix`, e.g.:

```
xy <- as.matrix(cd[, c("x", "y")])

spe2 <- SpatialExperiment(
    assay = y,
    colData = cd["z"],
    spatialCoords = xy)
```

Importantly, both of the above `SpatialExperiment()` function calls
lead to construction of the exact same object:

```
identical(spe1, spe2)
```

```
## [1] TRUE
```

Finally, `spatialCoords(Names)` are optional, i.e.,
we can construct a SPE using only a subset of the above arguments:

```
spe <- SpatialExperiment(
    assays = y)
isEmpty(spatialCoords(spe))
```

```
## [1] TRUE
```

In general, `spatialCoordsNames` takes precedence over `spatialCoords`,
i.e., if both are supplied, the latter will be ignored. In other words,
`spatialCoords` are preferentially extracted from the `DataFrame`
provided via `colData`. E.g., in the following function call,
`spatialCoords` will be ignored, and xy-coordinates are instead extracted
from the input `colData` according to the specified `spatialCoordsNames`.
In this case, a message is also provided:

```
n <- 10; m <- 20
y <- matrix(nrow = n, ncol = m)
cd <- DataFrame(x = seq(m), y = seq(m))
xy <- matrix(nrow = m, ncol = 2)
colnames(xy) <- c("x", "y")

SpatialExperiment(
    assay = y,
    colData = cd,
    spatialCoordsNames = c("x", "y"),
    spatialCoords = xy)
```

```
## Both 'spatialCoords' and 'spatialCoordsNames'  have been supplied;
## using 'spatialCoords'. Set either to NULL to suppress this message.
```

## 2.2 Spot-based

When working with spot-based ST data, such as *10x Genomics Visium* or other
platforms providing images, it is possible to store the image information
in the dedicated `imgData` structure.

Also, the `SpatialExperiment` class stores a `sample_id` value in the
`colData` structure, which is possible to set with the `sample_id`
argument (default is “sample\_01”).

Here we show how to load the default *Space Ranger* data files from a
10x Genomics Visium experiment, and build a `SpatialExperiment` object.

In particular, the `readImgData()` function is used to build an `imgData`
`DataFrame` to be passed to the `SpatialExperiment` constructor.
The `sample_id` used to build the `imgData` object must be the same one
used to build the `SpatialExperiment` object, otherwise an error is returned.

```
dir <- system.file(
   file.path("extdata", "10xVisium", "section1", "outs"),
   package = "SpatialExperiment")

# read in counts
fnm <- file.path(dir, "raw_feature_bc_matrix")
sce <- DropletUtils::read10xCounts(fnm)

# read in image data
img <- readImgData(
    path = file.path(dir, "spatial"),
    sample_id = "foo")

# read in spatial coordinates
fnm <- file.path(dir, "spatial", "tissue_positions_list.csv")
xyz <- read.csv(fnm, header = FALSE,
    col.names = c(
        "barcode", "in_tissue", "array_row", "array_col",
        "pxl_row_in_fullres", "pxl_col_in_fullres"))

# construct observation & feature metadata
rd <- S4Vectors::DataFrame(
    symbol = rowData(sce)$Symbol)

# construct 'SpatialExperiment'
(spe <- SpatialExperiment(
    assays = list(counts = assay(sce)),
    rowData = rd,
    colData = DataFrame(xyz),
    spatialCoordsNames = c("pxl_col_in_fullres", "pxl_row_in_fullres"),
    imgData = img,
    sample_id = "foo"))
```

```
## class: SpatialExperiment
## dim: 50 50
## metadata(0):
## assays(1): counts
## rownames(50): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000005886 ENSMUSG00000101476
## rowData names(1): symbol
## colnames: NULL
## colData names(5): barcode in_tissue array_row array_col sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

Alternatively, *[VisiumIO](https://bioconductor.org/packages/3.22/VisiumIO)*’s `TENxVisium/List()`
functions facilitate the import of *10x Genomics Visium* data to handle one
or more samples organized in folders reflecting the default *Space Ranger*
folder tree organization, as illustrated below (where “raw/filtered” refers
to either “raw” or “filtered” to match the `data` argument). Note that the
base directory “outs/” from Space Ranger can either be included manually in the
paths provided in the `sampleFolders` argument, or can be ignored; if ignored,
it will be added automatically. (Note that `tissue_positions.csv` was renamed
in Space Ranger v2.0.0; the `tissuePattern` argument can be used to specify a
pattern to match the tissue positions file.)

```
sample
 . | — outs
 · · | — raw/filtered_feature_bc_matrix.h5
 · · | — raw/filtered_feature_bc_matrix
 · · · | — barcodes.tsv.gz
 · · · | — features.tsv.gz
 · · · | — matrix.mtx.gz
 · · | — spatial
 · · · | — scalefactors_json.json
 · · · | — tissue_lowres_image.png
 · · · | — tissue_positions.csv
```

Using `TENxVisiumList()`, the above code to construct the same SPE is reduced to:

```
library(VisiumIO)
dir <- list.dirs(system.file(
    file.path("extdata", "10xVisium"),
    package = "SpatialExperiment"),
    recursive = FALSE, full.names = TRUE)
(ids <- basename(dir))
```

```
## [1] "section1" "section2"
```

```
(vl <- TENxVisiumList(
    sampleFolders = dir, sample_ids = ids,
    processing = "raw", image = "lowres"))
```

```
## An object of class "TENxVisiumList"
## Slot "VisiumList":
## List of length 2
```

```
(spe10x <- import(vl))
```

```
## class: SpatialExperiment
## dim: 50 99
## metadata(4): resources spatialList resources spatialList
## assays(1): counts
## rownames(50): ENSMUSG00000051951 ENSMUSG00000089699 ...
##   ENSMUSG00000005886 ENSMUSG00000101476
## rowData names(3): ID Symbol Type
## colnames(99): AAACAACGAATAGTTC-1 AAACAAGTATCTCCCA-1 ...
##   AAAGTCGACCCTCAGT-1 AAAGTGCCATCAATTA-1
## colData names(4): in_tissue array_row array_col sample_id
## reducedDimNames(0):
## mainExpName: Gene Expression
## altExpNames(0):
## spatialCoords names(2) : pxl_col_in_fullres pxl_row_in_fullres
## imgData names(4): sample_id image_id data scaleFactor
```

## 2.3 Molecule-based

To demonstrate how to accommodate molecule-based ST data
(e.g. *seqFISH* platform) inside a `SpatialExperiment` object,
we generate some mock data of 1000 molecule coordinates across
50 genes and 20 cells. These should be formatted into a `data.frame`
where each row corresponds to a molecule, and columns specify the
xy-positions as well as which gene/cell the molecule has been assigned to:

```
n <- 1e3  # number of molecules
ng <- 50  # number of genes
nc <- 20  # number of cells
# sample xy-coordinates in [0, 1]
x <- runif(n)
y <- runif(n)
# assign each molecule to some gene-cell pair
gs <- paste0("gene", seq(ng))
cs <- paste0("cell", seq(nc))
gene <- sample(gs, n, TRUE)
cell <- sample(cs, n, TRUE)
# assure gene & cell are factors so that
# missing observations aren't dropped
gene <- factor(gene, gs)
cell <- factor(cell, cs)
# construct data.frame of molecule coordinates
df <- data.frame(gene, cell, x, y)
head(df)
```

```
##     gene   cell          x          y
## 1 gene17 cell15 0.77395942 0.94714926
## 2 gene25 cell19 0.95239840 0.01196875
## 3 gene10  cell5 0.59089999 0.59031264
## 4 gene50  cell2 0.52909431 0.20781142
## 5  gene2 cell14 0.03920778 0.82980740
## 6 gene31 cell14 0.69891068 0.85308682
```

Next, it is possible to re-shape the above table into a
*[BumpyMatrix](https://bioconductor.org/packages/3.22/BumpyMatrix)* using `splitAsBumpyMatrix()`, which takes
as input the xy-coordinates, as well as arguments specifying the row and column
index of each observation:

```
# construct 'BumpyMatrix'
library(BumpyMatrix)
mol <- splitAsBumpyMatrix(
    df[, c("x", "y")],
    row = gene, col = cell)
```

Finally, it is possible to construct a `SpatialExperiment` object with two data
slots:

* The `counts` assay stores the number of molecules per gene and cell
  (equivalent to transcript counts in spot-based data)
* The `molecules` assay holds the spatial molecule positions (xy-coordinates)

Each entry in the `molecules` assay is a `DFrame` that contains the positions
of all molecules from a given gene that have been assigned to a given cell.

```
# get count matrix
y <- with(df, table(gene, cell))
y <- as.matrix(unclass(y))
y[1:5, 1:5]
```

```
##        cell
## gene    cell1 cell2 cell3 cell4 cell5
##   gene1     1     4     1     0     3
##   gene2     2     1     0     1     1
##   gene3     1     1     0     2     0
##   gene4     1     0     1     0     0
##   gene5     1     1     0     0     1
```

```
# construct SpatialExperiment
spe <- SpatialExperiment(
    assays = list(
        counts = y,
        molecules = mol))
spe
```

```
## class: SpatialExperiment
## dim: 50 20
## metadata(0):
## assays(2): counts molecules
## rownames(50): gene1 gene2 ... gene49 gene50
## rowData names(0):
## colnames(20): cell1 cell2 ... cell19 cell20
## colData names(1): sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## spatialCoords names(0) :
## imgData names(0):
```

The `BumpyMatrix` of molecule locations can be accessed
using the dedicated `molecules()` accessor:

```
molecules(spe)
```

```
## 50 x 20 BumpyDataFrameMatrix
## rownames: gene1 gene2 ... gene49 gene50
## colnames: cell1 cell2 ... cell19 cell20
## preview [1,1]:
##   DataFrame with 1 row and 2 columns
##             x         y
##     <numeric> <numeric>
##   1  0.578248  0.505883
```

# 3 Common operations

## 3.1 Subsetting

Subsetting objects is automatically defined to synchronize across
all attributes, as for any other Bioconductor *Experiment* class.

For example, it is possible to `subset` by `sample_id` as follows:

```
sub <- spe10x[, spe10x$sample_id == "section1"]
```

Or to retain only observations that map to tissue via:

```
sub <- spe10x[, colData(spe10x)$in_tissue]
sum(colData(spe10x)$in_tissue) == ncol(sub)
```

```
## [1] TRUE
```

## 3.2 Combining samples

To work with multiple samples, the `SpatialExperiment` class provides the `cbind`
method, which assumes unique `sample_id`(s) are provided for each sample.

In case the `sample_id`(s) are duplicated across multiple samples, the `cbind`
method takes care of this by appending indices to create unique sample identifiers.

```
spe1 <- spe2 <- spe
spe3 <- cbind(spe1, spe2)
```

```
## 'sample_id's are duplicated across 'SpatialExperiment' objects to cbind; appending sample indices.
```

```
unique(spe3$sample_id)
```

```
## [1] "sample01.1" "sample01.2"
```

Alternatively (and preferentially), we can create unique
`sample_id`(s) prior to `cbind`ing as follows:

```
# make sample identifiers unique
spe1 <- spe2 <- spe
spe1$sample_id <- paste(spe1$sample_id, "A", sep = ".")
spe2$sample_id <- paste(spe2$sample_id, "B", sep = ".")

# combine into single object
spe3 <- cbind(spe1, spe2)
```

## 3.3 Sample ID replacement

In particular, when trying to replace the `sample_id`(s) of a `SpatialExperiment`
object, these must map uniquely with the already existing ones, otherwise an
error is returned.

```
new <- spe3$sample_id
new[1] <- "section2.A"
spe3$sample_id <- new
```

```
## Error in .local(x, ..., value): Number of unique 'sample_id's is 2, but 3 were provided.
```

```
new[1] <- "third.one.of.two"
spe3$sample_id <- new
```

```
## Error in .local(x, ..., value): Number of unique 'sample_id's is 2, but 3 were provided.
```

Importantly, the `sample_id` `colData` field is *protected*, i.e.,
it will be retained upon attempted removal (= replacement by `NULL`):

```
# backup original sample IDs
tmp <- spe$sample_id
# try to remove sample IDs
spe$sample_id <- NULL
# sample IDs remain unchanged
identical(tmp, spe$sample_id)
```

```
## [1] TRUE
```

## 3.4 Image transformations

Both the `SpatialImage` (SpI) and `SpatialExperiment` (SpE) class currently support
two basic image transformations, namely, rotation (via `rotateImg()`) and
mirroring (via `mirrorImg()`). Specifically, for a SpI/E `x`:

* `rotateImg(x, degrees)` expects as `degrees` a single numeric in +/-[0,90,…,360].
  Here, a (negative) positive value corresponds to (counter-)clockwise rotation.
* `mirrorImg(x, axis)` expects as `axis` a character string specifying
  whether to mirror horizontally (`"h"`) or vertically (`"v"`).

Here, we apply various transformations using both a SpI (`spi`) and SpE (`spe`)
as input, and compare the resulting images to the original:

### 3.4.1 Rotation

```
# extract first image
spi <- getImg(spe10x)
# apply counter-/clockwise rotation
spi1 <- rotateImg(spi, -90)
spi2 <- rotateImg(spi, +90)
# visual comparison
par(mfrow = c(1, 3))
plot(as.raster(spi))
plot(as.raster(spi1))
plot(as.raster(spi2))
```

![](data:image/png;base64...)

```
# specify sample & image identifier
sid <- "section1"
iid <- "lowres"
# counter-clockwise rotation
tmp <- rotateImg(spe10x,
    sample_id = sid,
    image_id = iid,
    degrees = -90)
# visual comparison
par(mfrow = c(1, 2))
plot(imgRaster(spe10x, sid, iid))
plot(imgRaster(tmp, sid, iid))
```

![](data:image/png;base64...)

### 3.4.2 Mirroring

```
# extract first image
spi <- getImg(spe10x)
# mirror horizontally/vertically
spi1 <- mirrorImg(spi, "h")
spi2 <- mirrorImg(spi, "v")
# visual comparison
par(mfrow = c(1, 3))
plot(as.raster(spi))
plot(as.raster(spi1))
plot(as.raster(spi2))
```

![](data:image/png;base64...)

```
# specify sample & image identifier
sid <- "section2"
iid <- "lowres"
# mirror horizontally
tmp <- mirrorImg(spe10x,
    sample_id = sid,
    image_id = iid,
    axis = "h")
# visual comparison
par(mfrow = c(1, 2))
plot(imgRaster(spe10x, sid, iid))
plot(imgRaster(tmp, sid, iid))
```

![](data:image/png;base64...)

# 4 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] BumpyMatrix_1.18.0          VisiumIO_1.6.0
##  [3] TENxIO_1.12.0               SpatialExperiment_1.20.0
##  [5] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
##  [7] Biobase_2.70.0              GenomicRanges_1.62.0
##  [9] Seqinfo_1.0.0               IRanges_2.44.0
## [11] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [13] generics_0.1.4              MatrixGenerics_1.22.0
## [15] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rjson_0.2.23              xfun_0.53
##  [3] bslib_0.9.0               rhdf5_2.54.0
##  [5] lattice_0.22-7            tzdb_0.5.0
##  [7] vctrs_0.6.5               rhdf5filters_1.22.0
##  [9] tools_4.5.1               curl_7.0.0
## [11] parallel_4.5.1            tibble_3.3.0
## [13] pkgconfig_2.0.3           BiocBaseUtils_1.12.0
## [15] R.oo_1.27.1               Matrix_1.7-4
## [17] sparseMatrixStats_1.22.0  dqrng_0.4.1
## [19] lifecycle_1.0.4           compiler_4.5.1
## [21] tinytex_0.57              statmod_1.5.1
## [23] codetools_0.2-20          htmltools_0.5.8.1
## [25] sass_0.4.10               yaml_2.3.10
## [27] crayon_1.5.3              pillar_1.11.1
## [29] jquerylib_0.1.4           R.utils_2.13.0
## [31] BiocParallel_1.44.0       DelayedArray_0.36.0
## [33] cachem_1.1.0              limma_3.66.0
## [35] magick_2.9.0              abind_1.4-8
## [37] tidyselect_1.2.1          locfit_1.5-9.12
## [39] digest_0.6.37             bookdown_0.45
## [41] fastmap_1.2.0             grid_4.5.1
## [43] archive_1.1.12            cli_3.6.5
## [45] SparseArray_1.10.0        magrittr_2.0.4
## [47] S4Arrays_1.10.0           h5mread_1.2.0
## [49] readr_2.1.5               edgeR_4.8.0
## [51] DelayedMatrixStats_1.32.0 bit64_4.6.0-1
## [53] rmarkdown_2.30            XVector_0.50.0
## [55] DropletUtils_1.30.0       bit_4.6.0
## [57] hms_1.1.4                 R.methodsS3_1.8.2
## [59] beachmat_2.26.0           HDF5Array_1.38.0
## [61] evaluate_1.0.5            knitr_1.50
## [63] BiocIO_1.20.0             rlang_1.1.6
## [65] Rcpp_1.1.0                glue_1.8.0
## [67] scuttle_1.20.0            formatR_1.14
## [69] BiocManager_1.30.26       vroom_1.6.6
## [71] jsonlite_2.0.0            R6_2.6.1
## [73] Rhdf5lib_1.32.0
```