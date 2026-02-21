# Code example from 'scanMiRData' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## -----------------------------------------------------------------------------
library(scanMiR)
data("mmu", package="scanMiRData")
summary(mmu)
head(mmu)

## -----------------------------------------------------------------------------
library(scanMiRData)
mmu <- getKdModels("mmu", categories=c("Conserved across vertebrates", 
                                       "Conserved across mammals"))
summary(mmu)

## -----------------------------------------------------------------------------
summary(getKdModels("hsa"))
summary(getKdModels("rno"))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

