# Code example from 'Kdmodels' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(crop = NULL)

## ----echo=FALSE, out.width="35%", fig.align = 'center'------------------------
knitr::include_graphics(system.file('docs', '12mer.png', package = 'scanMiR'))

## -----------------------------------------------------------------------------
library(scanMiR)
data(SampleKdModel)
SampleKdModel

## -----------------------------------------------------------------------------
SampleKdModel$myVariable <- "test"

## -----------------------------------------------------------------------------
plotKdModel(SampleKdModel, what="seeds")

## -----------------------------------------------------------------------------
assignKdType("ACGTACGTACGT", SampleKdModel)
# or using multiple sequences:
assignKdType(c("CTAGCATTAAGT","ACGTACGTACGT"), SampleKdModel)

## -----------------------------------------------------------------------------
# we create a copy of the KdModel, and give it a different name:
mod2 <- SampleKdModel
mod2$name <- "dummy-miRNA"
kml <- KdModelList(SampleKdModel, mod2)
kml
summary(kml)

## -----------------------------------------------------------------------------
conservation(kml)

## -----------------------------------------------------------------------------
kd <- dummyKdData()
head(kd)

## -----------------------------------------------------------------------------
mod3 <- getKdModel(kd=kd, mirseq="TTAATGCTAATCGTGATAGGGGTT", name = "my-miRNA")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

