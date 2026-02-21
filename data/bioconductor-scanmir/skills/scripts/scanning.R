# Code example from 'scanning' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----echo = FALSE, out.width="35%", fig.align = 'right'-----------------------
knitr::include_graphics(system.file('docs', 'sticker.svg', package = 'scanMiR'))

## -----------------------------------------------------------------------------
library(scanMiR)

# seed sequence of hsa-miR-155-5p
seed <- "AGCAUUAA"

# load a sample transcript
data("SampleTranscript")

# run scan
matches <- findSeedMatches(SampleTranscript, seed, verbose = FALSE)
matches

## -----------------------------------------------------------------------------
# full sequence of the mature miR-155-5p transcript
miRNA <- "UUAAUGCUAAUCGUGAUAGGGGUU"

# run scan
matches <- findSeedMatches(SampleTranscript, miRNA, verbose = FALSE)
matches

## -----------------------------------------------------------------------------
viewTargetAlignment(matches[1], miRNA, SampleTranscript)

## -----------------------------------------------------------------------------
# load sample KdModel
data("SampleKdModel")

# run scan
matches <- findSeedMatches(SampleTranscript, SampleKdModel, verbose = FALSE)
matches

## ----echo = FALSE, out.width="80%", fig.align = 'right', fig.cap="Adapted from Grimson et al. 2007"----
knitr::include_graphics(system.file('docs', 'sitetypes.jpg', package = 'scanMiR'))

## ----message = FALSE----------------------------------------------------------
library(Biostrings)

# generate set of random sequences
seqs <- DNAStringSet(getRandomSeq(length = 1000, n = 10))

# add vector of ORF lengths
mcols(seqs)$ORF.length <- sample(500:800, length(seqs))

# run scan
matches2 <- findSeedMatches(seqs, SampleKdModel, verbose = FALSE)
head(matches2)

## -----------------------------------------------------------------------------
viewTargetAlignment(matches[1], SampleKdModel, SampleTranscript)

## -----------------------------------------------------------------------------
agg_matches <- aggregateMatches(matches2)
head(agg_matches)

## -----------------------------------------------------------------------------
unlist(scanMiR:::.defaultAggParams())

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

