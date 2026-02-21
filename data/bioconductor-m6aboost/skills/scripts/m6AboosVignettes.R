# Code example from 'm6AboosVignettes' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'----------------------------------------
BiocStyle::markdown()

## ----BiocManager, eval=FALSE--------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("m6Aboost")

## ----initialize, results="hide", warning=FALSE, message=FALSE-----------------
library(m6Aboost)

## ----echo=TRUE, warning=FALSE, message=FALSE----------------------------------
library(m6Aboost)
## Load the test data
testpath <- system.file("extdata", package = "m6Aboost")
test_gff3 <- file.path(testpath, "test_annotation.gff3")
test <- readRDS(file.path(testpath, "test.rds"))

test

## ----eval=TRUE, include=TRUE--------------------------------------------------
## truncationAssignment allows to assign the number of truncation events
## The input should be a GRanges object with the peaks and bigWig files
## with the truncation events (separated per strand)
truncationBw_p <- file.path(testpath, "truncation_positive.bw")
truncationBw_n <- file.path(testpath, "truncation_negative.bw")

test <- truncationAssignment(test, 
    bw_positive=truncationBw_p,
    bw_negative=truncationBw_n,
    sampleName = "WT1")

## CtoTAssignment allows to assign the number of C-to-T transitions
ctotBw_p <- file.path(testpath, "C2T_positive.bw")
ctotBw_n <- file.path(testpath, "C2T_negative.bw")
test <- CtoTAssignment(test, 
    bw_positive=ctotBw_p,
    bw_negative=ctotBw_n,
    sampleName = "CtoT_WT1")

## ----eval=FALSE, include=TRUE-------------------------------------------------
# ## E.g. for two replicates, this can be calculated as
# peak$WTmean <- (peak$WT1 + peak$WT2)/2

## -----------------------------------------------------------------------------
## Extract the features for the m6Aboost prediction
test <- preparingData(test, test_gff3, colname_reads="WTmean", 
    colname_C2T="CtoTmean")
test

## ----warning=FALSE, message=FALSE---------------------------------------------
## Note that since the test data set contains only a tiny fraction of the real 
## data, and a part of the test data belongs to the training set. Here for 
## preventing the unnecessary value change, we set the normalization to FALSE. 
out <- m6Aboost(test, "BSgenome.Mmusculus.UCSC.mm10", normalization = FALSE)
out

## ----echo=TRUE, message=FALSE-------------------------------------------------
## firstly user need to load the ExperimentHub
library(ExperimentHub)
eh <- ExperimentHub()
## "EH6021" is the retrieve record of the m6Aboost
model <-  eh[["EH6021"]]
## here shows more information about the stored model
query(eh, "m6Aboost")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

