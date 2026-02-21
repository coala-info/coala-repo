# Code example from 'restfulSEData' vignette. See references/ for full tutorial.

## ----get-data--------------------------------------------------------------
library(ExperimentHub)
ehub = ExperimentHub()
myfiles <- query(ehub , "restfulSEData")
myfiles
myfiles[[1]]
myfiles[["EH551"]] #load by EH id


## ----meta------------------------------------------------------------------
dataResource()

