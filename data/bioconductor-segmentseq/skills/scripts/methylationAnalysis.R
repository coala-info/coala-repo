# Code example from 'methylationAnalysis' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(segmentSeq)

## ----results='hide', eval = TRUE----------------------------------------------
if(FALSE) { # set to FALSE if you don't want parallelisation
    numCores <- min(8, detectCores())
    cl <- makeCluster(numCores)
} else {
    cl <- NULL
}

## -----------------------------------------------------------------------------
datadir <- system.file("extdata", package = "segmentSeq")
files <- c(
  "short_18B_C24_C24_trim.fastq_CG_methCalls.gz",
  "short_Sample_17A_trimmed.fastq_CG_methCalls.gz",
  "short_13_C24_col_trim.fastq_CG_methCalls.gz",
  "short_Sample_28_trimmed.fastq_CG_methCalls.gz")

mD <- readMeths(files = files, dir = datadir,
libnames = c("A1", "A2", "B1", "B2"), replicates = c("A","A","B","B"),
nonconversion = c(0.004777, 0.005903, 0.016514, 0.006134))

## ----fig = FALSE, height = 10, width = 12, fig.cap = "Distributions of methylation on the genome (first two million bases of chromosome 1)."----
par(mfrow = c(2,1))
dists <- plotMethDistribution(mD, main = "Distributions of methylation", chr = "Chr1")
plotMethDistribution(mD,
                     subtract = rowMeans(sapply(dists, function(x) x[,2])),
                     main = "Differences between distributions", chr = "Chr1")

## -----------------------------------------------------------------------------
sD <- processAD(mD, cl = cl)

## ----echo = FALSE, results = 'hide'-------------------------------------------
if(nrow(sD) != 249271) stop("sD object is the wrong size (should have 249271 rows). Failure.")

## -----------------------------------------------------------------------------
thresh = 0.2
hS <- heuristicSeg(sD = sD, aD = mD, prop = thresh, cl = cl, gap = 100, getLikes = FALSE)
hS

## ----echo = FALSE, results = 'hide'-------------------------------------------
if(nrow(hS) != 2955) stop("hS object is the wrong size (should have 2955 rows). Failure.")

## -----------------------------------------------------------------------------
hS <- mergeMethSegs(hS, mD, gap = 5000, cl = cl)

## ----eval = FALSE-------------------------------------------------------------
# hSL <- lociLikelihoods(hS, mD, cl = cl)

## ----echo = FALSE-------------------------------------------------------------
data(hSL)

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# %eBS <- classifySeg(sD, hS, mD, cl = cl)

## ----fig = FALSE, height = 10, width = 12, fig.caption = "Methylation and identified loci on the first ten thousand bases of chromosome 1."----
plotMeth(mD, hSL, chr = "Chr1", limits = c(1, 50000), cap = 10)

## -----------------------------------------------------------------------------
groups(hSL) <- list(NDE = c(1,1,1,1), DE = c("A", "A", "B", "B"))

## -----------------------------------------------------------------------------
hSL <- methObservables(hSL)

## -----------------------------------------------------------------------------
densityFunction(hSL) <- bbNCDist

## ----getPriors, eval=FALSE----------------------------------------------------
# hSL <- getPriors(hSL, cl = cl)

## ----getLikelihoods, eval=FALSE-----------------------------------------------
# hSL <- getLikelihoods(hSL, cl = cl)

## ----eval=FALSE---------------------------------------------------------------
# topCounts(hSL, "DE")

## ----stopCluster--------------------------------------------------------------
if(!is.null(cl))
    stopCluster(cl)

## -----------------------------------------------------------------------------
sessionInfo()

