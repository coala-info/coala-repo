# Code example from 'Vig02-handling-metadata-and-annotations' vignette. See references/ for full tutorial.

## ----load-libraries, message=FALSE, warning=FALSE-----------------------------
library(dplyr)
library(readxl)
library(AlpsNMR)

## ----load-samples-------------------------------------------------------------
MeOH_plasma_extraction_dir <- system.file("dataset-demo", package = "AlpsNMR")
zip_files <- list.files(MeOH_plasma_extraction_dir, pattern = glob2rx("*.zip"), full.names = TRUE)
dataset <- nmr_read_samples(sample_names = zip_files)
dataset <- nmr_interpolate_1D(dataset, axis = NULL)
dataset

## -----------------------------------------------------------------------------
plot(dataset, chemshift_range = c(3.4, 3.6))

## -----------------------------------------------------------------------------
nmr_meta_groups(dataset)

## -----------------------------------------------------------------------------
acqus_metadata <- nmr_meta_get(dataset, groups = "acqus")
acqus_metadata

## -----------------------------------------------------------------------------
colnames(acqus_metadata)

## -----------------------------------------------------------------------------
acqus_metadata[, c("NMRExperiment", "acqus_NUC1")]

## -----------------------------------------------------------------------------
procs_metadata <- nmr_meta_get(dataset, groups = "procs")
procs_metadata


## -----------------------------------------------------------------------------
excel_file <- file.path(MeOH_plasma_extraction_dir, "dummy_metadata.xlsx")
subject_timepoint <- read_excel(excel_file, sheet = 1)
subject_timepoint

## -----------------------------------------------------------------------------
dataset <- nmr_meta_add(dataset, metadata = subject_timepoint, by = "NMRExperiment")

## -----------------------------------------------------------------------------
nmr_meta_get(dataset, groups = "external")

## -----------------------------------------------------------------------------
plot(dataset, color = "TimePoint", linetype = "SubjectID", chemshift_range = c(3.4, 3.6))

## -----------------------------------------------------------------------------
additional_annotations <- data.frame(
    NMRExperiment = c("10", "20", "30"),
    SampleCollectionDay = c(1, 91, 3)
)
additional_annotations

## -----------------------------------------------------------------------------
dataset <- nmr_meta_add(dataset, additional_annotations)

## -----------------------------------------------------------------------------
nmr_meta_get(dataset, groups = "external")

## -----------------------------------------------------------------------------
subject_related_information <- data.frame(
    SubjectID = c("Ana", "Elia"),
    Age = c(33, 3),
    Sex = c("female", "female")
)
subject_related_information

## -----------------------------------------------------------------------------
dataset <- nmr_meta_add(dataset, subject_related_information, by = "SubjectID")

## -----------------------------------------------------------------------------
nmr_meta_get(dataset, groups = "external")

## -----------------------------------------------------------------------------
plot(dataset, color = "SubjectID", linetype = "as.factor(Age)", chemshift_range = c(7.7, 7.8)) + ggplot2::labs(linetype = "Age")

## -----------------------------------------------------------------------------
sessionInfo()

