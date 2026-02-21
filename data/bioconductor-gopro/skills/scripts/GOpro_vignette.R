# Code example from 'GOpro_vignette' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("GOpro", dependencies = TRUE)

## ----eval=TRUE, results='hide', warning=FALSE, message=FALSE------------------
library(GOpro)

## ----cache=TRUE, message=FALSE, results='markup'------------------------------
exrtcga

## ----results='hold', message=FALSE, cache=TRUE--------------------------------
findGO(exrtcga)

## ----results='hold', message=FALSE, cache=TRUE--------------------------------
findGO(exrtcga, extend = TRUE)

## ----results='markup', message=FALSE, cache=TRUE, fig.keep='all', fig.show='hold', dev='png'----
findGO(exrtcga, topGO = 2, grouped = 'clustering')

## ----results='markup', message=FALSE, cache=TRUE, fig.keep='all', fig.show='hold', dev='png'----
findGO(exrtcga, topGO = 2, grouped = 'clustering', over.rep = TRUE)

