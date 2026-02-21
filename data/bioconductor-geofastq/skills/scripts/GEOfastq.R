# Code example from 'GEOfastq' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(GEOfastq)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GEOfastq")

## -----------------------------------------------------------------------------
gse_name <- 'GSE133758'
gse_text <- crawl_gse(gse_name)

## -----------------------------------------------------------------------------
gsm_names <- extract_gsms(gse_text)
gsm_name <- gsm_names[182]
srp_meta <- crawl_gsms(gsm_name)

## -----------------------------------------------------------------------------
data_dir <- tempdir()

# example using smaller file
srp_meta <- data.frame(
        run  = 'SRR014242',
        row.names = 'SRR014242',
        gsm_name = 'GSM315559',
        ebi_dir = get_dldir('SRR014242'), stringsAsFactors = FALSE)

res <- get_fastqs(srp_meta, data_dir)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

