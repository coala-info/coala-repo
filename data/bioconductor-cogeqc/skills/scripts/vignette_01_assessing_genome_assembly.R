# Code example from 'vignette_01_assessing_genome_assembly' vignette. See references/ for full tutorial.

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

## ----get_maize_genomes--------------------------------------------------------
# Example 1: get stats for all maize genomes using taxon name
maize_stats <- get_genome_stats(taxon = "Zea mays")
head(maize_stats)
str(maize_stats)

# Example 2: get stats for all maize genomes using NCBI Taxonomy ID
maize_stats2 <- get_genome_stats(taxon = 4577)

# Checking if objects are the same
identical(maize_stats, maize_stats2)

## ----get_maize_genomes_with_filters-------------------------------------------
# Get chromosome-scale maize genomes with annotation
## Create list of filters
filt <- list(
    filters.has_annotation = "true",
    filters.assembly_level = "chromosome"
)
filt

## Obtain data
filtered_maize_genomes <- get_genome_stats(taxon = "Zea mays", filters = filt)
dim(filtered_maize_genomes)

## -----------------------------------------------------------------------------
# Check column names in the data frame of stats for maize genomes on the NCBI
names(maize_stats)

# Create a simulated data frame of stats for a maize genome
my_stats <- data.frame(
    accession = "my_lovely_maize",
    sequence_length = 2.4 * 1e9,
    gene_count_total = 50000,
    CC_ratio = 2
)

# Compare stats
compare_genome_stats(ncbi_stats = maize_stats, user_stats = my_stats)

## ----plot_genome_stats, fig.width=10, fig.height=5----------------------------
# Summarize genome stats in a plot
plot_genome_stats(ncbi_stats = maize_stats)

## ----plot_genome_stats_with_user_stats, fig.width=10, fig.height=5------------
plot_genome_stats(ncbi_stats = maize_stats, user_stats = my_stats)

## ----run_busco, eval=FALSE----------------------------------------------------
# # Path to FASTA file
# sequence <- system.file("extdata", "Hse_subset.fa", package = "cogeqc")
# 
# # Path to directory where BUSCO datasets will be stored
# download_path <- paste0(tempdir(), "/datasets")
# 
# # Run BUSCO if it is installed
# if(busco_is_installed()) {
#   run_busco(sequence, outlabel = "Hse", mode = "genome",
#             lineage = "burkholderiales_odb10",
#             outpath = tempdir(), download_path = download_path)
# }

## -----------------------------------------------------------------------------
# Path to output directory
output_dir <- system.file("extdata", package = "cogeqc")

busco_summary <- read_busco(output_dir)
busco_summary

## -----------------------------------------------------------------------------
data(batch_summary)
batch_summary

## ----plot_busco, out.width = '100%'-------------------------------------------
# Single FASTA file - Ostreococcus tauri
plot_busco(busco_summary)

# Batch mode - Herbaspirillum seropedicae and H. rubrisubalbicans
plot_busco(batch_summary)

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

