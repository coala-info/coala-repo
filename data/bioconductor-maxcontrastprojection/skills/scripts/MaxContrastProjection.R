# Code example from 'MaxContrastProjection' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results='asis'-------------------------------------
BiocStyle::latex()

## ----eval=FALSE------------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly=TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("MaxContrastProjection")

## --------------------------------------------------------------------------
library(MaxContrastProjection)
library(EBImage)
data(cells)
dim(cells)

## --------------------------------------------------------------------------
max_contrast = contrastProjection(imageStack = cells, w_x = 15, w_y = 15, 
                                smoothing = 5, brushShape = "box")

## --------------------------------------------------------------------------
max_contrast_large = contrastProjection(imageStack = cells[30:95, 55:115,], 
                                        w_x = 15, w_y = 15, smoothing = 5, 
                                        brushShape = "box")
max_contrast_small = contrastProjection(imageStack = cells[30:95, 55:115,], 
                                        w_x = 3, w_y = 3, smoothing = 5, 
                                        brushShape = "box")

## ----echo=FALSE------------------------------------------------------------
display(max_contrast_large / max(cells), method = "raster")

## ----echo=FALSE------------------------------------------------------------
display(max_contrast_small / max(cells), method = "raster")

## --------------------------------------------------------------------------
contrastStack = getContrastStack(imageStack = cells, w_x = 15, w_y = 15, 
                                brushShape = "box")
indexMap = getIndexMap(contrastStack = contrastStack, smoothing = 5)
max_contrast_fromMap = projection_fromMap(imageStack = cells, 
                                        indexMap = indexMap)

## --------------------------------------------------------------------------
max_intensity_proj = intensityProjection(imageStack = cells, projType = "max")
min_intensity_proj = intensityProjection(imageStack = cells, projType = "min")
mean_intensity_proj = intensityProjection(imageStack = cells, 
                                        projType = "mean")
median_intensity_proj = intensityProjection(imageStack = cells, 
                                            projType = "median")
sd_intensity_proj = intensityProjection(imageStack = cells, projType = "sd")
sum_intensity_proj = intensityProjection(imageStack = cells, projType = "sum")

## ----sessioninfo, results='asis'-------------------------------------------
toLatex(sessionInfo())

