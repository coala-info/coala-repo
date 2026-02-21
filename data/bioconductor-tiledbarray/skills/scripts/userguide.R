# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
X <- matrix(rnorm(1000), ncol=10)
library(TileDBArray)
writeTileDBArray(X)

## -----------------------------------------------------------------------------
as(X, "TileDBArray")

## -----------------------------------------------------------------------------
Y <- Matrix::rsparsematrix(1000, 1000, density=0.01)
writeTileDBArray(Y)

## -----------------------------------------------------------------------------
writeTileDBArray(Y > 0)

## -----------------------------------------------------------------------------
rownames(X) <- sprintf("GENE_%i", seq_len(nrow(X)))
colnames(X) <- sprintf("SAMP_%i", seq_len(ncol(X)))
writeTileDBArray(X)

## -----------------------------------------------------------------------------
out <- as(X, "TileDBArray")
dim(out)
head(rownames(out))
head(out[,1])

## -----------------------------------------------------------------------------
out[1:5,1:5] 
out * 2

## -----------------------------------------------------------------------------
colSums(out)
out %*% runif(ncol(out))

## -----------------------------------------------------------------------------
X <- matrix(rnorm(1000), ncol=10)
path <- tempfile()
writeTileDBArray(X, path=path, attr="WHEE")

## -----------------------------------------------------------------------------
path2 <- tempfile()
setTileDBPath(path2)
as(X, "TileDBArray") # uses path2 to store the backend.

## -----------------------------------------------------------------------------
sessionInfo()

