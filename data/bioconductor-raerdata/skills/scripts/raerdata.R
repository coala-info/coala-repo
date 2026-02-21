# Code example from 'raerdata' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version = "devel")
# 
# BiocManager::install("raerdata")

## -----------------------------------------------------------------------------
library(raerdata)

## -----------------------------------------------------------------------------
rediportal_coords_hg38()

## -----------------------------------------------------------------------------
cds_sites <- gabay_sites_hg38()
cds_sites[1:4, 1:4]

## -----------------------------------------------------------------------------
NA12878()

## -----------------------------------------------------------------------------
GSE99249()

## -----------------------------------------------------------------------------
pbmc_10x()

## ----rows.print = 30, cols.print = 3------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
raerdata_files <- query(eh, "raerdata")
data.frame(
    id = raerdata_files$ah_id,
    title = raerdata_files$title,
    description = raerdata_files$description
)

## -----------------------------------------------------------------------------
sessionInfo()

