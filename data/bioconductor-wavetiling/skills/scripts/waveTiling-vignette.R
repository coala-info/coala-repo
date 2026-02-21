# Code example from 'waveTiling-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'waveTiling-vignette.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=72)


###################################################
### code chunk number 2: waveTiling-vignette.Rnw:51-55
###################################################
library(waveTiling)
library(waveTilingData)
library(pd.atdschip.tiling)
data(leafdev)


###################################################
### code chunk number 3: waveTiling-vignette.Rnw:60-65
###################################################
leafdev <- as(leafdev,"WaveTilingFeatureSet")
leafdev <- addPheno(leafdev,noGroups=6,
	groupNames=c("day8","day9","day10","day11","day12","day13"),
	replics=rep(3,6))
leafdev


###################################################
### code chunk number 4: waveTiling-vignette.Rnw:68-70
###################################################
rm(leafdev)
gc()


###################################################
### code chunk number 5: waveTiling-vignette.Rnw:75-83
###################################################
library(BSgenome.Athaliana.TAIR.TAIR9)

# leafdevMapAndFilterTAIR9 <- filterOverlap(leafdev,remap=TRUE,
#	BSgenomeObject=Athaliana,chrId=1:7,
#	strand="both",MM=FALSE)
data(leafdevMapAndFilterTAIR9)

# leafdevBQ <- bgCorrQn(leafdev,useMapFilter=leafdevMapAndFilterTAIR9)


###################################################
### code chunk number 6: waveTiling-vignette.Rnw:91-100
###################################################
data(leafdevBQ)
chromosome <- 1
strand <- "forward"
leafdevFit <- wfm.fit(leafdevBQ,filter.overlap=leafdevMapAndFilterTAIR9,
	design="time",n.levels=10,
	chromosome=chromosome,strand=strand,minPos=22000000,
	maxPos=24000000,var.eps="marg",prior="improper",
	skiplevels=1,save.obs="plot",trace=TRUE)
leafdevFit


###################################################
### code chunk number 7: waveTiling-vignette.Rnw:107-111
###################################################
delta <- log(1.2,2)
leafdevInfCompare <- wfm.inference(leafdevFit,
	contrasts="compare",delta=c("median",delta))
leafdevInfCompare


###################################################
### code chunk number 8: waveTiling-vignette.Rnw:118-121
###################################################
sigGenomeRegionsCompare <- getGenomicRegions(leafdevInfCompare)
sigGenomeRegionsCompare[[2]]
length(sigGenomeRegionsCompare)


###################################################
### code chunk number 9: waveTiling-vignette.Rnw:128-135
###################################################
library(TxDb.Athaliana.BioMart.plantsmart22)
sigGenesCompare <- getSigGenes(fit=leafdevFit,inf=leafdevInfCompare,
	biomartObj=TxDb.Athaliana.BioMart.plantsmart22)
head(sigGenesCompare[[2]])
nonAnnoCompare <- getNonAnnotatedRegions(fit=leafdevFit,inf=leafdevInfCompare,
	biomartObj=TxDb.Athaliana.BioMart.plantsmart22)
head(nonAnnoCompare[[2]])


###################################################
### code chunk number 10: waveTiling-vignette.Rnw:140-145
###################################################
leafdevInfTimeEffect <- wfm.inference(leafdevFit,contrasts="effects",
	delta=c("median",2,0.2,0.2,0.2,0.2))

leafdevInfMeans <- wfm.inference(leafdevFit,contrasts="means",
	delta=4,minRunPos=30,minRunProbe=-1)


###################################################
### code chunk number 11: waveTiling-vignette.Rnw:150-176
###################################################
custDes <- matrix(0,nrow=18,ncol=6)
orderedFactor <- factor(1:6,ordered=TRUE)
desPoly <- lm(rnorm(6)~orderedFactor,x=TRUE)$x
custDes[,1] <- 1
custDes[,2:6] <- apply(desPoly[,2:6],2,rep,getReplics(leafdevBQ))
custDes

leafdevFitCustom <- wfm.fit(leafdevBQ,filter.overlap=leafdevMapAndFilterTAIR9,
	design="custom",design.matrix=custDes,n.levels=10,
	chromosome=chromosome,strand=strand,minPos=22000000,
	maxPos=24000000,var.eps="marg",prior="improper",
	skiplevels=1,save.obs="plot",trace=TRUE)

noGroups <- getNoGroups(leafdevBQ)
myContrastMat <- matrix(0,nrow=noGroups*(noGroups-1)/2,ncol=noGroups)
hlp1 <- rep(2:noGroups,1:(noGroups-1))
hlp2 <- unlist(sapply(1:(noGroups-1),function(x) seq(1:x)))
for (i in 1:nrow(myContrastMat))
{
	myContrastMat[i,hlp1[i]] <- 1
	myContrastMat[i,hlp2[i]] <- -1
}
myContrastMat

leafdevInfCustom <- wfm.inference(leafdevFitCustom,contrast.matrix=myContrastMat,
	delta=c("median",log(1.2,2)))


###################################################
### code chunk number 12: waveTiling-vignette.Rnw:184-192
###################################################
trs <- transcripts(TxDb.Athaliana.BioMart.plantsmart22)
sel <- trs[elementMetadata(trs)$tx_name %in% "AT1G62500.1",]
start <- start(ranges(sel))-2000
end <- end(ranges(sel))+2000
plotWfm(fit=leafdevFit,inf=leafdevInfCompare,
	biomartObj=TxDb.Athaliana.BioMart.plantsmart22,
	minPos=start,maxPos=end,two.strand=TRUE,
	plotData=TRUE,plotMean=FALSE,tracks=c(1,2,6,10,11))


###################################################
### code chunk number 13: waveTiling-vignette.Rnw:195-201
###################################################
start <- start(ranges(sel))-4000
end <- end(ranges(sel))+4000
plotWfm(fit=leafdevFit,inf=leafdevInfTimeEffect,
	biomartObj=TxDb.Athaliana.BioMart.plantsmart22,
	minPos=start,maxPos=end,two.strand=TRUE,
	plotData=TRUE,plotMean=FALSE,tracks=1)


###################################################
### code chunk number 14: waveTiling-vignette.Rnw:204-208
###################################################
plotWfm(fit=leafdevFit,inf=leafdevInfMeans,
	biomartObj=TxDb.Athaliana.BioMart.plantsmart22,
	minPos=start,maxPos=end,two.strand=TRUE,
	plotData=TRUE,plotMean=FALSE,tracks=1:6)


###################################################
### code chunk number 15: waveTiling-vignette.Rnw:216-234
###################################################
getGenomeInfo(leafdevFit)
dataOrigSpace <- getDataOrigSpace(leafdevFit)
dim(dataOrigSpace)
dataOrigSpace[1:8,1:8]
dataWaveletSpace <- getDataWaveletSpace(leafdevFit)
dim(dataWaveletSpace)
dataWaveletSpace[1:8,1:8]
getDesignMatrix(leafdevFit)
probepos <- getProbePosition(leafdevFit)
length(probepos)
head(probepos)

effects <- getEff(leafdevInfCompare)
dim(effects)
effects[1:8,1:8]
fdrs <- getFDR(leafdevInfCompare)
dim(fdrs)
fdrs[1:8,1:8]


