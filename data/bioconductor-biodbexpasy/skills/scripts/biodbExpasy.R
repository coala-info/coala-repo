# Code example from 'biodbExpasy' vignette. See references/ for full tutorial.

## ---- eval=FALSE--------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install('biodbExpasy')

## ---- results='hide'----------------------------------------------------------
mybiodb <- biodb::newInst()

## -----------------------------------------------------------------------------
conn <- mybiodb$getFactory()$createConn('expasy.enzyme')

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
conn$wsEnzymeByName(name="Alcohol", retfmt="ids")

## -----------------------------------------------------------------------------
conn$wsEnzymeByComment(comment="best", retfmt="ids")

## -----------------------------------------------------------------------------
mybiodb$terminate()

## -----------------------------------------------------------------------------
sessionInfo()

