# Code example from 'SigCheck' vignette. See references/ for full tutorial.

### R code from vignette source 'SigCheck.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: loadData
###################################################
library(breastCancerNKI)
library(Biobase)
data(nki)
nki


###################################################
### code chunk number 3: showPhenoData
###################################################
varLabels(nki)


###################################################
### code chunk number 4: tDMFS
###################################################
nki$t.dmfs


###################################################
### code chunk number 5: eDMFS
###################################################
nki$e.dmfs


###################################################
### code chunk number 6: excludeNA
###################################################
dim(nki)
nki <- nki[,!is.na(nki$e.dmfs)]
dim(nki)


###################################################
### code chunk number 7: loadKnown
###################################################
library(SigCheck)
data(knownSignatures)
names(knownSignatures)


###################################################
### code chunk number 8: getVANTVEER
###################################################
names(knownSignatures$cancer)
vantveer <- knownSignatures$cancer$VANTVEER
vantveer


###################################################
### code chunk number 9: showFeatureAnno
###################################################
fvarLabels(nki)


###################################################
### code chunk number 10: showSeries
###################################################
table(nki$series)


###################################################
### code chunk number 11: sigCheckSurvival
###################################################
check <- sigCheck(nki, classes="e.dmfs", survival="t.dmfs",
                  signature=knownSignatures$cancer$VANTVEER,
                  annotation="HUGO.gene.symbol",
                  validationSamples=which(nki$series=="NKI2")) 
check


###################################################
### code chunk number 12: survivalPval
###################################################
check@survivalPval


###################################################
### code chunk number 13: sigCheckAllSurvivalNoeval (eval = FALSE)
###################################################
## nkiResults <- sigCheckAll(check, iterations=1000) 


###################################################
### code chunk number 14: loadResults
###################################################
data(nkiResults)


###################################################
### code chunk number 15: sigCheckPlotSurvival
###################################################
sigCheckPlot(nkiResults)


###################################################
### code chunk number 16: sigCheckPlotSurvivalRes
###################################################
names(nkiResults)


###################################################
### code chunk number 17: sigCheckPlotSurvivalPvals
###################################################
nkiResults$checkRandom$checkPval
nkiResults$checkKnown$checkPval
nkiResults$checkPermutedSurvival$checkPval
nkiResults$checkPermutedFeatures$checkPval


###################################################
### code chunk number 18: sigCheckHi
###################################################
par(mfrow=c(2,2))
p5 <- sigCheck(check,
              scoreMethod="High",threshold=.5,
              plotTrainingKM=F)@survivalPval

p66 <- sigCheck(check,
              scoreMethod="High",threshold=.66,
              plotTrainingKM=F)@survivalPval

p33 <- sigCheck(check,
              scoreMethod="High",threshold=.33,
              plotTrainingKM=F)@survivalPval
p33.66 <-sigCheck(check,
              scoreMethod="High",threshold=c(.33,.66),
              plotTrainingKM=F)@survivalPval
p5
p66
p33
p33.66


###################################################
### code chunk number 19: sigCheckSurvivalClass
###################################################
check <- sigCheck(check, scoreMethod="classifier") 
check@survivalPval


###################################################
### code chunk number 20: sigCheckClassifier
###################################################
check <- sigCheck(nki, classes="e.dmfs",
                  signature=knownSignatures$cancer$VANTVEER,
                  annotation="HUGO.gene.symbol",
                  validationSamples=which(nki$series=="NKI2"),
                  scoreMethod="classifier") 
check


###################################################
### code chunk number 21: sigCheckClassifierStats
###################################################
check@sigPerformance
check@modePerformance
check@confusion


###################################################
### code chunk number 22: sigCheckClassify (eval = FALSE)
###################################################
## classifyRandom <- sigCheckRandom(check, iterations=1000)
## classifyKnown <- sigCheckKnown(check)


###################################################
### code chunk number 23: loadClassifyResults
###################################################
data(classifyResults)


###################################################
### code chunk number 24: sigClassifyPlot
###################################################
par(mfrow=c(1,2))
sigCheckPlot(classifyRandom, classifier=TRUE)
sigCheckPlot(classifyKnown,  classifier=TRUE)


###################################################
### code chunk number 25: MSigDBNoeval (eval = FALSE)
###################################################
## c6.oncogenic <- read.gmt('c6.all.v5.0.symbols.gmt')
## check.c6 <- sigCheckKnown(check, c6.oncogenic)
## sigCheckPlot(check.c6)


###################################################
### code chunk number 26: multicoreparam
###################################################
CoresToUse <- 6
library(BiocParallel)
mcp <- MulticoreParam(workers=CoresToUse)
register(mcp, default=TRUE)


###################################################
### code chunk number 27: setcores
###################################################
options(mc.cores=CoresToUse)


###################################################
### code chunk number 28: sessionInfo
###################################################
toLatex(sessionInfo())


