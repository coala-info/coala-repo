# Code example from 'RBioFormats' vignette. See references/ for full tutorial.

## ----installation, eval=FALSE-------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("RBioFormats")

## ----library------------------------------------------------------------------
library("RBioFormats")

## ----readgrey-----------------------------------------------------------------
f <- system.file("images", "sample.png", package = "EBImage")

img <- read.image(f)
img

## ----readrgb------------------------------------------------------------------
f <- system.file("images", "sample-color.png", package = "EBImage")

img <- read.image(f)
print(img, short = TRUE)

## ----dimorder-----------------------------------------------------------------
dimorder(img)

## ----classdef-----------------------------------------------------------------
getClassDef("AnnotatedImage")

## ----metadata-----------------------------------------------------------------
meta <- metadata(img)
meta

## ----printmeta----------------------------------------------------------------
print(meta, list.len = 99L)

## ----metaNames----------------------------------------------------------------
names(meta)
cMeta <- meta$coreMetadata
names( cMeta )

## ----coreMetadata-------------------------------------------------------------
identical( coreMetadata(meta), cMeta)

## ----coreMetadata2------------------------------------------------------------
identical( coreMetadata(img), cMeta )

## ----read.metadata------------------------------------------------------------
f <- system.file("images", "nuclei.tif", package = "EBImage")
metadata <- read.metadata(f)

metadata

## ----read.image slices, eval=FALSE--------------------------------------------
# for(t in seq_len(coreMetadata(metadata)$sizeT)) {
#   frame <- read.image(f, subset = list(T = t))
#   # perform some operations on each `frame`
# }

## ----parseXML, message=FALSE--------------------------------------------------
library("xml2")

omexml <- read.omexml(f)
read_xml(omexml)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

## ----mockFile, out.width='256px', out.height='256px'--------------------------
f <- mockFile(sizeX = 256, sizeY = 256)
img <- read.image(f)

library("EBImage")
display(img, method = "raster")

## ----defaultRange, echo=FALSE, results='asis', R.options=list(digits = 15)----
types <- c("int8", "uint8", "int16", "uint16", "int32", "uint32", "float", "double")

ranges <- sapply(types, function(t) {
  minmax <- FormatTools$defaultMinMax(FormatTools$pixelTypeFromString(t))
  setNames(minmax, c("min", "max"))
  })
knitr::kable(ranges)

## ----range--------------------------------------------------------------------
sapply(types, function(t) {
  img <- read.image(mockFile(sizeX = 65536, sizeY = 11, pixelType = t), normalize = FALSE)
  if (typeof(img)=="raw") 
    img <- readBin(img, what = "int", n = length(img), size = 1L)
  setNames(range(img), c("min", "max"))  
})

## ----comparewithref-----------------------------------------------------------
library("EBImage")
f <- system.file("images", "sample-color.png", package = "EBImage")
identical(readImage(f), as.Image(read.image(f)))

