# Code example from 'ObMiTi' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("ObMiTi")

## -----------------------------------------------------------------------------
# loading required libraries
library(ExperimentHub)
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
# query package resources on ExperimentHub
eh <- ExperimentHub()
query(eh, "ObMiTi")

# load data from ExperimentHub
ob_counts <- query(eh, "ObMiTi")[[1]] 

# print object
ob_counts

## -----------------------------------------------------------------------------
# print count matrix
assay(ob_counts)[1:5, 1:5]

## -----------------------------------------------------------------------------
#  View Structure of counts
str(colData(ob_counts))

# Studies' metadata available
names(colData(ob_counts))


# Sample GSM ID (Same ob_counts$geo_accession)
rownames(colData(ob_counts))

# Sample strain, tissue and diet ID
ob_counts$title

# Frequencies of different diets
table(ob_counts$diet.ch1)

# Frequncies of tissues
table(ob_counts$tissue.ch1)

# crosstable of tissue and diet and stratify by genotype
table(ob_counts$diet.ch1, ob_counts$tissue.ch1,ob_counts$genotype.ch1)


# Summarize Numeric data
summary(data.frame(colData(ob_counts)))

## -----------------------------------------------------------------------------
metadata(ob_counts)$measures

## -----------------------------------------------------------------------------
# print GRanges object
rowRanges(ob_counts)

## -----------------------------------------------------------------------------
se <- ob_counts[rowRanges(ob_counts)$biotype == 'protein_coding',]


## -----------------------------------------------------------------------------
plot(log(assay(se)[1:100,]))

## ----citation, warning=FALSE, eval=FALSE--------------------------------------
# #citing the package
# citation("ObMiTi")

## ----session_info-------------------------------------------------------------
devtools::session_info()

