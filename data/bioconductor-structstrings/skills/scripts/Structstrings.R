# Code example from 'Structstrings' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown(css.files = c('custom.css'))

## ----package, echo=FALSE------------------------------------------------------
suppressPackageStartupMessages({
  library(Structstrings)
})

## ----package2, eval=FALSE-----------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
# 	install.packages("BiocManager")
# BiocManager::install("Structstrings")
# library(Structstrings)

## ----annotation_convert-------------------------------------------------------
dbs[[2L]] <- convertAnnotation(dbs[[2L]],from = 2L, to = 1L)
dbs[[3L]] <- convertAnnotation(dbs[[3L]],from = 3L, to = 1L)
dbs[[4L]] <- convertAnnotation(dbs[[4L]],from = 4L, to = 1L)
# Note: convertAnnotation checks for presence of annotation and stops
# if there is any conflict.
dbs

## ----base_pairing-------------------------------------------------------------
# base pairing table
dbdfl <- getBasePairing(dbs)
dbdfl[[1L]]

## ----loopindices--------------------------------------------------------------
loopids <- getLoopIndices(dbs, bracket.type = 1L)
loopids[[1L]]
# can also be constructed from DotBracketDataFrame and contains the same 
# information
loopids2 <- getLoopIndices(dbdfl, bracket.type = 1L)
all(loopids == loopids2)

## ----dotbracket---------------------------------------------------------------
rec_dbs <- getDotBracket(dbdfl)
dbdf <- unlist(dbdfl)
dbdf$character <- NULL
dbdfl2 <- relist(dbdf,dbdfl)
# even if the character column is not set, the dot bracket string can be created
rec_dbs2 <- getDotBracket(dbdfl2)
rec_dbs3 <- getDotBracket(dbdfl, force = TRUE)
rec_dbs[[1L]]
rec_dbs2[[1L]]
rec_dbs3[[1L]]

## ----pseudoloop---------------------------------------------------------------
db <- DotBracketString("((((....[[[))))....((((....<<<<...))))]]]....>>>>...")
db
getDotBracket(getBasePairing(db), force = TRUE)

## ----structured_rna_string----------------------------------------------------
data("dbs", package = "Structstrings")
data("nseq", package = "Structstrings")
sdbs <- StructuredRNAStringSet(nseq,dbs)
sdbs[1L]
# subsetting to element returns the sequence
sdbs[[1L]]
# dotbracket() gives access to the DotBracketStringSet
dotbracket(sdbs)[[1L]]

## ----structured_rna_string_base_pairing---------------------------------------
dbdfl <- getBasePairing(sdbs)
dbdfl[[1L]]
# returns the result without sequence information
dbdfl <- getBasePairing(sdbs, return.sequence = TRUE)
dbdfl[[1L]]

## -----------------------------------------------------------------------------
sessionInfo()

