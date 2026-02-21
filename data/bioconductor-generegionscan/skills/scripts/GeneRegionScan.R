# Code example from 'GeneRegionScan' vignette. See references/ for full tutorial.

### R code from vignette source 'GeneRegionScan.Rnw'

###################################################
### code chunk number 1: gettingProbesets
###################################################
library(GeneRegionScan)


###################################################
### code chunk number 2: gettingProbesetsNotRunPart (eval = FALSE)
###################################################
## transcriptClustersFile<-"~/HuEx-1-0-st-v2.na26.hg18.transcript.csv"
## mpsToPsFile<-"~/HuEx-1-0-st-v2.r2.dt1.hg18.full.mps"
## listOfProbesets<-getProbesetsFromRegionOfInterest("HuEx-1-0-st-v2", "chr2", 215889955,216106710, transcriptClustersFile=transcriptClustersFile, mpsToPsFile=mpsToPsFile)


###################################################
### code chunk number 3: gettingProbeevelSet (eval = FALSE)
###################################################
## aptCelExtractPath<-"~/apt-bin/apt-cel-extract"
## clfPath<-"~/HuEx-1-0-st-v2.r2.clf"
## pgfPath<-"~/HuEx-1-0-st-v2.r2.pgf"
## 
## myProbeLevelSet<-getLocalProbeIntensities(listOfProbesets,"~/test-cels", aptCelExtractPath=aptCelExtractPath, pgfPath=pgfPath, clfPath=clfPath)


###################################################
### code chunk number 4: getSequence (eval = FALSE)
###################################################
## getSequence(myProbeLevelSet,1:5)


###################################################
### code chunk number 5: loadData
###################################################
data(exampleProbeLevelSet)
pData(exampleProbeLevelSet)[1:3,]


###################################################
### code chunk number 6: plot1
###################################################
plotOnGene(exampleProbeLevelSet, mrna)


###################################################
### code chunk number 7: plot2
###################################################
plotOnGene(exampleProbeLevelSet, mrna, summaryType="dots", interval=c(500,1000))
exonStructure(mrna, genomic)


###################################################
### code chunk number 8: plot3
###################################################
plotOnGene(exampleProbeLevelSet, mrna, label="gender", testType="wilcoxon", verbose=FALSE)
exonStructure(mrna, genomic)



###################################################
### code chunk number 9: plot4
###################################################
plotOnGene(exampleProbeLevelSet, mrna, label="genotype1", testType="linear model", verbose=FALSE)
exonStructure(mrna, genomic)


###################################################
### code chunk number 10: plot5
###################################################
mrna_subset<-mrna[[1]]
mrna_subset<-mrna_subset[500:1000]
plotCoexpression(exampleProbeLevelSet, gene=mrna_subset, correlationCutoff=0.5, probeLevelInfo=c("probeid","sequence"), verbose=FALSE)


###################################################
### code chunk number 11: plot6 (eval = FALSE)
###################################################
## geneRegionScan(exampleProbeLevelSet, gene=mrna, genomicData=genomic, label="genotype3", testType="linear model", correlationCutoff=0.5, probeLevelInfo=c("probeid","sequence"), verbose=FALSE)


###################################################
### code chunk number 12: sessioninfo
###################################################

sessionInfo()



