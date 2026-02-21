# Code example from 'getGEMatrix' vignette. See references/ for full tutorial.

## ----knitr, echo = FALSE-------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE, cache = FALSE)

## ----netrc_req, echo = FALSE---------------------------------------------
# This chunk is only useful for BioConductor checks and shouldn't affect any other setup
if (!any(file.exists("~/.netrc", "~/_netrc"))) {
    labkey.netrc.file <- ImmuneSpaceR:::get_env_netrc()
    labkey.url.base <- ImmuneSpaceR:::get_env_url()
}

## ----CreateConection, cache=FALSE, message = FALSE-----------------------
library(ImmuneSpaceR)
sdy269 <- CreateConnection("SDY269")
all <- CreateConnection("")

## ----listDatasets--------------------------------------------------------
sdy269$listDatasets()

## ----listDatasets-which--------------------------------------------------
all$listDatasets(output = "expression")

## ----getGEMatrix---------------------------------------------------------
TIV_2008 <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo")
TIV_2011 <- all$getGEMatrix(matrixName = "SDY144_Other_TIV_Geo")

## ----ExpressionSet-------------------------------------------------------
TIV_2008

## ----getGEMatrix-cohorts-------------------------------------------------
LAIV_2008 <- sdy269$getGEMatrix(cohortType = "LAIV group 2008_PBMC")

## ----summary-------------------------------------------------------------
TIV_2008_sum <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", outputType = "summary", annotation = "latest")

## ----summary-print-------------------------------------------------------
TIV_2008_sum

## ----multi---------------------------------------------------------------
# Within a study
em269 <- sdy269$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY269_PBMC_LAIV_Geo"))

# Combining across studies
TIV_seasons <- all$getGEMatrix(c("SDY269_PBMC_TIV_Geo", "SDY144_Other_TIV_Geo"),
                               outputType = "summary",
                               annotation = "latest")

## ----caching-dataset-----------------------------------------------------
names(sdy269$cache)

## ----caching-reload------------------------------------------------------
TIV_2008 <- sdy269$getGEMatrix("SDY269_PBMC_TIV_Geo", reload = TRUE)

## ----caching-clear-------------------------------------------------------
sdy269$clearCache()

## ----sessionInfo---------------------------------------------------------
sessionInfo()

