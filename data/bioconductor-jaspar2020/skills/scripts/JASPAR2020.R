# Code example from 'JASPAR2020' vignette. See references/ for full tutorial.

## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- echo=FALSE, results="hide", warning=FALSE-------------------------------
suppressPackageStartupMessages({
  library(JASPAR2020)
  library(TFBSTools)
})

## ----setup--------------------------------------------------------------------
library(JASPAR2020)
library(TFBSTools)


## ----example_name_id, tidy=TRUE-----------------------------------------------

## the user assigns a single matrix ID to the argument ID 
pfm <- getMatrixByID(JASPAR2020, ID="MA0139.1")
## the function returns a PFMatrix object
pfm

## ----seq_logo-----------------------------------------------------------------
seqLogo(toICM(pfm))

## ----multiple_matrix_id-------------------------------------------------------
## the user assigns multiple matrix IDs to the argument ID 
pfmList <- getMatrixByID(JASPAR2020, ID=c("MA0139.1", "MA1102.1"))
## the function returns a PFMatrix object
pfmList

## PFMatrixList can be subsetted to extract enclosed PFMatrix objects
pfmList[[2]]

## ----getMatrixByName_example--------------------------------------------------
pfm <- getMatrixByName(JASPAR2020, name="Arnt")
pfm

pfmList <- getMatrixByName(JASPAR2020, name=c("Arnt", "Ahr::Arnt"))
pfmList


## ----example_set, tidy=TRUE---------------------------------------------------

## select all matrices found in a specific species and constructed from the SELEX experiment
opts <- list()
opts[["species"]] <- 9606
opts[["type"]] <- "SELEX"
opts[["all_versions"]] <- TRUE
PFMatrixList <- getMatrixSet(JASPAR2020, opts)
PFMatrixList

## retrieve all matrices constructed from SELEX experiment
opts2 <- list()
opts2[["type"]] <- "SELEX"
PFMatrixList2 <- getMatrixSet(JASPAR2020, opts2)
PFMatrixList2

## ----session_info, echo=FALSE-------------------------------------------------
sessionInfo()

