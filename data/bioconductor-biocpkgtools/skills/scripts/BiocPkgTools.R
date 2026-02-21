# Code example from 'BiocPkgTools' vignette. See references/ for full tutorial.

## ----init, include=FALSE------------------------------------------------------
library(knitr)
opts_chunk$set(warning = FALSE, message = FALSE, cache=FALSE)

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## -----------------------------------------------------------------------------
library(BiocPkgTools)
head(biocBuildReport())

## ----eval=FALSE---------------------------------------------------------------
# problemPage(authorPattern = "V.*Carey")

## ----eval=FALSE---------------------------------------------------------------
# problemPage(dependsOn = "limma")

## -----------------------------------------------------------------------------
head(biocDownloadStats())

## -----------------------------------------------------------------------------
head(anacondaDownloadStats())

## -----------------------------------------------------------------------------
bpi = biocPkgList()
colnames(bpi)

## -----------------------------------------------------------------------------
head(bpi)

## -----------------------------------------------------------------------------
require(dplyr)
bpi = biocPkgList()
bpi |> 
    filter(Package=="GEOquery") |>
    pull(importsMe) |>
    unlist()

## ----biocExplore--------------------------------------------------------------
biocExplore()

## -----------------------------------------------------------------------------
dep_df = buildPkgDependencyDataFrame()
g = buildPkgDependencyIgraph(dep_df)
g
library(igraph)
head(V(g))
head(E(g))

## -----------------------------------------------------------------------------
igraph_network = buildPkgDependencyIgraph(buildPkgDependencyDataFrame())

## -----------------------------------------------------------------------------
igraph_geoquery_network = subgraphByDegree(igraph_network, "GEOquery")

## -----------------------------------------------------------------------------
library(visNetwork)
data <- toVisNetworkData(igraph_geoquery_network)

## -----------------------------------------------------------------------------
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px")

## -----------------------------------------------------------------------------
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
    visPhysics(stabilization=FALSE)

## -----------------------------------------------------------------------------
data$edges$color='lightblue'
data$edges[data$edges$edgetype=='Imports','color']= 'red'
data$edges[data$edges$edgetype=='Depends','color']= 'green'

visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
    visEdges(arrows='from') 

## -----------------------------------------------------------------------------
ledges <- data.frame(color = c("green", "lightblue", "red"),
  label = c("Depends", "Suggests", "Imports"), arrows =c("from", "from", "from"))
visNetwork(nodes = data$nodes, edges = data$edges, height = "500px") |>
  visEdges(arrows='from') |>
  visLegend(addEdges=ledges)

## ----biocViews----------------------------------------------------------------
library(biocViews)
data(biocViewsVocab)
biocViewsVocab
library(igraph)
g = graph_from_graphnel(biocViewsVocab)
library(visNetwork)
gv <- toVisNetworkData(g)
visNetwork(gv$nodes, gv$edges, width="100%") |>
    visIgraphLayout(layout = "layout_as_tree", circular=TRUE) |>
    visNodes(size=20) |>
    visPhysics(stabilization=FALSE)

## -----------------------------------------------------------------------------

depdf <- buildPkgDependencyDataFrame(repo=c("BioCsoft", "CRAN"),
                                     dependencies=c("Depends", "Imports"))
dim(depdf)
head(depdf)  # too big to show all

## -----------------------------------------------------------------------------
pkgDepMetrics("BiocPkgTools", depdf)

## -----------------------------------------------------------------------------
imp <- pkgDepImports("BiocPkgTools")
imp |> filter(pkg == "DT")

## ----demoorc------------------------------------------------------------------
inst = rownames(installed.packages())
cands = c("devtools", "evaluate", "ggplot2", "GEOquery", "gert", "utils")
totry = intersect(cands, inst)
oids = get_cre_orcids(totry)
oids

## ----lktab,eval=FALSE---------------------------------------------------------
# orcid_table(oids)

## -----------------------------------------------------------------------------
sessionInfo()

