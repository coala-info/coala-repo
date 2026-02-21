# Code example from 'a4Core-vignette' vignette. See references/ for full tutorial.

## ----loadLibraries, results = 'hide', echo = FALSE----------------------------

	library(a4Core)


## ----simulateData-------------------------------------------------------------
eSet <- simulateData(
	nCols = 40, nRows = 1000, 
	nEffectRows = 5, nNoEffectCols = 5,
	betweenClassDifference = 1, withinClassSd = 0.5
)
print(eSet)

## ----sessionInformation, echo = FALSE-----------------------------------------
print(sessionInfo())

