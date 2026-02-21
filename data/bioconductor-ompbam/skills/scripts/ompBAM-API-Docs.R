# Code example from 'ompBAM-API-Docs' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ompBAM")

## ----eval=FALSE---------------------------------------------------------------
# install.packages(c("devtools", "usethis"))

## -----------------------------------------------------------------------------
library(ompBAM)
pkg_path = file.path(tempdir(), "MyPkg")
use_ompBAM(pkg_path)

## -----------------------------------------------------------------------------
devtools::document(pkg_path)

## -----------------------------------------------------------------------------
devtools::load_all(pkg_path)

## -----------------------------------------------------------------------------
library(MyPkg)

## -----------------------------------------------------------------------------
idxstats(ompBAM::example_BAM("Unsorted"), 2)

## -----------------------------------------------------------------------------
idxstats(ompBAM::example_BAM("scRNAseq"), 2)

## ----eval=FALSE---------------------------------------------------------------
# library(ompBAM)
# project_path = "\path\to\MyPkg"
# use_ompBAM(project_path)

## ----eval=FALSE---------------------------------------------------------------
# devtools::document()

## -----------------------------------------------------------------------------
library(ompBAM)
pkg_path = file.path(tempdir(), "myPkgName")
use_ompBAM(pkg_path)

## ----eval=FALSE---------------------------------------------------------------
# use_ompBAM("/path/to/myPkgName")

## ----eval=FALSE---------------------------------------------------------------
# #' @useDynLib myPkgName, .registration = TRUE
# #' @import Rcpp
# NULL
# 
# #' @export
# idxstats <- function(bam_file, n_threads) {
#     idxstats_pbam(bam_file, n_threads)
# }

## ----eval=FALSE---------------------------------------------------------------
# idxstats(ompBAM::example_BAM("Unsorted"), 2)

## ----eval=FALSE---------------------------------------------------------------
# # this is added to R/ompBAM_imports.R by use_ompBAM()
# 
# #' @export
# idxstats <- function(bam_file, n_threads) {
#   idxstats_pbam(bam_file, n_threads)
# }

## ----eval=FALSE---------------------------------------------------------------
# source_path = system.file("examples", "ompBAMExample", "src",
#     package = "ompBAM")

## -----------------------------------------------------------------------------
sessionInfo()

