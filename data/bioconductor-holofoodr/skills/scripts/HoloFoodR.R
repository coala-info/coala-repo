# Code example from 'HoloFoodR' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    cache = TRUE
)

## -----------------------------------------------------------------------------
# BiocManager::install("HoloFoodR")

## -----------------------------------------------------------------------------
library(HoloFoodR)

## -----------------------------------------------------------------------------
animals <- doQuery("animals", max.hits = 100)
animals <- animals[ animals[["histological"]], ]

colnames(animals) |> head()

## -----------------------------------------------------------------------------
animal_data <- getData(
    accession.type = "animals", accession = animals[["accession"]])

## -----------------------------------------------------------------------------
samples <- animal_data[["samples"]]

colnames(samples) |> head()

## -----------------------------------------------------------------------------
sample_ids <- unique(samples[["accession"]])

## -----------------------------------------------------------------------------
mae <- getResult(sample_ids)
mae

## -----------------------------------------------------------------------------
mae[[1]]

## -----------------------------------------------------------------------------
# library(MGnifyR)
# 
# mg <- MgnifyClient(useCache = TRUE)
# 
# # Get those samples that are metagenomic samples
# metagenomic_samples <- samples[
#     samples[["sample_type"]] == "metagenomic_assembly", ]
# 
# # Get analysis IDs based on sample IDs
# analysis_ids <- searchAnalysis(
#     mg, type = "samples", metagenomic_samples[["accession"]])

## -----------------------------------------------------------------------------
path <- system.file("extdata", "analysis_ids.rds", package = "HoloFoodR")
analysis_ids <- readRDS(path)

## -----------------------------------------------------------------------------
head(analysis_ids)

## -----------------------------------------------------------------------------
# mae_metagenomic <- MGnifyR::getResult(mg, analysis_ids)

## -----------------------------------------------------------------------------
path <- system.file("extdata", "mae_metagenomic.rds", package = "HoloFoodR")
mae_metagenomic <- readRDS(path)

## -----------------------------------------------------------------------------
mae_metagenomic

## -----------------------------------------------------------------------------
# # Get experiments from metagenomic data
# exps <- experiments(mae_metagenomic)
# # Convert analysis names to sample names
# exps <- lapply(exps, function(x){
#     # Get corresponding sample ID
#     sample_id <- names(analysis_ids)[ match(colnames(x), analysis_ids) ]
#     # Replace analysis ID with sample ID
#     colnames(x) <- sample_id
#     return(x)
# })
# 
# # Add to original MultiAssayExperiment
# mae <- c(experiments(mae), exps)
# mae

## -----------------------------------------------------------------------------
# # Get untargeted metabolomic samples
# samples <- doQuery("samples", sample_type = "metabolomic")
# # Get the data
# metabolomic <- getMetaboLights(samples[["metabolomics_url"]])
# 
# # Show names of data.frames
# names(metabolomic)

## -----------------------------------------------------------------------------
sessionInfo()

