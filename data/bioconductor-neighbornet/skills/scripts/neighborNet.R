# Code example from 'neighborNet' vignette. See references/ for full tutorial.

### R code from vignette source 'neighborNet.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: neighborNet.Rnw:44-45
###################################################
load(system.file("extdata/listofgenes.RData", package = "NeighborNet"))


###################################################
### code chunk number 2: neighborNet.Rnw:49-50
###################################################
head(listofgenes)


###################################################
### code chunk number 3: neighborNet.Rnw:62-68
###################################################
load(system.file("extdata/dataColorectal4183.RData", package = "NeighborNet"))
load(system.file("extdata/dataColorectal9348.RData", package = "NeighborNet"))
load(system.file("extdata/dataColorectal21510.RData", package = "NeighborNet"))
load(system.file("extdata/dataColorectal32323.RData", package = "NeighborNet"))
load(system.file("extdata/dataColorectal8671.RData", package = "NeighborNet"))
head(dataColorectal4183)


###################################################
### code chunk number 4: neighborNet.Rnw:74-97
###################################################
pvThreshold <- 0.01
foldThreshold <- 1.5
de1 <- dataColorectal4183$EntrezID [
  dataColorectal4183$adj.P.Val < pvThreshold &
  abs(dataColorectal4183$logFC) > foldThreshold
]
de2 <- dataColorectal9348$EntrezID [
  dataColorectal9348$adj.P.Val < pvThreshold &
  abs(dataColorectal9348$logFC) > foldThreshold
]
de3 <- dataColorectal21510$EntrezID [
  dataColorectal21510$adj.P.Val < pvThreshold &
  abs(dataColorectal21510$logFC) > foldThreshold
]
de4 <- dataColorectal32323$EntrezID [
  dataColorectal32323$adj.P.Val < pvThreshold &
  abs(dataColorectal32323$logFC) > foldThreshold
]
de5 <- dataColorectal8671$EntrezID [
  dataColorectal8671$adj.P.Val < pvThreshold &
  abs(dataColorectal8671$logFC) > foldThreshold
]



###################################################
### code chunk number 5: neighborNet.Rnw:101-102
###################################################
de <- unique( c(de1,de2,de3,de4,de5))


###################################################
### code chunk number 6: neighborNet.Rnw:106-114
###################################################
ref <- unique( c(
  dataColorectal4183$EntrezID,
  dataColorectal9348$EntrezID,
  dataColorectal21510$EntrezID,
  dataColorectal32323$EntrezID,
  dataColorectal8671$EntrezID
))
head(ref)


###################################################
### code chunk number 7: neighborNet.Rnw:127-131
###################################################
library("NeighborNet")
library("graph")
sig_genes <- neighborNet(de = de, ref = ref, listofgenes=listofgenes)
sig_genes


###################################################
### code chunk number 8: peRes_twoway1
###################################################
require("graph")
attrs <- list(node= list(fontsize=40,fixedsize= FALSE),graph=list(overlap=FALSE), edge=list(lwd=0.6))
nAttr <- list()
nAttr$color <- c(rep("white",length(nodes(sig_genes))))
names(nAttr$color) <- nodes(sig_genes)
plot(sig_genes)


