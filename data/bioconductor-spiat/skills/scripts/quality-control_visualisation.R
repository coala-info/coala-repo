# Code example from 'quality-control_visualisation' vignette. See references/ for full tutorial.

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

## ----fig.height = 2, fig.width = 3.2------------------------------------------
marker_intensity_boxplot(formatted_image, "Immune_marker1")

## ----fig.height=3, fig.width=6, dpi = 72, out.width="100%"--------------------
plot_cell_marker_levels(formatted_image, "Immune_marker1")

## ----fig.height = 2.2, out.width="75%"----------------------------------------
plot_marker_level_heatmap(formatted_image, num_splits = 100, "Tumour_marker")

## -----------------------------------------------------------------------------
data_subset <- select_celltypes(
  formatted_image, keep=TRUE,
  celltypes = c("Tumour_marker","Immune_marker1,Immune_marker3", 
                "Immune_marker1,Immune_marker2",
                "Immune_marker1,Immune_marker2,Immune_marker4"),
  feature_colname = "Phenotype")
# have a look at what phenotypes are present
unique(data_subset$Phenotype)

## -----------------------------------------------------------------------------
# First predict the phenotypes (this is for generating not 100% accurate phenotypes)
predicted_image2 <- predict_phenotypes(spe_object = simulated_image,
                                      thresholds = NULL,
                                      tumour_marker = "Tumour_marker",
                                      baseline_markers = c("Immune_marker1", 
                                                           "Immune_marker2", 
                                                           "Immune_marker3", 
                                                           "Immune_marker4"),
                                      reference_phenotypes = FALSE)

# Then define the cell types based on predicted phenotypes
predicted_image2 <- define_celltypes(
  predicted_image2, 
  categories = c("Tumour_marker", "Immune_marker1,Immune_marker2",
                 "Immune_marker1,Immune_marker3", 
                 "Immune_marker1,Immune_marker2,Immune_marker4"), 
  category_colname = "Phenotype",
  names = c("Tumour", "Immune1", "Immune2",  "Immune3"),
  new_colname = "Cell.Type")

# Delete cells with unrealistic marker combinations from the dataset
predicted_image2 <- 
  select_celltypes(predicted_image2, "Undefined", feature_colname = "Cell.Type",
                   keep = FALSE)

# TSNE plot
g <- dimensionality_reduction_plot(predicted_image2, plot_type = "TSNE", 
                                   feature_colname = "Cell.Type")

## ----echo=TRUE, eval=FALSE----------------------------------------------------
# plotly::ggplotly(g)

## ----echo=FALSE, fig.width = 4, fig.height = 4, out.width = "70%"-------------
knitr::include_graphics("tSNE1.jpg")

## ----eval=FALSE---------------------------------------------------------------
# predicted_image2 <-
#   select_celltypes(predicted_image2, c("Cell_3302", "Cell_4917", "Cell_2297",
#                                        "Cell_488", "Cell_4362", "Cell_4801",
#                                        "Cell_2220", "Cell_3431", "Cell_533",
#                                        "Cell_4925", "Cell_4719", "Cell_469",
#                                        "Cell_1929", "Cell_310", "Cell_2536",
#                                        "Cell_321", "Cell_4195"),
#                    feature_colname = "Cell.ID", keep = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # TSNE plot
# g <- dimensionality_reduction_plot(predicted_image2, plot_type = "TSNE", feature_colname = "Cell.Type")
# 
# # plotly::ggplotly(g) # uncomment this code to interact with the plot

## ----echo=FALSE, fig.width = 4, fig.height = 4, out.width = "70%"-------------
knitr::include_graphics("tSNE2.jpg")

## ----fig.height = 2.5---------------------------------------------------------
my_colors <- c("red", "blue", "darkcyan", "darkgreen")
  
plot_cell_categories(spe_object = formatted_image, 
                     categories_of_interest = 
                       c("Tumour", "Immune1", "Immune2", "Immune3"), 
                     colour_vector = my_colors, feature_colname = "Cell.Type")

## ----eval=FALSE---------------------------------------------------------------
# marker_surface_plot(formatted_image, num_splits=15, marker="Immune_marker1")

## ----echo=FALSE, out.width = "75%"--------------------------------------------
knitr::include_graphics("marker_surface1.jpg")

## ----eval=FALSE---------------------------------------------------------------
# marker_surface_plot_stack(formatted_image, num_splits=15, markers=c("Tumour_marker", "Immune_marker1"))

## ----echo=FALSE, out.width = "75%"--------------------------------------------
knitr::include_graphics("marker_surface2.jpg")

## -----------------------------------------------------------------------------
sessionInfo()

