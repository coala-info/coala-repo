# Code example from 'GeneSummary' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(GeneSummary)
tb = loadGeneSummary(organism = 9606)
# # or use the full organism name
# tb = loadGeneSummary(organism = "Homo sapiens")
dim(tb)
head(tb)

## -----------------------------------------------------------------------------
tb = loadGeneSummary(organism = NULL)
sort(table(tb$Organism))
sort(table(tb$Review_status))

## -----------------------------------------------------------------------------
tb = loadGeneSummary(organism = NULL, status = "reviewed")
sort(table(tb$Review_status))

## -----------------------------------------------------------------------------
GeneSummary

## -----------------------------------------------------------------------------
sessionInfo()

