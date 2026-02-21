# Code example from 'IsoBayes' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(
    tidy = FALSE, cache = TRUE,
    dev = "png",
    message = TRUE, error = FALSE, warning = TRUE
)

## ----Bioconductor_installation, eval=FALSE------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("IsoBayes")

## ----vignettes, eval=FALSE----------------------------------------------------
# browseVignettes("IsoBayes")

## ----citation-----------------------------------------------------------------
citation("IsoBayes")

## ----load, message=FALSE------------------------------------------------------
library(IsoBayes)

## ----specify extdata path-----------------------------------------------------
data_dir = system.file("extdata", package = "IsoBayes")

## ----set path mRNA------------------------------------------------------------
tpm_path = paste0(data_dir, "/jurkat_isoform_kallisto.tsv")

## ----set path MM psm----------------------------------------------------------
path_to_peptides_psm = paste0(data_dir, "/AllPeptides.psmtsv")

## ----load psm-----------------------------------------------------------------
SE = generate_SE(path_to_peptides_psm = path_to_peptides_psm,
                 abundance_type = "psm",
                 input_type = "metamorpheus")
SE

## ----set path MM intensities--------------------------------------------------
path_to_peptides_intensities = paste0(data_dir, "/AllQuantifiedPeptides.tsv")
SE = generate_SE(path_to_peptides_psm = path_to_peptides_psm,
                 path_to_peptides_intensities = path_to_peptides_intensities,
                 abundance_type = "intensities",
                 input_type = "metamorpheus")

## ----set path OpenMS, eval = FALSE--------------------------------------------
# SE = generate_SE(path_to_peptides_psm = "/path/to/file.idXML",
#                  abundance_type = "psm",
#                  input_type = "openMS")

## ----set user data, eval = FALSE----------------------------------------------
# # X can be a path to a .tsv file or a data.frame
# SE = generate_SE(path_to_peptides_psm = X,
#                  abundance_type = "psm",
#                  input_type = "other")

## ----input_data---------------------------------------------------------------
data_loaded = input_data(SE, path_to_tpm = tpm_path)

## ----inference, eval = FALSE--------------------------------------------------
# set.seed(169612)
# results = inference(data_loaded)

## ----default inference--------------------------------------------------------
path_to_map_iso_gene = paste0(data_dir, "/map_iso_gene.csv")
set.seed(169612)
results_normalized = inference(data_loaded, map_iso_gene = path_to_map_iso_gene, traceplot = TRUE)

## ----get res------------------------------------------------------------------
names(results_normalized)

## ----get iso res--------------------------------------------------------------
head(results_normalized$isoform_results)

## ----get iso res norm---------------------------------------------------------
head(results_normalized$normalized_isoform_results)

## ----get iso res norm gene----------------------------------------------------
head(results_normalized$gene_abundance)

## ----plotting results---------------------------------------------------------
plot_relative_abundances(results_normalized, gene_id = "TUBB")

## ----plotting results no normalization----------------------------------------
plot_relative_abundances(results_normalized, gene_id = "TUBB", normalize_gene = FALSE)

## ----traceplot----------------------------------------------------------------
plot_traceplot(results_normalized, "TUBB-205")

plot_traceplot(results_normalized, "TUBB-206")

plot_traceplot(results_normalized, "TUBB-208")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

