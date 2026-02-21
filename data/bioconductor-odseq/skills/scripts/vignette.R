# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
set.seed(93)
library(odseq)
data("seqs")

## -----------------------------------------------------------------------------
library(msa)
alig <- msa(seqs)

## -----------------------------------------------------------------------------
ground_values <- c(rep(FALSE, 211), rep(TRUE, 100))
outliers <- odseq(alig, distance_metric = "affine", B = 1000)

## -----------------------------------------------------------------------------
mean(outliers == ground_values)

## -----------------------------------------------------------------------------
library(kebabs)
sp <- spectrumKernel(k = 3)
mat <- getKernelMatrix(sp, seqs)

## -----------------------------------------------------------------------------
outliers_unaligned <- odseq_unaligned(mat, B = 1000, type = "similarity")

## -----------------------------------------------------------------------------
mean(outliers_unaligned == ground_values)

