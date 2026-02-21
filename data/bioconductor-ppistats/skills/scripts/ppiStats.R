# Code example from 'ppiStats' vignette. See references/ for full tutorial.

### R code from vignette source 'ppiStats.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################
library("ppiStats")
library("ppiData")


###################################################
### code chunk number 2: getGavinData
###################################################
data(Gavin2002BPGraph)
data(Gavin2006BPGraph)
GavinGraphs = list(Gavin02=Gavin2002BPGraph,Gavin06=Gavin2006BPGraph)
GavinGraphs


###################################################
### code chunk number 3: summaryTables
###################################################
summaryTables = createSummaryTables(GavinGraphs)
summaryTables


###################################################
### code chunk number 4: viabilityCharts
###################################################
viabilityCharts(GavinGraphs)


###################################################
### code chunk number 5: findVBVPVBPsets
###################################################
GavinViableProteins = lapply(GavinGraphs,FUN=idViableProteins)
sapply(GavinViableProteins,FUN=function(x) lapply(x,FUN=length))

Gavin06VBPproteins =  GavinViableProteins[["Gavin06"]]$VBP
Gavin06VBPproteins[1:4]


###################################################
### code chunk number 6: inOutScatterCharts
###################################################
inOutScatterCharts(GavinGraphs)


###################################################
### code chunk number 7: sepSystematicStochastic
###################################################

systematicVBPsGavin06 = idSystematic(Gavin2006BPGraph,Gavin06VBPproteins,bpGraph=TRUE)

unbiasedGavin06VBPs = setdiff(Gavin06VBPproteins,systematicVBPsGavin06)

Gavin06VBPsubgraph = subGraph(unbiasedGavin06VBPs,Gavin2006BPGraph)
Gavin06VBPsubgraph


###################################################
### code chunk number 8: estimateStochasticErrorProbabilities
###################################################
data(ScISIC)

Gavin06m = as(Gavin06VBPsubgraph,"matrix")
errorProbabilities = estimateCCMErrorRates(Gavin06m,ScISIC)

pTPestimate = errorProbabilities$globalpTP
pFPestimate =errorProbabilities$globalpFP
solutionManifold = errorProbabilities$probPairs

pTPestimate
pFPestimate


###################################################
### code chunk number 9: plotErrorEstimates
###################################################
plot(solutionManifold[,"pFPs"],solutionManifold[,"pFNs"],type="l",col="violet",xlab="pFP",ylab="1-pTP")
points(pFPestimate,1-pTPestimate,cex=3,pch=8,col="turquoise")


###################################################
### code chunk number 10: inoutStats
###################################################
Gavin06VBPobserved = calcInOutDegStats(Gavin06VBPsubgraph)
Gavin06VBPobserved$unrecipInDegree[5:10]
Gavin06VBPobserved$unrecipOutDegree[5:10]
Gavin06VBPobserved$recipIn[5:10]


###################################################
### code chunk number 11: estimateDegree
###################################################
Gavin06VBPdegree = degreeEstimates(Gavin06m,pTPestimate,pFPestimate)
Gavin06VBPdegree[5:10]



###################################################
### code chunk number 12: sessionInfo
###################################################
sessionInfo()


