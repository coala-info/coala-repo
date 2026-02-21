# Code example from 'FourCSeq' vignette. See references/ for full tutorial.

## ----style, eval=TRUE, echo=FALSE, results="asis"--------------------------
BiocStyle::latex()

## ----include=FALSE---------------------------------------------------------
knitr::opts_chunk$set(concordance=TRUE, 
               resize.width="0.45\\textwidth", 
               fig.align='center',
               tidy = FALSE,
               message=FALSE)

## ----echo=FALSE, results='asis'--------------------------------------------
primerFile = system.file("extdata/primer.fa", 
                         package="FourCSeq")
writeLines(readLines(primerFile))

## ----eval=FALSE------------------------------------------------------------
#  system.file("extdata/python/demultiplex.py", package="FourCSeq")

## ----LoadLibraries, eval=TRUE----------------------------------------------
library(FourCSeq)

## ----filePaths, cache=TRUE-------------------------------------------------
referenceGenomeFile = system.file("extdata/dm3_chr2L_1-6900.fa",
                                  package="FourCSeq")
referenceGenomeFile

bamFilePath = system.file("extdata/bam", 
                          package="FourCSeq")
bamFilePath

primerFile = system.file("extdata/primer.fa", 
                         package="FourCSeq")
primerFile

## ----results='hide'--------------------------------------------------------
writeLines(readLines(primerFile))

## ----echo=FALSE,results='asis'---------------------------------------------
writeLines(readLines(primerFile))

## ----metadata, cache=TRUE--------------------------------------------------
metadata <- list(projectPath = "exampleData",
                 fragmentDir = "re_fragments",
                 referenceGenomeFile = referenceGenomeFile,
                 reSequence1 = "GATC",
                 reSequence2 = "CATG",
                 primerFile = primerFile,
                 bamFilePath = bamFilePath)
metadata

## ----colData, eval=TRUE, cache=TRUE----------------------------------------
colData <- DataFrame(viewpoint = "testdata",
                     condition = factor(rep(c("WE_68h", "MESO_68h", "WE_34h"), 
                                            each=2),
                                        levels = c("WE_68h", "MESO_68h", "WE_34h")),
                     replicate = rep(c(1, 2), 
                                     3),
                     bamFile = c("CRM_ap_ApME680_WE_6-8h_1_testdata.bam", 
                                 "CRM_ap_ApME680_WE_6-8h_2_testdata.bam",
                                 "CRM_ap_ApME680_MESO_6-8h_1_testdata.bam", 
                                 "CRM_ap_ApME680_MESO_6-8h_2_testdata.bam", 
                                 "CRM_ap_ApME680_WE_3-4h_1_testdata.bam",  
                                 "CRM_ap_ApME680_WE_3-4h_2_testdata.bam"),
                     sequencingPrimer="first")
colData

## ----ObjectInitialization, eval=TRUE, cache=TRUE, dependson=c("filePaths", "metadata", "colData")----
fc <- FourC(colData, metadata)
fc

## ----AddingFragmentReference, eval=TRUE, cache=TRUE, dependson=c("ObjectInitialization")----
fc <- addFragments(fc)

fc
rowRanges(fc)

## ----AddingViewpointFragmentInformation, eval=TRUE, cache=TRUE, dependson=c("ObjectInitialization")----
findViewpointFragments(fc) 

fc <- addViewpointFrags(fc)

## ----AddingViewpointFragmentInformationManually, eval=FALSE----------------
#  colData(fc)$chr = "chr2L"
#  colData(fc)$start = 6027
#  colData(fc)$end = 6878

## ----CountingReadOverlapsWithFragments, eval=TRUE, cache=TRUE, dependson=c("ObjectInitialization")----
fc <- countFragmentOverlaps(fc, trim=4, minMapq=30)

## ----combineFragEnds, eval=TRUE, cache=TRUE, dependson=c("CountingReadOverlapsWithFragments")----
fc <- combineFragEnds(fc)

## --------------------------------------------------------------------------
library(SummarizedExperiment)
fc
assays(fc)
head(assay(fc, "counts"))

## --------------------------------------------------------------------------
data(fc)
metadata(fc)$projectPath
metadata(fc)$projectPath <- "exampleData"

fc
assays(fc)
head(assay(fc, "counts"))

## ----WriteTrackFiles, eval=TRUE, cache=TRUE, dependson=c("CountingReadOverlapsWithFragments")----
writeTrackFiles(fc)
writeTrackFiles(fc, format='bedGraph')

## ----SmoothOverFragments, eval=TRUE, cache=TRUE, dependson=c("CountingReadOverlapsWithFragments")----
fc <- smoothCounts(fc)
fc

## ----correlation, dev.args=list(pointsize=16), dependson=c("CountingReadOverlapsWithFragments")----
plotScatter(fc[,c("ap_WE_68h_1", "ap_WE_68h_2")],
            xlab="Replicate1", ylab="Replicate2", asp=1)

## ----CalculateZScores, eval=TRUE, cache=TRUE, dependson=c("CountingReadOverlapsWithFragments"), results='hide'----
fcf <- getZScores(fc)
fcf

## ----zScoreDistribution, eval=TRUE, cache=TRUE, fig.show='hold', dependson=c("CalculateZScores")----
zScore <- SummarizedExperiment::assay(fcf, "zScore")

hist(zScore[,"ap_MESO_68h_1"], breaks=100)
hist(zScore[,"ap_MESO_68h_2"], breaks=100)

## ----zScoreDistribution2, eval=TRUE, cache=TRUE, fig.show='hold', dependson=c("zScoreDistribution")----
qqnorm(zScore[,"ap_MESO_68h_1"], 
       main="Normal Q-Q Plot - ap_MESO_68h_1")
abline(a=0, b=1)
qqnorm(zScore[,"ap_MESO_68h_2"], 
       main="Normal Q-Q Plot - ap_MESO_68h_2")
abline(a=0, b=1)

## ----addPeaks, eval=TRUE, cache=TRUE, fig.keep='none', dependson=c("CalculateZScores")----
fcf <- addPeaks(fcf, zScoreThresh=3, fdrThresh=0.01)
head(SummarizedExperiment::assay(fcf, "peaks"))

## ----fitDisplay, cache=TRUE, dependson=c("CalculateZScores"), fig.show='hold', fig.height=6, dev.args=list(pointsize=16)----
plotFits(fcf[,1], main="")

## ----plotZScores, eval=TRUE, cache=TRUE, fig.keep='all', fig.show='hold', dependson=c("CalculateZScores")----
library(TxDb.Dmelanogaster.UCSC.dm3.ensGene)

plotZScores(fcf[,c("ap_WE_68h_1", "ap_WE_68h_2")],
            txdb=TxDb.Dmelanogaster.UCSC.dm3.ensGene)

## ----FindDifferences, eval=TRUE, cache=TRUE, dependson=c("CalculateZScores")----
fcf <- getDifferences(fcf,
                      referenceCondition="WE_68h")
fcf

## ----plotDispersion, cache=TRUE, dependson=c("FindDifferences"), dev.args=list(pointsize=16)----
plotDispEsts(fcf)

## ----normalizationFactors, cache=TRUE, dependson=c("FindDifferences"), dev.args=list(pointsize=16)----
plotNormalizationFactors(fcf)

## ----maplot, cache=TRUE, dependson=c("FindDifferences"), dev.args=list(pointsize=16)----
plotMA(results(fcf, contrast=c("condition", "WE_68h", "MESO_68h")),
       alpha=0.01,
       xlab="Mean 4C signal",
       ylab="log2 fold change",
       ylim=c(-3.1,3.1))

## ----results, cache=TRUE, dependson=c("FindDifferences")-------------------
results <- getAllResults(fcf)
dim(results)
head(results)[,1:6]

## ----plotDifferences, eval=TRUE, cache=TRUE, dependson=c("FindDifferences"), fig.height=10, fig.width=15, resize.width="0.9\\textwidth", dev.args=list(pointsize=12)----
plotDifferences(fcf,
                txdb=TxDb.Dmelanogaster.UCSC.dm3.ensGene,
                plotWindows = 1e+05,
                textsize=16)

## ----integrationWithAnnotation1, eval=TRUE, cache=TRUE, fig.keep='none', dependson=c("FindDifferences")----
apId <- "FBgn0000099"
apGene <- genes(TxDb.Dmelanogaster.UCSC.dm3.ensGene,
                filter=list(gene_id=apId))
apGene

## ----integrationWithAnnotation2, eval=TRUE, cache=TRUE, fig.keep='none', dependson=c("FindDifferences")----
apPromotor <- promoters(apGene, upstream = 500, downstream=100)
apPromotor

## ----integrationWithAnnotation3, eval=TRUE, cache=TRUE, fig.keep='none', dependson=c("FindDifferences")----
frags <- rowRanges(fcf) 

if(length(frags) != nrow(results))
  stop("Number of rows is not the same for the fragment data and results table.")

ov <- findOverlaps(apPromotor, frags)
ov

## ----integrationWithAnnotation4, eval=TRUE, cache=TRUE, fig.keep='none', dependson=c("FindDifferences")----
results[subjectHits(ov),1:6]

## ----sessionInfo-----------------------------------------------------------
sessionInfo()

