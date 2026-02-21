# Code example from 'NCIgraph' vignette. See references/ for full tutorial.

### R code from vignette source 'NCIgraph.Rnw'

###################################################
### code chunk number 1: lib
###################################################
library(NCIgraph)


###################################################
### code chunk number 2: data
###################################################
data("NCIgraphVignette", package="NCIgraph")


###################################################
### code chunk number 3: data
###################################################
grList <- getNCIPathways(cyList=NCI.demo.cyList, parseNetworks=TRUE, entrezOnly=TRUE, verbose=TRUE)$pList


###################################################
### code chunk number 4: lib2
###################################################
library('Rgraphviz')


###################################################
### code chunk number 5: plotRaw
###################################################
graph <- NCI.demo.cyList[[1]]
gNames <- unlist(lapply(graph@nodeData@data,FUN=function(e) e$biopax.name))
names(gNames) <- nodes(graph)
graph <- layoutGraph(graph)
nodeRenderInfo(graph) <- list(label=gNames, cex=0.75)
renderGraph(graph)  


###################################################
### code chunk number 6: plotParsed
###################################################
graph <- grList[[1]]
gNames <- unlist(lapply(graph@nodeData@data,FUN=function(e) unique(e$biopax.xref.ENTREZGENE)))
names(gNames) <- nodes(graph)
graph <- layoutGraph(graph)
nodeRenderInfo(graph) <- list(label=gNames, cex=0.75)
renderGraph(graph)  


###################################################
### code chunk number 7: rawGraph
###################################################
graph <- NCI.demo.cyList[[1]]
gNames <- unlist(lapply(graph@nodeData@data,FUN=function(e) e$biopax.name))
names(gNames) <- nodes(graph)
graph <- layoutGraph(graph)
nodeRenderInfo(graph) <- list(label=gNames, cex=0.75)
renderGraph(graph)  


###################################################
### code chunk number 8: parsedGraph
###################################################
graph <- grList[[1]]
gNames <- unlist(lapply(graph@nodeData@data,FUN=function(e) unique(e$biopax.xref.ENTREZGENE)))
names(gNames) <- nodes(graph)
graph <- layoutGraph(graph)
nodeRenderInfo(graph) <- list(label=gNames, cex=0.75)
renderGraph(graph)  


