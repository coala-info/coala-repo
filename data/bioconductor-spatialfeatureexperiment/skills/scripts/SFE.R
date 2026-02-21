# Code example from 'SFE' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# BiocManager::install("SpatialFeatureExperiment")

## ----echo=FALSE, out.width = "100%", fig.cap="Schematics of the SFE object", fig.alt="SpatialFeatureExperiment expands on SpatialExperiment by adding column, row, and annotation geometries and spatial graphs. This is explained in detail in the following paragraphs."----
knitr::include_graphics("sfe_schematics.png")

## ----setup--------------------------------------------------------------------
library(SpatialFeatureExperiment)
library(SpatialExperiment)
library(SFEData)
library(sf)
library(Matrix)
library(RBioFormats)
library(spdep)
library(VisiumIO)
set.SubgraphOption(FALSE)

## -----------------------------------------------------------------------------
# Example dataset
(sfe <- McKellarMuscleData(dataset = "small"))

## -----------------------------------------------------------------------------
# Get Visium spot polygons
(spots <- dimGeometry(sfe, "spotPoly", MARGIN = 2))

## -----------------------------------------------------------------------------
plot(st_geometry(spots))

## -----------------------------------------------------------------------------
# Setter
dimGeometry(sfe, "foobar", MARGIN = 2) <- spots

## -----------------------------------------------------------------------------
# Getter, all geometries of one margin
(cgs <- dimGeometries(sfe, MARGIN = 2))

## -----------------------------------------------------------------------------
# Setter, all geometries
dimGeometries(sfe, MARGIN = 2) <- cgs

## -----------------------------------------------------------------------------
(cg_names <- dimGeometryNames(sfe, MARGIN = 2))

## -----------------------------------------------------------------------------
# Setter
dimGeometryNames(sfe, MARGIN = 2) <- cg_names

## -----------------------------------------------------------------------------
# Getter
(spots <- spotPoly(sfe))

## -----------------------------------------------------------------------------
# Setter
spotPoly(sfe) <- spots

## -----------------------------------------------------------------------------
# Getter, by name or index
(tb <- annotGeometry(sfe, "tissueBoundary"))

## -----------------------------------------------------------------------------
plot(st_geometry(tb))

## -----------------------------------------------------------------------------
# Setter, by name or index
annotGeometry(sfe, "tissueBoundary") <- tb

## -----------------------------------------------------------------------------
# Get all annoation geometries as named list
ags <- annotGeometries(sfe)

## -----------------------------------------------------------------------------
# Set all annotation geometries with a named list
annotGeometries(sfe) <- ags

## -----------------------------------------------------------------------------
# Get names of annotation geometries
(ag_names <- annotGeometryNames(sfe))

## -----------------------------------------------------------------------------
# Set names
annotGeometryNames(sfe) <- ag_names

## -----------------------------------------------------------------------------
# Getter
(tb <- tissueBoundary(sfe))

## -----------------------------------------------------------------------------
# Setter
tissueBoundary(sfe) <- tb

## -----------------------------------------------------------------------------
(g <- findSpatialNeighbors(sfe, MARGIN = 2, method = "tri2nb"))

## -----------------------------------------------------------------------------
plot(g, coords = spatialCoords(sfe))

## -----------------------------------------------------------------------------
# Set graph by name
spatialGraph(sfe, "graph1", MARGIN = 2) <- g
# Or equivalently
colGraph(sfe, "graph1") <- g

## -----------------------------------------------------------------------------
# Get graph by name
g <- spatialGraph(sfe, "graph1", MARGIN = 2L)
# Or equivalently
g <- colGraph(sfe, "graph1")
g

## -----------------------------------------------------------------------------
colGraph(sfe, "visium") <- findVisiumGraph(sfe, zero.policy = TRUE)

## -----------------------------------------------------------------------------
plot(colGraph(sfe, "visium"), coords = spatialCoords(sfe))

## -----------------------------------------------------------------------------
colGraphs(sfe)

## -----------------------------------------------------------------------------
colGraphNames(sfe)

## -----------------------------------------------------------------------------
# Construct toy dataset with 2 samples
sfe1 <- McKellarMuscleData(dataset = "small")
sfe2 <- McKellarMuscleData(dataset = "small2")
spotPoly(sfe2)$sample_id <- "sample02"
(sfe_combined <- cbind(sfe1, sfe2))

## -----------------------------------------------------------------------------
sampleIDs(sfe_combined)

## -----------------------------------------------------------------------------
# Only get the geometries for the second sample
(spots2 <- colGeometry(sfe_combined, "spotPoly", sample_id = "sample02"))

## -----------------------------------------------------------------------------
# Only set the geometries for the second sample
# Leaving geometries of the first sample intact
colGeometry(sfe_combined, "spotPoly", sample_id = "sample02") <- spots2

## -----------------------------------------------------------------------------
# Set graph only for the second sample
colGraph(sfe_combined, "foo", sample_id = "sample02") <- 
  findSpatialNeighbors(sfe_combined, sample_id = "sample02")

## -----------------------------------------------------------------------------
# Get graph only for the second sample
colGraph(sfe_combined, "foo", sample_id = "sample02")

## -----------------------------------------------------------------------------
# Set graph of the same name for both samples
# The graphs are computed separately for each sample
colGraphs(sfe_combined, sample_id = "all", name = "visium") <- 
  findVisiumGraph(sfe_combined, sample_id = "all")

## -----------------------------------------------------------------------------
# Get multiple graphs of the same name
colGraphs(sfe_combined, sample_id = "all", name = "visium")

## -----------------------------------------------------------------------------
# Or just all graphs of the margin
colGraphs(sfe_combined, sample_id = "all")

## -----------------------------------------------------------------------------
sfe_combined <- changeSampleIDs(sfe, replacement = c(Vis5A = "foo", sample02 = "bar"))
sfe_combined

## -----------------------------------------------------------------------------
# Visium barcode location from Space Ranger
data("visium_row_col")
coords1 <- visium_row_col[visium_row_col$col < 6 & visium_row_col$row < 6,]
coords1$row <- coords1$row * sqrt(3)

# Random toy sparse matrix
set.seed(29)
col_inds <- sample(1:13, 13)
row_inds <- sample(1:5, 13, replace = TRUE)
values <- sample(1:5, 13, replace = TRUE)
mat <- sparseMatrix(i = row_inds, j = col_inds, x = values)
colnames(mat) <- coords1$barcode
rownames(mat) <- sample(LETTERS, 5)

## -----------------------------------------------------------------------------
sfe3 <- SpatialFeatureExperiment(list(counts = mat), colData = coords1,
                                spatialCoordsNames = c("col", "row"),
                                spotDiameter = 0.7)

## -----------------------------------------------------------------------------
sfe3 <- SpatialFeatureExperiment(list(counts = mat), 
                                 spatialCoords = as.matrix(coords1[, c("col", "row")]),
                                 spotDiameter = 0.7)

## -----------------------------------------------------------------------------
# Convert regular data frame with coordinates to sf data frame
cg <- df2sf(coords1[,c("col", "row")], c("col", "row"), spotDiameter = 0.7)
rownames(cg) <- colnames(mat)
sfe3 <- SpatialFeatureExperiment(list(counts = mat), colGeometries = list(foo = cg))

## -----------------------------------------------------------------------------
dir <- system.file("extdata", package = "SpatialFeatureExperiment")
sample_ids <- c("sample01", "sample02")
samples <- file.path(dir, sample_ids)

## -----------------------------------------------------------------------------
list.files(file.path(samples[1], "outs"))

## -----------------------------------------------------------------------------
list.files(file.path(samples[1], "outs", "filtered_feature_bc_matrix"))

## -----------------------------------------------------------------------------
list.files(file.path(samples[1], "outs", "spatial"))

## -----------------------------------------------------------------------------
(sfe3 <- read10xVisiumSFE(samples, sample_id = sample_ids, type = "sparse", 
                          data = "filtered", images = "hires"))

## -----------------------------------------------------------------------------
(sfe3 <- read10xVisiumSFE(samples, sample_id = sample_ids, type = "sparse", 
                          data = "filtered", images = "hires", unit = "micron"))

## -----------------------------------------------------------------------------
unit(sfe3)

## -----------------------------------------------------------------------------
class(getImg(sfe3))

## -----------------------------------------------------------------------------
fp <- tempdir()
dir_use <- VizgenOutput(file_path = file.path(fp, "vizgen"))
list.files(dir_use)

## -----------------------------------------------------------------------------
(sfe_mer <- readVizgen(dir_use, z = 3L, image = "PolyT", add_molecules = TRUE))

## -----------------------------------------------------------------------------
list.files(dir_use)

## -----------------------------------------------------------------------------
dir_use <- XeniumOutput("v2", file_path = file.path(fp, "xenium"))
list.files(dir_use)

## -----------------------------------------------------------------------------
# RBioFormats issue: https://github.com/aoles/RBioFormats/issues/42
try(sfe_xen <- readXenium(dir_use, add_molecules = TRUE))
(sfe_xen <- readXenium(dir_use, add_molecules = TRUE))

## -----------------------------------------------------------------------------
list.files(dir_use)

## -----------------------------------------------------------------------------
dir_use <- CosMXOutput(file_path = file.path(fp, "cosmx"))
list.files(dir_use)

## -----------------------------------------------------------------------------
(sfe_cosmx <- readCosMX(dir_use, add_molecules = TRUE))

## -----------------------------------------------------------------------------
list.files(dir_use)

## -----------------------------------------------------------------------------
spe <- TENxVisium(spacerangerOut = file.path(samples[1], "outs"), processing = "filtered",
                  images = c("lowres", "hires")) |> import()

## -----------------------------------------------------------------------------
colnames(spe) <- make.unique(colnames(spe), sep = "-")
rownames(spatialCoords(spe)) <- colnames(spe)

## -----------------------------------------------------------------------------
(sfe3 <- toSpatialFeatureExperiment(spe))

## -----------------------------------------------------------------------------
dir_extdata <- system.file("extdata", package = "SpatialFeatureExperiment")
obj_vis <- readRDS(file.path(dir_extdata, "seu_vis_toy.rds"))

## -----------------------------------------------------------------------------
sfe_conv_vis <-
  toSpatialFeatureExperiment(x = obj_vis, 
                             image_scalefactors = "lowres",
                             unit = "micron",
                             BPPARAM = BPPARAM)
sfe_conv_vis

## -----------------------------------------------------------------------------
sfe_combined <- cbind(sfe1, sfe2)

## -----------------------------------------------------------------------------
(sfe_subset <- sfe[1:10, 1:10])

## -----------------------------------------------------------------------------
plot(colGraph(sfe_subset, "visium"), coords = spatialCoords(sfe_subset))

## -----------------------------------------------------------------------------
# Before
plot(st_geometry(tissueBoundary(sfe)))
plot(spotPoly(sfe), col = "gray", add = TRUE)

## -----------------------------------------------------------------------------
sfe_in_tissue <- crop(sfe, y = tissueBoundary(sfe), colGeometryName = "spotPoly")

## -----------------------------------------------------------------------------
# After
plot(st_geometry(tissueBoundary(sfe)))
plot(spotPoly(sfe_in_tissue), col = "gray", add = TRUE)

## -----------------------------------------------------------------------------
sfe_cropped <- crop(sfe, y = c(xmin = 5500, xmax = 6500, ymin = 13500, ymax = 14500),
                    colGeometryName = "spotPoly", sample_id = "Vis5A")

## -----------------------------------------------------------------------------
# Get logical vector
colData(sfe)$in_tissue <- annotPred(sfe, colGeometryName = "spotPoly", 
                                    annotGeometryName = "tissueBoundary",
                                    sample_id = "Vis5A")
# Get the number of nuclei per Visium spot
colData(sfe)$n_nuclei <- annotNPred(sfe, "spotPoly", annotGeometryName = "nuclei")
# Get geometries of intersections of Visium spots and myofibers
spot_intersections <- annotOp(sfe, colGeometryName = "spotPoly", 
                              annotGeometryName = "myofiber_simplified")

## -----------------------------------------------------------------------------
SpatialFeatureExperiment::bbox(sfe, sample_id = "Vis5A")

## -----------------------------------------------------------------------------
sfe_moved <- removeEmptySpace(sfe, sample_id = "Vis5A")

## ----fig.width=1, fig.height=1------------------------------------------------
img <- getImg(sfe3, image_id = "hires")
plot(img)
plot(transposeImg(img))

## ----fig.width=1, fig.height=1------------------------------------------------
plot(mirrorImg(img, direction = "vertical"))
plot(mirrorImg(img, direction = "horizontal"))

## -----------------------------------------------------------------------------
sfe3 <- mirrorImg(sfe3, sample_id = "sample01", image_id = "hires")

## -----------------------------------------------------------------------------
sfe_mirrored <- mirror(sfe_in_tissue)
sfe_transposed <- transpose(sfe_in_tissue)

## ----fig.width=6, fig.height=2------------------------------------------------
par(mfrow = c(1, 3), mar = rep(1.5, 4))
plot(st_geometry(tissueBoundary(sfe_in_tissue)))
plot(spotPoly(sfe_in_tissue), col = "gray", add = TRUE)

plot(st_geometry(tissueBoundary(sfe_mirrored)))
plot(spotPoly(sfe_mirrored), col = "gray", add = TRUE)

plot(st_geometry(tissueBoundary(sfe_transposed)))
plot(spotPoly(sfe_transposed), col = "gray", add = TRUE)

## -----------------------------------------------------------------------------
# Clean up
unlink(file.path(fp, "vizgen"), recursive = TRUE)
unlink(file.path(fp, "xenium"), recursive = TRUE)
unlink(file.path(fp, "cosmx"), recursive = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

