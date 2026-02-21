# Code example from 'introduction' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  fig.path = ifelse(knitr::pandoc_to() %in% c('html', 'html4'), 'inst/figures/', 'inst/figures/')
)

## ----eval=FALSE, message=FALSE------------------------------------------------
# if (!requireNamespace("BiocManager")) install.packages("BiocManager")
# 
# # Step 1
# BiocManager::install("sccomp")
# 
# # Step 2
# install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev/", getOption("repos")))
# 
# # Step 3
# cmdstanr::check_cmdstan_toolchain(fix = TRUE) # Just checking system setting
# cmdstanr::install_cmdstan()

## ----eval=FALSE, message=FALSE------------------------------------------------
# 
# # Step 1
# devtools::install_github("MangiolaLaboratory/sccomp")
# 
# # Step 2
# install.packages("cmdstanr", repos = c("https://stan-dev.r-universe.dev/", getOption("repos")))
# 
# # Step 3
# cmdstanr::check_cmdstan_toolchain(fix = TRUE) # Just checking system setting
# cmdstanr::install_cmdstan()

## ----message=FALSE, warning=FALSE---------------------------------------------
library(dplyr)
library(sccomp)
library(ggplot2)
library(forcats)
library(tidyr)
data("seurat_obj")
data("sce_obj")
data("counts_obj")

## ----eval=FALSE, message=FALSE------------------------------------------------
# 
# sccomp_result =
#   sce_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     cores = 1,
#     verbose = FALSE
#   ) |>
#   sccomp_test()
# 

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# 
# sccomp_result =
#   counts_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     abundance = "count",
#     cores = 1, verbose = FALSE
#   ) |>
#   sccomp_test()

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# sccomp_result

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# 
# sccomp_result =
#   counts_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     abundance = "count",
#     cores = 1, verbose = FALSE
#   ) |>
# 
#   # max_sampling_iterations is used her to not exceed the maximum file size for GitHub action of 100Mb
#   sccomp_remove_outliers(cores = 1, verbose = FALSE, max_sampling_iterations = 2000) |> # Optional
#   sccomp_test()

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# sccomp_result |>
#   sccomp_boxplot(factor = "type")

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# sccomp_result |>
#   sccomp_boxplot(factor = "type", remove_unwanted_effects = TRUE)

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# sccomp_result |>
#   plot_1D_intervals()

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# sccomp_result |>
#   plot_2D_intervals()

## ----out.height="200%", eval=FALSE, message=FALSE-----------------------------
# sccomp_result |> plot()

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# 
# sccomp_result =
#   counts_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     abundance = "proportion",
#     cores = 1, verbose = FALSE
#   ) |>
#   sccomp_test()

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# 
# res =
#     seurat_obj |>
#     sccomp_estimate(
#       formula_composition = ~ type + continuous_covariate,
#       sample = "sample",
#       cell_group = "cell_group",
#       cores = 1, verbose=FALSE
#     )
# 
# res

## ----message=FALSE------------------------------------------------------------
seurat_obj[[]] |> as_tibble()

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# res =
#   seurat_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type + (1 | group__),
#     sample = "sample",
#     cell_group = "cell_group",
#     bimodal_mean_variability_association = TRUE,
#     cores = 1, verbose = FALSE
#   )
# 
# res

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# res =
#   seurat_obj |>
#   sccomp_estimate(
#       formula_composition = ~ type + (type | group__),
#       sample = "sample",
#       cell_group = "cell_group",
#       bimodal_mean_variability_association = TRUE,
#       cores = 1, verbose = FALSE
#     )
# 
# res

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# res =
#   seurat_obj |>
#   sccomp_estimate(
#       formula_composition = ~ type + (type | group__) + (1 | group2__),
#       sample = "sample",
#       cell_group = "cell_group",
#       bimodal_mean_variability_association = TRUE,
#       cores = 1, verbose = FALSE
#     )
# 
# res

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# res |>
#    sccomp_proportional_fold_change(
#      formula_composition = ~  type,
#      from =  "healthy",
#      to = "cancer"
#     ) |>
#   select(cell_group, statement)

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# 
# seurat_obj |>
#   sccomp_estimate(
#     formula_composition = ~ 0 + type,
#     sample = "sample",
#     cell_group = "cell_group",
#     cores = 1, verbose = FALSE
#   ) |>
#   sccomp_test( contrasts =  c("typecancer - typehealthy", "typehealthy - typecancer"))
# 
# 

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# library(loo)
# 
# # Fit first model
# model_with_factor_association =
#   seurat_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     inference_method = "hmc",
#     enable_loo = TRUE,
#     verbose = FALSE
#   )
# 
# # Fit second model
# model_without_association =
#   seurat_obj |>
#   sccomp_estimate(
#     formula_composition = ~ 1,
#     sample = "sample",
#     cell_group = "cell_group",
#     inference_method = "hmc",
#     enable_loo = TRUE,
#     verbose = FALSE
#   )
# 
# # Compare models
# loo_compare(
#    attr(model_with_factor_association, "fit")$loo(),
#    attr(model_without_association, "fit")$loo()
# )
# 

## ----message=FALSE, warning=FALSE, eval = instantiate::stan_cmdstan_exists()----
# 
# res =
#   seurat_obj |>
#   sccomp_estimate(
#     formula_composition = ~ type,
#     formula_variability = ~ type,
#     sample = "sample",
#     cell_group = "cell_group",
#     cores = 1, verbose = FALSE
#   )
# 
# res
# 

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# plots = res |> sccomp_test() |> plot()
# 
# plots$credible_intervals_1D

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE-----------------
# plots$credible_intervals_2D

## ----eval = instantiate::stan_cmdstan_exists(), message=FALSE, warning=FALSE----
# 
# library(cmdstanr)
# library(posterior)
# library(bayesplot)
# 
# # Assuming res contains the fit object from cmdstanr
# fit <- res |> attr("fit")
# 
# # Extract draws for 'beta[2,1]'
# draws <- as_draws_array(fit$draws("beta[2,1]"))
# 
# # Create a traceplot for 'beta[2,1]'
# mcmc_trace(draws, pars = "beta[2,1]") + theme_bw()
# 

## ----message=FALSE------------------------------------------------------------
sessionInfo()

