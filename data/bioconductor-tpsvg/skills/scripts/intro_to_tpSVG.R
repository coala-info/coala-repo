# Code example from 'intro_to_tpSVG' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.small = TRUE,       # Reduce figure size
  fig.retina = NULL       # Reduce figure size
)

## ----install_github, eval=FALSE-----------------------------------------------
# # install.packages("devtools")
# devtools::install_github("boyiguo1/tpSVG")

## ----install_bioc, eval = FALSE-----------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("tpSVG")

## ----install_bioc_dev,eval = FALSE--------------------------------------------
# BiocManager::install(version='devel')

## ----load_packages, message = FALSE-------------------------------------------
library(tpSVG)
library(SpatialExperiment)
library(STexampleData)          # Example data
library(scuttle)                # Data preprocess

## ----data_preprocess, message = FALSE-----------------------------------------
spe <- Visium_humanDLPFC()
spe <- spe[, colData(spe)$in_tissue == 1]
spe <- logNormCounts(spe)

# Normalization factor
head(spe$sizeFactor)

# Equivalently, library size
spe$total <- counts(spe) |> colSums()

# Down-sizing genes for faster computation
idx <- which(
  rowData(spe)$gene_name %in% c("MOBP", "PCP4", "SNAP25",
                                "HBB", "IGKC", "NPY")
)
spe <- spe[idx, ]

## ----pois_eg------------------------------------------------------------------
set.seed(1)
spe_poisson  <- tpSVG(
  spe,
  family = poisson,
  assay_name = "counts",
  offset = log(spe$total)   # Natural log library size
)


rowData(spe_poisson)

## ----eval = FALSE-------------------------------------------------------------
# spe_gauss <- tpSVG(
#   spe,
#   family = gaussian(),
#   assay_name = "logcounts",
#   offset = NULL
# )

## -----------------------------------------------------------------------------
# Check missing data
idx_complete_case <- complete.cases(spe$ground_truth)
# If multiple covariates
# idx_complete_case <- complete.cases(spe$ground_truth, spe$cell_count)

# Remove missing data
spe <- spe[, idx_complete_case]

# Create a design matrix
x <- spe$ground_truth 

spe_poisson_cov  <- tpSVG(
  spe,
  X = x, 
  family = poisson,
  assay_name = "counts",
  offset = log(spe$total)   # Natural log library size
)

## ----load_seqFISH-------------------------------------------------------------
library(STexampleData)
spe <- seqFISH_mouseEmbryo()

spe

## ----model_seqFISH------------------------------------------------------------
# Calculate "library size"
spe$total <- counts(spe) |> colSums()

# Down-size genes
idx_gene <- which(
  rowData(spe)$gene_name %in%
    c("Sox2")
  )

library(tpSVG)

# Poisson model
tp_spe <- tpSVG(
  input = spe[idx_gene,],
  family = poisson(),
  offset = log(spe$total),
  assay_name = "counts")

rowData(tp_spe)

## ----session------------------------------------------------------------------
sessioninfo::session_info()

