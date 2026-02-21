# Code example from 'mcsurvdata' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(mcsurvdata)

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
dat <- query(eh, "mcsurvdata")
nda.brca <- dat[["EH1497"]]
nda.crc <- dat[["EH1498"]]

## -----------------------------------------------------------------------------
sessionInfo()

