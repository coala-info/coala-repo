# Code example from 'basic_analysis' vignette. See references/ for full tutorial.

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

## ----fig.height = 2.5---------------------------------------------------------
my_colors <- c("red", "blue", "darkcyan", "darkgreen")
  
plot_cell_categories(spe_object = formatted_image, 
                     categories_of_interest = 
                       c("Tumour", "Immune1", "Immune2", "Immune3"), 
                     colour_vector = my_colors, 
                     feature_colname = "Cell.Type")

## ----fig.width=3, fig.height = 2.2--------------------------------------------
p_cells <- calculate_cell_proportions(formatted_image, 
                                      reference_celltypes = NULL, 
                                      feature_colname ="Cell.Type",
                                      celltypes_to_exclude = "Others",
                                      plot.image = TRUE)
p_cells

## ----fig.height=1.2, fig.width = 3.8------------------------------------------
plot_cell_percentages(cell_proportions = p_cells, 
                      cells_to_exclude = "Tumour", cellprop_colname="Proportion_name")


## -----------------------------------------------------------------------------
distances <- calculate_pairwise_distances_between_celltypes(
  spe_object = formatted_image, 
  cell_types_of_interest = c("Tumour", "Immune1", "Immune3"),
  feature_colname = "Cell.Type")

## ----fig.height = 4, fig.width=6, out.width="75%"-----------------------------
plot_cell_distances_violin(distances)

## -----------------------------------------------------------------------------
summary_distances <- calculate_summary_distances_between_celltypes(distances)

summary_distances

## ----fig.height = 2.5, out.width = "75%"--------------------------------------
plot_distance_heatmap(phenotype_distances_result = summary_distances, metric = "mean")

## -----------------------------------------------------------------------------
min_dist <- calculate_minimum_distances_between_celltypes(
  spe_object = formatted_image, 
  cell_types_of_interest = c("Tumour", "Immune1", "Immune2","Immune3", "Others"),
  feature_colname = "Cell.Type")

## ----fig.height = 5, fig.width=8, out.width="75%"-----------------------------
plot_cell_distances_violin(cell_to_cell_dist = min_dist)

## -----------------------------------------------------------------------------
min_summary_dist <- calculate_summary_distances_between_celltypes(min_dist)

# show the first five rows
min_summary_dist[seq_len(5),]

## ----fig.height = 2.5, out.width = "75%"--------------------------------------
plot_distance_heatmap(phenotype_distances_result = min_summary_dist, metric = "mean")

## -----------------------------------------------------------------------------
sessionInfo()

