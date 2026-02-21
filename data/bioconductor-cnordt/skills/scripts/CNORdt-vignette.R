# Code example from 'CNORdt-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'CNORdt-vignette.Rnw'

###################################################
### code chunk number 1: installPackage (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("CNORdt")


###################################################
### code chunk number 2: Ropts
###################################################
options(width=70)


###################################################
### code chunk number 3: loadLib
###################################################
library(CellNOptR)
library(CNORdt)


###################################################
### code chunk number 4: getData
###################################################
data(CNOlistPB, package="CNORdt")
data(modelPB, package="CNORdt")


###################################################
### code chunk number 5: preProcess
###################################################
# pre-process model
model = preprocessing(CNOlistPB, modelPB)
initBstring <- rep(1, length(model$reacID))


###################################################
### code chunk number 6: optimise
###################################################
opt1 <- gaBinaryDT(CNOlist=CNOlistPB, model=model, initBstring=initBstring,
verbose=FALSE, boolUpdates=10, maxTime=30, lowerB=0.8, upperB=10)


###################################################
### code chunk number 7: plotData
###################################################
cutAndPlotResultsDT(
	model=model,
	CNOlist=CNOlistPB,
	bString=opt1$bString,
	plotPDF=FALSE,
	boolUpdates=10,
	lowerB=0.8,
	upperB=10
)


###################################################
### code chunk number 8: writeRes
###################################################
writeScaffold(
	modelComprExpanded=model,
	optimResT1=opt1,
	optimResT2=NA,
	modelOriginal=modelPB,
	CNOlist=CNOlistPB
)
	
writeNetwork(
	modelOriginal=modelPB,
	modelComprExpanded=model,
	optimResT1=opt1,
	CNOlist=CNOlistPB
)


