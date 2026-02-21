# Code example from 'MoleculeExperiment' vignette. See references/ for full tutorial.

## ----global-options, include=FALSE--------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE,
  collapse = TRUE,
  comment = "#>"
)
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# BiocManager::install("MoleculeExperiment")

## -----------------------------------------------------------------------------
library(MoleculeExperiment)
library(ggplot2)
library(EBImage)

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")

me <- readXenium(repoDir, keepCols = "essential")
me

## -----------------------------------------------------------------------------
ggplot_me() +
  geom_polygon_me(me, assayName = "cell", fill = "grey") +
  geom_point_me(me) +
  # zoom in to selected patch area
  coord_cartesian(
    xlim = c(4900, 4919.98),
    ylim = c(6400.02, 6420)
  )

## -----------------------------------------------------------------------------
ggplot_me() +
  geom_polygon_me(me, assayName = "cell", fill = "grey") +
  geom_point_me(me, byColour = "feature_id", selectFeatures = c("Nrn1", "Slc17a7")) +
  # zoom in to selected patch area
  coord_cartesian(
    xlim = c(4900, 4919.98),
    ylim = c(6400.02, 6420)
  )

## -----------------------------------------------------------------------------
# transform ME to SPE object
spe <- countMolecules(me)
spe

## -----------------------------------------------------------------------------
moleculesDf <- data.frame(
  sample_id = rep(c("sample1", "sample2"), times = c(30, 20)),
  features = rep(c("gene1", "gene2"), times = c(20, 30)),
  x_coords = runif(50),
  y_coords = runif(50)
)
head(moleculesDf)

## -----------------------------------------------------------------------------
boundariesDf <- data.frame(
  sample_id = rep(c("sample1", "sample2"), times = c(16, 6)),
  cell_id = rep(
    c(
      "cell1", "cell2", "cell3", "cell4",
      "cell1", "cell2"
    ),
    times = c(4, 4, 4, 4, 3, 3)
  ),
  vertex_x = c(
    0, 0.5, 0.5, 0,
    0.5, 1, 1, 0.5,
    0, 0.5, 0.5, 0,
    0.5, 1, 1, 0.5,
    0, 1, 0, 0, 1, 1
  ),
  vertex_y = c(
    0, 0, 0.5, 0.5,
    0, 0, 0.5, 0.5,
    0.5, 0.5, 1, 1,
    0.5, 0.5, 1, 1,
    0, 1, 1, 0, 0, 1
  )
)
head(boundariesDf)

## -----------------------------------------------------------------------------
moleculesMEList <- dataframeToMEList(moleculesDf,
  dfType = "molecules",
  assayName = "detected",
  sampleCol = "sample_id",
  factorCol = "features",
  xCol = "x_coords",
  yCol = "y_coords"
)
str(moleculesMEList, max.level = 3)

## -----------------------------------------------------------------------------
boundariesMEList <- dataframeToMEList(boundariesDf,
  dfType = "boundaries",
  assayName = "cell",
  sampleCol = "sample_id",
  factorCol = "cell_id",
  xCol = "vertex_x",
  yCol = "vertex_y"
)
str(boundariesMEList, 3)

## -----------------------------------------------------------------------------
toyME <- MoleculeExperiment(
  molecules = moleculesMEList,
  boundaries = boundariesMEList
)
toyME

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
segMask <- paste0(repoDir, "/BIDcell_segmask.tif")
boundaries(toyME, "BIDcell_segmentation") <- readSegMask(
  # use the molecule extent to define the boundary extent
  extent(toyME, assayName = "detected"),
  path = segMask, assayName = "BIDcell_segmentation",
  sample_id = "sample1", background_value = 0
)

toyME

## ----warning=FALSE------------------------------------------------------------
BIDcell_segmask_img <- EBImage::readImage(segMask)
EBImage::display(BIDcell_segmask_img, method = "raster")

## -----------------------------------------------------------------------------
ggplot_me() + 
  geom_polygon_me(toyME, assayName = "cell", byFill = "segment_id", colour = "black", alpha = 0.3) + 
  geom_polygon_me(toyME, assayName = "BIDcell_segmentation", fill = NA, colour = "red" ) + 
  geom_point_me(toyME, assayName = "detected", byColour = "feature_id", size = 1) +
  theme_classic()

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")

me <- readXenium(repoDir, keepCols = "essential", addBoundaries = "cell")
me

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/nanostring_Lung9_Rep1")

meCosmx <- readCosmx(repoDir, keepCols = "essential", addBoundaries = "cell")
meCosmx

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/vizgen_HumanOvarianCancerPatient2Slice2")
meMerscope <- readMerscope(repoDir,
  keepCols = "essential",
  addBoundaries = "cell"
)
meMerscope

## -----------------------------------------------------------------------------
showMolecules(me)

## -----------------------------------------------------------------------------
showBoundaries(me)

## ----echo=TRUE, results= 'hide'-----------------------------------------------
# NOTE: output not shown as it is too large
# access molecules slot (note: assay name needs to be specified)
molecules(me, assayName = "detected")
# access cell boundary information in boundaries slot
boundaries(me, assayName = "cell")

## -----------------------------------------------------------------------------
molecules(me, assayName = "detected", flatten = TRUE)

## -----------------------------------------------------------------------------
boundaries(me, assayName = "cell", flatten = TRUE)

## -----------------------------------------------------------------------------
# get features in sample 1
features(me, assayName = "detected")[[1]]

## -----------------------------------------------------------------------------
segmentIDs(me, "cell")

## -----------------------------------------------------------------------------
repoDir <- system.file("extdata", package = "MoleculeExperiment")
repoDir <- paste0(repoDir, "/xenium_V1_FF_Mouse_Brain")
nucleiMEList <- readBoundaries(
  dataDir = repoDir,
  pattern = "nucleus_boundaries.csv",
  segmentIDCol = "cell_id",
  xCol = "vertex_x",
  yCol = "vertex_y",
  keepCols = "essential",
  boundariesAssay = "nucleus",
  scaleFactorVector = 1
)

boundaries(me, "nucleus") <- nucleiMEList
me # note the addition of the nucleus boundaries to the boundaries slot

## -----------------------------------------------------------------------------
ggplot_me() +
  # add cell segments and colour by cell id
  geom_polygon_me(me, byFill = "segment_id", colour = "black", alpha = 0.1) +
  # add molecule points and colour by feature name
  geom_point_me(me, byColour = "feature_id", size = 0.1) +
  # add nuclei segments and colour the border with red
  geom_polygon_me(me, assayName = "nucleus", fill = NA, colour = "red") +
  # zoom in to selected patch area
  coord_cartesian(xlim = c(4900, 4919.98), ylim = c(6400.02, 6420))

## -----------------------------------------------------------------------------
new_extent = extent(meMerscope, "detected") - c(0, 100, 0, 0)
# new_extent = c(xmin = 924, xmax = 950, ymin = 26290, ymax = 26330)
new_extent

me_sub = subset_by_extent(meMerscope, new_extent)
me_sub

g1 = ggplot_me() +
  geom_polygon_me(meMerscope, byFill = "segment_id", colour = "black", alpha = 0.1) +
  geom_point_me(meMerscope, byColour = "feature_id", size = 0.1) +
  geom_polygon_me(meMerscope, assayName = "cell", fill = NA, colour = "red") + 
  ggtitle("Before subsetting")
g2 = ggplot_me() +
  geom_polygon_me(me_sub, byFill = "segment_id", colour = "black", alpha = 0.1) +
  geom_point_me(me_sub, byColour = "feature_id", size = 0.1) +
  geom_polygon_me(me_sub, assayName = "cell", fill = NA, colour = "red") + 
  ggtitle("After subsetting")

g1
g2

## -----------------------------------------------------------------------------
spe <- countMolecules(me, boundariesAssay = "nucleus")
spe

## -----------------------------------------------------------------------------
data(small_me)

## -----------------------------------------------------------------------------
bds_colours <- setNames(
  c("#F8766D", "#00BFC4"),
  c("Region 1", "Region 2")
)

fts_colours <- setNames(
  c("#FFD700", "#90EE90"),
  c("Pou3f1", "Sema3a")
)

file_path <- system.file("extdata/tiny_brain_shape2.csv", package = "MoleculeExperiment")

bds_shape_raw <- read.csv(file = file_path, header = TRUE)
bds_shape_raw$sample_id <- "xenium_tiny_subset"
bds_shape_raw$regionName <- names(bds_colours)[bds_shape_raw$index + 1]

bds_shape <- dataframeToMEList(bds_shape_raw,
  dfType = "boundaries",
  assayName = "virtualDissection",
  sampleCol = "sample_id",
  factorCol = "regionName",
  xCol = "axis.1",
  yCol = "axis.0",
  scaleFactor = 0.2125
)

boundaries(small_me, "virtualDissection") <- bds_shape

## -----------------------------------------------------------------------------
g <- ggplot() +
  geom_point_me(
    small_me,
    assayName = "detected", byColour = "feature_id", size = 0.2
  ) +
  geom_polygon_me(
    small_me,
    assayName = "cell", fill = NA, colour = "grey50", size = 0.1
  ) +
  geom_polygon_me(
    small_me,
    assayName = "nucleus", fill = NA, colour = "black", size = 0.1
  ) +
  geom_polygon_me(
    small_me,
    assayName = "virtualDissection", byFill = "segment_id", alpha = 0.3
  ) +
  scale_y_reverse() +
  theme_classic() +
  theme(axis.text = element_blank()) +
  theme(axis.ticks = element_blank()) +
  coord_fixed() +
  scale_colour_manual(values = fts_colours) +
  scale_fill_manual(values = bds_colours) +
  guides(color = guide_legend(override.aes = list(size = 2)))
g

## ----eval=FALSE---------------------------------------------------------------
# spe <- countMolecules(
#   small_me, boundariesAssay = "virtualDissection")
# spe

## -----------------------------------------------------------------------------
sessionInfo()

