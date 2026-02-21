# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)
library(BiocStyle)
self <- Biocpkg("alabaster.spatial")

## -----------------------------------------------------------------------------
library(SpatialExperiment)

# Copying the example from ?read10xVisium.
dir <- system.file("extdata", "10xVisium", package = "SpatialExperiment")
sample_ids <- c("section1", "section2")
samples <- file.path(dir, sample_ids, "outs")
spe <- read10xVisium(
   samples,
   sample_ids,
   type = "sparse",
   data = "raw",
   images = "lowres", 
   load = FALSE
)
colnames(spe) <- make.unique(colnames(spe)) # Making the column names unique.

spe

## -----------------------------------------------------------------------------
library(alabaster.spatial)
tmp <- tempfile()
saveObject(spe, tmp)
list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
roundtrip <- readObject(tmp)
plot(imgRaster(getImg(roundtrip, "section1")))

## -----------------------------------------------------------------------------
sessionInfo()

