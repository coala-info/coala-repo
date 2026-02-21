# Code example from 'keggorth' vignette. See references/ for full tutorial.

### R code from vignette source 'keggorth.Rnw'

###################################################
### code chunk number 1: lkkog
###################################################
library(keggorthology)
library(graph)
data(KOgraph)
KOgraph
nodes(KOgraph)[1:5]


###################################################
### code chunk number 2: lkr
###################################################
adj(KOgraph, nodes(KOgraph)[1])


###################################################
### code chunk number 3: lkpa
###################################################
library(RBGL)
sp.between(KOgraph, nodes(KOgraph)[1], "PPAR signaling pathway")


###################################################
### code chunk number 4: lkta
###################################################
nodeData(KOgraph,,"tag")[1:5]


###################################################
### code chunk number 5: lkde
###################################################
nodeData(KOgraph,,"depth")[1:5]


###################################################
### code chunk number 6: lkd
###################################################
getKOtags("insulin")


###################################################
### code chunk number 7: lkp
###################################################
library(hgu95av2.db)
mp = getKOprobes("Methionine")
library(ALL)
data(ALL)
ALL[mp,]


###################################################
### code chunk number 8: lksi
###################################################
sessionInfo()


