# Code example from 'biodbLipidmaps' vignette. See references/ for full tutorial.

## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install('biodbLipidmaps')

## ---- results='hide'----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
conn <- mybiodb$getFactory()$createConn('lipidmaps.structure')

## -----------------------------------------------------------------------------
conn$getNbEntries()

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
ids <- conn$wsLmsdSearch(mode='ProcessStrSearch', name="fatty", retfmt="ids")
ids

## -----------------------------------------------------------------------------
entries <- conn$getEntry(ids)

## -----------------------------------------------------------------------------
entriesDf <- mybiodb$entriesToDataframe(entries)

## ----entriesTable, echo=FALSE, results='asis'---------------------------------
knitr::kable(entriesDf, "pipe", caption="The entries listed in the result of the search.")

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

