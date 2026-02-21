# Code example from 'cgc-datasets' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(eval = FALSE, echo = TRUE)

## -----------------------------------------------------------------------------
# library("sevenbridges")
# # create an Auth object
# a <- Auth(
#   url = "https://cgc-datasets-api.sbgenomics.com/",
#   token = "your_cgc_token"
# )
# a$api(path = "datasets")

## -----------------------------------------------------------------------------
# a <- Auth(
#   url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0",
#   token = "your_cgc_token"
# )
# (res <- a$api()) # default method is GET
# # list all resources/entities
# names(res$"_links")

## -----------------------------------------------------------------------------
# (res <- a$api(path = "files"))

## -----------------------------------------------------------------------------
# a$api(path = "files/schema")

## -----------------------------------------------------------------------------
# (res <- a$api(path = "files"))
# 
# get_id <- function(obj) sapply(obj$"_embedded"$files, function(x) x$id)
# ids <- get_id(res)
# 
# # create CGC auth
# a_cgc <- Auth(platform = "cgc", token = a$token)
# a_cgc$copyFile(id = ids, project = "RFranklin/tcga-demo")

## -----------------------------------------------------------------------------
# body <- list(
#   entity = "samples",
#   hasCase = "0004D251-3F70-4395-B175-C94C2F5B1B81"
# )
# a$api(path = "query", body = body, method = "POST")

## -----------------------------------------------------------------------------
# a$api(path = "query/total", body = body, method = "POST")

## -----------------------------------------------------------------------------
# httr::content(
#   api(
#     token = a$token,
#     base_url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0/samples/9259E9EE-7279-4B62-8512-509CB705029C"
#   )
# )

## -----------------------------------------------------------------------------
# body <- list(
#   "entity" = "cases",
#   "hasAgeAtDiagnosis" = list(
#     "filter" = list(
#       "gt" = 10,
#       "lt" = 50
#     )
#   )
# )
# a$api(path = "query", body = body, method = "POST")

## -----------------------------------------------------------------------------
# body <- list(
#   "entity" = "cases",
#   "hasAgeAtDiagnosis" = list(
#     "filter" = list(
#       "gt" = 10,
#       "lt" = 50
#     )
#   ),
#   "hasDiseaseType" = "Kidney Chromophobe"
# )
# a$api(path = "query", body = body, method = "POST")

## -----------------------------------------------------------------------------
# body <- list(
#   "entity" = "cases",
#   "hasSample" = list(
#     "hasSampleType" = "Primary Tumor",
#     "hasPortion" = list(
#       "hasPortionNumber" = 11
#     )
#   ),
#   "hasNewTumorEvent" = list(
#     "hasNewTumorAnatomicSite" = c("Liver", "Pancreas"),
#     "hasNewTumorEventType" = list(
#       "filter" = list(
#         "contains" = "Recurrence"
#       )
#     )
#   )
# )
# a$api(path = "query", body = body, method = "POST")

## -----------------------------------------------------------------------------
# httr::content(
#   api(
#     token = a$token,
#     base_url = "https://cgc-datasets-api.sbgenomics.com/datasets/tcga/v0/cases/0004D251-3F70-4395-B175-C94C2F5B1B81"
#   )
# )

## -----------------------------------------------------------------------------
# get_id <- function(obj) sapply(obj$"_embedded"$files, function(x) x$id)
# names(res)
# 
# body <- list(
#   "entity" = "cases",
#   "hasSample" = list(
#     "hasSampleType" = "Primary Tumor",
#     "hasPortion" = list(
#       "hasPortionNumber" = 11,
#       "hasID" = "TCGA-DD-AAVP-01A-11"
#     )
#   ),
#   "hasNewTumorEvent" = list(
#     "hasNewTumorAnatomicSite" = "Liver",
#     "hasNewTumorEventType" = "Intrahepatic Recurrence"
#   )
# )
# 
# (res <- a$api(path = "files", body = body))
# get_id(res)

