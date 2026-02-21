# Code example from 'TPP2D' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
# install.packages("BiocManager")
# BiocManager::install("TPP2D")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("nkurzaw/TPP2D")

## ----Load, message=FALSE------------------------------------------------------
library(TPP2D)

## ----echo=FALSE, fig.cap="Experimental 2D-TPP workflow."----------------------
knitr::include_graphics("tpp_2d_schematic.jpg")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(TPP2D)

## -----------------------------------------------------------------------------
data("config_tab")
data("raw_dat_list")

config_tab

## ----warning=FALSE------------------------------------------------------------
import_df <- import2dDataset(
    configTable = config_tab,
    data = raw_dat_list,
    idVar = "protein_id",
    intensityStr = "signal_sum_",
    fcStr = "rel_fc_",
    nonZeroCols = "qusm",
    geneNameVar = "gene_name",
    addCol = NULL,
    qualColName = "qupm",
    naStrs = c("NA", "n/d", "NaN"),
    concFactor = 1e6,
    medianNormalizeFC = TRUE,
    filterContaminants = TRUE)

recomp_sig_df <- recomputeSignalFromRatios(import_df)

# resolve ambiguous protein names
preproc_df <- resolveAmbiguousProteinNames(recomp_sig_df)
# alternatively one could choose to run
# preproc_df <- resolveAmbiguousProteinNames(
#     recomp_sig_df, includeIsoforms = TRUE)

## ----echo=FALSE---------------------------------------------------------------
knitr::kable(tibble(
    column = colnames(recomp_sig_df),
    description = 
            c("protein identifier",
            "number of unique quantified peptides",
            "number of unique spectra",
            "gene name",
            "temperature incubated at",
            "experiment identifier",
            "TMT label",
            "RefCol",
            "treatment concentration",
            "raw reporter ion intensity sum",
            paste("raw relative fold change compared to",
                    "vehicle condition at the same temperature"),
            "log10 treatment concentration",
            "median normalized fold change",
            "recomputed reporter ion intensity",
            "recomputed log2 reporter ion intensity"),
    required = 
            c("Yes",
            "No",
            "No",
            "Yes",
            "Yes",
            "No",
            "No",
            "No",
            "No",
            "No",
            "No",
            "Yes",
            "No",
            "No",
            "Yes"))
)

## -----------------------------------------------------------------------------
model_params_df <- getModelParamsDf(
    df = preproc_df)

## -----------------------------------------------------------------------------
fstat_df <- computeFStatFromParams(model_params_df)

## -----------------------------------------------------------------------------
set.seed(12, kind = "L'Ecuyer-CMRG")
null_model <- bootstrapNullAlternativeModel(
    df = preproc_df,
    params_df = model_params_df,
    B = 2)

## ----warning=FALSE------------------------------------------------------------
fdr_tab <- getFDR( 
    df_out = fstat_df,
    df_null = null_model)

hits <- findHits(
    fdr_df = fdr_tab,
    alpha = 0.1)

hits %>% 
    dplyr::select(clustername, nObs, F_statistic, FDR)

## -----------------------------------------------------------------------------
plot2dTppVolcano(fdr_df = fdr_tab, hits_df = hits)

## -----------------------------------------------------------------------------
plot2dTppFit(recomp_sig_df, "tp1", 
             model_type = "H0",
             dot_size = 1,
             fit_color = "darkorange")

## -----------------------------------------------------------------------------
plot2dTppFit(recomp_sig_df, "tp1", 
             model_type = "H1",
             dot_size = 1,
             fit_color = "darkgreen")

## -----------------------------------------------------------------------------
plot2dTppFcHeatmap(recomp_sig_df, "tp1", 
                   drug_name = "drug X")

## -----------------------------------------------------------------------------
plot2dTppFcHeatmap(recomp_sig_df, "tp3", 
                   drug_name = "drug X")

## -----------------------------------------------------------------------------
sessionInfo()

