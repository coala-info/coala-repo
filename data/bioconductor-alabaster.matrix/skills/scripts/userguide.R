# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
self <- Githubpkg("ArtifactDB/alabaster.matrix")
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
library(Matrix)
y <- rsparsematrix(1000, 100, density=0.05)

library(alabaster.matrix)
tmp <- tempfile()
saveObject(y, tmp)

list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
roundtrip <- readObject(tmp)
class(roundtrip)

## -----------------------------------------------------------------------------
library(DelayedArray)
y <- DelayedArray(rsparsematrix(1000, 100, 0.05))
y <- log1p(abs(y) / 1:100) # adding some delayed ops.

tmp <- tempfile()
saveObject(y, tmp, DelayedArray.preserve.ops=TRUE)

# Inspecting the HDF5 file reveals many delayed operations:
rhdf5::h5ls(file.path(tmp, "array.h5"))

# And indeed, we can recover those same operations.
readObject(tmp)

## -----------------------------------------------------------------------------
sessionInfo()

