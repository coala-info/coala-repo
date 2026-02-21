# Code example from 'CopyNumberPlots' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(concordance=FALSE)
knitr::opts_chunk$set(fig.width = 18)
knitr::opts_chunk$set(fig.height = 12)
set.seed(21666641)

## ----getPackage, eval=FALSE---------------------------------------------------
#   if (!requireNamespace("BiocManager", quietly = TRUE))
#       install.packages("BiocManager")
#   BiocManager::install("CopyNumberPlots")

## ----eval = FALSE-------------------------------------------------------------
#   BiocManager::install("bernatgel/CopyNumberPlots")

## -----------------------------------------------------------------------------
  library(CopyNumberPlots)

  s1.file <- system.file("extdata", "S1.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1 <- loadSNPData(s1.file)
  s1

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1)

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, s1)

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1, r0=0.55, r1=1)
  plotLRR(kp, s1, r0=0, r1=0.45)

## -----------------------------------------------------------------------------
  s1.calls.file <- system.file("extdata", "S1.segments.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1.calls <- loadCopyNumberCalls(s1.calls.file)
  s1.calls

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, s1, r0=0.6, r1=1)
  plotLRR(kp, s1, r0=0.15, r1=0.55)
  #plotCopyNumberCalls(kp, s1.calls, r0=0, r1=0.10)

## -----------------------------------------------------------------------------
  raw.data.file <- system.file("extdata", "snp.data_test.csv", package = "CopyNumberPlots", mustWork=TRUE)
  snps <- loadSNPData(raw.data.file)
  snps

## -----------------------------------------------------------------------------
  cn.data <- toGRanges(c("chr14:66459785-86459774", "chr17:68663111-88866308",
                         "chr10:43426998-83426994", "chr3:88892741-120892733",
                         "chr2:12464318-52464316", "chrX:7665575-27665562"))
  
  cn.data$CopyNumberInteger <- sample(c(0,1,3,4), size = 6, replace = TRUE)
  cn.data$LossHetero <- cn.data$CopyNumberInteger<2
  
  cn.data

## -----------------------------------------------------------------------------
  cn.calls <- loadCopyNumberCalls(cn.data)
  cn.calls

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(plot.type = 1)
  #plotCopyNumberCalls(kp, cn.calls = cn.calls)

## -----------------------------------------------------------------------------
  s1.file <- system.file("extdata", "S1.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1 <- loadSNPData(s1.file)
  head(s1)
  
  s2.file <- system.file("extdata", "S2.rawdata.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s2 <- loadSNPData(s2.file)
  head(s2)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=s1)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=s1, r0=0, r1=0.2, labels = "BAF1", points.col = "orange",
          points.cex = 2, points.pch = 4, axis.cex = 0.3)
  plotBAF(kp, snps=s1, r0=0.3, r1=0.5, labels = "BAF2", points.col = "red",
          points.cex = 0.5, points.pch = 8, axis.cex = 0.7)
  plotBAF(kp, snps=s1, r0=0.6, r1=1, labels = "BAF3", 
          points.col = "#FF552222", points.cex = 1.8, points.pch = 16, 
          axis.cex = 0.7)

## -----------------------------------------------------------------------------
  samples <- list("Sample1"=s1, "Sample2"=s2)
  kp <- plotKaryotype(chromosomes="chr1")
  plotBAF(kp, snps=samples)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  kpAddBaseNumbers(kp)
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5, out.of.range = "density")

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, snps=s1,  ymin=-1.5, ymax=1.5, out.of.range = "density", density.window = 1e6)

## -----------------------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  plotLRR(kp, snps=s1, r0=0, r1=0.2, labels = "LRR1", points.col = "orange",
          points.cex = 2, points.pch = 4, axis.cex = 0.3)
  plotLRR(kp, snps=s1, r0=0.3, r1=0.5, labels = "LRR2", points.col = "red",
          points.cex = 0.5, points.pch = 8, axis.cex = 0.7, ymin=-1.5, ymax=1.5,
          out.of.range.col = "gold", out.of.range = "density",
          density.window = 10e6, density.height = 0.3)
  plotLRR(kp, snps=s1, r0=0.6, r1=1, labels = "LRR3",
          points.col = "#FF552222", points.cex = 1.8, points.pch = 16,
          axis.cex = 0.7)

## -----------------------------------------------------------------------------
  s1.calls.file <- system.file("extdata", "S1.segments.txt", package = "CopyNumberPlots", mustWork = TRUE)
  s1.calls <- loadCopyNumberCalls(s1.calls.file)
  s2.calls <- loadCopyNumberCalls(system.file("extdata", "S2.segments.txt", package = "CopyNumberPlots", mustWork = TRUE))
  s3.calls <- loadCopyNumberCalls(system.file("extdata", "S3.segments.txt", package = "CopyNumberPlots", mustWork = TRUE))
  s1.calls

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes = "chr1")
  #plotCopyNumberCalls(kp, s1.calls)

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chromosomes="chr1")
  #plotCopyNumberCalls(kp, s1.calls, cn.colors = "red_blue", loh.color = "orange", r1=0.8)
  cn.cols <- getCopyNumberColors(colors = "red_blue")
  legend("top", legend=names(cn.cols), fill = cn.cols, ncol=length(cn.cols))

## ----fig.wide=TRUE------------------------------------------------------------
  cn.calls <- list("Sample1"=s1.calls, "Sample2"=s2.calls, "Sample3"=s3.calls)
  kp <- plotKaryotype(chromosomes="chr1")
  #plotCopyNumberCalls(kp, cn.calls, r1=0.3)

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chr="chr1")
  #plotCopyNumberCallsAsLines(kp, s1.calls)

## ----fig.wide=TRUE------------------------------------------------------------
  kp <- plotKaryotype(chr="chr1")
  #plotCopyNumberCallsAsLines(kp, s1.calls, style = "segments")

## -----------------------------------------------------------------------------
  cn.cols <- getCopyNumberColors(colors = "green_orange_red")
  kp <- plotKaryotype(chromosomes="chr1")
  kpDataBackground(kp, color = cn.cols["2"], r0=0.3)
  #plotCopyNumberCalls(kp, cn.calls, loh.height = 0, r0=0.3)
  #plotCopyNumberSummary(kp, cn.calls, r1=0.25)

## -----------------------------------------------------------------------------
  cn.cols <- getCopyNumberColors(colors = "green_orange_red")
  kp <- plotKaryotype(chromosomes="chr1")
  kpDataBackground(kp, color = cn.cols["2"], r0=0.3)
  #plotCopyNumberCalls(kp, cn.calls, loh.height = 0, r0=0.3)
  #plotCopyNumberSummary(kp, cn.calls, r1=0.25, direction = "out")

## -----------------------------------------------------------------------------
  sessionInfo()

