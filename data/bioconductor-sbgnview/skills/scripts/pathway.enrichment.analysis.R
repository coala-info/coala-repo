# Code example from 'pathway.enrichment.analysis' vignette. See references/ for full tutorial.

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
library(SBGNview)
library(SummarizedExperiment)
data("IFNg", "pathways.info")
count.data <- assays(IFNg)$counts
head(count.data)
wt.cols <- which(IFNg$group == "wt")
ko.cols <- which(IFNg$group == "ko")


## ----echo = TRUE , results = 'hide',   message = FALSE, warning = FALSE-------
ensembl.pathway <- sbgn.gsets(id.type = "ENSEMBL",
                              species = "mmu",
                              mol.type = "gene",
                              output.pathway.name = TRUE
                              )
head(ensembl.pathway[[2]])

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
if(!requireNamespace("gage", quietly = TRUE)) {
  BiocManager::install("gage", update = FALSE)
}

library(gage)
degs <- gage(exprs = count.data,
           gsets = ensembl.pathway,
           ref = wt.cols,
           samp = ko.cols,
           compare = "paired" #"as.group"
           )
head(degs$greater)[,3:5]
head(degs$less)[,3:5]
down.pathways <- row.names(degs$less)[1:10]
head(down.pathways)

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
ensembl.koVsWt <- count.data[,ko.cols]-count.data[,wt.cols]
head(ensembl.koVsWt)

#alternatively, we can also calculate mean fold changes per gene, which corresponds to gage analysis above with compare="as.group"
mean.wt <- apply(count.data[,wt.cols] ,1 ,"mean")
head(mean.wt)
mean.ko <- apply(count.data[,ko.cols],1,"mean")
head(mean.ko)
# The abundance values were on log scale. Hence fold change is their difference.
ensembl.koVsWt.m <- mean.ko - mean.wt

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
#load the SBGNview pathway collection, which may takes a few seconds.
data(sbgn.xmls)
down.pathways <- sapply(strsplit(down.pathways,"::"), "[", 1)
head(down.pathways)
sbgnview.obj <- SBGNview(
    gene.data = ensembl.koVsWt,
    gene.id.type = "ENSEMBL",
    input.sbgn = down.pathways[1:2],#can be more than 2 pathways
    output.file = "ifn.sbgnview.less",
    show.pathway.name = TRUE,
    max.gene.value = 2,
    min.gene.value = -2,
    mid.gene.value = 0,
    node.sum = "mean",
    output.format = c("png"),
    
    font.size = 2.3,
    org = "mmu",
    
    text.length.factor.complex = 3,
    if.scale.compartment.font.size = TRUE,
    node.width.adjust.factor.compartment = 0.04 
)
sbgnview.obj


## ----ifng, echo = FALSE,fig.cap="\\label{fig:ifng}SBGNview graph of the most down-regulated pathways in IFNg KO experiment"----
library(knitr)
include_graphics("ifn.sbgnview.less_R-HSA-877300_Interferon gamma signaling.svg")

## ----ifna, echo = FALSE,fig.cap="\\label{fig:ifna}SBGNview graph of the second most down-regulated pathways in IFNg KO experiment"----
library(knitr)
include_graphics("ifn.sbgnview.less_R-HSA-909733_Interferon alpha_beta signaling.svg")

## ----echo = TRUE, results = 'hide', message = FALSE, warning = FALSE----------
data("cancer.ds")
sbgnview.obj <- SBGNview(
    gene.data = cancer.ds,
    gene.id.type = "ENTREZID",
    input.sbgn = "R-HSA-877300",
    output.file = "demo.SummarizedExperiment",
    show.pathway.name = TRUE,
    max.gene.value = 1,
    min.gene.value = -1,
    mid.gene.value = 0,
    node.sum = "mean",
    output.format = c("png"),
    
    font.size = 2.3,
    org = "hsa",
    
    text.length.factor.complex = 3,
    if.scale.compartment.font.size = TRUE,
    node.width.adjust.factor.compartment = 0.04
   )
sbgnview.obj


## ----cancerds, echo = FALSE,fig.cap="\\label{fig:cancerds}SBGNview of a cancer dataset gse16873"----
include_graphics("demo.SummarizedExperiment_R-HSA-877300_Interferon gamma signaling.svg")

## -----------------------------------------------------------------------------
sessionInfo()

