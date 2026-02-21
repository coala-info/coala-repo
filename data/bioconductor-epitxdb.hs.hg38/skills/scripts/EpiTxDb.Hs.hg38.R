# Code example from 'EpiTxDb.Hs.hg38' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ---- echo=FALSE--------------------------------------------------------------
suppressPackageStartupMessages({
  library(EpiTxDb.Hs.hg38)
})

## ---- eval=FALSE--------------------------------------------------------------
#  library(EpiTxDb.Hs.hg38)

## -----------------------------------------------------------------------------
etdb <- EpiTxDb.Hs.hg38.tRNAdb()
etdb

## -----------------------------------------------------------------------------
modifications(etdb)

## -----------------------------------------------------------------------------
cf <- chain.rRNA.hg19Tohg38()
cf

## -----------------------------------------------------------------------------
library(rtracklayer)
library(Modstrings)
files <- c(system.file("extdata","Modomics.LSU.Hs.txt",
                       package = "EpiTxDb.Hs.hg38"),
           system.file("extdata","Modomics.SSU.Hs.txt",
                       package = "EpiTxDb.Hs.hg38"))
seq <- lapply(files,readLines,encoding = "UTF-8")
seq <- unlist(seq)
names <- seq[seq.int(1L,6L,2L)]
seq <- seq[seq.int(2L,6L,2L)]
seq <- ModRNAStringSet(sanitizeFromModomics(gsub("-","",seq)))
names(seq) <- c("28S","5.8S","18S")
mod <- separate(seq)

## -----------------------------------------------------------------------------
mod[mod$mod == "m7G" | mod$mod == "m6A"]

## -----------------------------------------------------------------------------
mod_new <- unlist(liftOver(mod,cf))
mod_new[mod_new$mod == "m7G" | mod_new$mod == "m6A"]

## -----------------------------------------------------------------------------
rna <- getSeq(snoRNA.targets.hg38())
names(rna)[1:4] <- c("5S","18S","5.8S","28S")
seqtype(rna) <- "RNA"
seq_new <- combineIntoModstrings(rna, mod_new)
seq_new

## -----------------------------------------------------------------------------
sessionInfo()

