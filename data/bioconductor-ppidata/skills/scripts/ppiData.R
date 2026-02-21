# Code example from 'ppiData' vignette. See references/ for full tutorial.

### R code from vignette source 'ppiData.Rnw'

###################################################
### code chunk number 1: loadlib
###################################################

library(ppiData)
library(ppiStats)
library(org.Sc.sgd.db)



###################################################
### code chunk number 2: collectData
###################################################

dataList <- collectIntactPPIData(c("EBI-531419", "EBI-698096","EBI-762635"))
names(dataList)
dataList[["shortLabel"]]

##NB - intactPPIData = collectIntactPPIData() using the default parameters



###################################################
### code chunk number 3: exBaitsSys
###################################################
dataList[["baitsSystematic"]][1:5]


###################################################
### code chunk number 4: indexSet
###################################################
dataList[["indexSetAll"]][1]


###################################################
### code chunk number 5: createBPList
###################################################

bpList <- createBPList(dataList[["indexSetAll"]], dataList[["baitsSystematic"]], 
                        dataList[["preysSystematic"]])
names(bpList)
bpList[1]

## NB: y2h = createBPList(intactPPIData[["indexSetAll"]], intactPPIData[["baitsSystematic"]], intactPPIData[["preysSystematic"]]) 

## NB: y2hSysGW = Fixme


###################################################
### code chunk number 6: createMats
###################################################
bpMats <- lapply(bpList, function(x){
		bpMatrix(x, symMat = FALSE, homodimer = FALSE, baitAsPrey = FALSE,
    		unWeighted = TRUE, onlyRecip = FALSE, baitsOnly = FALSE)})

bpMats[1]	


###################################################
### code chunk number 7: ppiData.Rnw:207-219
###################################################
bpMats1 <- lapply(bpList, function(x){
		bpMatrix(x, symMat = TRUE, homodimer = FALSE, baitAsPrey = FALSE,
    		unWeighted = TRUE, onlyRecip = FALSE, baitsOnly = FALSE)})
bpMats1[1]

bpGraphs <- lapply(bpMats1, function(x){genBPGraph(x, directed=TRUE, bp=FALSE)})
bpGraphs[1]

##NB: Each graph data file is generated similarly using the same function
##as above. To see how we generated each of the graph objects, look 
##in inst/Script/genGraphs.R directory at the script used to generate the 
##graphNELs


