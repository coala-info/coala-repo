# Code example from 'systemPipeRdata' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'----------------
BiocStyle::markdown()
options(width=60, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts=list(width.cutoff=60), tidy=TRUE)

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE----
suppressPackageStartupMessages({
    library(systemPipeRdata)
})

## ----install, eval=FALSE----------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("systemPipeRdata")

## ----load_systemPipeRdata, eval=TRUE, messages=FALSE, warnings=FALSE----
library("systemPipeRdata") # Loads the package

## ----documentation_systemPipeRdata, eval=FALSE------------
# library(help="systemPipeRdata") # Lists package info
# vignette("systemPipeRdata") # Opens vignette

## ----check_availableWF, eval=FALSE------------------------
# availableWF()

## ----check_availableWF_table, echo=FALSE, message=FALSE----
library(magrittr)
Name <- c("new", "rnaseq", "riboseq", "chipseq", "varseq", "SPblast", "SPcheminfo", "SPscrna") 
Name_url <- c("new", "systemPipeRNAseq", "systemPipeRIBOseq", "systemPipeChIPseq", "systemPipeVARseq", "SPblast", "SPcheminfo", "SPscrna") 
Description <- c("Generic Workflow Template", "RNA-Seq Workflow Template", "RIBO-Seq Workflow Template", "ChIP-Seq Workflow Template", "VAR-Seq Workflow Template", "BLAST Workflow Template", "Cheminformatics Drug Similarity Template", "Basic Single-Cell Workflow Template") 
rmd <- paste0("https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/", Name_url, ".Rmd")
rmd <- paste0("<a href=", rmd, ">Rmd</a>")
html <- paste0("https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/", Name_url, ".html")
html <- paste0("<a href=", html, ">HTML</a>")
URL <- paste(rmd, html, sep=", ")
df <- data.frame(Name=Name, Description=Description, URL=URL)
df %>%
    kableExtra::kable("html", escape = FALSE, col.names = c("Name", "Description", "URL")) %>%
    kableExtra::kable_material(c("striped", "hover", "condensed")) %>%
    kableExtra::scroll_box(width = "80%", height = "500px")

## ----generate_workenvir, eval=FALSE-----------------------
# library(systemPipeRdata)
# genWorkenvir(workflow="rnaseq")
# setwd("rnaseq")

## ----project_rnaseq, eval=FALSE---------------------------
# library(systemPipeR)
# sal <- SPRproject()
# sal <- importWF(sal, file_path = "systemPipeRNAseq.Rmd", verbose = FALSE)

## ----run_rnaseq, eval=FALSE-------------------------------
# sal <- runWF(sal)

## ----plot_rnaseq, eval=FALSE------------------------------
# plotWF(sal)

## ----rnaseq-toplogy, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Toplogy graph of RNA-Seq workflow.", warning=FALSE----
knitr::include_graphics("results/plotwf_rnaseq.png")

## ----report_rnaseq, eval=FALSE----------------------------
# # Scietific report
# sal <- renderReport(sal)
# rmarkdown::render("systemPipeRNAseq.Rmd", clean = TRUE, output_format = "BiocStyle::html_document")
# 
# # Technical (log) report
# sal <- renderLogs(sal)

## ----eval=FALSE, tidy=FALSE-------------------------------
# availableWF(github = TRUE)

## ----return_samplepaths, eval=TRUE------------------------
pathList()[1:2]

## ----generate_workenvir2, eval=FALSE----------------------
# library(systemPipeRdata)
# genWorkenvir(workflow="...")

## ----sessionInfo------------------------------------------
sessionInfo()

