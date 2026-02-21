# Code example from 'introduction' vignette. See references/ for full tutorial.

## ---- import-------------------------------------------------------------
library(readat)
zipFile <- system.file(
  "extdata", "PLASMA.1.3k.20151030.adat.zip", 
  package = "readat"
)
adatFile <- unzip(zipFile, exdir = tempfile("readat"))
plasma1.3k <- readAdat(adatFile)

## ---- dimSeq-------------------------------------------------------------
sequenceData <- getSequenceData(plasma1.3k)
nrow(sequenceData) # 1310 less 11

## ---- importIncludeFails-------------------------------------------------
plasma1.3kIncFailures <- readAdat(adatFile, keepOnlyPasses = FALSE)
nrow(getSequenceData(plasma1.3kIncFailures))

## ---- melting------------------------------------------------------------
library(reshape2)
longPlasma1.3k <- melt(plasma1.3k)
str(longPlasma1.3k)

## ---- createExpressionSets-----------------------------------------------
as.ExpressionSet(plasma1.3k)
as.SummarizedExperiment(plasma1.3k)
if(requireNamespace("MSnbase"))
{
  as.MSnSet(plasma1.3k)
}

