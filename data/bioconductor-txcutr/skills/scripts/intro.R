# Code example from 'intro' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning=FALSE------------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    txcutr = citation("txcutr")[1]
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("txcutr")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----"citation"---------------------------------------------------------------
## Citation info
citation("txcutr")

## ----"txdb_sgd", message=FALSE------------------------------------------------
library(GenomicFeatures)
library(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene)
txdb <- TxDb.Scerevisiae.UCSC.sacCer3.sgdGene

## constrain to "chrI"
seqlevels(txdb) <- "chrI"

## view the lengths of first ten transcripts
transcriptLengths(txdb)[1:10,]

## ----"truncate_sgd"-----------------------------------------------------------
library(txcutr)

txdb_w500 <- truncateTxome(txdb, maxTxLength=500)

transcriptLengths(txdb_w500)[1:10,]

## ----"export_gtf", eval=FALSE-------------------------------------------------
# gtf_file <- tempfile("sacCer3_chrI.sgd.txcutr_w500", fileext=".gtf.gz")
# exportGTF(txdb_w500, file=gtf_file)

## ----"export_fasta", eval=FALSE-----------------------------------------------
# library(BSgenome.Scerevisiae.UCSC.sacCer3)
# sacCer3 <- BSgenome.Scerevisiae.UCSC.sacCer3
# 
# fasta_file <- tempfile("sacCer3_chrI.sgd.txcutr_w500", fileext=".fa.gz")
# exportFASTA(txdb_w500, genome=sacCer3, file=fasta_file)

## ----"merge_table"------------------------------------------------------------
df_merge <- generateMergeTable(txdb_w500, minDistance=500)

head(df_merge, 10)

## ----"merged_txs"-------------------------------------------------------------
df_merge[df_merge$tx_in != df_merge$tx_out,]

## -----------------------------------------------------------------------------
transcripts(txdb_w500, columns=c("tx_name", "gene_id"),
            filter=list(gene_id=c("YAL026C")))

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("intro.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("intro.Rmd", tangle = TRUE)

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

