# RBioFormats: an R interface to the Bio-Formats library

Andrzej Oleś

#### 30 October 2025

#### Package

RBioFormats 1.10.0 (Bio-Formats library version: 7.3.0)

# 1 Introduction

*[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* provides an interface from R to the OME
[Bio-Formats](https://github.com/ome/bioformats) Java library. Bio-Formats is a
solution for reading data of various image types, including many popular in life
sciences as well as proprietary microscopy image formats. It supports over 150
file formats from domains such as High Content Screening, time lapse imaging,
digital pathology and other complex multidimensional image formats.

Image pixel data is typically complemented by image metadata containing, for
example, technical and temporal parameters of the acquisition in the case of
microscopy images. Such annotation can be an invaluable source of additional
insight helpful during postprocessing or analyzing of the image data.

The package builds on top of the infrastructure provided by
*[EBImage](https://bioconductor.org/packages/3.22/EBImage)* by extending its class abstracting image data. The
primary motivation behind developing *[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* was to fill the
gap between data acquisition and analysis by providing a tool which allows to
directly read the acquired images without the need of any tedious image format
conversion in between.

The following chapters provide some practical examples illustrating the use of
the package. Along the way the classes used for representing image data and
metadata are described too.

# 2 Getting started

*[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* is an R package distributed as part of the
[Bioconductor](http://bioconductor.org) project. To install the package, start R
(version 4.2 or higher) and enter:

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("RBioFormats")
```

Once *[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* is installed, it can be loaded by the following
command.

```
library("RBioFormats")
```

```
## BioFormats library version 7.3.0
```

# 3 Reading images

Images can be loaded into R with the help of the package function `read.image`.
The following examples illustrates how to load a sample grayscale image

```
f <- system.file("images", "sample.png", package = "EBImage")

img <- read.image(f)
img
```

```
## AnnotatedImage
##   colorMode    : Grayscale
##   storage.mode : double
##   dim          : 768 512
##   dimorder     : x y
##   frames.total : 1
##   frames.render: 1
##
## imageData(object)[1:5,1:6]
##       y
## x           [,1]      [,2]      [,3]      [,4]      [,5]      [,6]
##   [1,] 0.4470588 0.4627451 0.4784314 0.4980392 0.5137255 0.5294118
##   [2,] 0.4509804 0.4627451 0.4784314 0.4823529 0.5058824 0.5215686
##   [3,] 0.4627451 0.4666667 0.4823529 0.4980392 0.5137255 0.5137255
##   [4,] 0.4549020 0.4666667 0.4862745 0.4980392 0.5176471 0.5411765
##   [5,] 0.4627451 0.4627451 0.4823529 0.4980392 0.5137255 0.5411765
##
## metadata
##  $ coreMetadata:List of 18
```

or an RGB image.

```
f <- system.file("images", "sample-color.png", package = "EBImage")

img <- read.image(f)
print(img, short = TRUE)
```

```
## AnnotatedImage
##   colorMode    : Color
##   storage.mode : double
##   dim          : 768 512 3
##   dimorder     : x y c
##   frames.total : 3
##   frames.render: 1
##
## metadata
##  $ coreMetadata:List of 18
```

Note the use of `short = TRUE` argument to `print` in the example above for
displaying object summary without the image data preview. There is also a
convenience function to query just for the order of dimensions.

```
dimorder(img)
```

```
## [1] "x" "y" "c"
```

# 4 The *AnnotatedImage* class

*RBioFormats* stores image data in an *AnnotatedImage* class which
extends the *Image* class from *[EBImage](https://bioconductor.org/packages/3.22/EBImage)*.

```
getClassDef("AnnotatedImage")
```

```
## Class "AnnotatedImage" [package "RBioFormats"]
##
## Slots:
##
## Name:          .Data      metadata     colormode
## Class:         array ImageMetadata       integer
##
## Extends:
## Class "Image", directly
## Class "array", by class "Image", distance 2
## Class "structure", by class "Image", distance 3
## Class "vector", by class "Image", distance 4, with explicit coerce
```

Compared to the original *Image* class the *AnnotatedImage* class features an
additional `metadata` slot containing image metadata.

```
meta <- metadata(img)
meta
```

```
## ImageMetadata
##  $ coreMetadata:List of 18
##   ..$ sizeX    : int 768
##   ..$ sizeY    : int 512
##   ..$ sizeZ    : int 1
##   ..$ sizeC    : int 3
##   ..$ sizeT    : int 1
##   ..$ pixelType: chr "uint8"
##   .. [list output truncated]
```

To alter the length of the printed output use the `list.len` attribute to
`print`.

```
print(meta, list.len = 99L)
```

```
## ImageMetadata
##  $ coreMetadata:List of 18
##   ..$ sizeX           : int 768
##   ..$ sizeY           : int 512
##   ..$ sizeZ           : int 1
##   ..$ sizeC           : int 3
##   ..$ sizeT           : int 1
##   ..$ pixelType       : chr "uint8"
##   ..$ bitsPerPixel    : int 8
##   ..$ imageCount      : int 3
##   ..$ dimensionOrder  : chr "XYCZT"
##   ..$ orderCertain    : logi TRUE
##   ..$ rgb             : logi FALSE
##   ..$ littleEndian    : logi FALSE
##   ..$ interleaved     : logi TRUE
##   ..$ falseColor      : logi FALSE
##   ..$ metadataComplete: logi FALSE
##   ..$ thumbnail       : logi FALSE
##   ..$ series          : int 1
##   ..$ resolutionLevel : int 1
```

# 5 Image metadata

Image metadata is represented by an *ImageMetadata* class structured as a named
list of coreMetadata, globalMetadata and seriesMetadata.

```
names(meta)
```

```
## [1] "coreMetadata"   "globalMetadata" "seriesMetadata"
```

```
cMeta <- meta$coreMetadata
names( cMeta )
```

```
##  [1] "sizeX"            "sizeY"            "sizeZ"            "sizeC"
##  [5] "sizeT"            "pixelType"        "bitsPerPixel"     "imageCount"
##  [9] "dimensionOrder"   "orderCertain"     "rgb"              "littleEndian"
## [13] "interleaved"      "falseColor"       "metadataComplete" "thumbnail"
## [17] "series"           "resolutionLevel"
```

`coreMetadata` stores information which is guaranteed to exist for any image
type, whereas the latter two metadata types are format-specific and can be
empty.

Each of these metadata sublists has an corresponding accessor function, e.g.,

```
identical( coreMetadata(meta), cMeta)
```

```
## [1] TRUE
```

and similarly for `globalMetadata` and `seriesMetadata`. These accessors are
useful for extracting the corresponding metadata directly from an
*AnnotatedImage* object

```
identical( coreMetadata(img), cMeta )
```

```
## [1] TRUE
```

# 6 Working with large data sets

The `read.metadata` function allows to access image metadata without loading the
corresponding pixel data.

```
f <- system.file("images", "nuclei.tif", package = "EBImage")
metadata <- read.metadata(f)

metadata
```

```
## ImageMetadata
##  $ coreMetadata  :List of 18
##   ..$ sizeX    : int 510
##   ..$ sizeY    : int 510
##   ..$ sizeZ    : int 1
##   ..$ sizeC    : int 1
##   ..$ sizeT    : int 4
##   ..$ pixelType: chr "uint8"
##   .. [list output truncated]
##  $ globalMetadata:List of 19
##   ..$ Document Name                    : chr "out.tif"
##   ..$ ImageLength                      : int 510
##   ..$ MetaDataPhotometricInterpretation: chr "Monochrome"
##   ..$ PhotometricInterpretation        : chr "BlackIsZero"
##   ..$ XResolution                      : num 72
##   ..$ NewSubfileType                   : num 2
##   .. [list output truncated]
```

This approach is especially useful when working with image series and/or stacks
which have high memory requirements. Information from the metadata can be used
as input to functions which read and process the data chunk-wise rather than
loading it all at once. For this purpose the `subset` argument to `read.image`
comes in handy. Just to give you an idea the following toy example iterates over
individual time frames. Similarly a region if interest from within individual
image frames could be extracted by providing ranges on the `X` and `Y` planar
dimensions. To subset image series specify them in the `series` argument.

```
for(t in seq_len(coreMetadata(metadata)$sizeT)) {
  frame <- read.image(f, subset = list(T = t))
  # perform some operations on each `frame`
}
```

# 7 OME-XML representation

The OME-XML DOM tree representation of the metadata can be accessed using tools
from the *[XML](https://CRAN.R-project.org/package%3DXML)* or *[xml2](https://CRAN.R-project.org/package%3Dxml2)* package. For details on
working with XML data in R see the corresponding package’s documentation.

```
library("xml2")

omexml <- read.omexml(f)
read_xml(omexml)
```

```
## {xml_document}
## <OME schemaLocation="http://www.openmicroscopy.org/Schemas/OME/2016-06 http://www.openmicroscopy.org/Schemas/OME/2016-06/ome.xsd" xmlns="http://www.openmicroscopy.org/Schemas/OME/2016-06" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
## [1] <Image ID="Image:0" Name="nuclei.tif">\n  <Pixels BigEndian="false" Dimen ...
## [2] <StructuredAnnotations>\n  <XMLAnnotation ID="Annotation:0" Namespace="op ...
```

# Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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
##  [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C
##  [3] LC_TIME=en_GB                 LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8
##  [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8
## [11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] xml2_1.4.1         RBioFormats_1.10.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] cli_3.6.5           knitr_1.50          rlang_1.1.6
##  [4] xfun_0.53           png_0.1-8           tiff_0.1-12
##  [7] generics_0.1.4      jsonlite_2.0.0      rJava_1.0-11
## [10] S4Vectors_0.48.0    RCurl_1.98-1.17     htmltools_0.5.8.1
## [13] stats4_4.5.1        sass_0.4.10         locfit_1.5-9.12
## [16] rmarkdown_2.30      grid_4.5.1          evaluate_1.0.5
## [19] jquerylib_0.1.4     abind_1.4-8         bitops_1.0-9
## [22] fastmap_1.2.0       yaml_2.3.10         lifecycle_1.0.4
## [25] bookdown_0.45       BiocManager_1.30.26 compiler_4.5.1
## [28] htmlwidgets_1.6.4   fftwtools_0.9-11    EBImage_4.52.0
## [31] lattice_0.22-7      digest_0.6.37       R6_2.6.1
## [34] bslib_0.9.0         jpeg_0.1-11         tools_4.5.1
## [37] BiocGenerics_0.56.0 cachem_1.1.0
```

# Appendix A: Working with test images

For development purposes it is useful to have images of a specific size or pixel
type for testing. Mock files containing gradient images can be generated with

```
f <- mockFile(sizeX = 256, sizeY = 256)
img <- read.image(f)

library("EBImage")
display(img, method = "raster")
```

![](data:image/png;base64...)

Note that the native image data range is different depending on pixel type.

|  | int8 | uint8 | int16 | uint16 | int32 | uint32 | float | double |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| min | -128 | 0 | -32768 | 0 | -2147483648 | 0 | -2147483648 | -2147483648 |
| max | 127 | 255 | 32767 | 65535 | 2147483647 | 4294967295 | 2147483647 | 2147483647 |

Image data returned by *[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* is by default scaled to the
[0:1] range. This behavior can be controlled using the `normalize` argument to
`read.image`.

```
sapply(types, function(t) {
  img <- read.image(mockFile(sizeX = 65536, sizeY = 11, pixelType = t), normalize = FALSE)
  if (typeof(img)=="raw")
    img <- readBin(img, what = "int", n = length(img), size = 1L)
  setNames(range(img), c("min", "max"))
})
```

```
##     int8 uint8  int16 uint16       int32 uint32 float double
## min -128     0 -32768      0 -2147483648      0     0      0
## max  127   255  32767  65535           0  65535 65535  65535
```

# Appendix B: Compared to *EBImage*

Loading images using *[RBioFormats](https://bioconductor.org/packages/3.22/RBioFormats)* should give the same results as
using the *[EBImage](https://bioconductor.org/packages/3.22/EBImage)* package.

```
library("EBImage")
f <- system.file("images", "sample-color.png", package = "EBImage")
identical(readImage(f), as.Image(read.image(f)))
```

```
## [1] TRUE
```