# Code example from 'lisaClust' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE, message = FALSE, warning = FALSE
)
library(BiocStyle)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager")) {
#   install.packages("BiocManager")
# }
# BiocManager::install("lisaClust")

## ----message=FALSE, warning=FALSE---------------------------------------------
# load required packages
library(lisaClust)
library(spicyR)
library(ggplot2)
library(SingleCellExperiment)
library(SpatialDatasets)

## ----eval=T-------------------------------------------------------------------
set.seed(51773)
x <- round(c(
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3,
  runif(200) + 3, runif(200) + 2, runif(200) + 1, runif(200)
), 4) * 100
y <- round(c(
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3,
  runif(200), runif(200) + 1, runif(200) + 2, runif(200) + 3
), 4) * 100
cellType <- factor(paste("c", rep(rep(c(1:2), rep(200, 2)), 4), sep = ""))
imageID <- rep(c("s1", "s2"), c(800, 800))

cells <- data.frame(x, y, cellType, imageID)

ggplot(cells, aes(x, y, colour = cellType)) +
  geom_point() +
  facet_wrap(~imageID) +
  theme_minimal()

## -----------------------------------------------------------------------------
SCE <- SingleCellExperiment(colData = cells)
SCE

## -----------------------------------------------------------------------------
SCE <- lisaClust(SCE, k = 2)
colData(SCE) |> head()

## -----------------------------------------------------------------------------
hatchingPlot(SCE, useImages = c("s1", "s2"))

## -----------------------------------------------------------------------------
lisaCurves <- lisa(SCE, Rs = c(20, 50, 100))

head(lisaCurves)

## -----------------------------------------------------------------------------
# Custom clustering algorithm
kM <- kmeans(lisaCurves, 2)

# Storing clusters into colData
colData(SCE)$custom_region <- paste("region", kM$cluster, sep = "_")
colData(SCE) |> head()

## -----------------------------------------------------------------------------
kerenSPE <- SpatialDatasets::spe_Keren_2018()

## -----------------------------------------------------------------------------
kerenSPE <- kerenSPE[,kerenSPE$imageID %in% c("5", "6")]

kerenSPE <- lisaClust(kerenSPE,
  k = 5
)

## -----------------------------------------------------------------------------
colData(kerenSPE)[, c("imageID", "region")] |>
  head(20)

## -----------------------------------------------------------------------------
regionMap(kerenSPE,
  type = "bubble"
)

## ----fig.height=7, fig.width=9------------------------------------------------
hatchingPlot(kerenSPE, nbp = 300)

## -----------------------------------------------------------------------------
sessionInfo()

