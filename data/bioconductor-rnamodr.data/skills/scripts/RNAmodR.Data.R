# Code example from 'RNAmodR.Data' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(RNAmodR.Data)
})

## ----eval=FALSE---------------------------------------------------------------
# library(RNAmodR.Data)

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
ExperimentHub::listResources(eh, "RNAmodR.Data")

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(GenomicRanges)
})

## ----eval=FALSE---------------------------------------------------------------
# library(GenomicRanges)

## -----------------------------------------------------------------------------
table <- read.csv2(RNAmodR.Data.snoRNAdb(), stringsAsFactors = FALSE)
head(table, n = 2)
# keep only the current coordinates
table <- table[,1:7]
snoRNAdb <- GRanges(seqnames = table$hgnc_symbol,
              ranges = IRanges(start = table$position, width = 1),strand = "+",
              type = "RNAMOD",
              mod = table$modification,
              Parent = table$hgnc_symbol,
              Activity = CharacterList(strsplit(table$guide,",")))
# convert to current gene name
snoRNAdb <- snoRNAdb[vapply(snoRNAdb$Activity != "unknown",all,logical(1)),]
snoRNAdb <- split(snoRNAdb,snoRNAdb$Parent)
head(snoRNAdb)

## -----------------------------------------------------------------------------
sessionInfo()

