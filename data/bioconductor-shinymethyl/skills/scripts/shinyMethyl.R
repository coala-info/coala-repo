# Code example from 'shinyMethyl' vignette. See references/ for full tutorial.

## ----shinyMethylData, eval=FALSE----------------------------------------------
# library(shinyMethyl)
# library(shinyMethylData)
# runShinyMethyl(summary.tcga.raw, summary.tcga.norm)

## ----loadlibraries, eval=TRUE, results="hide",warning=FALSE,message=FALSE-----
library(minfi)
library(minfiData)

## ----basedir,eval=FALSE-------------------------------------------------------
# baseDir <- system.file("extdata", package = "minfiData")
# # baseDir <- "/home/yourDirectoryPath"

## ----experimentsheet,eval=FALSE-----------------------------------------------
# targets <- read.450k.sheet(baseDir)
# head(targets)

## ----rgsetconstruction,eval=FALSE---------------------------------------------
# RGSet <- read.450k.exp(base = baseDir, targets = targets)

## ----phenotype, eval=FALSE----------------------------------------------------
# pd <- pData(RGSet)
# head(pd)

## ----summarize, eval=FALSE----------------------------------------------------
# myShinyMethylSet <- shinySummarize(RGSet)

## ----sessionLaunching, eval=FALSE---------------------------------------------
# runShinyMethyl(myShinyMethylSet)

## ----normalize, eval=FALSE----------------------------------------------------
# GRSet.norm <- preprocessQuantile(RGSet)

## ----summarizeNorm,eval=FALSE-------------------------------------------------
# summary   <- shinySummarize(RGSset)
# summary.norm <- shinySummarize(GRSet.norm)

## ----runshiny,eval=FALSE------------------------------------------------------
# runShinyMethyl(summary, summary.norm)

## ----eval=TRUE,warning=FALSE,message=FALSE------------------------------------
library(shinyMethyl)
library(shinyMethylData)
slotNames(summary.tcga.raw)

## ----pheno,eval=TRUE----------------------------------------------------------
head(summary.tcga.raw@phenotype)

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/screenshot_qc.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/screenshot_design.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/screenshot_sexprediction.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/screenshot_pca.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/screenshot_designbias.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/All.png")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/BothPlate.jpg")

## ----echo=FALSE---------------------------------------------------------------
knitr::include_graphics("figures/BothStatus.jpg")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

