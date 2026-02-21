# Code example from 'rRDP' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library("rRDP")
set.seed(1234)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("Biostrings")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("rRDP")
# BiocManager::install("rRDPData")

## ----eval=FALSE---------------------------------------------------------------
# Sys.setenv(JAVA_HOME = "C:\\Program Files\\Java\\jdk-20")

## ----comment = ""-------------------------------------------------------------
citation("rRDP")

## -----------------------------------------------------------------------------
seq <- readRNAStringSet(system.file("examples/RNA_example.fasta",
    package = "rRDP"
))
seq

## -----------------------------------------------------------------------------
annotation <- names(seq)

names(seq) <- sapply(strsplit(names(seq), " "), "[", 1)
seq

## -----------------------------------------------------------------------------
pred <- predict(rdp(), seq)
pred

## -----------------------------------------------------------------------------
attr(pred, "confidence")

## -----------------------------------------------------------------------------
actual <- decode_Greengenes(annotation)
actual

## -----------------------------------------------------------------------------
confusionTable(actual, pred, rank = "genus")
accuracy(actual, pred, rank = "genus")

## -----------------------------------------------------------------------------
trainingSequences <- readDNAStringSet(
    system.file("examples/trainingSequences.fasta", package = "rRDP")
)
trainingSequences

## -----------------------------------------------------------------------------
sprintf(names(trainingSequences[1]), fmt = "%.65s...")

## -----------------------------------------------------------------------------
customRDP <- trainRDP(trainingSequences, dir = "myRDP")
customRDP

## -----------------------------------------------------------------------------
testSequences <- readDNAStringSet(
    system.file("examples/testSequences.fasta", package = "rRDP")
)
pred <- predict(customRDP, testSequences)
pred

## -----------------------------------------------------------------------------
customRDP <- rdp(dir = "myRDP")

## -----------------------------------------------------------------------------
removeRDP(customRDP)

## -----------------------------------------------------------------------------
sessionInfo()

