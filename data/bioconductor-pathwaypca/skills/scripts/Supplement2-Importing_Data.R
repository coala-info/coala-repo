# Code example from 'Supplement2-Importing_Data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----packageLoad, message=FALSE-----------------------------------------------
library(tidyverse)
# Set tibble data frame print options
options(tibble.max_extra_cols = 10)

library(pathwayPCA)

## ----read_gmt-----------------------------------------------------------------
gmt_path <- system.file("extdata", "c2.cp.v6.0.symbols.gmt",
                         package = "pathwayPCA", mustWork = TRUE)
cp_pathwayCollection <- read_gmt(gmt_path, description = TRUE)

## ----pathwayCollection_structure----------------------------------------------
cp_pathwayCollection

## ----create_test_pathwayCollection--------------------------------------------
myPathways_ls <- list(
  pathway1 = c("Gene1", "Gene2"),
  pathway2 = c("Gene3", "Gene4", "Gene5"),
  pathway3 = "Gene6"
)
myPathway_names <- c(
  "KEGG_IMPORTANT_PATHWAY_1",
  "KEGG_IMPORTANT_PATHWAY_2",
  "SOME_OTHER_PATHWAY"
)
CreatePathwayCollection(
  sets_ls = myPathways_ls,
  TERMS = myPathway_names,
  website = "URL_TO_PATHWAY_CITATION"
)

## ----write_gmt, eval=FALSE----------------------------------------------------
# write_gmt(
#   pathwayCollection = cp_pathwayCollection,
#   file = "../test.gmt"
# )

## ----read_assay---------------------------------------------------------------
assay_path <- system.file("extdata", "ex_assay_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
assay_df <- read_csv(assay_path)

## ----assay_print--------------------------------------------------------------
assay_df

## ----transpose----------------------------------------------------------------
(assayT_df <- TransposeAssay(assay_df))

## ----subset_2ndrow------------------------------------------------------------
assayT_df[2, ]

## ----subset_3rdcol------------------------------------------------------------
assayT_df[, 3]

## ----subset_23----------------------------------------------------------------
assayT_df[2, 3, drop = TRUE]

## ----subset_3rdcol_byname-----------------------------------------------------
assayT_df$LSS

## ----stdExpr_Example, message=FALSE-------------------------------------------
library(SummarizedExperiment)
data(airway, package = "airway")

airway_df <- SE2Tidy(airway)

## -----------------------------------------------------------------------------
airway_df[, 1:20]

## ----read_pinfo---------------------------------------------------------------
pInfo_path <- system.file("extdata", "ex_pInfo_subset.csv",
                          package = "pathwayPCA", mustWork = TRUE)
pInfo_df <- read_csv(pInfo_path)

## ----pInfo--------------------------------------------------------------------
pInfo_df

## ----innerJoin----------------------------------------------------------------
joinedExperiment_df <- inner_join(pInfo_df, assayT_df, by = "Sample")
joinedExperiment_df

## ----tumour_data_load---------------------------------------------------------
data("colonSurv_df")
colonSurv_df

## ----pathway_list_load--------------------------------------------------------
data("colon_pathwayCollection")
colon_pathwayCollection

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

