# Code example from 'vignette_02_assessing_orthogroup_inference' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL,
    dpi = 100
)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# BiocManager::install("cogeqc")

## ----load_package, message=FALSE----------------------------------------------
# Load package after installation
library(cogeqc)

## ----data_description---------------------------------------------------------
# Orthogroups for Arabidopsis thaliana and Brassica oleraceae
data(og)
head(og)

# Interpro domain annotations
data(interpro_ath)
data(interpro_bol)

head(interpro_ath)
head(interpro_bol)

## ----read_orthogroups_demo----------------------------------------------------
# Path to the Orthogroups.tsv file created by OrthoFinder
og_file <- system.file("extdata", "Orthogroups.tsv.gz", package = "cogeqc") 

# Read and parse file
orthogroups <- read_orthogroups(og_file)
head(orthogroups)

## ----assess_og----------------------------------------------------------------
# Create a list of annotation data frames
annotation <- list(Ath = interpro_ath, Bol = interpro_bol)
str(annotation) # This is what the list must look like

og_assessment <- assess_orthogroups(og, annotation)
head(og_assessment)

## ----mean_h-------------------------------------------------------------------
mean(og_assessment$Mean_score)

## ----ref-based_og_assessment--------------------------------------------------
set.seed(123)

# Subset the top 5000 rows for demonstration purposes
og_subset <- og[1:5000, ]
ref <- og_subset

# Shuffle 100 genes to simulate a test set
idx_shuffle <- sample(seq_len(nrow(og_subset)), 100, replace = FALSE)
test <- og_subset
test$Gene[idx_shuffle] <- sample(
  test$Gene[idx_shuffle], size = length(idx_shuffle), replace = FALSE
)

# Compare test set to reference set
comparison <- compare_orthogroups(ref, test)
head(comparison)

# Calculating percentage of preservation
preserved <- sum(comparison$Preserved) / length(comparison$Preserved)
preserved

## -----------------------------------------------------------------------------
stats_dir <- system.file("extdata", package = "cogeqc")
ortho_stats <- read_orthofinder_stats(stats_dir)
ortho_stats

## ----plot_species_tree--------------------------------------------------------
data(tree)
plot_species_tree(tree)

## ----plot_species_tree_with_dups----------------------------------------------
plot_species_tree(tree, stats_list = ortho_stats)

## -----------------------------------------------------------------------------
plot_duplications(ortho_stats)

## ----plot_genes_in_ogs--------------------------------------------------------
plot_genes_in_ogs(ortho_stats)

## ----ssOGs--------------------------------------------------------------------
plot_species_specific_ogs(ortho_stats)

## ----plot_orthofinder_stats, fig.width = 12, fig.height = 7-------------------
plot_orthofinder_stats(
  tree, 
  xlim = c(-0.1, 2),
  stats_list = ortho_stats
)

## ----plot_og_overlap----------------------------------------------------------
plot_og_overlap(ortho_stats)

## ----og_sizes-----------------------------------------------------------------
plot_og_sizes(og) 
plot_og_sizes(og, log = TRUE) # natural logarithm scale
plot_og_sizes(og, max_size = 100) # only OGs with <= 100 genes

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

