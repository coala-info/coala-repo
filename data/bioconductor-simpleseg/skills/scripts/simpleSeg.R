# Code example from 'simpleSeg' vignette. See references/ for full tutorial.

params <-
list(test = FALSE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(BiocStyle)

## ----warning=FALSE, message=FALSE---------------------------------------------
# load required packages
library(simpleSeg)
library(ggplot2)
library(EBImage)
library(cytomapper)

## ----eval = FALSE-------------------------------------------------------------
# # Install the package from Bioconductor
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("simpleSeg")

## -----------------------------------------------------------------------------
# Get path to image directory
pathToImages <- system.file("extdata", package = "simpleSeg")

# Get directories of images

imageDirs <- dir(pathToImages, "Point", full.names = TRUE)
names(imageDirs) <- dir(pathToImages, "Point", full.names = FALSE)





# Get files in each directory
files <- files <- lapply(
  imageDirs,
  list.files,
  pattern = "tif",
  full.names = TRUE
)

# Read files with readImage from EBImage
images <- lapply(files, EBImage::readImage, as.is = TRUE)

# Convert to cytoImageList
images <- cytomapper::CytoImageList(images)
mcols(images)$imageID <- names(images)

## -----------------------------------------------------------------------------
masks <- simpleSeg::simpleSeg(images,
  nucleus = "HH3",
  transform = "sqrt"
)

## -----------------------------------------------------------------------------
# Visualise segmentation performance one way.
EBImage::display(colorLabels(masks[[1]]))

## -----------------------------------------------------------------------------
# Visualise segmentation performance another way.
cytomapper::plotPixels(
  image = images[1],
  mask = masks[1],
  img_id = "imageID",
  colour_by = c("PanKRT", "GLUT1", "HH3", "CD3", "CD20"),
  display = "single",
  colour = list(
    HH3 = c("black", "blue"),
    CD3 = c("black", "purple"),
    CD20 = c("black", "green"),
    GLUT1 = c("black", "red"),
    PanKRT = c("black", "yellow")
  ),
  bcg = list(
    HH3 = c(0, 1, 1.5),
    CD3 = c(0, 1, 1.5),
    CD20 = c(0, 1, 1.5),
    GLUT1 = c(0, 1, 1.5),
    PanKRT = c(0, 1, 1.5)
  ),
  legend = NULL
)

## ----parallel example---------------------------------------------------------
masks <- simpleSeg::simpleSeg(images,
  nucleus = "HH3",
  cores = 1
)

## ----out.width = "400px"------------------------------------------------------
cellSCE <- cytomapper::measureObjects(masks, images, img_id = "imageID")

## -----------------------------------------------------------------------------
# Transform and normalise the marker expression of each cell type.
# Use a square root transform, then trimmed the 99 quantile
cellSCE <- normalizeCells(cellSCE,
  assayIn = "counts",
  assayOut = "norm",
  imageID = "imageID",
  transformation = "sqrt",
  method = c("trim99", "minMax")
)

## ----fig.width=5, fig.height=5------------------------------------------------
# Extract marker data and bind with information about images
df <- as.data.frame(cbind(colData(cellSCE), t(assay(cellSCE, "counts"))))

# Plots densities of PanKRT for each image.
ggplot(df, aes(x = PanKRT, colour = imageID)) +
  geom_density() +
  labs(x = "PanKRT expression") +
  theme_minimal()

## ----fig.width=5, fig.height=5------------------------------------------------
# Extract normalised marker information.
df <- as.data.frame(cbind(colData(cellSCE), t(assay(cellSCE, "norm"))))

# Plots densities of normalised PanKRT for each image.
ggplot(df, aes(x = PanKRT, colour = imageID)) +
  geom_density() +
  labs(x = "PanKRT expression") +
  theme_minimal()

## -----------------------------------------------------------------------------
sessionInfo()

