# Code example from 'overview' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
# Mocking up a Y-shaped trajectory.
centers <- rbind(c(0,0), c(0, -1), c(1, 1), c(-1, 1))
rownames(centers) <- seq_len(nrow(centers))
clusters <- sample(nrow(centers), 1000, replace=TRUE)
cells <- centers[clusters,]
cells <- cells + rnorm(length(cells), sd=0.5)

# Creating the MST:
library(TrajectoryUtils)
mst <- createClusterMST(cells, clusters)
plot(mst)

## -----------------------------------------------------------------------------
guessMSTRoots(mst, method="maxstep")
guessMSTRoots(mst, method="minstep")

## -----------------------------------------------------------------------------
defineMSTPaths(mst, roots=c("1"))
defineMSTPaths(mst, roots=c("2"))

## -----------------------------------------------------------------------------
defineMSTPaths(mst, times=c(`1`=4, `2`=0, `3`=1, `4`=0))

## -----------------------------------------------------------------------------
splitByBranches(mst)

## -----------------------------------------------------------------------------
# Make up a matrix of pseudotime orderings.
ncells <- 200
npaths <- 5
orderings <- matrix(rnorm(1000), ncells, npaths)

# Default constructor:
(pto <- PseudotimeOrdering(orderings))

## -----------------------------------------------------------------------------
pto$cluster <- sample(LETTERS[1:5], ncells, replace=TRUE)
cellData(pto)

## -----------------------------------------------------------------------------
pathData(pto)$description <- sprintf("PATH-%i", seq_len(npaths))
pathData(pto)

## -----------------------------------------------------------------------------
pathStat(pto, "confidence") <- matrix(runif(1000), ncells, npaths)
pathStatNames(pto)

## -----------------------------------------------------------------------------
summary(averagePseudotime(pto))

## -----------------------------------------------------------------------------
sessionInfo()

