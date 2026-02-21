# Code example from 'overview' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("tidySpatialExperiment")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("pak", quietly = TRUE))
#     install.packages("pak")
# 
# pak::pak("william-hutchison/tidySpatialExperiment")

## ----message=FALSE, results=FALSE---------------------------------------------
# Load example SpatialExperiment object
library(tidySpatialExperiment)
example(read10xVisium)

## ----echo=FALSE---------------------------------------------------------------
# Remove unneeded second sample from demo data
spe <-
    spe |>
    filter(sample_id == "section1")

## -----------------------------------------------------------------------------
spe

## -----------------------------------------------------------------------------
spe |>
    colData() |>
    head()

spe |> 
    spatialCoords() |>
    head()

spe |>
    imgData()

## -----------------------------------------------------------------------------
spe |>
   filter(array_col < 5)


## -----------------------------------------------------------------------------
spe |>
    mutate(in_region = c(in_tissue & array_row < 10))

## -----------------------------------------------------------------------------
# Nest the SpatialExperiment object by sample_id
spe_nested <-
    spe |> 
    nest(data = -sample_id)

# View the nested SpatialExperiment object
spe_nested

# Unnest the nested SpatialExperiment objects
spe_nested |>
    unnest(data)

## -----------------------------------------------------------------------------
spe |>
    filter(sample_id == "section1" & in_tissue) |>
    
    # Add a column with the sum of feature counts per cell
    mutate(count_sum = purrr::map_int(.cell, ~
        spe[, .x] |> 
            counts() |> 
            sum()
      )) |>
    
    # Plot with tidySpatialExperiment and ggplot2
    ggplot(aes(x = reorder(.cell, count_sum), y = count_sum)) +
    geom_point() +
    coord_flip()

## ----eval=FALSE, message=FALSE, warning=FALSE---------------------------------
# spe |>
#     filter(sample_id == "section1") |>
#     plot_ly(
#         x = ~ array_col,
#         y = ~ array_row,
#         color = ~ in_tissue,
#         type = "scatter"
#     )

## -----------------------------------------------------------------------------
# Join feature data in wide format, preserving the SpatialExperiment object
spe |>
    join_features(features = c("ENSMUSG00000025915", "ENSMUSG00000042501"), shape = "wide") |> 
    head()

# Join feature data in long format, discarding the SpatialExperiment object
spe |>
    join_features(features = c("ENSMUSG00000025915", "ENSMUSG00000042501"), shape = "long") |> 
    head()

## -----------------------------------------------------------------------------
spe |>
    aggregate_cells(in_tissue, assays = "counts")

## -----------------------------------------------------------------------------
spe |>
    filter(sample_id == "section1") |>
    mutate(in_ellipse = ellipse(array_col, array_row, c(20, 40), c(20, 20))) |>
    ggplot(aes(x = array_col, y = array_row, colour = in_ellipse)) +
    geom_point()

## ----eval=FALSE---------------------------------------------------------------
# spe_gated <-
#   spe |>
#   gate(colour = "in_tissue", alpha = 0.8)

## ----echo=FALSE---------------------------------------------------------------
# Load pre-recorded brush path from data for example
data("demo_brush_data", package = "tidySpatialExperiment")

tidygate_env <<- rlang::env()
tidygate_env$gates <- demo_brush_data 

spe_gated <-
  spe |>
  gate(programmatic_gates = tidygate_env$gates)

## -----------------------------------------------------------------------------
# Select cells within any gate
spe_gated |> 
  filter(!is.na(.gated))
# Select cells within gate 2
spe_gated |>
  filter(stringr::str_detect(.gated, "2"))

## -----------------------------------------------------------------------------
# Inspect previously drawn gates
tidygate_env$gates |>
  head()

## ----eval=FALSE---------------------------------------------------------------
# # Save if needed
# tidygate_env$gates |>
#   write_rds("important_gates.rds")

## ----eval=FALSE---------------------------------------------------------------
# important_gates <-
#   read_rds("important_gates.rds")
# 
# spe |>
#   gate(programmatic_gates = important_gates)) |>
#   filter(!is.na(.gated))

## ----echo=FALSE---------------------------------------------------------------
spe |>
  gate(programmatic_gates = tidygate_env$gates) |>
  filter(!is.na(.gated))

## -----------------------------------------------------------------------------
spe |>
    select(-.cell) |>
    head()

## ----error=TRUE---------------------------------------------------------------
try({
# sample_id is not removed, despite the user's request
spe |>
    select(-sample_id)

# This change maintains separation of sample_ids and is permitted
spe |> 
    mutate(sample_id = stringr::str_c(sample_id, "_modified")) |>
    head()

# This change does not maintain separation of sample_ids and produces an error
spe |>
    mutate(sample_id = "new_sample")
})

## ----error=TRUE---------------------------------------------------------------
try({
# Attempting to remove pxl_col_in_fullres produces an error
spe |>
    select(-pxl_col_in_fullres)

# Attempting to modify pxl_col_in_fullres produces an error
spe |> 
    mutate(pxl_col_in_fullres)
})

## -----------------------------------------------------------------------------
sessionInfo()

