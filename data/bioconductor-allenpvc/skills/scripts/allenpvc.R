# Code example from 'allenpvc' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'-------------------------------------
BiocStyle::markdown()

## ----install, eval=FALSE---------------------------------------------------
#  BiocManager::install("allenpvc")

## ----load_eh---------------------------------------------------------------
library(allenpvc)
apvc <- allenpvc()

## ----get_assay-------------------------------------------------------------
head(assay(apvc, "counts")[, 1:5])

## ----coldata---------------------------------------------------------------
head(colData(apvc))

## ----primary_type----------------------------------------------------------
head(apvc$primary_type, 20)

## ----broad_type------------------------------------------------------------
head(apvc$broad_type, 20)

## ----cre_qc----------------------------------------------------------------
head(colData(apvc)[, c("cre_driver_1", "pass_qc_checks")])

## ----spike_in--------------------------------------------------------------
apvc_endo <- apvc[!isSpike(apvc),]
apvc_endo
apvc_spike <- apvc[isSpike(apvc),]
apvc_spike

## ----sessioninfo, echo=FALSE-----------------------------------------------
sessionInfo()

