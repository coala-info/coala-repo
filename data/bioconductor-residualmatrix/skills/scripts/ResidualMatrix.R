# Code example from 'ResidualMatrix' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## -----------------------------------------------------------------------------
design <- model.matrix(~gl(5, 10000))

# Making up a large-ish sparse matrix.
library(Matrix)
set.seed(100)
y0 <- rsparsematrix(nrow(design), 30000, 0.01)

library(ResidualMatrix)
resids <- ResidualMatrix(y0, design)
resids

## -----------------------------------------------------------------------------
hist(resids[,1])

## -----------------------------------------------------------------------------
set.seed(100)
system.time(pc.out <- BiocSingular::runPCA(resids, 10, center=FALSE,
    BSPARAM=BiocSingular::RandomParam()))
str(pc.out)

## -----------------------------------------------------------------------------
hist(rowSums(resids))

## -----------------------------------------------------------------------------
design2 <- model.matrix(~gl(2, 10000))
design2 <- cbind(design2, BAD=runif(nrow(design2)))
colnames(design2)

## -----------------------------------------------------------------------------
# Making up another large-ish sparse matrix.
y0 <- rsparsematrix(nrow(design2), 30000, 0.01)

resid2 <- ResidualMatrix(y0, design2, keep=1:2)
resid2

## -----------------------------------------------------------------------------
batches <- gl(3, 1000)
controls <- c(1:100, 1:100+1000, 1:100+2000)
y <- matrix(rnorm(30000), nrow=3000)

resid3 <- ResidualMatrix(y, design=model.matrix(~batches), restrict=controls)
resid3

## -----------------------------------------------------------------------------
sessionInfo()

