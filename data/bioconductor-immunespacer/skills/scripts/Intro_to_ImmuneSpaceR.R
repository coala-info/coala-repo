# Code example from 'Intro_to_ImmuneSpaceR' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, cache = FALSE------------------------------------
library(knitr)
library(rmarkdown)
opts_chunk$set(cache = FALSE)

## ----netrc_req, echo = FALSE---------------------------------------------
# This chunk is only useful for BioConductor checks and shouldn't affect any other setup
if (!any(file.exists("~/.netrc", "~/_netrc"))) {
    labkey.netrc.file <- ImmuneSpaceR:::get_env_netrc()
    labkey.url.base <- ImmuneSpaceR:::get_env_url()
}

## ----CreateConnection, cache=FALSE, message=FALSE------------------------
library(ImmuneSpaceR)
sdy269 <- CreateConnection(study = "SDY269")
sdy269

## ----getDataset----------------------------------------------------------
sdy269$getDataset("hai")

## ----getDataset-filter, message = FALSE----------------------------------
library(Rlabkey)
myFilter <- makeFilter(c("gender", "EQUAL", "Female"))
hai <- sdy269$getDataset("hai", colFilter = myFilter)

## ----getGEMatrix---------------------------------------------------------
sdy269$getGEMatrix("SDY269_PBMC_LAIV_Geo")

## ----getGEMatrix-multiple------------------------------------------------
sdy269$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY269_PBMC_LAIV_Geo"))

## ----getGEMatrix-summary-------------------------------------------------
gs <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", outputType = "summary", annotation = "latest")

## ---- dev='png', fig.width=15--------------------------------------------
sdy269$plot("hai")

sdy269$plot("elisa")

## ---- cross-connection---------------------------------------------------
con <- CreateConnection("")

## ---- cross-connection-print---------------------------------------------
con

## ----cross-connection-qplot, dev='png', fig.align="center"---------------
plotFilter <- makeFilter(c("cohort", "IN", "TIV 2010;TIV Group 2008"))
con$plot("elispot", filter = plotFilter)

## ----sessionInfo---------------------------------------------------------
sessionInfo()

