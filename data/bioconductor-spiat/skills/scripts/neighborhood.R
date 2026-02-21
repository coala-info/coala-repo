# Code example from 'neighborhood' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message=FALSE------------------------------------------------------------
library(SPIAT)

## ----fig.height = 2.5, out.width = "75%"--------------------------------------
data("image_no_markers")

plot_cell_categories(
  image_no_markers, c("Tumour", "Immune","Immune1","Immune2","Others"),
  c("red","blue","darkgreen", "brown","lightgray"), "Cell.Type")

## -----------------------------------------------------------------------------
average_minimum_distance(image_no_markers)

## -----------------------------------------------------------------------------
clusters <- identify_neighborhoods(
  image_no_markers, method = "hierarchical", min_neighborhood_size = 100,
  cell_types_of_interest = c("Immune", "Immune1", "Immune2"), radius = 50, 
  feature_colname = "Cell.Type")

## -----------------------------------------------------------------------------
neighorhoods_vis <- 
  composition_of_neighborhoods(clusters, feature_colname = "Cell.Type")
neighorhoods_vis <- 
  neighorhoods_vis[neighorhoods_vis$Total_number_of_cells >=5,]

## ----fig.width = 3, fig.height = 3, out.width = "70%"-------------------------
plot_composition_heatmap(neighorhoods_vis, feature_colname="Cell.Type")

## -----------------------------------------------------------------------------
average_nearest_neighbor_index(clusters, reference_celltypes=c("Cluster_1"), 
                               feature_colname="Neighborhood", p_val = 0.05)

## -----------------------------------------------------------------------------
average_nearest_neighbor_index(
  image_no_markers, reference_celltypes=c("Immune", "Immune1" , "Immune2"), 
  feature_colname="Cell.Type", p_val = 0.05)

## -----------------------------------------------------------------------------
sessionInfo()

