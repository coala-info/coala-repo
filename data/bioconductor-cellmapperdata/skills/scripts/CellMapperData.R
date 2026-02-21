# Code example from 'CellMapperData' vignette. See references/ for full tutorial.

### R code from vignette source 'CellMapperData.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: CellMapperData.Rnw:37-41
###################################################
library(ExperimentHub)
hub <- ExperimentHub()
x <- query(hub, "CellMapperData")
x


###################################################
### code chunk number 3: CellMapperData.Rnw:46-47 (eval = FALSE)
###################################################
## ?CellMapperData


###################################################
### code chunk number 4: CellMapperData.Rnw:52-54
###################################################
BrainAtlas <- x[["EH170"]]
BrainAtlas


###################################################
### code chunk number 5: CellMapperData.Rnw:66-69
###################################################
names(BrainAtlas)
dim(BrainAtlas$B)
length(BrainAtlas$d)


