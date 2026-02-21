# Code example from 'EpiCompare' vignette. See references/ for full tutorial.

## ----setup_vignette-----------------------------------------------------------
library(EpiCompare)

## -----------------------------------------------------------------------------
data("encode_H3K27ac") # ENCODE ChIP-seq
data("CnT_H3K27ac") # CUT&Tag
data("CnR_H3K27ac") # CUT&Run
data("hg19_blacklist") # hg19 genome blacklist 
data("CnT_H3K27ac_picard") # CUT&Tag Picard summary output
data("CnR_H3K27ac_picard") # CUT&Run Picard summary output

## -----------------------------------------------------------------------------
peaklist <- list(CnT_H3K27ac, CnR_H3K27ac) # create list of peakfiles 
names(peaklist) <- c("CnT", "CnR") # set names 

## -----------------------------------------------------------------------------
# create list of Picard summary
picard <- list(CnT_H3K27ac_picard, CnR_H3K27ac_picard) 
names(picard) <- c("CnT", "CnR") # set names 

## -----------------------------------------------------------------------------
reference_peak <- list("ENCODE_H3K27ac" = encode_H3K27ac)

## -----------------------------------------------------------------------------
EpiCompare(peakfiles = peaklist,
           genome_build = "hg19",
           blacklist = hg19_blacklist,
           picard_files = picard,
           reference = reference_peak,
           upset_plot = FALSE,
           stat_plot = FALSE,
           chromHMM_plot = FALSE,
           chromHMM_annotation = "K562",
           chipseeker_plot = FALSE,
           enrichment_plot = FALSE,
           tss_plot = FALSE,
           interact = FALSE,
           save_output = FALSE,
           output_filename = "EpiCompare_test",
           output_timestamp = FALSE,
           output_dir = tempdir())

## ----Session_Info_vignette----------------------------------------------------
utils::sessionInfo()

