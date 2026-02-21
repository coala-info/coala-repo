# Code example from 'lefser' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(comment = "#>", 
                      fig.align = "center",
                      collapse = FALSE, 
                      message = FALSE, 
                      warning = FALSE, 
                      eval = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("lefser")

## -----------------------------------------------------------------------------
library(lefser)

## -----------------------------------------------------------------------------
data(zeller14)
zeller14 <- zeller14[, zeller14$study_condition != "adenoma"]

## -----------------------------------------------------------------------------
## Contingency table
table(zeller14$age_category, zeller14$study_condition)

## ----eval=FALSE---------------------------------------------------------------
# lefser(zeller14, classCol = "study_condition", subclassCol = "age_category")

## -----------------------------------------------------------------------------
tn <- get_terminal_nodes(rownames(zeller14))
zeller14tn <- zeller14[tn,]

## -----------------------------------------------------------------------------
zeller14tn_ra <- relativeAb(zeller14tn)

## -----------------------------------------------------------------------------
set.seed(1234)
res <- lefser(zeller14tn_ra, # relative abundance only with terminal nodes
              classCol = "study_condition",
              subclassCol = "age_category")
head(res)

## -----------------------------------------------------------------------------
lefserPlot(res)

## ----warning=FALSE------------------------------------------------------------
library(phyloseq)
library(SummarizedExperiment)

## Load phyloseq object
fp <- system.file("extdata", 
                  "study_1457_split_library_seqs_and_mapping.zip",
                  package = "phyloseq")
kostic <- microbio_me_qiime(fp)

## Split data tables
counts <- unclass(otu_table(kostic))
coldata <- as(sample_data(kostic), "data.frame")

## Create a SummarizedExperiment object
SummarizedExperiment(assays = list(counts = counts), colData = coldata)

## -----------------------------------------------------------------------------
mia::makeTreeSummarizedExperimentFromPhyloseq(kostic)

## -----------------------------------------------------------------------------
sessionInfo()

