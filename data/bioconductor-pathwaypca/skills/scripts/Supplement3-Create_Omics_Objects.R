# Code example from 'Supplement3-Create_Omics_Objects' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----packageLoad, message=FALSE-----------------------------------------------
library(tidyverse)
library(pathwayPCA)

## ----tumour_data_load---------------------------------------------------------
data("colonSurv_df")
colonSurv_df

## ----pathway_list_load--------------------------------------------------------
data("colon_pathwayCollection")
colon_pathwayCollection
str(colon_pathwayCollection$pathways, list.len = 10)

## ----data_types---------------------------------------------------------------
# Original integer column
head(colonSurv_df$OS_event, 10)

# Integer to Character
head(as.character(colonSurv_df$OS_event), 10)

# Integer to Logical
head(as.logical(colonSurv_df$OS_event), 10)

# Integer to Factor
head(as.factor(colonSurv_df$OS_event), 10)

## ----create_OmicsSurv_object--------------------------------------------------
colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "surv"
)

## ----print_colonOmicsSurv-----------------------------------------------------
colon_OmicsSurv

## ----create_OmicsReg_object---------------------------------------------------
colon_OmicsReg <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:2],
  respType = "reg"
)
colon_OmicsReg

## ----create_OmicsCateg_object-------------------------------------------------
colon_OmicsCateg <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, c(1, 3)],
  respType = "categ"
)
colon_OmicsCateg

## ----getAssay_get-------------------------------------------------------------
getAssay(colon_OmicsSurv)

## ----getAssay_set-------------------------------------------------------------
getAssay(colon_OmicsSurv) <- colonSurv_df[, (3:12)]

## ----view_new_colon_OS--------------------------------------------------------
colon_OmicsSurv

## ----getAssay_set2------------------------------------------------------------
getAssay(colon_OmicsSurv) <- colonSurv_df[, -(1:2)]

## ----inspect_updated_pathwayCollection----------------------------------------
getPathwayCollection(colon_OmicsSurv)

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

