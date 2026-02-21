# Code example from 'vignette_confidenceIntervals' vignette. See references/ for full tutorial.

## ----loadStyle, warning=FALSE, echo=FALSE, message=FALSE, results="hide"------
library(BiocStyle)

## ----packages, include=FALSE--------------------------------------------------
library(YAPSA)
library(Biostrings)
library(BSgenome.Hsapiens.UCSC.hg19)
library(knitr)
opts_chunk$set(echo=TRUE)
opts_chunk$set(fig.show='asis')

## ----loadStoredSigData--------------------------------------------------------
data(sigs)
data(cutoffs)
data("lymphomaNature2013_mutCat_df")
current_cutoff_vector <- cutoffCosmicValid_abs_df[6,]

## ----LCDwithCutoffs-----------------------------------------------------------
lymphoma_COSMIC_listsList <-
  LCD_complex_cutoff_combined(
      in_mutation_catalogue_df = lymphomaNature2013_mutCat_df,
      in_cutoff_vector = current_cutoff_vector, 
      in_signatures_df = AlexCosmicValid_sig_df, 
      in_sig_ind_df = AlexCosmicValid_sigInd_df)

## ----subrgroupAnnotation------------------------------------------------------
data(lymphoma_PID)
colnames(lymphoma_PID_df) <- "SUBGROUP"
lymphoma_PID_df$PID <- rownames(lymphoma_PID_df)
COSMIC_subgroups_df <- 
  make_subgroups_df(lymphoma_PID_df,
                    lymphoma_COSMIC_listsList$cohort$exposures)

## ----captionExposures, echo=FALSE---------------------------------------------
cap <- "Exposures to SNV mutational signatures"

## ----exposuresCutoffs, warning=FALSE, fig.width=8, fig.height=6, fig.cap= cap----
exposures_barplot(
  in_exposures_df = lymphoma_COSMIC_listsList$cohort$exposures,
  in_signatures_ind_df = lymphoma_COSMIC_listsList$cohort$out_sig_ind_df,
  in_subgroups_df = COSMIC_subgroups_df)               

## ----captionCI, echo=FALSE----------------------------------------------------
cap <- "Confidence interval calculation for exposures to mutational 
        signatures"

## ----computeCI, echo=TRUE, warning=FALSE--------------------------------------
complete_df <- variateExp(
  in_catalogue_df = lymphomaNature2013_mutCat_df,
  in_sig_df = lymphoma_COSMIC_listsList$cohort$signatures,
  in_exposures_df = lymphoma_COSMIC_listsList$cohort$exposures,
  in_sigLevel = 0.025, in_delta = 0.4)

## ----displayCompleteDf, echo=TRUE, warning=FALSE------------------------------
head(complete_df, 12)

## ----plotCI, echo=TRUE, warning=FALSE, fig.width=17, fig.height=15, fig.cap=cap----
plotExposuresConfidence(
  in_complete_df = complete_df, 
  in_subgroups_df = COSMIC_subgroups_df,
  in_sigInd_df = lymphoma_COSMIC_listsList$cohort$out_sig_ind_df)

