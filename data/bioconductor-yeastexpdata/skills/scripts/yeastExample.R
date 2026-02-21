# Code example from 'yeastExample' vignette. See references/ for full tutorial.

### R code from vignette source 'yeastExample.Rnw'

###################################################
### code chunk number 1: Setup
###################################################
library("yeastExpData")
library("RBGL")
require("Rgraphviz", quietly=TRUE)
data(ccyclered)


###################################################
### code chunk number 2: makeClusterGraph
###################################################

clusts =  split(ccyclered[["Y.name"]],
                         ccyclered[["Cluster"]])

cg1 = new("clusterGraph",
        clusters = lapply(clusts, as.character))

ccClust = connComp(cg1)



###################################################
### code chunk number 3: litGraph
###################################################

 data(litG)

 ccLit = connectedComp(litG)

 cclens = sapply(ccLit, length)

 table(cclens)

 ccL2 = ccLit[cclens>1]
 ccl2 = cclens[cclens>1]



###################################################
### code chunk number 4: createSubG
###################################################

 sG1 = subGraph(ccL2[[5]], litG)

 sG2 = subGraph(ccL2[[1]], litG)



###################################################
### code chunk number 5: subGraphs
###################################################
  if (require("Rgraphviz"))
     plot(sG1, "neato")


###################################################
### code chunk number 6: sG2
###################################################
  if (require("Rgraphviz"))
    plot(sG2, "neato")


###################################################
### code chunk number 7: intersect
###################################################

 commonG = intersection(litG, cg1)

 commonG




###################################################
### code chunk number 8: edgePerm
###################################################

ePerm = function (g1, g2, B=500) {
 ans = rep(NA, B)
 n1 = nodes(g1)

 for(i in 1:B) {
    nodes(g1) = sample(n1)
    ans[i] = numEdges(intersection(g1, g2))
 }
 return(ans)
}

set.seed(123)

##takes a long time
#nPdist = ePerm(litG, cg1)
data(nPdist)
max(nPdist)


