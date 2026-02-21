# Code example from 'VplotR' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo=FALSE, results="hide", warning=FALSE-------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
suppressPackageStartupMessages({
    library(GenomicRanges)
    library(ggplot2)
    library(VplotR)
})

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
# BiocManager::install("VplotR")
# library("VplotR")

## ----eval = TRUE--------------------------------------------------------------
library(VplotR)
bamfile <- system.file("extdata", "ex1.bam", package = "Rsamtools")
fragments <- importPEBamFiles(
    bamfile, 
    shift_ATAC_fragments = TRUE
)
fragments

## ----eval = TRUE--------------------------------------------------------------
data(ce11_proms)
ce11_proms
data(ATAC_ce11_Serizay2020)
ATAC_ce11_Serizay2020

## ----eval = TRUE--------------------------------------------------------------
data(ABF1_sacCer3)
ABF1_sacCer3
data(MNase_sacCer3_Henikoff2011)
MNase_sacCer3_Henikoff2011

## ----eval = TRUE--------------------------------------------------------------
df <- getFragmentsDistribution(
    MNase_sacCer3_Henikoff2011, 
    ABF1_sacCer3
)
p <- ggplot(df, aes(x = x, y = y)) + geom_line() + theme_ggplot2()
p

## ----eval = TRUE--------------------------------------------------------------
p <- plotVmat(x = MNase_sacCer3_Henikoff2011, granges = ABF1_sacCer3)
p

## ----eval = TRUE--------------------------------------------------------------
list_params <- list(
    "MNase\n@ ABF1" = list(MNase_sacCer3_Henikoff2011, ABF1_sacCer3), 
    "MNase\n@ random loci" = list(
        MNase_sacCer3_Henikoff2011, sampleGRanges(ABF1_sacCer3)
    )
)
p <- plotVmat(
    list_params, 
    cores = 1
)
p

## ----eval = TRUE--------------------------------------------------------------
list_params <- list(
    "Germline ATACseq\n@ Ubiq. proms" = list(
        ATAC_ce11_Serizay2020[['Germline']], 
        ce11_proms[ce11_proms$which.tissues == 'Ubiq.']
    ), 
    "Germline ATACseq\n@ Germline proms" = list(
        ATAC_ce11_Serizay2020[['Germline']], 
        ce11_proms[ce11_proms$which.tissues == 'Germline']
    ),
    "Neuron ATACseq\n@ Ubiq. proms" = list(
        ATAC_ce11_Serizay2020[['Neurons']], 
        ce11_proms[ce11_proms$which.tissues == 'Ubiq.']
    ), 
    "Neuron ATACseq\n@ Neuron proms" = list(
        ATAC_ce11_Serizay2020[['Neurons']], 
        ce11_proms[ce11_proms$which.tissues == 'Neurons']
    )
)
p <- plotVmat(
    list_params, 
    cores = 1,
    nrow = 2, ncol = 5
)
p

## ----eval = TRUE--------------------------------------------------------------
# No normalization 
p <- plotVmat(
    list_params, 
    cores = 1, 
    nrow = 2, ncol = 5, 
    verbose = FALSE,
    normFun = 'none'
)
p

## ----eval = TRUE--------------------------------------------------------------
# Library depth + number of loci of interest (default)
p <- plotVmat(
    list_params, 
    cores = 1, 
    nrow = 2, ncol = 5, 
    verbose = FALSE,
    normFun = 'libdepth+nloci'
)
p

## ----eval = TRUE--------------------------------------------------------------
# Zscore
p <- plotVmat(
    list_params, 
    cores = 1, 
    nrow = 2, ncol = 5, 
    verbose = FALSE,
    normFun = 'zscore'
)
p
# Quantile
p <- plotVmat(
    list_params, 
    cores = 1, 
    nrow = 2, ncol = 5, 
    verbose = FALSE,
    normFun = 'quantile', 
    s = 0.99
)
p

## -----------------------------------------------------------------------------
p <- plotFootprint(
    MNase_sacCer3_Henikoff2011,
    ABF1_sacCer3
)
p

## -----------------------------------------------------------------------------
data(MNase_sacCer3_Henikoff2011_subset)
genes_sacCer3 <- GenomicFeatures::genes(TxDb.Scerevisiae.UCSC.sacCer3.sgdGene::
    TxDb.Scerevisiae.UCSC.sacCer3.sgdGene
)
p <- plotProfile(
    fragments = MNase_sacCer3_Henikoff2011_subset,
    window = "chrXV:186,400-187,400", 
    loci = ABF1_sacCer3, 
    annots = genes_sacCer3,
    min = 20, max = 200, alpha = 0.1, size = 1.5
)
p

## ----echo = TRUE, collapse = TRUE, eval = TRUE--------------------------------
sessionInfo()

