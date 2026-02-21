# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)
library(BiocStyle)
self <- Githubpkg("ArtifactDB/alabaster.bumpy")

## -----------------------------------------------------------------------------
library(BumpyMatrix)
library(S4Vectors)
df <- DataFrame(x=runif(100), y=runif(100))
f <- factor(sample(letters[1:20], nrow(df), replace=TRUE), letters[1:20])
mat <- BumpyMatrix(split(df, f), c(5, 4))

## -----------------------------------------------------------------------------
library(alabaster.bumpy)
tmp <- tempfile()
saveObject(mat, tmp)
list.files(tmp, recursive=TRUE)

## -----------------------------------------------------------------------------
readObject(tmp)

## -----------------------------------------------------------------------------
sessionInfo()

