# Code example from 'pkgDepTools' vignette. See references/ for full tutorial.

### R code from vignette source 'pkgDepTools.Rnw'

###################################################
### code chunk number 1: setup0
###################################################
options(width=72)


###################################################
### code chunk number 2: setup
###################################################
library("pkgDepTools")
library("Biobase")
library("Rgraphviz")


###################################################
### code chunk number 3: testMakeDepGraph0
###################################################
library(BiocInstaller)
biocUrl <- biocinstallRepos()["BioCsoft"]
biocDeps <- makeDepGraph(biocUrl, type="source", dosize=FALSE)


###################################################
### code chunk number 4: testMakeDepGraph
###################################################
biocDeps
edges(biocDeps)["annotate"]
## if dosize=TRUE, size in MB is stored
## as a node attribute:
## nodeData(biocDeps, n="annotate", attr="size")


###################################################
### code chunk number 5: CategoryPlot
###################################################
categoryNodes <- c("Category", 
                   names(acc(biocDeps, "Category")[[1]]))
categoryGraph <- subGraph(categoryNodes, biocDeps)
nn <- makeNodeAttrs(categoryGraph, shape="ellipse")
plot(categoryGraph, nodeAttrs=nn)


###################################################
### code chunk number 6: demo-setup
###################################################
allDeps <- makeDepGraph(biocinstallRepos(), type="source",
                        keep.builtin=TRUE, dosize=FALSE)



###################################################
### code chunk number 7: demo1
###################################################
getInstallOrder("GOstats", allDeps)


###################################################
### code chunk number 8: demo2
###################################################
getInstallOrder("GOstats", allDeps, needed.only=FALSE)


###################################################
### code chunk number 9: whoDependsOnMe
###################################################
allDepsOnMe <- reverseEdgeDirections(allDeps)
usesMethods <- dijkstra.sp(allDepsOnMe, start="methods")$distance
usesMethods <- usesMethods[is.finite(usesMethods)]
length(usesMethods) - 1 ## don't count methods itself
table(usesMethods)



###################################################
### code chunk number 10: sessionInfo
###################################################
toLatex(sessionInfo())


