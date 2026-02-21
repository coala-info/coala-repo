# Code example from 'secondary' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("BridgeDbR")
# install.packages(pkgs=c("rJava", "curl"))
# 
# library(curl)
# library(rJava)
# library(BridgeDbR)

## ----eval=FALSE---------------------------------------------------------------
# sec2pri = BridgeDbR::loadDatabase("ChEBI_secID2priID.bridge")

## ----eval=FALSE---------------------------------------------------------------
# BridgeDbR::map(sec2pri, source="Ce", identifier="CHEBI:1234")

## ----eval=FALSE---------------------------------------------------------------
# mappedIDs = BridgeDbR::map(sec2pri, source="Ce", identifier="CHEBI:1234")
# mappedIDs[intersect(which(mappedIDs[,"target"] == "Ce"),which(mappedIDs[,"isPrimary"] == "T")),]

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

