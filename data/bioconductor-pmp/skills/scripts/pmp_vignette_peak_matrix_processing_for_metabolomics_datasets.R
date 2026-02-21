# Code example from 'pmp_vignette_peak_matrix_processing_for_metabolomics_datasets' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("pmp")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(pmp)
library(SummarizedExperiment)
library(S4Vectors)

## ----eval=FALSE---------------------------------------------------------------
# help ("MTBLS79")

## -----------------------------------------------------------------------------
data(MTBLS79)
MTBLS79

## -----------------------------------------------------------------------------
sum(is.na(assay(MTBLS79)))
sum(is.na(assay(MTBLS79))) / length(assay(MTBLS79)) * 100

## -----------------------------------------------------------------------------
MTBLS79_filtered <- filter_samples_by_mv(df=MTBLS79, max_perc_mv=0.1)

MTBLS79_filtered

sum(is.na(assay(MTBLS79_filtered)))

## -----------------------------------------------------------------------------
MTBLS79_filtered <- filter_peaks_by_fraction(df=MTBLS79_filtered, min_frac=0.9, 
    classes=MTBLS79_filtered$Class, method="QC", qc_label="QC")

MTBLS79_filtered

sum(is.na(assay(MTBLS79_filtered)))

## -----------------------------------------------------------------------------
MTBLS79_filtered <- filter_peaks_by_fraction(df=MTBLS79_filtered, min_frac=0.9, 
    classes=MTBLS79_filtered$Class, method="across")

MTBLS79_filtered

sum(is.na(assay(MTBLS79_filtered)))

## -----------------------------------------------------------------------------
MTBLS79_filtered <- filter_peaks_by_rsd(df=MTBLS79_filtered, max_rsd=30, 
    classes=MTBLS79_filtered$Class, qc_label="QC")

MTBLS79_filtered

sum(is.na(assay(MTBLS79_filtered)))

## -----------------------------------------------------------------------------
processing_history(MTBLS79_filtered)

## -----------------------------------------------------------------------------
MTBLS79_pqn_normalised <- pqn_normalisation(df=MTBLS79_filtered, 
    classes=MTBLS79_filtered$Class, qc_label="QC")

## -----------------------------------------------------------------------------
MTBLS79_mv_imputed <- mv_imputation(df=MTBLS79_pqn_normalised,
    method="knn")

## -----------------------------------------------------------------------------
MTBLS79_glog <- glog_transformation(df=MTBLS79_mv_imputed,
    classes=MTBLS79_filtered$Class, qc_label="QC")

## ----plot_glog, fig.width=5---------------------------------------------------
opt_lambda <- 
    processing_history(MTBLS79_glog)$glog_transformation$lambda_opt
glog_plot_optimised_lambda(df=MTBLS79_mv_imputed,
    optimised_lambda=opt_lambda,
    classes=MTBLS79_filtered$Class, qc_label="QC")

## -----------------------------------------------------------------------------
peak_matrix <- t(assay(MTBLS79))
sample_classes <- MTBLS79$Class

class(peak_matrix)
dim(peak_matrix)
class(sample_classes)

## ----message=TRUE, warning=TRUE-----------------------------------------------
mv_imputed <- mv_imputation(df=peak_matrix, method="mn")
rsd_filtered <- filter_peaks_by_rsd(df=mv_imputed, max_rsd=30, 
    classes=sample_classes, qc_label="QC")

class (mv_imputed)
dim (mv_imputed)

class (rsd_filtered)
dim (rsd_filtered)

## -----------------------------------------------------------------------------
sessionInfo()

