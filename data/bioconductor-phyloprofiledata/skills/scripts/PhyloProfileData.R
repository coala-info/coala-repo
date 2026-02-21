# Code example from 'PhyloProfileData' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh = ExperimentHub()
myData <- query(eh, "PhyloProfileData")
myData

## ----warning = FALSE, message = FALSE-----------------------------------------
ampkTorPhyloProfile <- myData[["EH2544"]]
head(ampkTorPhyloProfile)

## ----warning = FALSE, message = FALSE-----------------------------------------
ampkTorFasta <- myData[["EH2545"]]
head(ampkTorFasta)

## ----warning = FALSE, message = FALSE-----------------------------------------
ampkTorDomain <- myData[["EH2546"]]
head(ampkTorDomain)

## ----warning = FALSE, message = FALSE-----------------------------------------
arthropodaPhyloProfile <- myData[["EH2547"]]
head(arthropodaPhyloProfile)

## ----warning = FALSE, message = FALSE-----------------------------------------
arthropodaFasta <- myData[["EH2548"]]
head(arthropodaFasta)

## ----warning = FALSE, message = FALSE-----------------------------------------
arthropodaDomain <- myData[["EH2549"]]
head(arthropodaDomain)

## ----sessionInfo, echo = FALSE------------------------------------------------
sessionInfo(package = "PhyloProfileData")

