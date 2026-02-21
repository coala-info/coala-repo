# Code example from 'workflow' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(scMultiSim)

## ----true-counts--------------------------------------------------------------
data(GRN_params_100)

results <- sim_true_counts(list(
  # required options
  GRN = GRN_params_100,
  tree = Phyla3(),
  num.cells = 500,
  # optional options
  num.cif = 20,
  discrete.cif = F,
  cif.sigma = 0.1
  # ... other options
))

## ----run-shiny, eval = FALSE--------------------------------------------------
# run_shiny()

## ----technical-noise----------------------------------------------------------
add_expr_noise(results)
divide_batches(results, nbatch = 2)

## ----visualize----------------------------------------------------------------
plot_tsne(results$counts, results$cell_meta$pop)

