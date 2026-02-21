# Code example from 'goTools' vignette. See references/ for full tutorial.

### R code from vignette source 'goTools.Rnw'

###################################################
### code chunk number 1: goTools.Rnw:81-83
###################################################
library("goTools", verbose=FALSE)
data(probeID)  


###################################################
### code chunk number 2: goTools.Rnw:90-93
###################################################
class(affylist)
length(affylist)
affylist[[1]][1:5]


###################################################
### code chunk number 3: goTools.Rnw:140-143 (eval = FALSE)
###################################################
## library(GO.db)
## subset=c(L1=list(affylist[[1]][1:5]),L2=list(affylist[[2]][1:5]))
## res <-ontoCompare(subset, probeType="hgu133a")


###################################################
### code chunk number 4: ontoPlotEg1 (eval = FALSE)
###################################################
## library(GO.db)
## subset=c(L1=list(affylist[[1]][1:5]),L2=list(affylist[[2]][1:5]))
## res <- ontoCompare(subset, probeType="hgu133a", plot=TRUE)


###################################################
### code chunk number 5: goTools.Rnw:194-195
###################################################
EndNodeList()


###################################################
### code chunk number 6: goTools.Rnw:207-208 (eval = FALSE)
###################################################
## MFendnode <- CustomEndNodeList("GO:0003674", rank=2)


###################################################
### code chunk number 7: goTools.Rnw:216-217 (eval = FALSE)
###################################################
## res <- ontoCompare(subset, probeType="hgu133a", endnode=MFendnode, goType="MF")


