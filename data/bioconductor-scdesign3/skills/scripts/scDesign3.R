# Code example from 'scDesign3' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    message = FALSE,
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)
tools::R_user_dir("scDesign3", which="cache")

## ----message=FALSE, warning=FALSE, results='hide'-----------------------------
library(scDesign3)
library(SingleCellExperiment)
library(ggplot2)
theme_set(theme_bw())

## -----------------------------------------------------------------------------
#example_sce <- readRDS((url("https://figshare.com/ndownloader/files/40581992")))
#print(example_sce)
#example_sce <- example_sce[1:100, ]

data("example_count", package = "scDesign3")
data("pseudotime", package = "scDesign3")

example_sce <- SingleCellExperiment::SingleCellExperiment(assays = list(counts = example_count, logcounts = log1p(example_count)),
  colData = DataFrame(pseudotime = pseudotime))

## ----message=FALSE, warning=FALSE, results='hide'-----------------------------
set.seed(123)
example_simu <- scdesign3(
    sce = example_sce,
    assay_use = "counts",
    celltype = NULL,
    pseudotime = "pseudotime",
    spatial = NULL,
    other_covariates = NULL,
    mu_formula = "s(pseudotime, k = 10, bs = 'cr')", # mgcg::gam stype formula input.
    sigma_formula = "1", # If you want your dispersion also varies along pseudotime, use "s(pseudotime, k = 5, bs = 'cr')". This will significantly increase the computational cost.
    family_use = "nb",
    n_cores = 2, # Consider the balance between your ROM and threads.
    usebam = FALSE,
    corr_formula = "1",
    copula = "gaussian",
    DT = TRUE,
    pseudo_obs = FALSE,
    return_model = FALSE,
    nonzerovar = FALSE
  )

## -----------------------------------------------------------------------------
dim(example_simu$new_count)

## -----------------------------------------------------------------------------
logcounts(example_sce) <- log1p(counts(example_sce))
simu_sce <- SingleCellExperiment(list(counts = example_simu$new_count), colData = example_simu$new_covariate)
logcounts(simu_sce) <- log1p(counts(simu_sce))

## -----------------------------------------------------------------------------
set.seed(123)
compare_figure <- plot_reduceddim(ref_sce = example_sce, 
                                  sce_list = list(simu_sce), 
                                  name_vec = c("Reference", "scDesign3"),
                                  assay_use = "logcounts", 
                                  if_plot = TRUE, 
                                  color_by = "pseudotime", 
                                  n_pc = 20)
plot(compare_figure$p_umap)

## -----------------------------------------------------------------------------
sessionInfo()

