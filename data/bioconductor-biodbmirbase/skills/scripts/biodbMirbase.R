# Code example from 'biodbMirbase' vignette. See references/ for full tutorial.

## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install('biodbMirbase')

## ---- results='hide'----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
conn <- mybiodb$getFactory()$createConn('mirbase.mature')

## -----------------------------------------------------------------------------
ids <- conn$getEntryIds(2)
ids

## -----------------------------------------------------------------------------
entries <- conn$getEntry(ids)
entries

## -----------------------------------------------------------------------------
x <- mybiodb$entriesToDataframe(entries)
x

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

