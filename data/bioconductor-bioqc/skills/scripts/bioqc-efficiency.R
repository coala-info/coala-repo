# Code example from 'bioqc-efficiency' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
options(fig_caption=TRUE)
library(knitr)
opts_chunk$set(out.extra='style="display:block; margin: auto"', fig.align="center")

## ----lib, warning=FALSE, message=FALSE, results="hide", include=FALSE---------
library(testthat)
library(BioQC)
library(org.Hs.eg.db) ## to simulate an microarray expression dataset
library(lattice)
library(latticeExtra)
library(gridExtra)
library(gplots)
library(rbenchmark)

pdf.options(family="ArialMT", useDingbats=FALSE)

set.seed(1887)

## list human genes
humanGenes <- keys(revmap(org.Hs.egSYMBOL))

## read tissue-specific gene signatures
gmtFile <- system.file("extdata/exp.tissuemark.affy.roche.symbols.gmt",
                       package="BioQC")
gmt <- readGmt(gmtFile)

## ----algofig, echo=FALSE, fig.height=4.5, fig.cap="BioQC speeds up the Wilcoxon-Mann-Whitney test by avoiding futile sorting operations on the same sample."----
knitr::include_graphics("wmw-speedup.png")

## ----time_benchmark, echo=FALSE-----------------------------------------------
randomMatrix <- function(rows=humanGenes, ncol=5) {
  nrow <- length(rows)
  mat <- matrix(rnorm(nrow*ncol),
                nrow=nrow, byrow=TRUE)
  rownames(mat) <- rows
  return(mat)
}
noSamples <- c(1, 5, 10, 20, 50, 100)
noBenchRep <- 100
tmRandomMats <- lapply(noSamples, function(x) randomMatrix(ncol=x))
tissueInds <- sapply(gmt, function(x) match(x$genes, humanGenes))

wmwTestR <- function(matrix, indices, alternative) {
  res <- apply(matrix, 2, function(x) {
    sapply(indices, function(index) {
      sub <- rep(FALSE, length(x))
      sub[index] <- TRUE
      wt <- wilcox.test(x[sub], x[!sub],
                        alternative=alternative,
                        exact=FALSE)
      return(wt$p.value)
      })
    })
  return(res)
  }

## WARNING: very slow (~1-2 hours)
benchmarkFile <- "simulation-benchmark.RData"
if(!file.exists(benchmarkFile)) {
  bioqcRes <- lapply(tmRandomMats, function(mat) {
    bench <- benchmark(wmwTestRes<- wmwTest(mat,
                                            tissueInds,
                                            valType="p.greater",
                                            simplify=TRUE),
                       replications=noBenchRep)
    elapTime <- c("elapsed"=bench$elapsed,
                  "user"=bench$user.self,
                  "sys"=bench$sys.self)/noBenchRep
    res <- list(elapTime=elapTime,
                wmwTestRes=wmwTestRes)
    return(res)
    })
  
  rRes <- lapply(tmRandomMats, function(mat) {
    elapTime <- system.time(wmwTestRes <- wmwTestR(mat, tissueInds, alternative="greater"))
    res <- list(elapTime=elapTime,
                wmwTestRes=wmwTestRes)
    return(res)
    })
  save(bioqcRes, rRes, file=benchmarkFile)
  } else {
    load(benchmarkFile)
 }
getWmwTestRes <- function(x) x$wmwTestRes
rNumRes <- lapply(rRes, getWmwTestRes)
bioqcNumRes <- lapply(bioqcRes, getWmwTestRes)

## ----time_benchmark_identical-------------------------------------------------
expect_equal(bioqcNumRes, rNumRes)

## ----trellis_prepare, echo=FALSE----------------------------------------------
op <- list(layout.widths = list(left.padding = 0, key.ylab.padding = 0.5,
                                ylab.axis.padding = 0.5, axis.right = 0.5, right.padding = 0),
           layout.heights = list(top.padding = 0, bottom.padding = 0,
                                 axis.top = 0, main.key.padding = 0.5, key.axis.padding = 0.5),
           axis.text=list(cex=1.2),
           par.xlab.text=list(cex=1.4),
           par.sub.text=list(cex=1.4),
           add.text=list(cex=1.4),
           par.ylab.text=list(cex=1.4))

## ----time_benchmark_vis, echo=FALSE, fig.width=8, fig.height=4.5, dev='png', dev.args=list(pointsize=2.5), fig.cap="**Figure 2**: Time benchmark results of BioQC and R implementation of Wilcoxon-Mann-Whitney test. Left panel: elapsed time in seconds (logarithmic Y-axis). Right panel: ratio of elapsed time by two implementations. All results achieved by a single thread on in a RedHat Linux server."----
getTimeRes <- function(x) x$elapTime["elapsed"]
bioqcTimeRes <- sapply(bioqcRes, getTimeRes)
rTimeRes <- sapply(rRes, getTimeRes)
timeRes <- data.frame(NoSample=noSamples,
                      Time=c(bioqcTimeRes, rTimeRes),
                      Method=rep(c("BioQC", "NativeR"), each=length(noSamples)))

timeXY <- xyplot(Time ~ NoSample, group=Method, data=timeRes,  type="b",
                 auto.key=list(columns=2L),
                 xlab="Number of samples", ylab="Time [s]",
                 par.settings=list(superpose.symbol=list(cex=1.25, pch=16, col=c("black", "red")),
                                   superpose.line=list(col=c("black", "red"))),
                 scales=list(tck=c(1,0), alternating=1L,
                             x=list(at=noSamples),
                             y=list(log=2, at=10^c(-2, -1, 0,1,2,3, log10(2000)), labels=c(0.01, 0.1, 1, 10,100,1000, 2000))))
timeFactor <- with(timeRes,
                   tapply(1:nrow(timeRes),
                          list(NoSample),  function(x) {
                            bioqcTime <- subset(timeRes[x,], Method=="BioQC")$Time
                            rTime <- subset(timeRes[x,], Method=="NativeR")$Time
                            rTime/bioqcTime
                            }))
timeFactor.yCeiling <- max(ceiling(timeFactor/500))*500
timeFactorBar <- barchart(timeFactor ~ noSamples, horizontal=FALSE,
                          xlab="Number of samples", ylab="Ratio of elapsed time [R/BioQC]",
                          ylim=c(-20, timeFactor.yCeiling+50), col=colorRampPalette(c("lightblue", "navyblue"))(length(noSamples)),
                          scales=list(tck=c(1, 0), alternating=1L,
                                      y=list(at=seq(0,timeFactor.yCeiling, by=500)),
                                      x=list(at=seq(along=timeFactor), labels=noSamples)))

grid.arrange(timeXY, timeFactorBar, ncol=2)


## ----session_info-------------------------------------------------------------
sessionInfo()

