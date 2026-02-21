# Code example from 'RTNduals' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(RTNduals)
data("tniData", package = "RTN")
gexp <- tniData$expData
annot <- tniData$rowAnnotation
tfs <- c("IRF8","IRF1","PRDM1","E2F3","STAT4","LMO4","ZNF552")

## ----eval=FALSE---------------------------------------------------------------
# ##--- load package and dataset for demonstration
# library(RTNduals)
# data("tniData", package = "RTN")
# gexp <- tniData$expData
# annot <- tniData$rowAnnotation
# tfs <- c("IRF8","IRF1","PRDM1","E2F3","STAT4","LMO4","ZNF552")

## ----include=FALSE------------------------------------------------------------
##--- generate a pre-processed TNI-class object
rtni <- tni.constructor(gexp, regulatoryElements = tfs, rowAnnotation=annot)

## ----eval=FALSE---------------------------------------------------------------
# ##--- generate a pre-processed TNI-class object
# rtni <- tni.constructor(gexp, regulatoryElements = tfs, rowAnnotation=annot)

## ----include=FALSE------------------------------------------------------------
##--- compute a regulatory network (set nPermutations>=1000)
rtni <- tni.permutation(rtni, nPermutations=100, pValueCutoff=0.05, verbose=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# ##--- compute a regulatory network (set nPermutations>=1000)
# rtni <- tni.permutation(rtni, nPermutations=100, pValueCutoff=0.05)

## ----include=FALSE------------------------------------------------------------
##--- check stability of the regulatory network (set nBootstrap>=100)
rtni <- tni.bootstrap(rtni, nBootstrap=10, verbose=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# ##--- check stability of the regulatory network (set nBootstrap>=100)
# rtni <- tni.bootstrap(rtni, nBootstrap=10)

## ----include=FALSE------------------------------------------------------------
##--- Compute the DPI-filtered regulatory network
rtni <- tni.dpi.filter(rtni, eps = NA, verbose=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# ##--- Compute the DPI-filtered regulatory network
# # Note: we recommend setting 'eps = NA' in order to
# # estimate the threshold from the empirical null
# # distribution computed in the permutation and
# # bootstrap steps.
# rtni <- tni.dpi.filter(rtni, eps = NA)

## ----include=FALSE------------------------------------------------------------
##--- construct an mbr object and apply DPI algorithm
rmbr <- tni2mbrPreprocess(rtni)

## ----eval=FALSE---------------------------------------------------------------
# ##--- construct an mbr object and apply DPI algorithm
# rmbr <- tni2mbrPreprocess(rtni)

## ----include=FALSE------------------------------------------------------------
##--- test associations for dual regulons
rmbr <- mbrAssociation(rmbr, verbose=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# ##--- test associations for dual regulons
# rmbr <- mbrAssociation(rmbr)

## ----eval=TRUE----------------------------------------------------------------
##--- check summary
mbrGet(rmbr, what="summary")

## ----eval=TRUE----------------------------------------------------------------
##--- get results
overlap <- mbrGet(rmbr, what="dualsOverlap")
correlation <- mbrGet(rmbr, what="dualsCorrelation")

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

