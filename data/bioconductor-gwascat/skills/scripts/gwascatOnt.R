# Code example from 'gwascatOnt' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
suppressPackageStartupMessages({
library(gwascat)
})

## ----getg---------------------------------------------------------------------
library(gwascat)
requireNamespace("graph")
data(efo.obo.g)
efo.obo.g
sn = head(graph::nodes(efo.obo.g))
sn

## ----procdef------------------------------------------------------------------
nd = graph::nodeData(efo.obo.g)
alldef = sapply(nd, function(x) unlist(x[["def"]]))
allnames = sapply(nd, function(x) unlist(x[["name"]]))
alld2 = sapply(alldef, function(x) if(is.null(x)) return(" ") else x[1])
mydf = data.frame(id = names(allnames), concept=as.character(allnames), def=unlist(alld2))

## ----limtab-------------------------------------------------------------------
limdf = mydf[ grep("autoimm", mydf$def, ignore.case=TRUE), ]
requireNamespace("DT")
suppressWarnings({
DT::datatable(limdf, rownames=FALSE, options=list(pageLength=5))
})

## ----lkg----------------------------------------------------------------------
graph::nodeData(efo.obo.g, "EFO:0000540")
ue = graph::ugraph(efo.obo.g)
neighISD = graph::adj(ue, "EFO:0000540")[[1]]
sapply(graph::nodeData(graph::subGraph(neighISD, efo.obo.g)), "[[", "name")

## ----lkggg--------------------------------------------------------------------
requireNamespace("RBGL")
p = RBGL::sp.between( efo.obo.g, "EFO:0000685", "EFO:0000001")
sapply(graph::nodeData(graph::subGraph(p[[1]]$path_detail, efo.obo.g)), "[[", "name")

## ----lkef---------------------------------------------------------------------
data(ebicat_2020_04_30)
names(S4Vectors::mcols(ebicat_2020_04_30))
adinds = grep("autoimmu", ebicat_2020_04_30$MAPPED_TRAIT)
adgr = ebicat_2020_04_30[adinds]
adgr
S4Vectors::mcols(adgr)[, c("MAPPED_TRAIT", "MAPPED_TRAIT_URI")]

