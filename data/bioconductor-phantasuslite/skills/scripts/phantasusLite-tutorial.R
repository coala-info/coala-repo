# Code example from 'phantasusLite-tutorial' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("phantasusLite")

## ----message=FALSE, eval=FALSE------------------------------------------------
# library(devtools)
# install_github("ctlab/phantasusLite")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(GEOquery)
library(phantasusLite)

## ----message=FALSE------------------------------------------------------------
ess <- getGEO("GSE53053")
es <- ess[[1]]

## -----------------------------------------------------------------------------
head(exprs(es))

## -----------------------------------------------------------------------------
url <- 'https://alserglab.wustl.edu/hsds/?domain=/counts'
getHSDSFileList(url)

## -----------------------------------------------------------------------------
file <- "dee2/mmusculus_star_matrix_20240409.h5"
es <- loadCountsFromH5FileHSDS(es, url, file)
head(exprs(es))

## -----------------------------------------------------------------------------
es <- ess[[1]]
es <- loadCountsFromHSDS(es, url)
head(exprs(es))

## -----------------------------------------------------------------------------
preproc(experimentData(es))$gene_counts_source

## -----------------------------------------------------------------------------
head(fData(es))

## -----------------------------------------------------------------------------
es$title

## -----------------------------------------------------------------------------
es <- inferCondition(es)
print(es$condition)
print(es$replicate)

## -----------------------------------------------------------------------------
f <- file.path(tempdir(), "GSE53053.gct")
writeGct(es, f)

## -----------------------------------------------------------------------------
es2 <- readGct(f)
print(es2)

## -----------------------------------------------------------------------------
sessionInfo()

