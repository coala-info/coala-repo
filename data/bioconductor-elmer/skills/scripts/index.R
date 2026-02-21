# Code example from 'index' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github(repo = "tiagochst/ELMER.data")
# devtools::install_github(repo = "tiagochst/ELMER")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("ELMER")

## ----fig.height=6,echo=FALSE, message=FALSE, warning=FALSE, include=TRUE------
library(ELMER, quietly = TRUE)

## ----sessioninfo, eval=TRUE---------------------------------------------------
sessionInfo()

