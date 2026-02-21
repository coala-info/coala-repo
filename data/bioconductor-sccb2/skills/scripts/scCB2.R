# Code example from 'scCB2' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("scCB2")
# 

## ----eval=FALSE---------------------------------------------------------------
# library(scCB2)
# 
# # If raw data has three separate files within one directory
# # and you want to control FDR at the default 1%:
# RealCell <-  QuickCB2(dir = "/path/to/raw/data/directory")
# 
# # If raw data is in HDF5 format and
# # you'd like a Seurat object under default FDR threshold:
# RealCell_S <-  QuickCB2(h5file = "/path/to/raw/data/HDF5",
#                         AsSeurat = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# DropletUtils::write10xCounts(path = "/path/to/save/data",
#                              x = RealCell)

## -----------------------------------------------------------------------------
library(scCB2)
library(SummarizedExperiment)

data(mbrainSub)

data.dir <- file.path(tempdir(),"CB2_example")
DropletUtils::write10xCounts(data.dir,
                             mbrainSub,
                             version = "3")

list.files(data.dir)

## -----------------------------------------------------------------------------
mbrainSub_2 <- Read10xRaw(data.dir)
identical(mbrainSub, mbrainSub_2)

## -----------------------------------------------------------------------------
check_cutoff <- CheckBackgroundCutoff(mbrainSub)
check_cutoff$summary_table
check_cutoff$recommended_cutoff

## -----------------------------------------------------------------------------
CBOut <- CB2FindCell(mbrainSub, FDR_threshold = 0.01, lower = 100, Ncores = 2)
str(assay(CBOut)) # cell matrix
str(metadata(CBOut)) # test statistics, p-values, etc

## -----------------------------------------------------------------------------
RealCell <- GetCellMat(CBOut, MTfilter = 0.25)
str(RealCell)

## -----------------------------------------------------------------------------
SeuratObj <- Seurat::CreateSeuratObject(counts = RealCell, 
                                        project = "mbrain_example")
SeuratObj

## -----------------------------------------------------------------------------
RealCell_Quick <- QuickCB2(dir = data.dir, Ncores = 2)
str(RealCell_Quick)

## -----------------------------------------------------------------------------
sessionInfo()

