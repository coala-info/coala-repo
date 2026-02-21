# Code example from 'cfdnakit-vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.align = "center"
)

## ----install via BiocManager, eval=FALSE--------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("cfdnakit")

## ----install devtools and BiocManager, eval=FALSE-----------------------------
# if(! "devtools" %in% rownames(installed.packages()))
#     install.packages("devtools")
# if(! "BiocManager" %in% rownames(installed.packages()))
#     install.packages("BiocManager")

## ----install cfdnakit via github, eval=FALSE----------------------------------
# library(devtools)  ### use devtools
# install_github("Pitithat-pu/cfdnakit") ### install cfDNAKit

## ----load the package cfdnakit, eval=FALSE------------------------------------
# library(cfdnakit) ### Load cfdnakit package

## ----read a bam file and splited into 1000 KB non-overlapping bins, warning=FALSE----
library(cfdnakit)
sample_bamfile <- system.file("extdata",
                             "ex.plasma.bam",
                package = "cfdnakit")
plasma_SampleBam <- read_bamfile(sample_bamfile,
                                apply_blacklist = FALSE)

## ----save the file, eval=FALSE------------------------------------------------
# ### Optional
# saveRDS(plasma_SampleBam, file = "patientcfDNA_SampleBam.RDS")

## ----plot fragment length distribution, eval=FALSE----------------------------
# plot_fragment_dist(list("Plasma.Sample"=plasma_SampleBam))

## ----load example patient cfDNA sample BAM, warning=FALSE---------------------
example_RDS <- "example_patientcfDNA_SampleBam.RDS"
example_RDS_file <-
    system.file("extdata",example_RDS,
                package = "cfdnakit")
sample_bins <- readRDS(example_RDS_file)


## ----getting build-in healthy plasma cfDNA sample, warning=FALSE--------------
control_rds<-"BH01_CHR15.SampleBam.rds"
control_RDS_file <-
    system.file("extdata",control_rds,
                package = "cfdnakit")
control_bins <-
    readRDS(control_RDS_file)


## ----plot fragment length distribution comparing to a healthy cfDNA, fig.width=5.5, fig.height=4----
comparing_list <- list("Healthy.cfDNA"=control_bins,
                      "Patient.1"=sample_bins)
plot_fragment_dist(comparing_list)


## ----getting fragment length profile,warning=FALSE, fig.width=12, fig.height=5----
sample_profile <- 
  get_fragment_profile(sample_bins,
                       sample_id = "Patient.1")

## ----show sample profile------------------------------------------------------
sample_profile$sample_profile

## ----plot genome-wide short-fragment ratio, fig.width=12, fig.height=5, warning=FALSE----
## For this demenstration, we load a real patient-derived cfDNA profile.
patient.SampleFragment.file <-
    system.file("extdata",
                "example_patientcfDNA_SampleFragment.RDS",
                package = "cfdnakit")
patient.SampleFragment <- readRDS(patient.SampleFragment.file)
plot_sl_ratio(patient.SampleFragment)

## ----save SampleFragment Profile file,eval=FALSE------------------------------
# destination_dir <- "~/cfdnakit.result"
# saveRDS(sample_profile,
#         file = paste0(destination_dir,
#         "/plasma.SampleFragment.RDS"))

## ----create PoN profile, eval=FALSE-------------------------------------------
# PoN.profiles <- create_PoN("Path.to/Pon-list.txt")
# 
# saveRDS(PoN.profiles, "PoN.rds")

## ----Make a pon profile-------------------------------------------------------
PoN_rdsfile <- system.file("extdata",
                          "ex.PoN.rds",
                          package = "cfdnakit")

PoN.profiles <- readRDS(PoN_rdsfile)

## ----Reading PoN samples,warning=FALSE,fig.width=8, fig.height=4--------------
sample_zscore <- 
  get_zscore_profile(patient.SampleFragment,
                     PoN.profiles)

## ----Reading PoN samples and plot scaled value,warning=FALSE,fig.width=8, fig.height=4----
sample_zscore_segment <- segmentByPSCB(sample_zscore)

plot_transformed_sl(sample_zscore,sample_zscore_segment)

## ----cnv calling and plot distance matrix,warning=FALSE,fig.width=6, fig.height=4----
sample_cnv <- call_cnv(sample_zscore_segment,sample_zscore)

plot_distance_matrix(sample_cnv)

## ----get and print solution table---------------------------------------------
solution_table <- get_solution_table(sample_cnv)

solution_table

## ----plot cnv-calling first solution,warning=FALSE,fig.width=12, fig.height=5----
plot_cnv_solution(sample_cnv,selected_solution = 1)

## ----calculate CES score------------------------------------------------------
calculate_CES_score(sample_zscore_segment)

## ----session info-------------------------------------------------------------
sessionInfo()

