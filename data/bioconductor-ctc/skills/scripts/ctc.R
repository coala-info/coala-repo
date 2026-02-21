# Code example from 'ctc' vignette. See references/ for full tutorial.

### R code from vignette source 'ctc.Rnw'

###################################################
### code chunk number 1: ctc.Rnw:45-48
###################################################
data(USArrests)
h = hclust(dist(USArrests))
plot(h)


###################################################
### code chunk number 2: ctc.Rnw:51-52
###################################################
heatmap(as.matrix(USArrests))


###################################################
### code chunk number 3: ctc.Rnw:61-63
###################################################
library(ctc)
r2xcluster(USArrests,file='USArrests_xcluster.txt')


###################################################
### code chunk number 4: ctc.Rnw:66-67
###################################################
r2cluster(USArrests,file='USArrests_xcluster.txt')


###################################################
### code chunk number 5: ctc.Rnw:92-94
###################################################
hr = hclust(dist(USArrests))
hc = hclust(dist(t(USArrests)))


###################################################
### code chunk number 6: ctc.Rnw:101-102
###################################################
write(hc2Newick(hr),file='hclust.newick')


###################################################
### code chunk number 7: ctc.Rnw:106-109
###################################################
r2atr(hc,file="cluster.atr")
r2gtr(hr,file="cluster.gtr")
r2cdt(hr,hc,USArrests ,file="cluster.cdt")


###################################################
### code chunk number 8: ctc.Rnw:113-114
###################################################
hclust2treeview(USArrests,file="cluster.cdt")


