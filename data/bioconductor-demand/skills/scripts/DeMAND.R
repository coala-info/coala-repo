# Code example from 'DeMAND' vignette. See references/ for full tutorial.

### R code from vignette source 'DeMAND.Rnw'

###################################################
### code chunk number 1: DeMAND.Rnw:24-27 (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("DeMAND")


###################################################
### code chunk number 2: DeMAND.Rnw:34-35
###################################################
library(DeMAND)


###################################################
### code chunk number 3: DeMAND.Rnw:50-52
###################################################
data(inputExample)
#ls()


###################################################
### code chunk number 4: DeMAND.Rnw:57-59
###################################################
dobj <- demandClass(exp=bcellExp, anno=bcellAnno, network=bcellNetwork)
printDeMAND(dobj)


###################################################
### code chunk number 5: DeMAND.Rnw:66-68
###################################################
dobj <- runDeMAND(dobj, fgIndex=caseIndex, bgIndex=controlIndex)
printDeMAND(dobj)


###################################################
### code chunk number 6: DeMAND.Rnw:100-101
###################################################
sessionInfo()


