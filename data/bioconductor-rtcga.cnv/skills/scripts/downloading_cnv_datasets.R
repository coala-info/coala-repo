# Code example from 'downloading_cnv_datasets' vignette. See references/ for full tutorial.

## ----echo=FALSE-------------------------------------------------------------------------------------------------------------------------------------
library(knitr)
opts_chunk$set(comment="", message=FALSE, warning = FALSE, tidy.opts=list(keep.blank.line=TRUE, width.cutoff=150),options(width=150), eval = FALSE)

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# if (!require(devtools)) {
#     install.packages("devtools")
#     require(devtools)
# }
# BiocManager::install("RTCGA/RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# browseVignettes("RTCGA")

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# library(RTCGA)
# checkTCGA('Dates')

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# (cohorts <- infoTCGA() %>%
#    rownames() %>%
#    sub("-counts", "", x=.))

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# #dir.create( "data/CNV2" )
# releaseDate <- "2015-11-01"
# for (cohort in cohorts) {
#   try(downloadTCGA( cancerTypes = cohort, destDir = "data/CNV2", date = releaseDate, dataSet = "Merge_snp__genome_wide_snp_6__broad_mit_edu__Level_3__segmented_scna_minus_germline_cnv_hg19__seg.Level_3" ),
#       silent=TRUE)
# }

## ----eval=FALSE-------------------------------------------------------------------------------------------------------------------------------------
# allCNVFiles <- list.files("data/CNV2", pattern = "cnv", recursive = TRUE, full.names = TRUE)
# for (CNVFile in allCNVFiles) {
#     CNV <- read.table(CNVFile,h=T)
# 
#     cohortName <- strsplit(strsplit(CNVFile, split = "/")[[1]][4], "\\.")[[1]][1]
#     name = paste0(cohortName, ".CNV")
#     assign(name, CNV)
#     save(list = name, file=paste0("data/CNV2/", name, ".rda"), compression_level = 9, compress = "xz")
# 
# }
# 

