# Code example from 'Rbec' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----CommunityProfiling, eval = TRUE------------------------------------------
library(Rbec)
fq <- system.file("extdata", "test_raw_merged_reads.fastq.gz", package="Rbec")

ref <- system.file("extdata", "test_ref.fasta", package="Rbec")

Rbec(fq, ref, tempdir(), 1, 500, 33)

## ----Contam_detect, eval = TRUE-----------------------------------------------
log_path <- list.files(paste(path.package("Rbec"), "extdata/contamination_test", sep="/"), recursive=TRUE, full.names=TRUE)
log_file <- tempfile()
writeLines(log_path, log_file)
Contam_detect(log_file, tempdir())

