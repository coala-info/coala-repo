# Code example from 'permutation_based_testing' vignette. See references/ for full tutorial.

## ----set.up, include=FALSE, messages=FALSE, warnings=FALSE--------------------
knitr::opts_chunk$set(message=FALSE, collapse = TRUE, comment="")

# R packages
library(devtools)
load_all()

## ----load.data----------------------------------------------------------------
# Load pre-simulated feature set 
# See ?sim_FS for more information
data(sim_FS)

# Load pre-computed input-score
# See ?sim_Scores for more information
data(sim_Scores)

## ----ks.method----------------------------------------------------------------
candidate_search_res <- CaDrA::candidate_search(
  FS = sim_FS,
  input_score = sim_Scores,
  method = "ks_pval",          # Use Kolmogorow-Smirnow scoring function 
  method_alternative = "less", # Use one-sided hypothesis testing
  weights = NULL,              # If weights is provided, perform a weighted-KS test
  search_method = "both",      # Apply both forward and backward search
  top_N = 7,                   # Number of top features to kick start the search
  max_size = 10,               # Allow at most 10 features in meta-feature matrix
  best_score_only = FALSE      # Return all results from the search
)

## ----ks.meta.plot-------------------------------------------------------------
# Extract the best meta-feature result
topn_best_meta <- CaDrA::topn_best(topn_list = candidate_search_res)

# Visualize meta-feature result
CaDrA::meta_plot(topn_best_list = topn_best_meta)

## -----------------------------------------------------------------------------
# Set seed for permutation-based testing
set.seed(123)

perm_res <- CaDrA::CaDrA(
  FS = sim_FS, 
  input_score = sim_Scores, 
  method = "ks_pval",             # Use Kolmogorow-Smirnow scoring function 
  method_alternative = "less",    # Use one-sided hypothesis testing
  weights = NULL,                 # If weights is provided, perform a weighted-KS test
  search_method = "both",         # Apply both forward and backward search
  top_N = 7,                      # Repeat the search with the top N features
  max_size = 10,                  # Allow at most 10 features in the meta-feature matrix
  n_perm = 100,                   # Number of permutations to perform
  perm_alternative = "one.sided", # One-sided permutation-based p-value alternative type
  plot = FALSE,                   # We will plot later
  ncores = 2                      # Number of cores to perform parallelization
)

## ----ks.permutation.plot------------------------------------------------------
# Visualize permutation results
permutation_plot(perm_res = perm_res)

## ----RsessionInfo-------------------------------------------------------------
sessionInfo()

