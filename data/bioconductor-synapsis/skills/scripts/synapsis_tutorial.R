# Code example from 'synapsis_tutorial' vignette. See references/ for full tutorial.

## ----setup--------------------------------------------------------------------
library(knitr)
library(rmarkdown)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("synapsis")

## ----eval = FALSE-------------------------------------------------------------
# library(devtools)

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_git('https://github.com/mcneilllucy/synapsis', dependencies  = TRUE)

## -----------------------------------------------------------------------------
library(synapsis)

## ----eval = FALSE-------------------------------------------------------------
# ??auto_crop_fast

## -----------------------------------------------------------------------------
path = paste0(system.file("extdata",package = "synapsis"))

## -----------------------------------------------------------------------------
library(EBImage)

## -----------------------------------------------------------------------------
file_MLH3 <- paste0(path,"/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-MLH3.tif")
image_MLH3 <- readImage(file_MLH3)

## ----eval = FALSE-------------------------------------------------------------
# display(2*image_MLH3)

## -----------------------------------------------------------------------------
file_SYCP3 <- paste0(path,"/MLH3rabbit488_SYCP3mouse594_fancm_fvb_x_fancm_bl6_724++_slide01_006-SYCP3.tif")
image_SYCP3 <- readImage(file_SYCP3)

## ----eval = FALSE-------------------------------------------------------------
# display(2*image_SYCP3)

## -----------------------------------------------------------------------------
cat("dimension of image:", dim(image_MLH3)[1], " x ", dim(image_MLH3)[2], sep = " ")

## -----------------------------------------------------------------------------
mb = 1e06
cat("file size in mb:", file.size(file_MLH3)/mb, sep = " ")

## -----------------------------------------------------------------------------
auto_crop_fast(path, annotation = "on", max_cell_area = 30000, min_cell_area = 7000, file_ext = "tif")

## -----------------------------------------------------------------------------
unlink(paste0(path,"/crops-RGB/"), recursive = TRUE) 
unlink(paste0(path,"/crops/"), recursive = TRUE) 

## -----------------------------------------------------------------------------
auto_crop_fast(path, annotation = "on", max_cell_area = 30000, min_cell_area = 7000, file_ext = "tif",crowded_cells = TRUE)

## -----------------------------------------------------------------------------
SYCP3_stats <- get_pachytene(path,ecc_thresh = 0.8, area_thresh = 0.04, annotation = "on",file_ext = "tif")

## -----------------------------------------------------------------------------
foci_counts <- count_foci(path,offset_factor = 8, brush_size = 3, offset_px = 0.6, brush_sigma = 3, annotation = "on", stage = "pachytene",file_ext = "tif", watershed_stop= "on",  crowded_foci = FALSE, C1 = 0.03, disc_size_foci = 9)

## -----------------------------------------------------------------------------
print(foci_counts)

## -----------------------------------------------------------------------------
unlink(paste0(path,"/crops-RGB/"), recursive = TRUE) 
unlink(paste0(path,"/crops/"), recursive = TRUE) 

