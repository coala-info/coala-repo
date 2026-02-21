# Code example from 'SpotClean' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
require(knitr)
opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
set.seed(1)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("SpotClean")
# 

## -----------------------------------------------------------------------------
library(SpotClean)
library(S4Vectors)

## ----eval=FALSE---------------------------------------------------------------
# # Not run
# 
# # Load 10x Visium data
# mbrain_raw <- read10xRaw("/path/to/matrix/folder")
# mbrain_slide_info <- read10xSlide("/path/to/tissue/csv",
#                                   "/path/to/tissue/image",
#                                   "/path/to/scale/factor")
# 
# # Visualize raw data
# mbrain_obj <- createSlide(count_mat = mbrain_raw,
#                           slide_info = mbrain_slide_info)
# visualizeSlide(slide_obj = mbrain_obj)
# visualizeHeatmap(mbrain_obj,rownames(mbrain_raw)[1])
# 
# # Decontaminate raw data
# decont_obj <- spotclean(mbrain_obj)
# 
# # Visualize decontaminated gene
# visualizeHeatmap(decont_obj,rownames(mbrain_raw)[1])
# 
# # Visualize the estimated per-spot contamination rate
# visualizeHeatmap(decont_obj,metadata(decont_obj)$contamination_rate,
#                  logged = FALSE, legend_title = "contamination rate",
#                  legend_range = c(0,1))
# 
# # (Optionally) Transform to Seurat object for downstream analyses
# seurat_obj <- convertToSeurat(decont_obj,image_dir = "/path/to/spatial/folder")

## ----eval=F-------------------------------------------------------------------
# # Not run
# library(SpatialExperiment)
# slide_obj <- read10xVisium(samples = "/path/to/spaceranger/output/",
#                          data = "raw") # must specify data = "raw"
# decont_obj <- spotclean(slide_obj)
# str(assays(decont_obj)$decont)

## -----------------------------------------------------------------------------
# load count matrix
data(mbrain_raw)
str(mbrain_raw)

# read spatial metadata
spatial_dir <- system.file(file.path("extdata",
                                     "V1_Adult_Mouse_Brain_spatial"),
                           package = "SpotClean")
list.files(spatial_dir)

mbrain_slide_info <- read10xSlide(tissue_csv_file=file.path(spatial_dir,
                                       "tissue_positions_list.csv"),
             tissue_img_file = file.path(spatial_dir,
                                       "tissue_lowres_image.png"),
             scale_factor_file = file.path(spatial_dir,
                                       "scalefactors_json.json"))
str(mbrain_slide_info)

## -----------------------------------------------------------------------------
slide_obj <- createSlide(mbrain_raw, mbrain_slide_info)
slide_obj

## ----fig.width=5, fig.height=5------------------------------------------------
visualizeSlide(slide_obj)

## ----fig.width=5, fig.height=4------------------------------------------------
visualizeLabel(slide_obj,"tissue")

## ----fig.width=5, fig.height=4------------------------------------------------
metadata(slide_obj)$slide$total_counts <- Matrix::colSums(mbrain_raw)
visualizeHeatmap(slide_obj,"total_counts")

## ----fig.width=5, fig.height=4------------------------------------------------
visualizeHeatmap(slide_obj,"Mbp")

## -----------------------------------------------------------------------------
decont_obj <- spotclean(slide_obj, maxit=10, candidate_radius = 20)

## -----------------------------------------------------------------------------
decont_obj
names(metadata(decont_obj))

## ----fig.width=5, fig.height=4------------------------------------------------
visualizeHeatmap(decont_obj,"Mbp")

## -----------------------------------------------------------------------------
summary(metadata(decont_obj)$contamination_rate)

## -----------------------------------------------------------------------------
arcScore(slide_obj)

## -----------------------------------------------------------------------------
seurat_obj <- convertToSeurat(decont_obj,image_dir = spatial_dir)

## -----------------------------------------------------------------------------
sessionInfo()

