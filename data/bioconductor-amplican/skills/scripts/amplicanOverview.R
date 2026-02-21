# Code example from 'amplicanOverview' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(amplican)
config <- system.file("extdata", "config.csv", package = "amplican")
config <- read.csv(config)
knitr::kable(head(config))

## ----configPath, echo=TRUE, eval=FALSE----------------------------------------
# system.file("extdata", "config.csv", package = "amplican")

## ----amplicanPipeline, echo=TRUE, eval=FALSE----------------------------------
# # path to example config file
# config <- system.file("extdata", "config.csv", package = "amplican")
# # path to example fastq files
# fastq_folder <- system.file("extdata", package = "amplican")
# # output folder, a full path
# results_folder <- tempdir()
# 
# #  run amplican
# amplicanPipeline(config, fastq_folder, results_folder)
# 
# # results of the analysis can be found at
# message(results_folder)

## ----echo=FALSE---------------------------------------------------------------
barcodeFilters <- system.file("extdata", "results", "barcode_reads_filters.csv", 
                              package = "amplican")
barcodeFilters <- read.csv(barcodeFilters)
knitr::kable(head(barcodeFilters))

## ----echo=FALSE---------------------------------------------------------------
config_summary <- system.file("extdata", "results", "config_summary.csv", 
                              package = "amplican")
config_summary <- read.csv(config_summary)
config_summary <- config_summary[, c("ID", "Barcode", "Reads", "Reads_Filtered",
                                     "Reads_In", "Reads_Del",
                                     "Reads_Edited", "Reads_Frameshifted")]
knitr::kable(head(config_summary))

## ----echo=TRUE----------------------------------------------------------------
# path to example RunParameters.txt
run_params <- system.file("extdata", "results", "RunParameters.txt", 
                          package = "amplican")
# show contents of the file
readLines(run_params) 

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# # path to the example alignments folder
# system.file("extdata", "results", "alignments", package = "amplican")

## ----echo=FALSE---------------------------------------------------------------
alignments <- system.file("extdata", "results", "alignments", 
                          "events_filtered_shifted_normalized.csv", 
                          package = "amplican")
alignments <- read.csv(alignments)
knitr::kable(head(alignments))

## ----echo=TRUE----------------------------------------------------------------
aln <- system.file("extdata", "results", "alignments", 
                   "AlignmentsExperimentSet.rds", 
                   package = "amplican")
aln <- readRDS(aln)
amplican::lookupAlignment(aln, ID = "ID_1") # will print most frequent alignment for ID_1

