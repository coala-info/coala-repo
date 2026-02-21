# Code example from 'data_reading-formatting' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----message=FALSE------------------------------------------------------------
library(SPIAT)

## -----------------------------------------------------------------------------
# Construct a dummy marker intensity matrix
## rows are markers, columns are cells
intensity_matrix <- matrix(c(14.557, 0.169, 1.655, 0.054,
                             17.588, 0.229, 1.188, 2.074, 
                             21.262, 4.206,  5.924, 0.021), nrow = 4, ncol = 3)
# define marker names as rownames
rownames(intensity_matrix) <- c("DAPI", "CD3", "CD4", "AMACR")
# define cell IDs as colnames
colnames(intensity_matrix) <- c("Cell_1", "Cell_2", "Cell_3") 

# Construct a dummy metadata (phenotypes, x/y coordinates)
# the order of the elements in these vectors correspond to the cell order 
# in `intensity matrix`
phenotypes <- c("OTHER",  "AMACR", "CD3,CD4")
coord_x <- c(82, 171, 184)
coord_y <- c(30, 22, 38)

general_format_image <- format_image_to_spe(format = "general", 
                                            intensity_matrix = intensity_matrix,
                                            phenotypes = phenotypes, 
                                            coord_x = coord_x,coord_y = coord_y)

## -----------------------------------------------------------------------------
# phenotypes and cell properties (if available)
colData(general_format_image)
# cell coordinates
spatialCoords(general_format_image)
# marker intensities
assay(general_format_image)

## ----message=FALSE------------------------------------------------------------
raw_inform_data <- system.file("extdata", "tiny_inform.txt.gz", package = "SPIAT")
markers <- c("DAPI", "CD3", "PD-L1", "CD4", "CD8", "AMACR")
locations <- c("Nucleus","Cytoplasm", "Membrane","Cytoplasm","Cytoplasm",
               "Cytoplasm") # The order is the same as `markers`.
formatted_image <- format_image_to_spe(format="inForm", path=raw_inform_data, 
                                       markers=markers, locations=locations)

## ----message=FALSE------------------------------------------------------------
raw_inform_data <- system.file("extdata", "tiny_inform.txt.gz", package = "SPIAT")
markers <- c("DAPI", "CD3", "PD-L1", "CD4", "CD8", "AMACR")
intensity_columns_interest <- c(
  "Nucleus DAPI (DAPI) Mean (Normalized Counts, Total Weighting)",
  "Cytoplasm CD3 (Opal 520) Mean (Normalized Counts, Total Weighting)", 
  "Membrane PD-L1 (Opal 540) Mean (Normalized Counts, Total Weighting)",
  "Cytoplasm CD4 (Opal 620) Mean (Normalized Counts, Total Weighting)",
  "Cytoplasm CD8 (Opal 650) Mean (Normalized Counts, Total Weighting)", 
  "Cytoplasm AMACR (Opal 690) Mean (Normalized Counts, Total Weighting)"
  ) # The order is the same as `markers`.
formatted_image <- format_inform_to_spe(path=raw_inform_data, markers=markers,
                     intensity_columns_interest=intensity_columns_interest)
class(formatted_image) # The formatted image is a SpatialExperiment object
dim(colData(formatted_image))
dim(assay(formatted_image))

## ----message=FALSE------------------------------------------------------------
raw_halo_data <- system.file("extdata", "tiny_halo.csv.gz", package = "SPIAT")
markers <- c("DAPI", "CD3", "PD-L1", "CD4", "CD8", "AMACR")
intensity_columns_interest <- c("Dye 1 Nucleus Intensity",
                                "Dye 2 Cytoplasm Intensity",
                                "Dye 3 Membrane Intensity",
                                "Dye 4 Cytoplasm Intensity",
                                "Dye 5 Cytoplasm Intensity",
                                "Dye 6 Cytoplasm Intensity")
dye_columns_interest <- c("Dye 1 Positive Nucleus",
                          "Dye 2 Positive Cytoplasm",
                          "Dye 3 Positive Membrane",
                          "Dye 4 Positive Cytoplasm",
                          "Dye 5 Positive Cytoplasm",
                          "Dye 6 Positive Cytoplasm")
formatted_image <- format_halo_to_spe(
  path=raw_halo_data, markers=markers,
  intensity_columns_interest=intensity_columns_interest,
  dye_columns_interest=dye_columns_interest)
class(formatted_image) # The formatted image is a SpatialExperiment object
dim(colData(formatted_image))
dim(assay(formatted_image))

## -----------------------------------------------------------------------------
data("simulated_image")

## -----------------------------------------------------------------------------
class(simulated_image)

## -----------------------------------------------------------------------------
dim(simulated_image)

## -----------------------------------------------------------------------------
# take a look at first 5 columns
assay(simulated_image)[, 1:5]

## -----------------------------------------------------------------------------
# take a look at first 5 rows
colData(simulated_image)[1:5, ]

## -----------------------------------------------------------------------------
# take a look at first 5 rows
spatialCoords(simulated_image)[1:5, ]

## -----------------------------------------------------------------------------
unique(simulated_image$Phenotype)

## -----------------------------------------------------------------------------
split_image <- image_splitter(simulated_image, number_of_splits=3, plot = FALSE)

## ----fig.height=6, fig.width = 4----------------------------------------------
predicted_image <- predict_phenotypes(spe_object = simulated_image,
                                      thresholds = NULL,
                                      tumour_marker = "Tumour_marker",
                                      baseline_markers = c("Immune_marker1", 
                                                           "Immune_marker2", 
                                                           "Immune_marker3", 
                                                           "Immune_marker4"),
                                      reference_phenotypes = TRUE)

## ----fig.width = 9, fig.height=2, out.width="100%"----------------------------
marker_prediction_plot(predicted_image, marker="Immune_marker1")

## ----eval=FALSE---------------------------------------------------------------
# predicted_image2 <- predict_phenotypes(spe_object = simulated_image,
#                                       thresholds = NULL,
#                                       tumour_marker = "Tumour_marker",
#                                       baseline_markers = c("Immune_marker1",
#                                                            "Immune_marker2",
#                                                            "Immune_marker3",
#                                                            "Immune_marker4"),
#                                       reference_phenotypes = FALSE)

## ----include=FALSE------------------------------------------------------------
predicted_image2 <- predict_phenotypes(spe_object = simulated_image,
                                      thresholds = NULL,
                                      tumour_marker = "Tumour_marker",
                                      baseline_markers = c("Immune_marker1", 
                                                           "Immune_marker2", 
                                                           "Immune_marker3", 
                                                           "Immune_marker4"),
                                      reference_phenotypes = FALSE)

## -----------------------------------------------------------------------------
formatted_image <- define_celltypes(
    simulated_image, 
    categories = c("Tumour_marker","Immune_marker1,Immune_marker2", 
                   "Immune_marker1,Immune_marker3", 
                   "Immune_marker1,Immune_marker2,Immune_marker4", "OTHER"), 
    category_colname = "Phenotype", 
    names = c("Tumour", "Immune1", "Immune2", "Immune3", "Others"),
    new_colname = "Cell.Type")

## -----------------------------------------------------------------------------
sessionInfo()

