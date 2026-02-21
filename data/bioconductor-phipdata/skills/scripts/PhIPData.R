# Code example from 'PhIPData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  comment = "##"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# 
# BiocManager::install("PhIPData")

## ----include = TRUE, results = "hide", message = FALSE, warning = FALSE-------
library(PhIPData)

## ----echo = FALSE, fig.cap = "Schematic of a PhIPData object. Commands used to access each component of the object are listed underneath its visual representation. Code in black indicates functions specific to `PhIPData` objects while functions in red extend `SummarizedExperiment` functions. Here, `pd` is a generic `PhIPData` object.", out.width = "\\maxwidth"----
knitr::include_graphics("extras/PhIPData.png")

## ----setup, warning = FALSE, message = FALSE----------------------------------
library(dplyr)
library(readr)

## -----------------------------------------------------------------------------
set.seed(20210120)

# Read in peptide metadata -------------
virscan_file <- system.file("extdata", "virscan.tsv", package = "PhIPData")
virscan_info <- readr::read_tsv(virscan_file,
                                col_types = readr::cols(
                                  pep_id = readr::col_character(),
                                  pro_id = readr::col_character(),
                                  pos_start = readr::col_double(),
                                  pos_end = readr::col_double(),
                                  UniProt_acc = readr::col_character(),
                                  pep_dna = readr::col_character(),
                                  pep_aa = readr::col_character(),
                                  pro_len = readr::col_double(),
                                  taxon_id = readr::col_double(),
                                  species = readr::col_character(),
                                  genus = readr::col_character(),
                                  product = readr::col_character()
                                )) %>%
  as.data.frame()

# Simulate data -------------
n_samples <- 5L
n_peps <- nrow(virscan_info)

counts_dat <- matrix(sample(1:1e6, n_samples*n_peps, replace = TRUE),
                 nrow = n_peps)
logfc_dat <- matrix(rnorm(n_samples*n_peps, mean = 0, sd = 10), 
                    nrow = n_peps)
prob_dat <- matrix(rbeta(n_samples*n_peps, shape1 = 1, shape2 = 1), 
                   nrow = n_peps)

# Sample metadata -------------
sample_meta <- data.frame(sample_name = paste0("sample", 1:n_samples),
                          gender = sample(c("M", "F"), n_samples, TRUE),
                          group = sample(c("ctrl", "trt", "beads"), n_samples, TRUE))

# Set row/column names -------------
rownames(counts_dat) <- rownames(logfc_dat) <-
  rownames(prob_dat) <- rownames(virscan_info) <-
  paste0("pep_", 1:n_peps)

colnames(counts_dat) <- colnames(logfc_dat) <-
  colnames(prob_dat) <- rownames(sample_meta) <-
  paste0("sample_", 1:n_samples)

# Experimental metadata -------------
exp_meta <- list(date_run = as.Date("2021/01/20"), 
                 reads_per_sample = colSums(counts_dat))

## -----------------------------------------------------------------------------
phip_obj <- PhIPData(counts_dat, logfc_dat, prob_dat, 
                     virscan_info, sample_meta, 
                     exp_meta)

phip_obj

## -----------------------------------------------------------------------------
assays(phip_obj)

head(assays(phip_obj)$counts)   # Returns the same as assays(phip_obj)[["counts"]]

## -----------------------------------------------------------------------------
head(assay(phip_obj, "logfc"))   # Returns the same as assay(phip_obj, 2)

## -----------------------------------------------------------------------------
head(counts(phip_obj))
head(logfc(phip_obj))
head(prob(phip_obj))

## ----error = T----------------------------------------------------------------
replacement_dat <- matrix(1, nrow = n_peps, ncol = n_samples)

# Replace the counts matrix -------------
head(counts(phip_obj))
counts(phip_obj) <- replacement_dat
head(counts(phip_obj))

# Add a new assay -----------
head(assay(phip_obj, "new_assay"))
assay(phip_obj, "new_assay") <- replacement_dat
head(assay(phip_obj, "new_assay"))

# Returns and error because `counts`, `logfc`, and `prob` must be in the 
# assays of a PhIPData object
assays(phip_obj) <- list(new_assay1 = replacement_dat, 
                         new_assay2 = replacement_dat)

## -----------------------------------------------------------------------------
# Only showing 2 columns for easier viewing
peptideInfo(phip_obj)[, 8:9]

## -----------------------------------------------------------------------------
sampleInfo(phip_obj)

## -----------------------------------------------------------------------------
phip_obj$group

## -----------------------------------------------------------------------------
metadata(phip_obj)

## -----------------------------------------------------------------------------
phip_obj[1:10, 1:2]

## -----------------------------------------------------------------------------
phip_obj[, phip_obj$group == "beads"]

## -----------------------------------------------------------------------------
ebv_sub <- subset(phip_obj, grepl("Epstein-Barr virus", species))

peptideInfo(ebv_sub)[, "species"]

## -----------------------------------------------------------------------------
subsetBeads(phip_obj)

## -----------------------------------------------------------------------------
librarySize(phip_obj)

## -----------------------------------------------------------------------------
head(propReads(phip_obj))

## -----------------------------------------------------------------------------
# Save virscan_info as the human_virus library
makeLibrary(virscan_info, "human_virus")

## -----------------------------------------------------------------------------
PhIPData(counts = counts_dat, 
         sampleInfo = sample_meta,
         peptideInfo = getLibrary("human_virus"))

## -----------------------------------------------------------------------------
removeLibrary("human_virus")

## ----error = T----------------------------------------------------------------
# Create alias for HIV ----------
setAlias("hiv", "[Hh]uman immunodeficiency virus")

# Use alias ----------
hiv_sub <- subset(phip_obj, grepl(getAlias("hiv"), species))
peptideInfo(hiv_sub)[, "species"]

# Remove alias from database -----------
deleteAlias("hiv")

# The following command returns an error that the virus does
# not exist in the alias database. 
subset(phip_obj, grepl(getAlias("hiv"), species))

## -----------------------------------------------------------------------------
# PhIPData to DGEList
as(phip_obj, "DGEList")
as(phip_obj, "DataFrame")

## -----------------------------------------------------------------------------
sessionInfo()

