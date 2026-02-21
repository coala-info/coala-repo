# Code example from 'tRNAdbImport' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages(
  library(tRNAdbImport)
)

## ----eval=FALSE---------------------------------------------------------------
# library(tRNAdbImport)

## -----------------------------------------------------------------------------
# accessing tRNAdb
# tRNA from yeast for Alanine and Phenylalanine
gr <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
                    aminoacids = c("Phe","Ala"))

## ----eval=FALSE---------------------------------------------------------------
# # get a Phenylalanine tRNA from yeast
# gr <- import.tRNAdb.id(tdbID = gr[gr$tRNA_type == "Phe",][1L]$tRNAdb_ID)

## ----eval=FALSE---------------------------------------------------------------
# # find the same tRNA via blast
# gr <- import.tRNAdb.blast(blastSeq = gr$tRNA_seq)

## -----------------------------------------------------------------------------
# accessing mtRNAdb
# get the mitochrondrial tRNA for Alanine in Bos taurus
gr <- import.mttRNAdb(organism = "Bos taurus", 
                      aminoacids = "Ala")

## ----eval=FALSE---------------------------------------------------------------
# # get one mitochrondrial tRNA in Bos taurus.
# gr <- import.mttRNAdb.id(mtdbID = gr[1L]$tRNAdb_ID)

## -----------------------------------------------------------------------------
# check that the result has the appropriate columns
istRNAdbGRanges(gr)

## ----eval=FALSE---------------------------------------------------------------
# gr <- import.tRNAdb(organism = "Saccharomyces cerevisiae",
#                     aminoacids = c("Phe","Ala"),
#                     database = "RNA")
# gr$tRNA_seq

## ----eval=FALSE---------------------------------------------------------------
# separate(gr$tRNA_seq)

## ----echo=FALSE---------------------------------------------------------------
suppressPackageStartupMessages({
  library(Biostrings)
  library(rtracklayer)
})

## ----eval=FALSE---------------------------------------------------------------
# library(Biostrings)
# library(rtracklayer)
# # saving the tRAN sequences as fasta file
# writeXStringSet(gr$tRNA_seq, filepath = tempfile())
# # converting tRNAdb information to GFF compatible values
# gff <- tRNAdb2GFF(gr)
# gff
# # Saving the information as gff3 file
# export.gff3(gff, con = tempfile())

## -----------------------------------------------------------------------------
sessionInfo()

