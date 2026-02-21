# Code example from 'vignette_exomes' vignette. See references/ for full tutorial.

## ----load_style, warning=FALSE, message=FALSE, results="hide"-----------------
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
current_sig_df <- AlexInitialArtif_sig_df
library(BSgenome.Hsapiens.UCSC.hg19)

## -----------------------------------------------------------------------------
data("smallCellLungCancerMutCat_NatureGenetics2012")

## ----loadLymphomaFtp, eval=FALSE----------------------------------------------
# smallCellLungCancer_NatureGenetics2012_ftp_path <- paste0(
#   "ftp://ftp.sanger.ac.uk/pub/cancer/AlexandrovEtAl/",
#   "somatic_mutation_data/Lung%20Small%20Cell/",
#   "Lung%20Small%20Cell_clean_somatic_mutations_for_signature_analysis.txt")
# exome_vcf_like_df <-
#   read.csv(file = smallCellLungCancer_NatureGenetics2012_ftp_path,
#            header=FALSE,sep="\t")
# names(exome_vcf_like_df) <- c("PID","TYPE","CHROM","START",
#                                        "STOP","REF","ALT","FLAG")
# exome_vcf_like_df <- subset(exome_vcf_like_df, TYPE == "subs",
#                             select = c(CHROM, START, REF, ALT, PID))
# names(exome_vcf_like_df)[2] <- "POS"
# exome_vcf_like_df <- translate_to_hg19(exome_vcf_like_df,"CHROM")
# word_length <- 3
# exome_mutCatRaw_list <-
#   create_mutation_catalogue_from_df(
#     exome_vcf_like_df,
#     this_seqnames.field = "CHROM", this_start.field = "POS",
#     this_end.field = "POS", this_PID.field = "PID",
#     this_subgroup.field = "SUBGROUP",
#     this_refGenome = BSgenome.Hsapiens.UCSC.hg19,
#     this_wordLength = 3)
# exome_mutCatRaw_df <- as.data.frame(exome_mutCatRaw_list$matrix)

## ----loadCorrectionFactors----------------------------------------------------
data(targetCapture_cor_factors)

## ----listCorrectionFactors----------------------------------------------------
names(targetCapture_cor_factors)

## ----correctTargetCapture-----------------------------------------------------
targetCapture <- "AgilentSureSelectAllExon"
cor_list <- targetCapture_cor_factors[[targetCapture]]
corrected_catalog_df <- normalizeMotifs_otherRownames(exome_mutCatRaw_df,
                                                        cor_list$rel_cor)

## ----optimalCutoffs-----------------------------------------------------------
data(cutoffs)
current_cutoff_vector <- cutoffCosmicValid_rel_df[6,]

## ----LCDwithCutoffs-----------------------------------------------------------
exome_listsList <-
  LCD_complex_cutoff_combined(
      in_mutation_catalogue_df = corrected_catalog_df,
      in_cutoff_vector = current_cutoff_vector, 
      in_signatures_df = AlexCosmicValid_sig_df, 
      in_sig_ind_df = AlexCosmicValid_sigInd_df)

## ----ExposuresCutoffsCap, echo=FALSE------------------------------------------
cap <- "Exposures barplot."

## ----exposuresCutoffs, warning=FALSE, fig.width=8, fig.height=6, fig.cap=cap----
exposures_barplot(
  in_exposures_df = exome_listsList$cohort$exposures,
  in_signatures_ind_df = exome_listsList$cohort$out_sig_ind_df)         

