# Code example from 'CAnD' vignette. See references/ for full tutorial.

### R code from vignette source 'CAnD.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadLibrariesAndData
###################################################
library(CAnD)
data(ancestries)
dim(ancestries)


###################################################
### code chunk number 3: viewData
###################################################
ancestries[1:2,c(1,2,25,48)]


###################################################
### code chunk number 4: plotHists
###################################################

par(mfrow=c(2,2))
hist(ancestries$Afr_1,main="Est Proportion African Ancestry\nChromosome 1",
     xlab="Chr 1 Prop African Ancest",cex.main=0.8)
hist(ancestries$Afr_2,main="Est Proportion African Ancestry\nChromosome 2",
     xlab="Chr 2 Prop African Ancest",cex.main=0.8)

afrCols <- seq(from=25,to=(25+22))
asianCols <- seq(from=(25+22+1),to=ncol(ancestries))
hist(as.numeric(ancestries[1,afrCols]),main="Est Proportion African Ancestry\nGenome-wide, Sample 1",
     xlab="Sample 1 Prop African Ancestry",cex.main=0.8)
hist(as.numeric(ancestries[1,asianCols]),main="Est Proportion Asian Ancestry\nGenome-wide, Sample 1",
     xlab="Sample 1 Prop Asian Ancestry",cex.main=0.8)


###################################################
### code chunk number 5: subsetp
###################################################
euroCols <- seq(from=2,to=(2+22))
head(ancestries[,euroCols[20:23]],2)
colnames(ancestries[euroCols])

euroEsts <- ancestries[,euroCols]
dim(euroEsts)
head(euroEsts[,1:5],2)


###################################################
### code chunk number 6: param
###################################################
param_cRes <- CAnD(euroEsts)
param_cRes

test(param_cRes)
overallpValue(param_cRes)
overallStatistic(param_cRes)
BonfCorr(param_cRes)


###################################################
### code chunk number 7: param_results
###################################################
pValues(param_cRes)


###################################################
### code chunk number 8: plotb
###################################################
plotPvals(param_cRes, main="CAnD P-values\nProportion European Ancestry Genome-wide")


###################################################
### code chunk number 9: plot2
###################################################
chr1 <- ancestries[,c("Euro_1","Afr_1","Asian_1")]
barPlotAncest(chr1,title="Chromosome 1 Ancestry Proportions")


###################################################
### code chunk number 10: sessInfo
###################################################
toLatex(sessionInfo())


###################################################
### code chunk number 11: resetOptions
###################################################
options(prompt="> ", continue="+ ")


