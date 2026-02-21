# Code example from 'spatial-heterogeneity' vignette. See references/ for full tutorial.

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

## -----------------------------------------------------------------------------
calculate_entropy(formatted_image, cell_types_of_interest = c("Immune1","Immune2"), 
                  feature_colname = "Cell.Type")

## ----out.width = "70%"--------------------------------------------------------
data("defined_image")
grid <- grid_metrics(defined_image, FUN = calculate_entropy, n_split = 20,
                     cell_types_of_interest=c("Tumour","Immune3"), 
                     feature_colname = "Cell.Type")

## -----------------------------------------------------------------------------
calculate_percentage_of_grids(grid, threshold = 0.75, above = TRUE)

## -----------------------------------------------------------------------------
calculate_spatial_autocorrelation(grid, metric = "globalmoran")

## -----------------------------------------------------------------------------
gradient_positions <- c(30, 50, 100)
gradient_entropy <- 
  compute_gradient(defined_image, radii = gradient_positions, 
                   FUN = calculate_entropy,  cell_types_of_interest = c("Immune1","Immune2"),
                   feature_colname = "Cell.Type")
length(gradient_entropy)
head(gradient_entropy[[1]])

## -----------------------------------------------------------------------------
gradient_pos <- seq(50, 500, 50) ##radii
gradient_results <- entropy_gradient_aggregated(defined_image, cell_types_of_interest = c("Immune3","Tumour"),
                                                feature_colname = "Cell.Type", radii = gradient_pos)
# plot the results
plot(1:10,gradient_results$gradient_df[1, 3:12])

## -----------------------------------------------------------------------------
sessionInfo()

