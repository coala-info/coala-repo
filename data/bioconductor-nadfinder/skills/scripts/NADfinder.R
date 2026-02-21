# Code example from 'NADfinder' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE--------------------------------
suppressPackageStartupMessages({
  library(NADfinder)
  library(BSgenome.Mmusculus.UCSC.mm10)
  library(rtracklayer)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE, eval=TRUE)

## ----quickStart, fig.width=6, fig.height=4------------------------------------
## load the library
library(NADfinder)
library(SummarizedExperiment)
## test bam files in the package
path <- system.file("extdata", package = "NADfinder", lib.loc = NULL,
            mustWork = TRUE)
bamFiles <- dir(path, ".bam$")

## window size for tile of genome. Here we set it to a big window size,
## ie., 50k because of the following two reasons:
## 1. peaks of NADs are wide;
## 2. data will be smoothed better with bigger window size.
ws <- 50000
## step for tile of genome
step <- 5000
## Set the background. 
## 0.25 means 25% of the lower ratios will be used for background training.
backgroundPercentage <- 0.25
## Count the reads for each window with a given step in the genome.
## The output will be a GRanges object.
library(BSgenome.Mmusculus.UCSC.mm10)

## ----eval=FALSE---------------------------------------------------------------
# se <- tileCount(reads=file.path(path, bamFiles),
#                 genome=Mmusculus,
#                 windowSize=ws,
#                 step=step,
#                 mode = IntersectionNotStrict,
#                 dataOverSamples = FALSE)

## -----------------------------------------------------------------------------
data(single.count)
se <- single.count

## -----------------------------------------------------------------------------

## Calculate ratios for peak calling. We use nucleoleus vs genomic DNA.
dat <- log2se(se, nucleolusCols = "N18.subsampled.srt.bam", 
              genomeCols ="G18.subsampled.srt.bam",
              transformation = "log2CPMRatio")
## Smooth the ratios for each chromosome.
## We found that for each chromosome, the ratios are higher in 5'end than 3'end.
datList <- smoothRatiosByChromosome(dat, chr = c("chr18", "chr19"), N = 100)
## check the difference between the cumulative percentage tag allocation 
## in genome and nucleoleus samples.
cumulativePercentage(datList[["chr18"]])

## -----------------------------------------------------------------------------
## check the results of smooth function
chr18 <- datList[["chr18"]] ## we only have reads in chr18 in test data.
chr18subset <- subset(chr18, seq.int(floor(length(chr18)/10))*10)
chr18 <- assays(chr18subset)
ylim <- range(c(chr18$ratio[, 1], 
                chr18$bcRatio[, 1], 
                chr18$smoothedRatio[, 1]))
plot(chr18$ratio[, 1], 
     ylim=ylim*c(.9, 1.1), 
     type="l", main="chr18")
abline(h=0, col="cyan", lty=2)
points(chr18$bcRatio[, 1], type="l", col="green")
points(chr18$smoothedRatio[, 1], type="l", col="red")
legend("topright", 
       legend = c("raw_ratio", "background_corrected", "smoothed"), 
       fill = c("black", "green", "red"))
## call peaks for each chromosome
peaks <- lapply(datList, trimPeaks, 
                backgroundPercentage=backgroundPercentage, 
                cutoffAdjPvalue=0.05, countFilter=1000)
## plot the peaks in "chr18"
peaks.subset <- countOverlaps(rowRanges(chr18subset), peaks$chr18)>=1
peaks.run <- rle(peaks.subset)
run <- cumsum(peaks.run$lengths)
run <- data.frame(x0=c(1, run[-length(run)]), x1=run)
#run <- run[peaks.run$values, , drop=FALSE]
rect(xleft = run$x0, ybottom = ylim[2]*.75, 
     xright = run$x1, ytop = ylim[2]*.8,
     col = "black")
## convert list to a GRanges object
peaks.gr <- unlist(GRangesList(peaks))

## -----------------------------------------------------------------------------
## output the peaks
write.csv(as.data.frame(unname(peaks.gr)), "peaklist.csv", row.names=FALSE)
## export peaks to a bed file.
library(rtracklayer)
#export(peaks.gr, "peaklist.bed", "BED")

## -----------------------------------------------------------------------------
library(NADfinder)
## bam file path
path <- system.file("extdata", package = "NADfinder", lib.loc = NULL,
            mustWork = TRUE)
bamFiles <- dir(path, ".bam$")

f <- bamFiles
ws <- 50000
step <- 5000
library(BSgenome.Mmusculus.UCSC.mm10)

## ----eval=FALSE---------------------------------------------------------------
# se <- tileCount(reads=file.path(path, f),
#                 genome=Mmusculus,
#                 windowSize=ws,
#                 step=step)

## -----------------------------------------------------------------------------
data(triplicate.count)
se <- triplicate.count

## Calculate ratios for nucleoloar vs genomic samples.
se <- log2se(se, 
             nucleolusCols = c("N18.subsampled.srt-2.bam", 
                                "N18.subsampled.srt-3.bam",
                                "N18.subsampled.srt.bam" ),
             genomeCols = c("G18.subsampled.srt-2.bam",
                            "G18.subsampled.srt-3.bam",
                            "G18.subsampled.srt.bam"), 
             transformation = "log2CPMRatio")
seList<- smoothRatiosByChromosome(se, chr="chr18")
cumulativePercentage(seList[["chr18"]])
peaks <- lapply(seList, callPeaks, 
                cutoffAdjPvalue=0.05, countFilter=1)
peaks <- unlist(GRangesList(peaks))
peaks

## ----fig.height=1.5-----------------------------------------------------------
ideo <- readRDS(system.file("extdata", "ideo.mm10.rds", 
                            package = "NADfinder"))
plotSig(ideo=ideo, grList=GRangesList(peaks), mcolName="AveSig", 
        layout=list("chr18"), 
        parameterList=list(types="heatmap"))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

