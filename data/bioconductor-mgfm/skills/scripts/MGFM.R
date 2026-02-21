# Code example from 'MGFM' vignette. See references/ for full tutorial.

### R code from vignette source 'MGFM.Rnw'

###################################################
### code chunk number 1: MGFM.Rnw:52-54
###################################################
library("MGFM")
ls("package:MGFM")


###################################################
### code chunk number 2: MGFM.Rnw:84-85
###################################################
options(width=60)


###################################################
### code chunk number 3: MGFM.Rnw:87-90
###################################################
data("ds2.mat")
dim(ds2.mat)
colnames(ds2.mat)


###################################################
### code chunk number 4: MGFM.Rnw:123-124
###################################################
  library(MGFM)


###################################################
### code chunk number 5: DS1
###################################################
data("ds2.mat")
require(hgu133a.db)
marker.list2 <- getMarkerGenes(ds2.mat, samples2compare="all", annotate=TRUE,  chip="hgu133a",score.cutoff=1)
names(marker.list2)
# show the first 20 markers of liver
marker.list2[["liver_markers"]][1:20]


###################################################
### code chunk number 6: DS2
###################################################
data("ds2.mat")
# If no annotation (mapping of probe sets to genes) is desired, no chip name is needed.
marker.list2 <- getMarkerGenes(ds2.mat, samples2compare="all", annotate=FALSE, score.cutoff=1)
names(marker.list2)
# show the first 20 markers of lung
marker.list2[["lung_markers"]][1:20]


###################################################
### code chunk number 7: sessionInfo
###################################################
sessionInfo()


