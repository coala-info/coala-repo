# Code example from 'HumanAffyData' vignette. See references/ for full tutorial.

### R code from vignette source 'HumanAffyData.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: HumanAffyData.Rnw:42-46
###################################################
library(ExperimentHub)
hub <- ExperimentHub()
x <- query(hub, "HumanAffyData")
x


###################################################
### code chunk number 3: HumanAffyData.Rnw:51-52
###################################################
E.MTAB.62 <- x[["EH177"]]


###################################################
### code chunk number 4: HumanAffyData.Rnw:57-58
###################################################
E.MTAB.62


###################################################
### code chunk number 5: HumanAffyData.Rnw:63-66
###################################################
data <- exprs(E.MTAB.62)
dim(data)
data[1:5,1:5]


###################################################
### code chunk number 6: HumanAffyData.Rnw:73-75
###################################################
pDat <- pData(E.MTAB.62)
print(summary(pDat))


###################################################
### code chunk number 7: HumanAffyData.Rnw:80-83
###################################################
Groups_96 <- as.character(pDat$Groups_369)
Groups_96[Groups_96 %in% names(which(table(pDat$Groups_96) < 10))] <- ''
pDat$Groups_96 <- as.factor(Groups_96)


###################################################
### code chunk number 8: HumanAffyData.Rnw:92-93
###################################################
citation("HumanAffyData")


