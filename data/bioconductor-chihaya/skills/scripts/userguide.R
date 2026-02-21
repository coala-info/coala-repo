# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
library(DelayedArray)
x <- DelayedArray(matrix(runif(1000), ncol=10))
x <- x[11:15,] / runif(5) 
x <- log2(x + 1)
x
showtree(x)

## -----------------------------------------------------------------------------
library(chihaya)
tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)
rhdf5::h5ls(tmp)

## -----------------------------------------------------------------------------
y <- loadDelayed(tmp)
y

## -----------------------------------------------------------------------------
library(Matrix)
x <- rsparsematrix(1000, 1000, density=0.01)
x <- DelayedArray(x) + runif(1000)

tmp <- tempfile(fileext=".h5")
saveDelayed(x, tmp)
rhdf5::h5ls(tmp)
file.info(tmp)[["size"]]

# Compared to a dense array.
tmp2 <- tempfile(fileext=".h5")
out <- HDF5Array::writeHDF5Array(x, tmp2, "data")
file.info(tmp2)[["size"]]

# Loading it back in.
y <- loadDelayed(tmp)
showtree(y)

## -----------------------------------------------------------------------------
library(HDF5Array)
test <- HDF5Array(tmp2, "data")
stuff <- log2(test + 1)
stuff

tmp <- tempfile(fileext=".h5")
saveDelayed(stuff, tmp)
rhdf5::h5ls(tmp)
file.info(tmp)[["size"]] # size of the delayed operations + pointer to the actual file

y <- loadDelayed(tmp)
y

## -----------------------------------------------------------------------------
sessionInfo()

