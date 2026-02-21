# Code example from 'tissue-structure' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message=FALSE------------------------------------------------------------
library(SPIAT)

## -----------------------------------------------------------------------------
data("simulated_image")

# define cell types
formatted_image <- define_celltypes(
    simulated_image, 
    categories = c("Tumour_marker","Immune_marker1,Immune_marker2", 
                   "Immune_marker1,Immune_marker3", 
                   "Immune_marker1,Immune_marker2,Immune_marker4", "OTHER"), 
    category_colname = "Phenotype", 
    names = c("Tumour", "Immune1", "Immune2", "Immune3", "Others"),
    new_colname = "Cell.Type")

## ----fig.width = 2.7, fig.height = 3------------------------------------------
R_BC(formatted_image, cell_type_of_interest = "Tumour", "Cell.Type")

## ----fig.width = 2.7, fig.height = 3------------------------------------------
formatted_border <- identify_bordering_cells(formatted_image, 
                                             reference_cell = "Tumour", 
                                             feature_colname="Cell.Type")

## -----------------------------------------------------------------------------
# Get the number of tumour clusters
attr(formatted_border, "n_of_clusters")

## ----echo=FALSE, fig.height=2, fig.width=2, out.width="75%"-------------------
knitr::include_graphics("tumour-structure.jpg")

## -----------------------------------------------------------------------------
formatted_distance <- calculate_distance_to_margin(formatted_border)

## -----------------------------------------------------------------------------
names_of_immune_cells <- c("Immune1", "Immune2","Immune3")

formatted_structure <- define_structure(
  formatted_distance, cell_types_of_interest = names_of_immune_cells, 
  feature_colname = "Cell.Type", n_margin_layers = 5)

categories <- unique(formatted_structure$Structure)

## ----fig.height = 3, fig.width = 5.8 , out.width = "90%"----------------------
plot_cell_categories(formatted_structure, feature_colname = "Structure")

## -----------------------------------------------------------------------------
immune_proportions <- calculate_proportions_of_cells_in_structure(
  spe_object = formatted_structure, 
  cell_types_of_interest = names_of_immune_cells, feature_colname ="Cell.Type")

immune_proportions

## -----------------------------------------------------------------------------
immune_distances <- calculate_summary_distances_of_cells_to_borders(
  spe_object = formatted_structure, 
  cell_types_of_interest = names_of_immune_cells, feature_colname = "Cell.Type")

immune_distances

## -----------------------------------------------------------------------------
sessionInfo()

