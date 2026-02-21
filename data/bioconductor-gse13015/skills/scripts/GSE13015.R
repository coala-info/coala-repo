# Code example from 'GSE13015' vignette. See references/ for full tutorial.

## ----get-expression matrix----------------------------------------------------
library(ExperimentHub)
dat = ExperimentHub()
hub = query(dat , "GSE13015")
temp = hub[["EH5429"]]


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

