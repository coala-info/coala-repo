# Code example from 'crisprBowtie' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version="devel")
# BiocManager::install("crisprBowtie")

## -----------------------------------------------------------------------------
library(Rbowtie)
fasta <- file.path(find.package("crisprBowtie"), "example/chr1.fa")
tempDir <- tempdir()
Rbowtie::bowtie_build(fasta,
                      outdir=tempDir,
                      force=TRUE,
                      prefix="myIndex")

## ----warning=FALSE, message=FALSE---------------------------------------------
library(crisprBowtie)
data(SpCas9, package="crisprBase")
crisprNuclease <- SpCas9
spacers <- c("TCCGCGGGCGACAATGGCAT",
             "TGATCCCGCGCTCCCCGATG",
             "CCGGGAGCCGGGGCTGGACG",
             "CCACCCTCAGGTGTGCGGCC",
             "CGGAGGGCTGCAGAAAGCCT",
             "GGTGATGGCGCGGGCCGGGC")
runCrisprBowtie(spacers,
                crisprNuclease=crisprNuclease,
                n_mismatches=3,
                canonical=FALSE,
                bowtie_index=file.path(tempDir, "myIndex"))

## ----eval=TRUE----------------------------------------------------------------
seeds <- c("GTAAAGGT", "AAGGATTG")
runBowtie(seeds,
          n_mismatches=2,
          bowtie_index=file.path(tempDir, "myIndex"))

## -----------------------------------------------------------------------------
sessionInfo()

