# Code example from 'plotExG' vignette. See references/ for full tutorial.

### R code from vignette source 'plotExG.Rnw'

###################################################
### code chunk number 1: lkmapk
###################################################
library(graph)
library(pathRender)
library(Rgraphviz)
data(pancrCaIni)
plot(pancrCaIni, nodeAttrs=pwayRendAttrs(pancrCaIni))


###################################################
### code chunk number 2: doall
###################################################
library(ALL)
if (!exists("ALL")) data(ALL)


###################################################
### code chunk number 3: doredu
###################################################
if ("package:hgu95av2" %in% search()) detach("package:hgu95av2")
library(hgu95av2.db)
red1 = reduceES( ALL, nodes(pancrCaIni), revmap(hgu95av2SYMBOL), "symbol" )
red1
pData(featureData(red1))


###################################################
### code chunk number 4: dored2
###################################################
collap1 = reduceES( ALL, nodes(pancrCaIni), revmap(hgu95av2SYMBOL), "symbol", mean )
collap1


###################################################
### code chunk number 5: dothp
###################################################
library(RColorBrewer)
plotExGraph(pancrCaIni, collap1, 1)


