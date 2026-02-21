# Code example from 'vignette_signature_specific_cutoffs' vignette. See references/ for full tutorial.

## ----loadStyle, warning=FALSE, echo=FALSE, message=FALSE, results="hide"------
library(BiocStyle)

## ----packages, include=FALSE--------------------------------------------------
library(YAPSA)
library(knitr)
library(gridExtra)
library(dplyr)
opts_chunk$set(echo=TRUE)
opts_chunk$set(fig.show='asis')

## ----loadSignatures-----------------------------------------------------------
data(sigs)
data(sigs_pcawg)

## ----loadCutoffs--------------------------------------------------------------
data(cutoffs)
data(cutoffs_pcawg)

## ----cutoffExample------------------------------------------------------------
data(cutoffs)
current_cutoff_vector <- cutoffCosmicValid_abs_df[6, ]
current_cutoff_vector

## ----loadData-----------------------------------------------------------------
data(lymphomaNature2013_mutCat_df)

## ----setVariables-------------------------------------------------------------
current_sig_df <- AlexCosmicValid_sig_df
current_sigInd_df <- AlexCosmicValid_sigInd_df

## ----cutoffVector-------------------------------------------------------------
current_cutoff_vector <- rep(0, dim(AlexCosmicValid_sig_df)[2])

## ----lymphomaCohortLCD_results------------------------------------------------
lymphoma_COSMIC_zero_listsList <-
  LCD_complex_cutoff_combined(
    in_mutation_catalogue_df = lymphomaNature2013_mutCat_df,
    in_cutoff_vector = current_cutoff_vector, 
    in_signatures_df = current_sig_df, 
    in_sig_ind_df = current_sigInd_df)

## ----subrgroupAnnotation------------------------------------------------------
data(lymphoma_PID)
colnames(lymphoma_PID_df) <- "SUBGROUP"
lymphoma_PID_df$PID <- rownames(lymphoma_PID_df)
COSMIC_subgroups_df <- 
  make_subgroups_df(lymphoma_PID_df,
                    lymphoma_COSMIC_zero_listsList$cohort$exposures)

## ----captionBarplot2, echo=FALSE----------------------------------------------
cap <- "Absoute exposures of the COSMIC signatures in the lymphoma mutational
        catalogs, signature-specific cutoffs with a cost factor of 6 used
        for the LCD"

## ----exposuresZero, warning=FALSE, fig.width=8, fig.height=6, fig.cap = cap----
result_cohort <- lymphoma_COSMIC_zero_listsList$cohort
exposures_barplot(
  in_exposures_df = result_cohort$exposures,
  in_signatures_ind_df = result_cohort$out_sig_ind_df,
  in_subgroups_df = COSMIC_subgroups_df)        

## ----setSignatureSpecificCutoffs----------------------------------------------
current_cutoff_df <- cutoffCosmicValid_abs_df
current_cost_factor <- 6
current_cutoff_vector <- current_cutoff_df[current_cost_factor,]

## ----LCDwithCutoffs-----------------------------------------------------------
lymphoma_COSMIC_listsList <-
  LCD_complex_cutoff_combined(
      in_mutation_catalogue_df = lymphomaNature2013_mutCat_df,
      in_cutoff_vector = current_cutoff_vector, 
      in_signatures_df = current_sig_df, 
      in_sig_ind_df = current_sigInd_df)

## ----captionBarplot, echo=FALSE-----------------------------------------------
cap <- "Absolute exposures of the COSMIC signatures in the lymphoma mutational
        catalogs, signature-specific cutoffs with a cost factor of 6 used
        for the LCD"

## ----exposuresCutoffs, warning=FALSE, fig.width=8, fig.height=6, fig.cap= cap----
result_cohort <- lymphoma_COSMIC_listsList$cohort
exposures_barplot(
  in_exposures_df = result_cohort$exposures,
  in_signatures_ind_df = result_cohort$out_sig_ind_df,
  in_subgroups_df = COSMIC_subgroups_df)               

