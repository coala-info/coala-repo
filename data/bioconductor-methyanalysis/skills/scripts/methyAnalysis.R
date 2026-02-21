# Code example from 'methyAnalysis' vignette. See references/ for full tutorial.

### R code from vignette source 'methyAnalysis.Rnw'

###################################################
### code chunk number 1: init
###################################################
options(width=50)


###################################################
### code chunk number 2: load library and example data
###################################################
library(methyAnalysis)
## load the example data
data(exampleMethyGenoSet)

## show MethyGenoSet class
slotNames(exampleMethyGenoSet)
# showClass('MethyGenoSet')

## get chromosome location information
head(rowRanges(exampleMethyGenoSet))

## retrieve methylation data
dim(exprs(exampleMethyGenoSet))

## Sample information
colData(exampleMethyGenoSet)


###################################################
### code chunk number 3: Slide-window smoothing of the DNA methylation data
###################################################
methyGenoSet.sm <- smoothMethyData(exampleMethyGenoSet, winSize = 250)

## winsize is kept as an attribute
attr(methyGenoSet.sm, 'windowSize')


###################################################
### code chunk number 4: Differential methylation test
###################################################
## get sample type information
sampleType <- colData(exampleMethyGenoSet)$SampleType

## Do differential test
allResult <- detectDMR.slideWin(exampleMethyGenoSet, sampleType=sampleType)
head(allResult)


###################################################
### code chunk number 5: Identifying DMR
###################################################
## Identify the DMR (Differentially Methylated Region) by setting proper parameters.
## Here we just use default ones
allDMRInfo = identifySigDMR(allResult)
names(allDMRInfo)


###################################################
### code chunk number 6: Identifying DMR
###################################################
## Annotate significant DMR info
DMRInfo.ann <- annotateDMRInfo(allDMRInfo, 'TxDb.Hsapiens.UCSC.hg19.knownGene')

## output the DMR information
export.DMRInfo(DMRInfo.ann, savePrefix='testExample')


###################################################
### code chunk number 7: Export data for external tools (eval = FALSE)
###################################################
## ## output in IGV supported "gct" file
## export.methyGenoSet(exampleMethyGenoSet, file.format='gct', savePrefix='test')
## ## output in BigWig files
## export.methyGenoSet(exampleMethyGenoSet, file.format='bw', savePrefix='test')


###################################################
### code chunk number 8: heatmap
###################################################
heatmapByChromosome(exampleMethyGenoSet, gene='6493',  genomicFeature='TxDb.Hsapiens.UCSC.hg19.knownGene', includeGeneBody=TRUE, newPlot=FALSE)


###################################################
### code chunk number 9: heatmap_phenotype
###################################################
plotMethylationHeatmapByGene('6493', methyGenoSet=exampleMethyGenoSet, includeGeneBody=TRUE,
    phenoData=colData(exampleMethyGenoSet), genomicFeature='TxDb.Hsapiens.UCSC.hg19.knownGene', 
    newPlot=FALSE)


###################################################
### code chunk number 10: methyAnalysis.Rnw:214-215
###################################################
toLatex(sessionInfo())


