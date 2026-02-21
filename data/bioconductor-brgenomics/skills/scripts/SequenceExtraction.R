# Code example from 'SequenceExtraction' vignette. See references/ for full tutorial.

## ---- message = FALSE---------------------------------------------------------
library(BRGenomics)
library(Biostrings)

## -----------------------------------------------------------------------------
# get path to included 2bit file
sfile <- system.file("extdata", "dm6_chr4chrM.2bit",
                     package = "BRGenomics")

## -----------------------------------------------------------------------------
seq_chr4 <- import(sfile)
seq_chr4

## -----------------------------------------------------------------------------
data("txs_dm6_chr4")
txs_pr <- promoters(txs_dm6_chr4, 0, 100)

## -----------------------------------------------------------------------------
seq_txs_pr <- getSeq(TwoBitFile(sfile), txs_pr)
seq_txs_pr

## -----------------------------------------------------------------------------
RNAStringSet(seq_txs_pr)
suppressWarnings(translate(seq_txs_pr))
oligonucleotideFrequency(seq_txs_pr[1:5], width = 1)
oligonucleotideFrequency(seq_txs_pr[1:5], width = 2)

## -----------------------------------------------------------------------------
tss_seq <- getSeq(TwoBitFile(sfile), promoters(txs_dm6_chr4, 4, 4))
tsspwm <- PWM(tss_seq)
tsspwm

