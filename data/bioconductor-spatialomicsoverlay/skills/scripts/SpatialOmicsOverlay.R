# Code example from 'SpatialOmicsOverlay' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  fig.width = 10,
  fig.retina = 1
)

options(java.parameters = "-Xmx4g")
library(RBioFormats)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("GeomxTools")
# BiocManager::install("SpatialOmicsOverlay")

## ----Load Libraries-----------------------------------------------------------
library(SpatialOmicsOverlay)
library(GeomxTools)

## ----tiff file----------------------------------------------------------------
tifFile <- downloadMouseBrainImage()
tifFile

## ----Read in Data-------------------------------------------------------------
muBrainLW <- system.file("extdata", "muBrain_LabWorksheet.txt",
                         package = "SpatialOmicsOverlay")

muBrain <- readSpatialOverlay(ometiff = tifFile, annots = muBrainLW, 
                              slideName = "D5761 (3)", image = FALSE,  
                              saveFile = FALSE, outline = FALSE)

## ----object accessors---------------------------------------------------------
#full object
muBrain
#sample names
head(sampNames(muBrain))
#slide name
slideName(muBrain)
#metadata of ROI overlays
#Height, Width, X, Y values are in pixels
head(meta(overlay(muBrain)))
#coordinates of each ROI
head(coords(muBrain))

## ----plot w/o image Sample_ID-------------------------------------------------
plotSpatialOverlay(overlay = muBrain, hiRes = FALSE, legend = FALSE)

## ----add plotting factors-----------------------------------------------------
muBrainAnnots <- readLabWorksheet(lw = muBrainLW, slideName = "D5761 (3)")
muBrainGeomxSet <- readRDS(unzip(system.file("extdata", "muBrain_GxT.zip",
                                  package = "SpatialOmicsOverlay")))
muBrain <- addPlottingFactor(overlay = muBrain, annots = muBrainAnnots, 
                             plottingFactor = "segment")
muBrain <- addPlottingFactor(overlay = muBrain, annots = muBrainGeomxSet, 
                             plottingFactor = "Calm1")
muBrain <- addPlottingFactor(overlay = muBrain, annots = 1:length(sampNames(muBrain)), 
                             plottingFactor = "ROILabel")
muBrain
head(plotFactors(muBrain))

## ----customizable ggplot------------------------------------------------------
plotSpatialOverlay(overlay = muBrain, hiRes = FALSE, colorBy = "Calm1", 
                   scaleBarWidth = 0.3, scaleBarColor = "green") +
    viridis::scale_color_viridis()+
    ggplot2::labs(title = "Calm1 Expression in Mouse Brain")

## ----pyramidal tiff, echo=FALSE, fig.cap="Pyramidal TIFF", out.width = '50%'----
knitr::include_graphics("images/pyramidalTIFF.png")

## ----add image----------------------------------------------------------------
#lowest resolution = fastest speeds
checkValidRes(ometiff = tifFile)
res <- 8
muBrain <- addImageOmeTiff(overlay = muBrain, ometiff = tifFile, res = res)
muBrain
showImage(muBrain)

## ----plot with image----------------------------------------------------------
plotSpatialOverlay(overlay = muBrain, colorBy = "segment", corner = "topcenter", 
                   scaleBarWidth = 0.5, textDistance = 130, scaleBarColor = "cyan")

## ----fluorLegend in plotSpatialOverlay----------------------------------------
plotSpatialOverlay(overlay = muBrain, colorBy = "segment", corner = "topcenter", 
                   scaleBarWidth = 0.5, textDistance = 130, scaleBarColor = "cyan",
                   fluorLegend = TRUE)

## ----fluorLegend function-----------------------------------------------------
library(cowplot)
gp <- plotSpatialOverlay(overlay = muBrain, colorBy = "segment", 
                         corner = "bottomright")
legend <- fluorLegend(muBrain, nrow = 2, textSize = 4, 
                      boxColor = "grey85", alpha = 0.3)
cowplot::ggdraw() +
    cowplot::draw_plot(gp) +
    cowplot::draw_plot(legend, scale = 0.105, x = 0.1, y = -0.25)

## ----flip axes----------------------------------------------------------------
muBrain <- flipY(muBrain)
plotSpatialOverlay(overlay = muBrain, colorBy = "segment", scaleBar = FALSE)
plotSpatialOverlay(overlay = flipX(muBrain), colorBy = "segment", scaleBar = FALSE)

## ----crop tissue--------------------------------------------------------------
muBrain <- cropTissue(overlay = muBrain, buffer = 0.05)
plotSpatialOverlay(overlay = muBrain, colorBy = "ROILabel", legend = FALSE, scaleBar = FALSE)+
    viridis::scale_fill_viridis(option = "C")

## ----crop samples-------------------------------------------------------------
samps <- muBrainAnnots$Sample_ID[muBrainAnnots$segment == "Full ROI" & 
                                     muBrainAnnots$slide.name == slideName(muBrain)]

muBrainCrop <- cropSamples(overlay = muBrain, sampleIDs = samps, sampsOnly = TRUE)
plotSpatialOverlay(overlay = muBrainCrop, colorBy = "Calm1", scaleBar = TRUE, 
                   corner = "bottomleft", textDistance = 5)+
    ggplot2::scale_fill_gradient2(low = "grey", high = "red", 
                                  mid = "yellow", midpoint = 2500)

muBrainCrop <- cropSamples(overlay = muBrain, sampleIDs = samps, sampsOnly = FALSE)
plotSpatialOverlay(overlay = muBrainCrop, colorBy = "segment", scaleBar = TRUE, 
                   corner = "bottomleft", textDistance = 5)

## ----image coloring-----------------------------------------------------------
chan4 <- add4ChannelImage(overlay = muBrain)
fluor(chan4)
chan4 <- changeImageColoring(overlay = chan4, color = "#32a8a4", dye = "FITC")
chan4 <- changeImageColoring(overlay = chan4, color = "magenta", dye = "Alexa 647")
chan4 <- changeColoringIntensity(overlay = chan4, minInten = 500, 
                                 maxInten = 10000, dye = "Cy5")
fluor(chan4)
# change 4 channel TIFF to RGB
chan4 <- recolor(chan4)
showImage(chan4)

## -----------------------------------------------------------------------------
sessionInfo()

