# Code example from 'clustifyrdatahub' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    message = FALSE,
    warning = FALSE,
    comment = "#>",
    fig.path = "man/figures/",
    out.width = "100%"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("clustifyrdatahub")

## -----------------------------------------------------------------------------
knitr::kable(dplyr::select(
  read.csv(system.file("extdata", "metadata.csv", package = "clustifyrdatahub")),
  c(1, 9, 2:7)))

## -----------------------------------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()

## query
refs <- query(eh, "clustifyrdatahub")
refs
## either by index or id
ref_hema_microarray <- refs[[7]]         ## load the first resource in the list
ref_hema_microarray <- refs[["EH3450"]]  ## load by EH id

## or list and load
refs <- listResources(eh, "clustifyrdatahub")
ref_hema_microarray <- loadResources(
    eh, 
    "clustifyrdatahub",
    "ref_hema_microarray"
    )[[1]]

## use for classification of cell types
res <- clustifyr::clustify(
    input = clustifyr::pbmc_matrix_small,
    metadata = clustifyr::pbmc_meta$classified,
    ref_mat = ref_hema_microarray,
    query_genes = clustifyr::pbmc_vargenes
)

## -----------------------------------------------------------------------------
## or load refs by function name (after loading hub library)
library(clustifyrdatahub)
ref_hema_microarray()[1:5, 1:5]           ## data are loaded
ref_hema_microarray(metadata = TRUE)      ## only metadata

## -----------------------------------------------------------------------------
sessionInfo()

