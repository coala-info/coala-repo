# Code example from 'segmentSeq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE------------------------------------------------------------
library(segmentSeq)

## ----results='hide', eval = TRUE----------------------------------------------
if(FALSE) { # set to FALSE if you don't want parallelisation
    numCores <- min(8, detectCores())
    cl <- makeCluster(numCores)
} else {
    cl <- NULL
}

## ----echo = FALSE, results='hide'---------------------------------------------
set.seed(1)

## -----------------------------------------------------------------------------
datadir <- system.file("extdata", package = "segmentSeq")
libfiles <- c("SL9.txt", "SL10.txt", "SL26.txt", "SL32.txt")
libnames <- c("SL9", "SL10", "SL26", "SL32")
replicates <- c("AGO6", "AGO6", "AGO4", "AGO4")

aD <- readGeneric(files = libfiles, dir = datadir,
                  replicates = replicates, libnames = libnames,
                  polyLength = 10, header = TRUE, gap = 200)
aD

## -----------------------------------------------------------------------------
sD <- processAD(aD, cl = cl)
sD

## ----echo = FALSE, results = 'hide'-------------------------------------------
if(nrow(sD) != 1452) stop("sD object is the wrong size (should have 1452 rows). Failure.")

## -----------------------------------------------------------------------------
hS <- heuristicSeg(sD = sD, aD = aD, RKPM = 1000, largeness = 1e8, getLikes = TRUE, cl = cl)

## ----echo = FALSE, results = 'hide'-------------------------------------------
if(nrow(hS) != 507) stop("hS object is the wrong size (should have 507 rows). Failure.")
if(any(abs(colSums(exp(hS@locLikelihoods)) - c(88, 208)) > 2)) stop("hS object contains wrong number of loci. Likely failure.")

## -----------------------------------------------------------------------------
cS <- classifySeg(sD = sD, aD = aD, cD = hS, cl = cl)
cS

## ----echo = FALSE, results = 'hide'-------------------------------------------
if(abs(nrow(cS) - 64) > 2) stop("cS object is the wrong size (should have ~142 rows). Likely failure.")
if(any(abs(colSums(exp(cS@locLikelihoods)) - c(29,36)) > 2)) stop("cS object contains wrong number of loci. Likely failure.")

## ----fig = FALSE, height = 10, width = 12, fig.cap="The segmented genome (first $10^5$ bases of chromosome 1)."----
par(mfrow = c(2,1), mar = c(2,6,2,2))
plotGenome(aD, hS, chr = ">Chr1", limits = c(1, 1e5),
           showNumber = FALSE, cap = 50)
plotGenome(aD, cS, chr = ">Chr1", limits = c(1, 1e5),
           showNumber = FALSE, cap = 50)

## -----------------------------------------------------------------------------
loci <- selectLoci(cS, FDR = 0.05)
loci

## -----------------------------------------------------------------------------
groups(cS) <- list(NDE = c(1,1,1,1), DE = c("AGO6", "AGO6", "AGO4", "AGO4"))

## -----------------------------------------------------------------------------
cS <- getPriors(cS, cl = cl)

## -----------------------------------------------------------------------------
cS <- getLikelihoods(cS, nullData = TRUE, cl = cl)

## -----------------------------------------------------------------------------
topCounts(cS, NULL, number = 3)

## -----------------------------------------------------------------------------
topCounts(cS, "NDE", number = 3)

## -----------------------------------------------------------------------------
topCounts(cS, "DE", number = 3)

## ----stopCluster--------------------------------------------------------------
if(!is.null(cl))
    stopCluster(cl)

## -----------------------------------------------------------------------------
sessionInfo()

