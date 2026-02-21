# Code example from 'S4Arrays_quick_overview' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("S4Arrays")

## ----message=FALSE------------------------------------------------------------
library(S4Arrays)

showClass("Array")

## -----------------------------------------------------------------------------
sessionInfo()

