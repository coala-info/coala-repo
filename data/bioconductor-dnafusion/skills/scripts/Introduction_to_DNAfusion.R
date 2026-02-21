# Code example from 'Introduction_to_DNAfusion' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    tidy.opts = list(width.cutoff=100),
    tidy = FALSE,
    message = FALSE,
    collapse = TRUE,
    comment = "#>"
)

## ----pull_DNAfusion, message=FALSE, results = 'hide', echo = FALSE------------
library(DNAfusion)


## ----setup_bioconductor, message=FALSE, results = 'hide', eval = FALSE--------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("DNAfusion")
# library(DNAfusion)
# 

## ----examples-----------------------------------------------------------------
H3122_bam <- system.file("extdata", 
                            "H3122_EML4.bam",
                            package = "DNAfusion")
HCC827_bam <-  system.file("extdata", 
                            "HCC827_EML4.bam", 
                            package = "DNAfusion")


## ----EML4_ALK_detection2------------------------------------------------------
H3122_result <- EML4_ALK_detection(file = H3122_bam, 
                        genome = "hg38", 
                        mates = 2) 
head(H3122_result)


## ----EML4_ALK_detection3------------------------------------------------------
HCC827_result <- EML4_ALK_detection(file = HCC827_bam, 
                    genome = "hg38", 
                    mates = 2)
HCC827_result


## ----EML4_sequence------------------------------------------------------------
EML4_sequence(H3122_result, genome = "hg38", basepairs = 20)
EML4_sequence(HCC827_result, genome = "hg38", basepairs = 20)


## ----ALK_sequence-------------------------------------------------------------
ALK_sequence(H3122_result, genome = "hg38", basepairs = 20)
ALK_sequence(HCC827_result, genome = "hg38", basepairs = 20)


## ----break_position-----------------------------------------------------------
break_position(H3122_result, genome = "hg38", gene = "EML4")
break_position(HCC827_result, genome = "hg38", gene = "EML4")


## ----break_position_depth-----------------------------------------------------
break_position_depth(H3122_bam, H3122_result, genome = "hg38", gene = "EML4")
break_position_depth(HCC827_bam, HCC827_result, genome = "hg38", gene = "EML4")


## ----EML4_ALK_analysis_results, message=FALSE---------------------------------
H3122_results <- EML4_ALK_analysis(file = H3122_bam, 
                                    genome = "hg38", 
                                    mates = 2, 
                                    basepairs = 20)
HCC827_results <- EML4_ALK_analysis(file = HCC827_bam, 
                                    genome = "hg38", 
                                    mates = 2, 
                                    basepairs = 20)


## ----EML4_ALK_analysis_output1------------------------------------------------
head(H3122_results$clipped_reads)


## ----EML4_ALK_analysis_output2------------------------------------------------

H3122_results$last_EML4

H3122_results$first_ALK

H3122_results$breakpoint_ALK

H3122_results$breakpoint_EML4

H3122_results$read_depth_ALK

H3122_results$read_depth_EML4

HCC827_results


## ----introns_ALK_EML4_results, message=FALSE----------------------------------
introns_ALK_EML4(file=H3122_bam,genome="hg38")
introns_ALK_EML4(file=HCC827_bam,genome="hg38")

## ----ifind_variants_results, message=FALSE------------------------------------
find_variants(file=H3122_bam,genome="hg38")
find_variants(file=HCC827_bam,genome="hg38")

## ----session, echo = FALSE----------------------------------------------------
sessioninfo::session_info(
    pkgs = "attached",
    include_base = FALSE,
    dependencies = NA,
    to_file = FALSE
)


