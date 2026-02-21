# Code example from 'bioinformatics_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  digits = 3,
  collapse = TRUE,
  comment = "#>",
  fig.align = "center", 
  fig.width = 8
)
options(digits = 3)

## -----------------------------------------------------------------------------
library(dar)
data("metaHIV_phy")
set.seed(1234)

metaHIV_phy

## -----------------------------------------------------------------------------
# Recipe Initialization
rec <- recipe(metaHIV_phy, var_info = "RiskGroup2", tax_info = "Species")
rec

## -----------------------------------------------------------------------------
# Summary Stats by levels
phy_qc(rec)

# Adding prepro steps
rec <- 
  rec |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_by_prevalence()

rec

## -----------------------------------------------------------------------------
# DA steps definition
rec <- 
  rec |> 
  step_wilcox() |>
  # step_ancom() |>
  step_aldex() |>
  step_deseq() |>
  step_corncob(filter_discriminant = FALSE) |> 
  step_metagenomeseq(rm_zeros = 0.01) |>
  step_maaslin(min_prevalence = 0) |> 
  step_lefse()

rec

## -----------------------------------------------------------------------------
# Execute in parallel
da_results <- prep(rec, parallel = TRUE)

da_results

## -----------------------------------------------------------------------------
# Default DA taxa results
results <- 
  bake(da_results) |> 
  cool()

results

## -----------------------------------------------------------------------------
# Intersection plot
intersection_plt(da_results, ordered_by = "degree", font_size = 1)

## -----------------------------------------------------------------------------
# Exclusion plot 
exclusion_plt(da_results)

## -----------------------------------------------------------------------------
# Correlation heatmap
corr_heatmap(da_results, font_size = 10) 

## -----------------------------------------------------------------------------
# Mutual plot
mutual_plt(
  da_results, 
  count_cutoff = length(steps_ids(da_results, type = "da")), 
  top_n = 24
)

## -----------------------------------------------------------------------------
# Define consensus strategy
da_results <- bake(da_results)
da_results

## -----------------------------------------------------------------------------
# Extract results for bake id 1
f_results <- cool(da_results, bake = 1)

f_results

## -----------------------------------------------------------------------------
# Ids for Bacteroide and Provotella species 
ids <- 
  f_results |>
  dplyr::filter(stringr::str_detect(taxa, "Bacteroi.*|Prevote.*")) |>
  dplyr::pull(taxa_id) 

# Abundance plot as boxplot
abundance_plt(da_results, taxa_ids = ids, type = "boxplot") 

# Abundance plot as heatmap
abundance_plt(da_results, type = "heatmap", transform = "compositional")

## -----------------------------------------------------------------------------
devtools::session_info()

