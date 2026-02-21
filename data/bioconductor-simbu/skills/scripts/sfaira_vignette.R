# Code example from 'sfaira_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(SimBu)

## ----eval=FALSE---------------------------------------------------------------
# setup_list <- SimBu::setup_sfaira(basedir = tempdir())

## ----eval=FALSE---------------------------------------------------------------
# ds_pancrease <- SimBu::dataset_sfaira_multiple(
#   sfaira_setup = setup_list,
#   organisms = "Homo sapiens",
#   tissues = "pancreas",
#   name = "human_pancreas"
# )

## ----eval=FALSE---------------------------------------------------------------
# all_datasets <- SimBu::sfaira_overview(setup_list = setup_list)
# head(all_datasets)

## ----eval=FALSE---------------------------------------------------------------
# SimBu::dataset_sfaira(
#   sfaira_id = "homosapiens_lungparenchyma_2019_10x3v2_madissoon_001_10.1186/s13059-019-1906-x",
#   sfaira_setup = setup_list,
#   name = "dataset_by_id"
# )

## -----------------------------------------------------------------------------
utils::sessionInfo()

