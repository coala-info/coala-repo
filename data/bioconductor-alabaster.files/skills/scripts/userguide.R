# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(BiocStyle)
self <- Biocpkg("alabaster.files")
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)

## -----------------------------------------------------------------------------
bam.file <- system.file("extdata", "ex1.bam", package="Rsamtools", mustWork=TRUE)
bam.index <- paste0(bam.file, ".bai")

## -----------------------------------------------------------------------------
library(alabaster.files)
library(S4Vectors)
wrapped.bam <- BamFileReference(bam.file, index=bam.index)

## -----------------------------------------------------------------------------
dir <- tempfile()
saveObject(wrapped.bam, dir)

## -----------------------------------------------------------------------------
readObject(dir)

## -----------------------------------------------------------------------------
df <- DataFrame(Sample=LETTERS[1:4])

# Adding a column of assorted wrapper files:
df$File <- list(
    wrapped.bam,
    BigWigFileReference(system.file("tests", "test.bw", package = "rtracklayer")),
    BigBedFileReference(system.file("tests", "test.bb", package = "rtracklayer")),
    BcfFileReference(system.file("extdata", "ex1.bcf.gz", package = "Rsamtools"))
)

# Saving it all to the staging directory:
dir <- tempfile()
saveObject(df, dir)

# Now reading it back in:
roundtrip <- readObject(dir)
roundtrip$File

## -----------------------------------------------------------------------------
sessionInfo()

