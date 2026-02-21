# Code example from 'vignette_planttfhunter' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----"install", eval = FALSE--------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#       install.packages("BiocManager")
#   }
# 
# BiocManager::install("planttfhunter")

## ----load_package, message = FALSE--------------------------------------------
library(planttfhunter)

## ----data---------------------------------------------------------------------
data(gsu)
gsu

## ----scheme, echo = FALSE-----------------------------------------------------
data(classification_scheme)
knitr::kable(classification_scheme)

## ----identifying_tfs----------------------------------------------------------
data(gsu_annotation)

# Annotate TF-related domains using a local installation of HMMER
if(hmmer_is_installed()) {
  gsu_annotation <- annotate_pfam(gsu)
} 

# Take a look at the first few lines of the output
head(gsu_annotation)

## ----classifying_tfs----------------------------------------------------------
# Classify TFs into families
gsu_families <- classify_tfs(gsu_annotation)

# Take a look at the output
head(gsu_families)

# Count number of TFs per family
table(gsu_families$Family)

## ----simulate_data_proteomes--------------------------------------------------
set.seed(123) # for reproducibility

# Simulate 4 different species by sampling 100 random genes from `gsu`
proteomes <- list(
    Gsu1 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu2 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu3 = gsu[sample(names(gsu), 50, replace = FALSE)],
    Gsu4 = gsu[sample(names(gsu), 50, replace = FALSE)]
)
proteomes

## ----simulate_data_species_metadata-------------------------------------------
# Create simulated species metadata
species_metadata <- data.frame(
    row.names = names(proteomes),
    Division = "Rhodophyta",
    Origin = c("US", "Belgium", "China", "Brazil")
)

species_metadata

## ----get_tf_counts------------------------------------------------------------
data(tf_counts)

# Get TF counts per family in each species as a SummarizedExperiment object
if(hmmer_is_installed()) {
    tf_counts <- get_tf_counts(proteomes, species_metadata)
}

# Take a look at the SummarizedExperiment object
tf_counts

# Look at the matrix of counts: assay() function from SummarizedExperiment
SummarizedExperiment::assay(tf_counts)

# Look at the species metadata: colData() function from SummarizedExperiment
SummarizedExperiment::colData(tf_counts)

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

