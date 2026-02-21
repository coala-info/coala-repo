# Code example from 'User-Guide' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install_dep, eval=FALSE--------------------------------------------------
# # Install Bioconductor dependencies
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(c(
#     "SummarizedExperiment", "S4Vectors", "DESeq2", "DEXSeq",
#     "fgsea", "sva", "BiocParallel"))

## ----install_bioc, eval=FALSE-------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("pairedGSEA")

## ----install_github, eval=FALSE-----------------------------------------------
# # Install pairedGSEA from github
# devtools::install_github("shdam/pairedGSEA", build_vignettes = TRUE)

## ----setup--------------------------------------------------------------------
library("pairedGSEA")

# Defining plotting theme
ggplot2::theme_set(ggplot2::theme_classic(base_size = 20))

## Load data
# In this vignette we will use the included example Summarized Experiment.
# See ?example_se for more information about the data.
data("example_se") 

if(FALSE){ # Examples of other data imports
    # Example of count matrix
    tx_count <- read.csv("path/to/counts.csv") # Or other load function
    md_file <- "path/to/metadata.xlsx" # Can also be a .csv file or a data.frame
    
    # Example of locally stored DESeqDataSet
    dds <- readRDS("path/to/dds.RDS")
    
    # Example of locally stored SummarizedExperiment
    se <- readRDS("path/to/se.RDS")
}

## Experiment parameters
group_col <- "group_nr" # Column with the groups you would like to compare
sample_col <- "id" # Name of column that specifies the sample id of each sample.
# This is used to ensure the metadata and count data contains the same samples
# and to arrange the data according to the metadata
# (important for underlying tools)
baseline <- 1 # Name of baseline group
case <- 2 # Name of case group
experiment_title <- "TGFb treatment for 12h" # Name of your experiment. This is
# used in the file names that are stored if store_results is TRUE (recommended)


## ----metadata_check-----------------------------------------------------------
# Check if parameters above fit with metadaata
SummarizedExperiment::colData(example_se)


## ----sample_check-------------------------------------------------------------
# Check that all data samples are in the metadata
all(colnames(example_se) %in%
        SummarizedExperiment::colData(example_se)[[sample_col]])


## ----paired_diff--------------------------------------------------------------
set.seed(500) # For reproducible results

diff_results <- paired_diff(
    object = example_se,
    metadata = NULL, # Use with count matrix or if you want to change it in
    # the input object
    group_col = group_col,
    sample_col = sample_col,
    baseline = baseline,
    case = case,
    experiment_title = experiment_title,
    store_results = FALSE # Set to TRUE (recommended)  if you want
    # to store intermediate results, such as the results on transcript level 
    )


## ----extra_settings, eval=FALSE-----------------------------------------------
# covariates = NULL,
# run_sva = TRUE,
# use_limma = FALSE,
# prefilter = 10,
# fit_type = "local",
# test = "LRT",
# quiet = FALSE,
# parallel = TRUE,
# BPPARAM = BiocParallel::bpparam(),
# ...

## ----paied_ora----------------------------------------------------------------
# Define gene sets in your preferred way
gene_sets <- pairedGSEA::prepare_msigdb(
    species = "Homo sapiens", 
    collection = "C5", 
    gene_id_type = "ensembl_gene"
    )

ora <- paired_ora(
    paired_diff_result = diff_results,
    gene_sets = gene_sets,
    experiment_title = NULL # experiment_title - if not NULL,
    # the results will be stored in an RDS object in the 'results' folder
    )


## ----include=FALSE------------------------------------------------------------
# ignore. To fix build fails
if (sum(ora$padj_splicing < 0.05, na.rm = TRUE) < 20 ) {
    data("example_ora_results")
    ora <- example_ora_results
}


## ----ora_settings, eval=FALSE-------------------------------------------------
# cutoff = 0.05,
# min_size = 25,
# quiet = FALSE

## ----scatter------------------------------------------------------------------
# Scatter plot function with default settings
plot_ora(
    ora,
    paired = FALSE,
    plotly = FALSE,
    pattern = "Telomer", # Identify all gene sets about telomeres
    cutoff = 0.05, # Only include significant gene sets
    lines = TRUE # Guide lines
    )


## ----session info-------------------------------------------------------------
sessionInfo()

