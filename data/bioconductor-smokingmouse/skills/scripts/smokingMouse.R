# Code example from 'smokingMouse' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    AnnotationHubData = citation("AnnotationHubData")[1],
    BiocStyle = citation("BiocStyle")[1],
    ExperimentHub = citation("ExperimentHub")[1],
    ExperimentHubData = citation("ExperimentHubData")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
	smokingMouse = citation("smokingMouse")[2],
    testthat = citation("testthat")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("smokingMouse")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("smokingMouse")

## ----"start", message=FALSE---------------------------------------------------
library("smokingMouse")

## ----'experiment_hub'---------------------------------------------------------
## Load ExperimentHub for downloading the data
library("ExperimentHub")

## Connect to ExperimentHub
ehub <- ExperimentHub::ExperimentHub()

## Load the datasets of the package
myfiles <- query(ehub, "smokingMouse")

## Resulting smokingMouse files from our ExperimentHub query
myfiles

## ----'download_data'----------------------------------------------------------
## Load SummarizedExperiment which defines the class container for the data
library("SummarizedExperiment")

######################
#     Mouse data 
######################
myfiles["EH8313"]

## Download the mouse gene data
#  EH8313 | rse_gene_mouse_RNAseq_nic-smo
rse_gene <- myfiles[["EH8313"]]

## This is a RangedSummarizedExperiment object
rse_gene

## Optionally check the memory size
# lobstr::obj_size(rse_gene)
# 159.68 MB

## Check sample info 
head(colData(rse_gene), 3)

## Check gene info
head(rowData(rse_gene), 3)

## Access the original counts
class(assays(rse_gene)$counts)
dim(assays(rse_gene)$counts)
assays(rse_gene)$counts[1:3, 1:3]

## Access the log-normalized counts
class(assays(rse_gene)$logcounts)
assays(rse_gene)$logcounts[1:3, 1:3]


######################
#     Human data 
######################
myfiles["EH8318"]

## Download the human gene data
# EH8318 | de_genes_adult_human_brain_smoking
de_genes_prenatal_human_brain_smoking <- myfiles[["EH8318"]]

## This is a GRanges object
class(de_genes_prenatal_human_brain_smoking)
de_genes_prenatal_human_brain_smoking

## Optionally check the memory size
# lobstr::obj_size(de_genes_prenatal_human_brain_smoking)
# 3.73 MB

## Access data of human genes as normally do with other GenomicRanges::GRanges()
## objects or re-cast it as a data.frame
de_genes_df <- as.data.frame(de_genes_prenatal_human_brain_smoking)
head(de_genes_df)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

