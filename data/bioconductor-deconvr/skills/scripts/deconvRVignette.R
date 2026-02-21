# Code example from 'deconvRVignette' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, 
                      error = FALSE,
                      warning = FALSE)
BiocStyle::markdown()
library(knitr)
library(deconvR)
library(doParallel)
library(dplyr)

cl <- parallel::makeCluster(2)
doParallel::registerDoParallel(cl)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("deconvR")

## ----message = FALSE, output.lines=10-----------------------------------------
library(deconvR) 

data("HumanCellTypeMethAtlas")
head(HumanCellTypeMethAtlas[,1:5])

## ----message = FALSE, output.lines=10-----------------------------------------
data("IlluminaMethEpicB5ProbeIDs")
head(IlluminaMethEpicB5ProbeIDs)

## ----message = FALSE, output.lines=10-----------------------------------------
samples <- simulateCellMix(3,reference = HumanCellTypeMethAtlas)$simulated
head(samples)

## ----message = FALSE, output.lines=10-----------------------------------------
sampleMeta <- data.table("Experiment_accession" = colnames(samples)[-1],
                         "Biosample_term_name" = "new cell type")
head(sampleMeta)

## ----output.lines=10----------------------------------------------------------
extended_matrix <- findSignatures(samples = samples, 
                                 sampleMeta = sampleMeta, 
                                 atlas = HumanCellTypeMethAtlas,
                                 IDs = "IDs")
head(extended_matrix)

## ----message = FALSE, output.lines=10-----------------------------------------
load(system.file("extdata", "WGBS_GRanges.rda",
                                     package = "deconvR"))
head(WGBS_GRanges)

## ----message = FALSE, output.lines=10-----------------------------------------
head(methylKit::methRead(system.file("extdata", "test1.myCpG.txt", 
                                     package = "methylKit"), 
                         sample.id="test", assembly="hg18", 
                         treatment=1, context="CpG", mincov = 0))

## ----message = FALSE, output.lines=10-----------------------------------------
data("IlluminaMethEpicB5ProbeIDs")
head(IlluminaMethEpicB5ProbeIDs)

## ----output.lines=10----------------------------------------------------------
mapped_WGBS_data <- BSmeth2Probe(probe_id_locations = IlluminaMethEpicB5ProbeIDs, 
                                 WGBS_data = WGBS_GRanges,
                                 multipleMapping = TRUE,
                                 cutoff = 10)
head(mapped_WGBS_data)

## -----------------------------------------------------------------------------
deconvolution <- deconvolute(reference = HumanCellTypeMethAtlas, 
                             bulk = mapped_WGBS_data)
deconvolution$proportions

## ----output.lines=10----------------------------------------------------------
data("HumanCellTypeMethAtlas")
exampleSamples <- simulateCellMix(1,reference = HumanCellTypeMethAtlas)$simulated
exampleMeta <- data.table("Experiment_accession" = "example_sample",
                          "Biosample_term_name" = "example_cell_type")
colnames(exampleSamples) <- c("CpGs", "example_sample")
colnames(HumanCellTypeMethAtlas)[1] <- c("CpGs")

signatures <- findSignatures(
  samples = exampleSamples,
  sampleMeta = exampleMeta,
  atlas = HumanCellTypeMethAtlas,
  IDs = "CpGs", K = 100, tissueSpecCpGs = TRUE)

print(head(signatures[[2]]))

## ----output.lines=10----------------------------------------------------------
data("HumanCellTypeMethAtlas")
exampleSamples <- simulateCellMix(1,reference = HumanCellTypeMethAtlas)$simulated
exampleMeta <- data.table("Experiment_accession" = "example_sample",
                          "Biosample_term_name" = "example_cell_type")
colnames(exampleSamples) <- c("CpGs", "example_sample")
colnames(HumanCellTypeMethAtlas)[1] <- c("CpGs")

signatures <- findSignatures(
  samples = exampleSamples,
  sampleMeta = exampleMeta,
  atlas = HumanCellTypeMethAtlas,
  IDs = "CpGs", tissueSpecDMPs = TRUE)

print(head(signatures[[2]]))

## -----------------------------------------------------------------------------
sessionInfo()
stopCluster(cl)

