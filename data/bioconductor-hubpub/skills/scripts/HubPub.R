# Code example from 'HubPub' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----bioconductor, eval = FALSE-----------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("HubPub")

## ----load, message = FALSE----------------------------------------------------
library(HubPub)

## ----create-------------------------------------------------------------------
fl <- tempdir()
create_pkg(file.path(fl, "examplePkg"), "ExperimentHub")

## ----resource-----------------------------------------------------------------
metadata <- hub_metadata(
    Title = "ENCODE",
    Description = "a test entry",
    BiocVersion = "4.1",
    Genome = NA_character_,
    SourceType = "JSON",
    SourceUrl = "http://www.encodeproject.org",
    SourceVersion = "x.y.z",
    Species = NA_character_,
    TaxonomyId = as.integer(9606),
    Coordinate_1_based = NA,
    DataProvider = "ENCODE Project",
    Maintainer = "tst person <tst@email.com>",
    RDataClass = "Rda",
    DispatchClass = "Rda",
    Location_Prefix = "s3://experimenthub/",
    RDataPath = "ENCODExplorerData/encode_df_lite.rda",
    Tags = "ENCODE:Homo sapiens"
)

add_resource(file.path(fl, "examplePkg"), metadata)

## ----read_metadata------------------------------------------------------------
resource <- file.path(fl, "examplePkg", "inst", "extdata", "metadata.csv")
tst <- read.csv(resource)
tst

## ----publish------------------------------------------------------------------
## For publishing directories with multiple files
fl <- tempdir()
utils::write.csv(mtcars, file = file.path(fl, "mtcars1.csv"))
utils::write.csv(mtcars, file = file.path(fl, "mtcars2.csv"))
publish_resource(fl, "test_dir")

## For publishing a single file
utils::write.csv(mtcars, file = file.path(fl, "mtcars3.csv"))
publish_resource(file.path(fl, "mtcars3.csv"), "test_dir")

## ----session_info-------------------------------------------------------------
sessionInfo()

