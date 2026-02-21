# Code example from 'bsseq' vignette. See references/ for full tutorial.

## ----dependencies, warning=FALSE, message=FALSE-------------------------------
library(bsseq)

## ----BSchr22------------------------------------------------------------------
data(BS.chr22)
BS.chr22

## ----ov-granges---------------------------------------------------------------
head(granges(BS.chr22), n = 4)

## ----ov-getCoverage-----------------------------------------------------------
head(getCoverage(BS.chr22, type = "M"), n = 4)
head(getCoverage(BS.chr22), n = 4)

## ----using-examples-----------------------------------------------------------
head(start(BS.chr22), n = 4)
head(seqnames(BS.chr22), n = 4)
sampleNames(BS.chr22)
pData(BS.chr22)
dim(BS.chr22)
BS.chr22[1:6,1]
subsetByOverlaps(BS.chr22, 
                 GRanges(seqnames = "chr22", 
                         ranges = IRanges(start = 1, end = 2*10^7)))

## ----data-bsseq---------------------------------------------------------------
M <- matrix(0:8, 3, 3)
Cov <- matrix(1:9, 3, 3)
BStmp <- BSseq(chr = c("chr1", "chrX", "chr1"), pos = 1:3, 
               M = M, Cov = Cov, sampleNames = c("A1","A2", "B"))

## ----data-order---------------------------------------------------------------
granges(BStmp)
BStmp <- orderBSseq(BStmp, seqOrder = c("chr1", "chrX"))
granges(BStmp)

## ----data-chrSelect-----------------------------------------------------------
chrSelectBSseq(BStmp, seqnames = "chr1", order = TRUE)

## ----data-combine-------------------------------------------------------------
BStmp2 <- combine(BStmp, BS.chr22[1:3,])
granges(BStmp2)
getCoverage(BStmp2)

## ----data-collapse------------------------------------------------------------
collapseBSseq(BStmp, group = c("A", "A", "B"))

## ----getCoverage1-------------------------------------------------------------
head(getCoverage(BS.chr22, type = "Cov"), n = 4)
head(getCoverage(BS.chr22, type = "M"), n = 4)

## ----regions------------------------------------------------------------------
regions <- GRanges(seqnames = c("chr22", "chr22"), 
                   ranges = IRanges(start = 1.5 * 10^7 + c(0,200000), 
                                    width = 1000))
getCoverage(BS.chr22, regions = regions, what = "perRegionTotal")

## ----getCoverage2-------------------------------------------------------------
getCoverage(BS.chr22, regions = regions, what = "perBase")

## ----getMeth------------------------------------------------------------------
getMeth(BS.chr22, regions, type = "raw")
getMeth(BS.chr22, regions[2], type = "raw", what = "perBase")

## ----locateScript, results="hide"---------------------------------------------
system.file("scripts", "get_BS.chr22.R", package = "bsseq")

## ----BSmooth------------------------------------------------------------------
BS.chr22.1 <- BSmooth(BS.chr22[,"r1"], verbose = TRUE)
BS.chr22.1

## ----eval=FALSE---------------------------------------------------------------
# library(HDF5Array)
# saveHDF5SummarizedExperiment(BSseq, dir = "./BSseqName.h5")

## ----eval=FALSE---------------------------------------------------------------
# BSseq <- loadHDF5SummarizedExperiment(dir = "./BSseqName.h5")

## ----eval=FALSE---------------------------------------------------------------
# BSseq <- read.bismark(bismarkfiles, BACKEND = "HDF5Array", BPPARAM = MulticoreParam(workers = 10))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

