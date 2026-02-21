# Code example from 'bioqc-introduction' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----seed, include=FALSE------------------------------------------------------
set.seed(1887)

## ----lib, warning=FALSE, message=FALSE, results="hide"------------------------
library(Biobase)
library(BioQC)
gmtFile <- system.file("extdata/exp.tissuemark.affy.roche.symbols.gmt", package="BioQC")
gmt <- readGmt(gmtFile)

## ----gmtReadin----------------------------------------------------------------
Nrow <- 2000L
Nsample <- 5L
gss <- unique(unlist(sapply(gmt, function(x) x$genes)))
myEset <- new("ExpressionSet",
              exprs=matrix(rnorm(Nrow*Nsample), nrow=Nrow),
              featureData=new("AnnotatedDataFrame",
                              data.frame(GeneSymbol=sample(gss, Nrow))))

## ----runBioQC-----------------------------------------------------------------
dummyRes <- wmwTest(myEset, gmt, valType="p.greater", simplify=TRUE)
summary(p.adjust(dummyRes, "BH"))

## ----basicDs------------------------------------------------------------------
myMatrix <- matrix(rnorm(Nrow*Nsample),
                   ncol=Nsample,
                   dimnames=list(NULL, LETTERS[1:Nsample]))
myList <- list(signature1=sample(1:Nrow, 100),
               signature2=sample(1:Nrow, 50),
               signature3=sample(1:Nrow, 200))
wmwTest(myMatrix, myList, valType="p.greater", simplify=TRUE)

## ----benchmark----------------------------------------------------------------
bm.Nrow <- 22000
bw.Nsample <- 5
bm.Ngs <- 5
bm.Ngssize <- sapply(1:bm.Ngs, function(x) sample(1:bm.Nrow/2, replace=TRUE))
ind <- lapply(1:bm.Ngs, function(i) sample(1:bm.Nrow, bm.Ngssize[i]))
exprs <- matrix(round(rnorm(bm.Nrow*bw.Nsample),4), nrow=bm.Nrow)

system.time(Cres <- wmwTest(exprs, ind, valType="p.less", simplify=TRUE))
system.time(Rres <- apply(exprs, 2, function(x)
                          sapply(ind, function(y)
                                 wmwTestInR(x, y, valType="p.less"))))


## ----backgroundMatters--------------------------------------------------------
bgVec <- rnorm(20000)
bgVec[1:10000] <- bgVec[1:10000] + 2
bgVec[1:10] <- bgVec[1:10] + 1
ind <- c(1:10)

(pAllGenes <- wmwTest(bgVec, ind))
(pHighExpGenes <- wmwTest(bgVec[1:10000], ind))

## ----session_info-------------------------------------------------------------
sessionInfo()

