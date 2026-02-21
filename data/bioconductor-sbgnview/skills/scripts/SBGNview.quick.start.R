# Code example from 'SBGNview.quick.start' vignette. See references/ for full tutorial.

## ----echo = FALSE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
library(knitr)

## ----setup, eval = FALSE------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)){
#      install.packages("BiocManager")
# }
# BiocManager::install(c("xml2", "rsvg", "igraph", "httr", "KEGGREST", "pathview", "gage", "SBGNview.data", "SummarizedExperiment", "AnnotationDbi"))

## ----depend, eval = FALSE-----------------------------------------------------
# sudo apt install libxml2-dev libssl-dev libcurl4-openssl-dev librsvg2-dev

## ----install, eval = FALSE----------------------------------------------------
# BiocManager::install(c("SBGNview"))

## ----install.1, eval = FALSE--------------------------------------------------
# install.packages("devtools")
# devtools::install_github("datapplab/SBGNview")

## ----clone.git, eval = FALSE--------------------------------------------------
# git clone https://github.com/datapplab/SBGNview.git

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
library(SBGNview)
# load demo dataset, SBGN pathway data collection and info, which may take a few seconds
data("gse16873.d","pathways.info", "sbgn.xmls")
input.pathways <- findPathways("Adrenaline and noradrenaline biosynthesis")
SBGNview.obj <- SBGNview(
          gene.data = gse16873.d[,1:3], 
          gene.id.type = "entrez",
          input.sbgn = input.pathways$pathway.id,
          output.file = "quick.start", 
          output.formats =  c("png")
          ) 
print(SBGNview.obj)

## ----quickStartFig, echo = FALSE,fig.cap="\\label{fig:quickStartFig}Quick start example: Adrenaline and noradrenaline biosynthesis pathway. "----
include_graphics("quick.start_P00001.svg")

## ----echo = TRUE, eval = TRUE, results = 'hide', message = FALSE, warning = FALSE----
outputFile(SBGNview.obj) <- "quick.start.highlights"
SBGNview.obj + highlightArcs(class = "production",color = "red") + 
               highlightArcs(class = "consumption",color = "blue") +
               highlightNodes(node.set = c("tyrosine", "(+-)-epinephrine"), 
                              stroke.width = 4, stroke.color = "green") + 
               highlightPath(from.node = "tyrosine", to.node = "dopamine",
                             from.node.color = "green",
                             to.node.color = "blue",
                             shortest.paths.cols = "purple",
                             input.node.stroke.width = 6,
                             path.node.stroke.width = 5,
                             path.node.color = "purple",
                             path.stroke.width = 5,
                             tip.size = 10 )

## ----quickStartFigHighlight, echo = FALSE,fig.cap="\\label{fig:quickStartFigHighlight}Quick start example: Highlight arcs, nodes, and path."----
include_graphics("quick.start.highlights_P00001.svg")

## -----------------------------------------------------------------------------
sessionInfo()

