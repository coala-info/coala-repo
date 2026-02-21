# Code example from 'scMultiome' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
# 
# BiocManager::install("scMultiome")
# 

## ----results = FALSE, message=FALSE-------------------------------------------
library(scMultiome)
listDatasets()

## ----results = 'asis', echo = FALSE-------------------------------------------
lds <- listDatasets()
knitr::kable(lds, caption = "Available Data Sets")


## -----------------------------------------------------------------------------
prostateENZ(metadata = TRUE)


## -----------------------------------------------------------------------------
tfBinding(genome = "hg38", source ="atlas", metadata = TRUE)

## ----devtoolsAvailable, eval = FALSE, include = FALSE-------------------------
# devtoolsAvailable <- requireNamespace("devtools", quietly = TRUE)
# 
# if (devtoolsAvailable) {
#     # attach development version of the package
#     devtools::load_all()
# }
# 

## ----saving, class.output = "scroll250", class.echo = "scroll250"-------------
# construct a dummy data set
mae <- dummyMAE()
mae

# name the file to save to
fileName <- tempfile(fileext = ".h5")

# save data set
saveMAE(mae, fileName)


## ----test reloading-----------------------------------------------------------
testFile(fileName)


## ----making metadata, eval = FALSE--------------------------------------------
# makeMakeMetadata(<DATASET_NAME>)

## ----build metadata, eval = FALSE---------------------------------------------
# source(system.file("scripts", "make-metadata.R", package = "scMultiome"))

## ----validation, eval = FALSE, class.output = "scroll250"---------------------
# ExperimentHubData::makeExperimentHubMetadata(dirname(system.file(package = "scMultiome")))

## ----making, eval = FALSE-----------------------------------------------------
# makeMakeData(<DATASET_NAME>)
# 

## ----making2, eval = FALSE----------------------------------------------------
# makeR("dataset")
# 

## ----documentation, eval = FALSE----------------------------------------------
# # build documentation
# devtools::document()
# 
# # view package man page
# ?scMultiome
# 
# # view your data set man page
# help("dataset")
# 

## ----DESCRIPTION, eval = FALSE------------------------------------------------
# desc::desc_add_author("<GIVEN_NAME>", "<FAMILY_NAME>", "<EMAIL>", role = "aut")
# desc::desc_bump_version("minor")
# 

## ----upload, eval = FALSE-----------------------------------------------------
# uploadFile(file = fileName, sasToken = "<SAS_TOKEN>")
# 

## -----------------------------------------------------------------------------
sessionInfo()

