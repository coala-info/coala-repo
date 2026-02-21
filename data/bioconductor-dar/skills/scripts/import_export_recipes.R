# Code example from 'import_export_recipes' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  digits = 3,
  collapse = TRUE,
  comment = "#>"
)
options(digits = 3)

## -----------------------------------------------------------------------------
library(dar)
data(metaHIV_phy)

# Create a recipe with steps
rec <- 
  recipe(metaHIV_phy, "RiskGroup2", "Species") |>
  step_subset_taxa(tax_level = "Kingdom", taxa = c("Bacteria", "Archaea")) |>
  step_filter_taxa(.f = "function(x) sum(x > 0) >= (0.3 * length(x))") |>
  step_maaslin()

# Export the steps to a JSON file
out_file <- tempfile(fileext = ".json")
export_steps(rec, out_file)

## -----------------------------------------------------------------------------
# Initialize a recipe with a phyloseq object
rec <- recipe(metaHIV_phy, "RiskGroup2", "Species")

# Import the steps from a JSON file
json_file <- out_file
rec <- import_steps(rec, json_file)
rec

## -----------------------------------------------------------------------------
## Execute
da_results <- prep(rec, parallel = FALSE) |> bake()
da_results

## -----------------------------------------------------------------------------
devtools::session_info()

