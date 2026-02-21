# Code example from 'Using_MSGFgui' vignette. See references/ for full tutorial.

## ---- echo=FALSE, results='hide', message=FALSE--------------------------
library(MSGFgui)

## ---- eval=FALSE---------------------------------------------------------
#  # Standard fashion
#  MSGFgui()
#  
#  # You can pass parameters along to shiny's runApp()
#  MSGFgui(port='0.0.0.0')

## ------------------------------------------------------------------------
results <- currentData()

show(results) # Empty as no analysis has been run

## ---- eval=TRUE, echo=TRUE-----------------------------------------------
sessionInfo()

