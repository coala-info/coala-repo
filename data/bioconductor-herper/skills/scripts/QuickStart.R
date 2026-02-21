# Code example from 'QuickStart' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide", include = FALSE-------------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=FALSE,
                      #dev="png",
                      message=FALSE, error=FALSE, warning=TRUE)
options(width=100)

## ----getPackage, eval=FALSE-----------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("Herper")

## -------------------------------------------------------------------------------------------------
library(Herper)

## ----install_Condatools, echo=T, eval=F-----------------------------------------------------------
# myMiniconda <- file.path(tempdir(),"Test")
# install_CondaTools("salmon==1.3.0", "herper", pathToMiniConda = myMiniconda)

## ----install_CondaSysReqs, eval=F-----------------------------------------------------------------
# testPkg <- system.file("extdata/HerperTestPkg",package="Herper")
# install.packages(testPkg,type = "source",repos = NULL)
# condaDir <- file.path(tempdir(),"r-miniconda")
# condaPaths <- install_CondaSysReqs("HerperTestPkg", pathToMiniConda = myMiniconda,SysReqsAsJSON=FALSE)
# #' system2(file.path(condaPaths$pathToEnvBin,"samtools"),args = "--help")
# 

## ----sessionInfo----------------------------------------------------------------------------------
sessionInfo()

