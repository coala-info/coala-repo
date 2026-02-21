# Code example from 'BiFET' vignette. See references/ for full tutorial.

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# Load necessary libraries
suppressPackageStartupMessages(library(BiFET))
suppressPackageStartupMessages(library(GenomicRanges))
library(BiFET)
library(GenomicRanges)
peak_file <- system.file("extdata", "input_peak_motif.Rdata",
                         package = "BiFET")
load(peak_file)

# Display the first few rows and columns of the peak file
head(GRpeaks)


## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# Display the first few rows and columns of the motif file
head(GRmotif)

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
# call the function “calculate_enrich_p” to return a list of 
# parameter alpha_k, enrichment p values from BiFET algorithm 
  # and enrichment p values from the hypergeometric test :
result <- calculate_enrich_p(GRpeaks, GRmotif)
head(result)

