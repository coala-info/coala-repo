# Code example from 'crisprBwa' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version="devel")
# BiocManager::install("crisprBwa")

## -----------------------------------------------------------------------------
library(Rbwa)
fasta <- system.file(package="crisprBwa", "example/chr12.fa")
outdir <- tempdir()
index <- file.path(outdir, "chr12")
Rbwa::bwa_build_index(fasta,
                      index_prefix=index)

## -----------------------------------------------------------------------------
library(crisprBwa)
library(BSgenome.Hsapiens.UCSC.hg38)
data(SpCas9, package="crisprBase")
crisprNuclease <- SpCas9
bsgenome <- BSgenome.Hsapiens.UCSC.hg38
spacers <- c("AGCTGTCCGTGGGGGTCCGC",
             "CCCCTGCTGCTGTGCCAGGC",
             "ACGAACTGTAAAAGGCTTGG",
             "ACGAACTGTAACAGGCTTGG",
             "AAGGCCCTCAGAGTAATTAC")
runCrisprBwa(spacers,
             bsgenome=bsgenome,
             crisprNuclease=crisprNuclease,
             n_mismatches=3,
             canonical=FALSE,
             bwa_index=index)

## ----eval=TRUE----------------------------------------------------------------
seeds <- c("GTAAGCGGAGTGT", "AACGGGGAGATTG")
runBwa(seeds,
       n_mismatches=2,
       bwa_index=index)

## -----------------------------------------------------------------------------
sessionInfo()

