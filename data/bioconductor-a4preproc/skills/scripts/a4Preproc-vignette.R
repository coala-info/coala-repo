# Code example from 'a4Preproc-vignette' vignette. See references/ for full tutorial.

## ----loadLibraries, results = 'hide', echo = FALSE----------------------------

	library(a4Preproc)


## ----addGeneInfo, message = FALSE---------------------------------------------
library(ALL)
data(ALL)
a4ALL <- addGeneInfo(eset = ALL)
print(head(fData(a4ALL)))
print(head(featureData(a4ALL)))

## ----sessionInformation, echo = FALSE-----------------------------------------
print(sessionInfo())

