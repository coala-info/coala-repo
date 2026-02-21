# Code example from 'reanalysing-public-data' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# if (!require(ReactomeGSA))
#   BiocManager::install("ReactomeGSA")

## -----------------------------------------------------------------------------
library(ReactomeGSA)

# get all available species found in the datasets
all_species <- get_public_species()

head(all_species)

## -----------------------------------------------------------------------------
# search for datasets on BRAF and melanoma
datasets <- find_public_datasets("melanoma BRAF")

# the function returns the found datasets as a data.frame
datasets[1:4, c("id", "title")]

## -----------------------------------------------------------------------------
# find the correct entry in the search result
# this must be the complete row of the data.frame returned
# by the find_public_datasets function
dataset_search_entry <- datasets[datasets$id == "E-MTAB-7453", ]

str(dataset_search_entry)

## -----------------------------------------------------------------------------
# this function only takes one argument, which must be
# a single row from the data.frame returned by the
# find_public_datasets function
mel_cells_braf <- load_public_dataset(dataset_search_entry, verbose = TRUE)

## -----------------------------------------------------------------------------
# use the biobase functions to access the metadata
library(Biobase)

# basic metadata
pData(mel_cells_braf)

## -----------------------------------------------------------------------------
# access the stored metadata using the experimentData function
experimentData(mel_cells_braf)

# for some datasets, longer descriptions are available. These
# can be accessed using the abstract function
abstract(mel_cells_braf)

## -----------------------------------------------------------------------------
table(mel_cells_braf$compound)

## -----------------------------------------------------------------------------
# create the analysis request
my_request <-ReactomeAnalysisRequest(method = "Camera")

# do not create a visualization for this example
my_request <- set_parameters(request = my_request, create_reactome_visualization = FALSE)

# add the dataset using the loaded object
my_request <- add_dataset(request = my_request, 
                          expression_values = mel_cells_braf, 
                          name = "E-MTAB-7453", 
                          type = "rnaseq_counts",
                          comparison_factor = "compound", 
                          comparison_group_1 = "PLX4720", 
                          comparison_group_2 = "none")

my_request

## -----------------------------------------------------------------------------
# perform the analysis using ReactomeGSA
res <- perform_reactome_analysis(my_request)

# basic overview of the result
print(res)

# key pathways
res_pathways <- pathways(res)

head(res_pathways)

## -----------------------------------------------------------------------------
sessionInfo()

