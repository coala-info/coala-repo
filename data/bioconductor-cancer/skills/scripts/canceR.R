# Code example from 'canceR' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# sudo apt-get insall ("r-cran-tcltk2","r-cran-tkrplot")
# sudo apt-get install(Tk-table, BWidget)
# sudo apt-get install libcurl4-openssl-dev
# sudo apt-get install r-cran-xml

## ----eval=FALSE---------------------------------------------------------------
# install.packages("RCurl", "XML")
# install.packages(c("cgdsr","tkrplot","Formula","RCurl" ))

## ----eval=FALSE---------------------------------------------------------------
# library(biocManager)
# biocManegr::install("GSEABase", "GSEAlm","geNetClassifier","Biobase", "phenoTest")
# BiocManager::install("canceR")

## ----eval=FALSE---------------------------------------------------------------
# library(devtools)
# devtools::install_git("kmezhoud/canceR")

## ----eval=FALSE---------------------------------------------------------------
# library(canceR)
# canceR()

