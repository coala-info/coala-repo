# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
library(DelayedRandomArray)
X <- RandomUnifArray(c(1e6, 1e6))
X

## -----------------------------------------------------------------------------
RandomNormArray(c(100, 50))
RandomPoisArray(c(100, 50), lambda=5)
RandomGammaArray(c(100, 50), shape=2, rate=5)
RandomWeibullArray(c(100, 50), shape=5)

## -----------------------------------------------------------------------------
RandomNormArray(c(100, 50), mean=1)

## -----------------------------------------------------------------------------
RandomNormArray(c(100, 50), mean=1:100)

## -----------------------------------------------------------------------------
means <- RandomNormArray(c(100, 50))
RandomPoisArray(c(100, 50), lambda=2^means)

## -----------------------------------------------------------------------------
ngenes <- 20000
log.abundances <- runif(ngenes, -2, 5)

nclusters <- 20 # define 20 clusters and their population means.
cluster.means <- matrix(2^rnorm(ngenes*nclusters, log.abundances, sd=2), ncol=nclusters)

ncells <- 1e6
clusters <- sample(nclusters, ncells, replace=TRUE) # randomly allocate cells
cell.means <- DelayedArray(cluster.means)[,clusters]

dispersions <- 0.05 + 10/cell.means # typical mean variance trend.

y <- RandomNbinomArray(c(ngenes, ncells), mu=cell.means, size=1/dispersions)
y

## -----------------------------------------------------------------------------
# Row-wise chunks:
RandomUnifArray(c(1000, 500), chunkdim=c(1, 500))

# Column-wise chunks:
RandomUnifArray(c(1000, 500), chunkdim=c(1000, 1))

## -----------------------------------------------------------------------------
set.seed(199)
RandomUnifArray(c(10, 5), chunkdim=c(1, 5))

set.seed(199)
RandomUnifArray(c(10, 5), chunkdim=c(10, 1))

## -----------------------------------------------------------------------------
set.seed(999)
RandomNormArray(c(10, 5))

set.seed(999)
RandomNormArray(c(10, 5))

## -----------------------------------------------------------------------------
RandomPoisArray(c(1e6, 1e6), lambda=0.5) # dense by default

RandomPoisArray(c(1e6, 1e6), lambda=0.5, sparse=TRUE) # treat as sparse

## -----------------------------------------------------------------------------
sessionInfo()

