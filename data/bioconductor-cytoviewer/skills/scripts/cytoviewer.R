# Code example from 'cytoviewer' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE,
                        fig.retina = 0.75, crop = NULL)
library(BiocStyle)

## ----library, echo=FALSE------------------------------------------------------
library(cytoviewer)

## ----bioc-install, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("cytoviewer")

## ----devel-install, eval=FALSE------------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE))
#     install.packages("remotes")
# 
# remotes::install_github("BodenmillerGroup/cytoviewer")

## ----load---------------------------------------------------------------------
library(cytoviewer)

## ----dataset------------------------------------------------------------------
# Load example datasets 
library(cytomapper)
data("pancreasImages")
data("pancreasMasks")
data("pancreasSCE")

pancreasImages
pancreasMasks 
pancreasSCE

## ----cytoviewer---------------------------------------------------------------
# Use cytoviewer with images, masks and object
app <- cytoviewer(image = pancreasImages, 
                  mask = pancreasMasks, 
                  object = pancreasSCE, 
                  img_id = "ImageNb", 
                  cell_id = "CellNb")

if (interactive()) {
  
  shiny::runApp(app, launch.browser = TRUE)

  }

## ----read-in-images-----------------------------------------------------------
library(cytomapper)

# Data directory that stores images and masks in tiff format
data_path <- system.file("extdata", package = "cytomapper")

# Read in images
cur_images <- loadImages(data_path, pattern = "_imc.tiff")
cur_images

# Read in masks
cur_masks <- loadImages(data_path, pattern = "_mask.tiff", as.is = TRUE)
cur_masks

## ----add-metadata-------------------------------------------------------------
names(cur_images)
names(cur_masks)
mcols(cur_masks)$ImageNb <- mcols(cur_images)$ImageNb <- c("E34", "G01", "J02")

## ----channelNames-example-----------------------------------------------------
channelNames(cur_images) <- c("H3", "CD99", "PIN", "CD8a", "CDH")

## ----measureObjects-----------------------------------------------------------
cur_sce <- measureObjects(image = cur_images, 
                          mask = cur_masks, 
                          img_id = "ImageNb")
cur_sce

## ----cytoviewer-manual--------------------------------------------------------
# Use cytoviewer with images, masks and object
app_1 <- cytoviewer(image = cur_images, 
                  mask = cur_masks, 
                  object = cur_sce, 
                  img_id = "ImageNb", 
                  cell_id = "object_id")

if (interactive()) {
  
  shiny::runApp(app_1, launch.browser = TRUE)

  }

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

