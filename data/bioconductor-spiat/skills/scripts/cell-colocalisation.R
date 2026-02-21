# Code example from 'cell-colocalisation' vignette. See references/ for full tutorial.

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
average_percentage_of_cells_within_radius(spe_object = formatted_image, 
                                          reference_celltype = "Immune1", 
                                          target_celltype = "Immune2", 
                                          radius=100, feature_colname="Cell.Type")

## -----------------------------------------------------------------------------
average_marker_intensity_within_radius(spe_object = formatted_image,
                                       reference_marker ="Immune_marker3",
                                       target_marker = "Immune_marker2",
                                       radius=30)

## ----fig.height = 2.2, fig.width = 4------------------------------------------
plot_average_intensity(spe_object=formatted_image, reference_marker="Immune_marker3", 
                       target_marker="Immune_marker2", radii=c(30, 35, 40, 45, 50, 75, 100))

## -----------------------------------------------------------------------------
mixing_score_summary(spe_object = formatted_image, reference_celltype = "Immune1", 
                     target_celltype = "Immune2", radius=100, feature_colname ="Cell.Type")

## ----echo=FALSE, fig.width = 2, fig.height = 1, out.width = "100%"------------
knitr::include_graphics("cross-k-function.jpg")

## ----fig.width = 4.2----------------------------------------------------------
df_cross <- calculate_cross_functions(formatted_image, method = "Kcross", 
                                      cell_types_of_interest = c("Tumour","Immune2"), 
                                      feature_colname ="Cell.Type",
                                      dist = 100)

## -----------------------------------------------------------------------------
AUC_of_cross_function(df_cross)

## ----echo = FALSE, fig.height = 2.5-------------------------------------------
my_colors <- c("red", "blue", "darkcyan", "darkgreen")
plot_cell_categories(formatted_image, c("Tumour", "Immune1", "Immune2", "Immune3"), 
                     my_colors, "Cell.Type")

## ----fig.width = 4------------------------------------------------------------
df_cross <- calculate_cross_functions(formatted_image, method = "Kcross", 
                                      cell_types_of_interest = c("Tumour","Immune3"), 
                                      feature_colname ="Cell.Type",
                                      dist = 100)

## -----------------------------------------------------------------------------
crossing_of_crossK(df_cross)

## -----------------------------------------------------------------------------
sessionInfo()

