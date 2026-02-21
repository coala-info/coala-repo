# Code example from 'beadarraySNP' vignette. See references/ for full tutorial.

### R code from vignette source 'beadarraySNP.rnw'

###################################################
### code chunk number 1: R.hide
###################################################
library(beadarraySNP)


###################################################
### code chunk number 2: Samplesheet
###################################################
datadir <- system.file("testdata", package="beadarraySNP")
readLines(paste(datadir,"4samples_opa4.csv",sep="/"))


###################################################
### code chunk number 3: Import
###################################################
SNPdata <- read.SnpSetIllumina(paste(datadir,"4samples_opa4.csv",sep="/"),datadir)
SNPdata


###################################################
### code chunk number 4: Phenodata
###################################################
pd<-read.AnnotatedDataFrame(paste(datadir,"targets.txt",sep="/"),sep="\t")
pData(SNPdata)<-cbind(pData(SNPdata),pData(pd))


###################################################
### code chunk number 5: QC1
###################################################
qc<-calculateQCarray(SNPdata)
data(QC.260)
plotQC(QC.260,"greenMed")


###################################################
### code chunk number 6: QC2
###################################################
par(mfrow=c(2,2),mar=c(4,2,1,1))
reportSamplePanelQC(QC.260,by=8)
SNPdata<-removeLowQualitySamples(SNPdata,1500,100,"OPA")


###################################################
### code chunk number 7: Normalization
###################################################
SNPnrm<-normalizeBetweenAlleles.SNP(SNPdata)
SNPnrm<-normalizeWithinArrays.SNP(SNPnrm,callscore=0.8,relative=TRUE,fixed=FALSE,quantilepersample=TRUE)
SNPnrm<-normalizeLoci.SNP(SNPnrm,normalizeTo=2)


###################################################
### code chunk number 8: reporting
###################################################
SNPnrm<-SNPnrm[featureData(SNPnrm)$CHR %in% c("4","16","17","18","19","20","X","Y"),]
reportSamplesSmoothCopyNumber(SNPnrm,normalizedTo=2,smooth.lambda=4)


###################################################
### code chunk number 9: reporting2
###################################################
reportSamplesSmoothCopyNumber(SNPnrm, normalizedTo=2, paintCytobands =TRUE, smooth.lambda=4,organism="hsa",sexChromosomes=TRUE)


###################################################
### code chunk number 10: beadarraySNP.rnw:166-167
###################################################
toLatex(sessionInfo())


