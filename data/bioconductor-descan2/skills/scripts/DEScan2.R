# Code example from 'DEScan2' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, cache=FALSE-------------------------------------------
## numbers >= 10^5 will be denoted in scientific notation,
## and rounded to 2 digits
options(scipen = 1, digits = 4)

## ----message=FALSE------------------------------------------------------------
library("DEScan2")
library("RUVSeq")
library("edgeR")
BiocParallel::register(BiocParallel::SerialParam())

## ----eval=TRUE----------------------------------------------------------------
bam.files <- list.files(system.file(file.path("extdata","bam"), 
                        package="DEScan2"),
                        pattern="bam$", full.names=TRUE)

## ----findPeaks, cache=TRUE, eval=FALSE----------------------------------------
# peaksGRL <- DEScan2::findPeaks(files=bam.files[1], filetype="bam", genomeName="mm9",
#     binSize=50, minWin=50, maxWin=1000, zthresh=10, minCount=0.1, sigwin=10,
#     minCompWinWidth=5000, maxCompWinWidth=10000, save=FALSE,
#     outputFolder="peaks", force=TRUE, onlyStdChrs=TRUE, chr=NULL, verbose=FALSE)

## ----finalRegions, cache=TRUE, eval=TRUE, message=FALSE-----------------------
peaks.file <- system.file(
                file.path("extdata","peaks","RData","peaksGRL_all_files.rds"),
                package="DEScan2")

peaksGRL <- readRDS(peaks.file)
regionsGR <- DEScan2::finalRegions(peakSamplesGRangesList=peaksGRL, zThreshold=10,
                minCarriers=3, saveFlag=FALSE, outputFolder=NULL, verbose=FALSE)

head(regionsGR)

## ----countFinalRegions, cache=TRUE, eval=TRUE, message=FALSE------------------
bam.path <- system.file(file.path("extdata","bam"), package="DEScan2")
finalRegions <- DEScan2::countFinalRegions(regionsGRanges=regionsGR, 
                    readsFilePath=bam.path, fileType="bam", minCarriers=1,
                    genomeName="mm9", onlyStdChrs=TRUE, saveFlag=FALSE,
                    verbose=FALSE)

counts <- SummarizedExperiment::assay(finalRegions)
regions <- SummarizedExperiment::rowRanges(finalRegions)

## ----eval=TRUE----------------------------------------------------------------
counts <- counts[regions$`k-carriers` >= 4, ]
counts <- counts[rowSums(counts) > 0,]
colnames(counts) <- c("FC1", "FC4", "HC1", "HC4", "FC6", "FC9", "HC6", "HC9")
counts <- counts[,order(colnames(counts))]
head(counts)

## ----RUV, cache=TRUE, eval=TRUE-----------------------------------------------
library("RColorBrewer")
colors <- brewer.pal(3, "Set2")
set <- EDASeq::betweenLaneNormalization(counts, which = "upper")
groups <- matrix(c(1:8), nrow=2, byrow=TRUE)
trt <- factor(c(rep("FC", 4), rep("HC", 4)))

## ----rawPlot, fig.width=3.5, fig.height=3.5, fig.show='hold'------------------
EDASeq::plotRLE(set, outline=FALSE, ylim=c(-4, 4),
        col=colors[trt], main="No Normalization RLE")
EDASeq::plotPCA(set, col=colors[trt], main="No Normalization PCA", 
                labels=FALSE, pch=19)

## ----ruvPlot, fig.width=3.5, fig.height=3.5, fig.show='hold'------------------
k <- 4
s <- RUVSeq::RUVs(set, cIdx=rownames(set), scIdx=groups, k=k)

EDASeq::plotRLE(s$normalizedCounts, outline=FALSE, ylim=c(-4, 4), 
        col=colors[trt], main="Normalized RLE")
EDASeq::plotPCA(s$normalizedCounts, col=colors[trt], main="Normalized PCA",
        labels=FALSE, pch=19)

## ----test, cache=TRUE, eval=TRUE----------------------------------------------
design <- model.matrix(~0 + trt + s$W)
colnames(design) <- c(levels(trt), paste0("W", 1:k))

y <- edgeR::DGEList(counts=counts, group=trt)
y <- edgeR::estimateDisp(y, design)

fit <- edgeR::glmQLFit(y, design, robust=TRUE)

con <- limma::makeContrasts(FC - HC, levels=design)

qlf <- edgeR::glmQLFTest(fit, contrast=con)
res <- edgeR::topTags(qlf, n=Inf, p.value=0.05)
head(res$table)
dim(res$table)
regions[rownames(res$table)]

## ----eval=FALSE---------------------------------------------------------------
# library("BiocParallel")
# 
# peaksGRL <- DEScan2::findPeaks(files=bam.files[1], filetype="bam", genomeName="mm9",
#     binSize=50, minWin=50, maxWin=1000, zthresh=10, minCount=0.1, sigwin=10,
#     minCompWinWidth=5000, maxCompWinWidth=10000, save=FALSE,
#     outputFolder="peaks", force=TRUE, onlyStdChrs=TRUE, chr=NULL, verbose=FALSE,
#     BPPARAM=BiocParallel::MulticoreParam(2))

