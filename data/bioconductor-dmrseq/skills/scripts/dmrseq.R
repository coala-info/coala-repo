# Code example from 'dmrseq' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE,
    dev="png", 
    message=FALSE, error=FALSE, warning=TRUE)

## ----quickStart, eval=FALSE---------------------------------------------------
# bs <- BSseq(chr = chr, pos = pos,
#             M = M, Cov = Cov,
#             sampleNames = sampleNames)
# pData(bs)$Condition <- trt
# 
# regions <- dmrseq(bs=bs, testCovariate="Condition")

## ----bismarkinput-------------------------------------------------------------
library(dmrseq)
infile <- system.file("extdata/test_data.fastq_bismark.bismark.cov.gz",
                        package = 'bsseq')
bismarkBSseq <- read.bismark(files = infile,
                               rmZeroCov = TRUE,
                               strandCollapse = FALSE,
                               verbose = TRUE)
bismarkBSseq

## ----dissect, results="hide", echo=FALSE--------------------------------------
data("BS.chr21")
M <- getCoverage(BS.chr21, type="M")
Cov <- getCoverage(BS.chr21, type="Cov")
chr <- as.character(seqnames(BS.chr21))
pos <- start(BS.chr21)
celltype <- pData(BS.chr21)$CellType
sampleNames <- sampleNames(BS.chr21)

## ----fromScratch--------------------------------------------------------------
head(M)
head(Cov)
head(chr)
head(pos)

dim(M)
dim(Cov)
length(chr)
length(pos)

print(sampleNames)
print(celltype)

bs <- BSseq(chr = chr, pos = pos,
            M = M, Cov = Cov, 
            sampleNames = sampleNames)
show(bs)

## ----cleanup, results="hide", echo=FALSE--------------------------------------
rm(M, Cov, pos, chr, bismarkBSseq)

## ----meta---------------------------------------------------------------------
pData(bs)$CellType <- celltype
pData(bs)$Replicate <- substr(sampleNames, 
                              nchar(sampleNames), nchar(sampleNames))

pData(bs)

## ----filter-------------------------------------------------------------------
# which loci and sample indices to keep
loci.idx <- which(DelayedMatrixStats::rowSums2(getCoverage(bs, type="Cov")==0) == 0)
sample.idx <- which(pData(bs)$CellType %in% c("imr90", "h1"))

bs.filtered <- bs[loci.idx, sample.idx]

## ----results="hide", echo=FALSE-----------------------------------------------
rm(bs.filtered)

## ----mainfunction, message=TRUE, warning=TRUE---------------------------------
testCovariate <- "CellType"
regions <- dmrseq(bs=bs[240001:260000,],
                  cutoff = 0.05,
                  testCovariate=testCovariate)

## ----showresults--------------------------------------------------------------
show(regions)

## ----parallel, eval=FALSE-----------------------------------------------------
# library("BiocParallel")
# register(MulticoreParam(4))

## ----blocks, message=TRUE, warning=TRUE---------------------------------------
testCovariate <- "CellType"
blocks <- dmrseq(bs=bs[120001:125000,],
                  cutoff = 0.05,
                  testCovariate=testCovariate,
                  block = TRUE,
                  minInSpan = 500,
                  bpSpan = 5e4,
                  maxGapSmooth = 1e6,
                  maxGap = 5e3)
head(blocks)

## -----------------------------------------------------------------------------
sum(regions$qval < 0.05)

# select just the regions below FDR 0.05 and place in a new data.frame
sigRegions <- regions[regions$qval < 0.05,]

## ----hyper--------------------------------------------------------------------
sum(sigRegions$stat > 0) / length(sigRegions)

## ----plot, out.width='\\textwidth', fig.height = 2.5, warning=FALSE-----------
# get annotations for hg18
annoTrack <- getAnnot("hg18")

plotDMRs(bs, regions=regions[1,], testCovariate="CellType",
    annoTrack=annoTrack)

## ----plotblock, out.width='\\textwidth', fig.height = 2.5, warning=FALSE------
plotDMRs(bs, regions=blocks[1,], testCovariate="CellType",
    annoTrack=annoTrack)

## ----plot2, fig.height=3------------------------------------------------------
plotEmpiricalDistribution(bs, testCovariate="CellType")

## ----plot3, fig.height=3------------------------------------------------------
plotEmpiricalDistribution(bs, testCovariate="CellType", 
                          type="Cov", bySample=TRUE)

## ----export, eval=FALSE-------------------------------------------------------
# write.csv(as.data.frame(regions),
#           file="h1_imr90_results.csv")

## ----meandiff-----------------------------------------------------------------
rawDiff <- meanDiff(bs, dmrs=sigRegions, testCovariate="CellType")
str(rawDiff)

## ----sim----------------------------------------------------------------------
data(BS.chr21)

# reorder samples to create a null comparison 
BS.null <- BS.chr21[1:20000,c(1,3,2,4)]

# add 100 DMRs
BS.chr21.sim <- simDMRs(bs=BS.null, num.dmrs=100)

# bsseq object with original null + simulated DMRs
show(BS.chr21.sim$bs)

# coordinates of spiked-in DMRs
show(BS.chr21.sim$gr.dmrs)

# effect sizes
head(BS.chr21.sim$delta)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

