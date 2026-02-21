# Code example from 'FANTOM3and4CAGE' vignette. See references/ for full tutorial.

### R code from vignette source 'FANTOM3and4CAGE.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width = 60)
olocale=Sys.setlocale(locale="C")


###################################################
### code chunk number 2: FANTOM3and4CAGE.Rnw:68-69
###################################################
library(FANTOM3and4CAGE)


###################################################
### code chunk number 3: FANTOM3and4CAGE.Rnw:78-80
###################################################
data(FANTOMhumanSamples)
head(FANTOMhumanSamples, 10)


###################################################
### code chunk number 4: FANTOM3and4CAGE.Rnw:94-96
###################################################
data(FANTOMtissueCAGEhuman)
names(FANTOMtissueCAGEhuman)


###################################################
### code chunk number 5: FANTOM3and4CAGE.Rnw:102-104
###################################################
lung_group <- FANTOMtissueCAGEhuman[["lung"]]
head(lung_group)


###################################################
### code chunk number 6: FANTOM3and4CAGE.Rnw:110-113
###################################################
data(FANTOMtimecourseCAGEmouse)
names(FANTOMtimecourseCAGEmouse)
head(FANTOMtimecourseCAGEmouse[["adipogenic_induction"]])


###################################################
### code chunk number 7: FANTOM3and4CAGE.Rnw:121-122
###################################################
sessionInfo()


