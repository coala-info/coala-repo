# Code example from 'curatedTBData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----install curatedTBData, eval = FALSE--------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("curatedTBData")

## ----libraries, message=FALSE, warning=FALSE, results='hide'------------------
library(curatedTBData)
library(dplyr)
library(SummarizedExperiment)
library(sva)

## ----accessimg datasummary----------------------------------------------------
# Remove GeographicalRegion, Age, DiagnosisMethod, Notes, Tissue, HIVStatus for concise display
data("DataSummary", package = "curatedTBData")
DataSummary |>
  dplyr::select(-c(`Country/Region`, Age, DiagnosisMethod, Notes,
                   Tissue, HIVStatus)) |>
  DT::datatable()

## ----access data with dry.run-------------------------------------------------
curatedTBData("GSE19439", dry.run = TRUE, curated.only = FALSE)

## ----download full data for GSE19439, warning=FALSE---------------------------
GSE19439 <- curatedTBData("GSE19439", dry.run = FALSE, curated.only = FALSE)
GSE19439

## ----warning=FALSE------------------------------------------------------------
GSE79362 <- curatedTBData("GSE79362", dry.run = FALSE, curated.only = FALSE)
GSE79362

## ----access selected curated datasets microarray, warning=FALSE, results='hide'----
myGEO <- c("GSE19435", "GSE19439", "GSE19442", "GSE19444", "GSE22098")
object_list <- curatedTBData(myGEO, dry.run = FALSE, curated.only = TRUE)

## -----------------------------------------------------------------------------
object_list[1:2]

## ----ACS RNA-seq, warning=FALSE, results='hide'-------------------------------
GSE79362 <- curatedTBData("GSE79362", dry.run = FALSE, curated.only = FALSE)

## -----------------------------------------------------------------------------
GSE79362

## -----------------------------------------------------------------------------
GSE19439 <- object_list$GSE19439
GSE19439[, GSE19439$TBStatus == "PTB"]["assay_curated"] # 13 samples

## -----------------------------------------------------------------------------
GSE19439[, GSE19439$TBStatus %in% c("PTB", "LTBI")]["assay_curated"] # 30 samples

## -----------------------------------------------------------------------------
GSE19491 <- combine_objects(object_list, experiment_name = "assay_curated",
                            update_genes = TRUE)
GSE19491

## -----------------------------------------------------------------------------
unique(GSE19491$Study)

## ----commbine objects multiple experiment name--------------------------------
exp <- combine_objects(c(GSE79362[1], object_list[1]),
                       experiment_name = c("assay_reprocess_hg19",
                                           "assay_curated"),
                       update_genes = TRUE)
exp

## ----batch correction, message=FALSE------------------------------------------
batch1 <- colData(GSE19491)$Study
combat_edata1 <- sva::ComBat(dat = assay(GSE19491), batch = batch1)
assays(GSE19491)[["Batch_corrected_assay"]] <- combat_edata1
GSE19491

## ----subset active TB and LTBI, message=FALSE, warning=FALSE------------------
multi_set_PTB_LTBI <- lapply(object_list, function(x)
  subset_curatedTBData(x, annotationColName = "TBStatus",
                       annotationCondition = c("LTBI", "PTB"), 
                       assayName = "assay_curated"))
# Remove NULL from the list
multi_set_PTB_LTBI <- multi_set_PTB_LTBI[!sapply(multi_set_PTB_LTBI, is.null)]
multi_set_PTB_LTBI[1:3]

## ----subset patients with HIV, message=FALSE, warning=FALSE-------------------
multi_set_HIV <- lapply(object_list, function(x)
  subset_curatedTBData(x, annotationColName = "HIVStatus",
                       annotationCondition = "Negative",
                       assayName = "assay_curated"))
# Remove NULL from the list
multi_set_HIV <- multi_set_HIV[!vapply(multi_set_HIV, is.null, TRUE)]
multi_set_HIV[1:3]

## ----session info-------------------------------------------------------------
sessionInfo()

