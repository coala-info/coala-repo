# Code example from 'TabulaMurisSenisData' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(SingleCellExperiment)
library(TabulaMurisSenisData)
library(ggplot2)

## -----------------------------------------------------------------------------
tmp <- TabulaMurisSenisBulk(infoOnly = TRUE)
tms_bulk <- TabulaMurisSenisBulk()
tms_bulk

## -----------------------------------------------------------------------------
table(colData(tms_bulk)$organ)

## -----------------------------------------------------------------------------
listTabulaMurisSenisTissues(dataset = "Droplet")

## -----------------------------------------------------------------------------
tmp <- TabulaMurisSenisDroplet(tissues = "All", infoOnly = TRUE)
tms_droplet <- TabulaMurisSenisDroplet(tissues = "All")
tms_droplet

## -----------------------------------------------------------------------------
# tissue colors
tissue_cols <- c(Pancreas = "#3182bd", Thymus = "#31a354", 
                 Trachea = "#636363", Bladder = "#637939", 
                 Lung = "#7b4173", Large_Intestine = "#843c39", 
                 Fat = "#969696", Tongue = "#a1d99b", 
                 Mammary_Gland = "#ce6dbd", Limb_Muscle = "#d6616b", 
                 Marrow = "#de9ed6", Skin = "#e6550d", 
                 Liver = "#e7969c", Heart_and_Aorta = "#e7ba52", 
                 Kidney = "#e7cb94", Spleen = "#fd8d3c")

# get dataset with all tissues
se <- tms_droplet$All
se 

# prepare data set for ggplot
ds <- as.data.frame(reducedDim(se, "UMAP"))
ds <- cbind(ds, tissue = colData(se)$tissue)
head(ds)

# plot
ggplot(ds, aes(x = UMAP1, y = UMAP2, color = tissue)) + 
  geom_point(size = 0.05) + 
  scale_color_manual(values = tissue_cols) + 
  theme_classic() + 
  guides(colour = guide_legend(override.aes = list(size = 5)))

## -----------------------------------------------------------------------------
listTabulaMurisSenisTissues(dataset = "FACS")

## -----------------------------------------------------------------------------
tmp <- TabulaMurisSenisFACS(tissues = "All", infoOnly = TRUE)
tms_facs <- TabulaMurisSenisFACS(tissues = "All")
tms_facs

## -----------------------------------------------------------------------------
# tissue colors
tissue_cols <- c(Skin = "#e6550d", Pancreas = "#3182bd", 
                 Limb_Muscle = "#d6616b", Heart = "#e7ba52", 
                 Spleen = "#fd8d3c", Diaphragm = "#8c6d31", 
                 Trachea = "#636363", Tongue = "#a1d99b", 
                 Thymus = "#31a354", `Brain_Non-Myeloid` = "#cedb9c", 
                 Brain_Myeloid = "#b5cf6b", Bladder = "#637939", 
                 Large_Intestine = "#843c39", BAT = "#9c9ede", 
                 GAT = "#bd9e39", MAT = "#a55194", SCAT = "#6baed6", 
                 Lung = "#7b4173", Liver = "#e7969c", 
                 Marrow = "#de9ed6", Kidney = "#e7cb94", 
                 Aorta = "#393b79", Mammary_Gland = "#ce6dbd")

# get dataset with all tissues
se <- tms_facs$All
se 

# prepare data set for ggplot
ds <- as.data.frame(reducedDim(se, "UMAP"))
ds <- cbind(ds, tissue = colData(se)$tissue)
head(ds)

# plot
ggplot(ds, aes(x = UMAP1, y = UMAP2, color = tissue)) + 
  geom_point(size = 0.05) + 
  scale_color_manual(values = tissue_cols) + 
  theme_classic() + 
  guides(colour = guide_legend(override.aes = list(size = 5)))

## -----------------------------------------------------------------------------
sce_all_facs <- TabulaMurisSenisFACS(tissues = "All", processedCounts = TRUE)$All
sce_all_facs

## -----------------------------------------------------------------------------
assayNames(sce_all_facs)
reducedDimNames(sce_all_facs)

## ----include=FALSE------------------------------------------------------------
library(iSEE)

## ----launchisee, eval=FALSE---------------------------------------------------
# library(iSEE)
# iSEE(sce_all_facs)

## -----------------------------------------------------------------------------
initial <- list()

################################################################################
# (Compact) Settings for Reduced dimension plot 1
################################################################################

initial[["ReducedDimensionPlot1"]] <- new(
    "ReducedDimensionPlot", 
    DataBoxOpen = TRUE, 
    Type = "UMAP", 
    VisualBoxOpen = TRUE, 
    ColorBy = "Feature name", 
    ColorByFeatureName = "Col1a1", 
    ColorByFeatureSource = "RowDataTable1", 
    ColorByFeatureDynamicSource = FALSE
)

################################################################################
# (Compact) Settings for Row data table 1
################################################################################

initial[["RowDataTable1"]] <- new(
    "RowDataTable", 
    Selected = "Col1a1", 
    Search = "Col1"
)
    
################################################################################
# (Compact) Settings for Feature assay plot 1
################################################################################

initial[["FeatureAssayPlot1"]] <- new(
    "FeatureAssayPlot", 
    DataBoxOpen = TRUE, 
    Assay = "logcounts", 
    XAxis = "Column data", 
    XAxisColumnData = "tissue", 
    YAxisFeatureName = "Col1a1", 
    YAxisFeatureSource = "RowDataTable1"
)


## ----eval=FALSE---------------------------------------------------------------
# initial <- list()
# 
# ################################################################################
# # Settings for Reduced dimension plot 1
# ################################################################################
# 
# initial[["ReducedDimensionPlot1"]] <- new("ReducedDimensionPlot", Type = "UMAP", XAxis = 1L, YAxis = 2L,
#     FacetRowByColData = "FACS.selection", FacetColumnByColData = "FACS.selection",
#     ColorByColumnData = "FACS.selection", ColorByFeatureNameAssay = "logcounts",
#     ColorBySampleNameColor = "#FF0000", ShapeByColumnData = "FACS.selection",
#     SizeByColumnData = "n_genes", FacetRowBy = "None", FacetColumnBy = "None",
#     ColorBy = "Feature name", ColorByDefaultColor = "#000000",
#     ColorByFeatureName = "Col1a1", ColorByFeatureSource = "RowDataTable1",
#     ColorByFeatureDynamicSource = FALSE, ColorBySampleName = "A10_B000497_B009023_S10.mm10-plus-0-0",
#     ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
#     ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
#     ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = TRUE,
#     VisualChoices = "Color", ContourAdd = FALSE, ContourColor = "#0000FF",
#     PointSize = 1, PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200,
#     CustomLabels = FALSE, CustomLabelsText = "A10_B000497_B009023_S10.mm10-plus-0-0",
#     FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom",
#     HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "FACS.selection",
#     LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
#         c(2L, 5L, 1L)), class = c("package_version", "numeric_version"
#     ))), PanelId = c(ReducedDimensionPlot = 1L), PanelHeight = 500L,
#     PanelWidth = 4L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
#     ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
#     ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
#     ColumnSelectionRestrict = FALSE, SelectionHistory = list())
# 
# ################################################################################
# # Settings for Row data table 1
# ################################################################################
# 
# initial[["RowDataTable1"]] <- new("RowDataTable", Selected = "Col1a1", Search = "Col1", SearchColumns = c("",
# "", "", "", ""), HiddenColumns = character(0), VersionInfo = list(
#     iSEE = structure(list(c(2L, 5L, 1L)), class = c("package_version",
#     "numeric_version"))), PanelId = c(RowDataTable = 1L), PanelHeight = 500L,
#     PanelWidth = 4L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
#     ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
#     ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
#     ColumnSelectionRestrict = FALSE, SelectionHistory = list())
# 
# ################################################################################
# # Settings for Feature assay plot 1
# ################################################################################
# 
# initial[["FeatureAssayPlot1"]] <- new("FeatureAssayPlot", Assay = "logcounts", XAxis = "Column data",
#     XAxisColumnData = "tissue", XAxisFeatureName = "0610005C13Rik",
#     XAxisFeatureSource = "---", XAxisFeatureDynamicSource = FALSE,
#     YAxisFeatureName = "Col1a1", YAxisFeatureSource = "RowDataTable1",
#     YAxisFeatureDynamicSource = FALSE, FacetRowByColData = "FACS.selection",
#     FacetColumnByColData = "FACS.selection", ColorByColumnData = "age",
#     ColorByFeatureNameAssay = "logcounts", ColorBySampleNameColor = "#FF0000",
#     ShapeByColumnData = "FACS.selection", SizeByColumnData = "n_genes",
#     FacetRowBy = "None", FacetColumnBy = "None", ColorBy = "None",
#     ColorByDefaultColor = "#000000", ColorByFeatureName = "0610005C13Rik",
#     ColorByFeatureSource = "---", ColorByFeatureDynamicSource = FALSE,
#     ColorBySampleName = "A10_B000497_B009023_S10.mm10-plus-0-0",
#     ColorBySampleSource = "---", ColorBySampleDynamicSource = FALSE,
#     ShapeBy = "None", SizeBy = "None", SelectionAlpha = 0.1,
#     ZoomData = numeric(0), BrushData = list(), VisualBoxOpen = FALSE,
#     VisualChoices = "Color", ContourAdd = FALSE, ContourColor = "#0000FF",
#     PointSize = 1, PointAlpha = 1, Downsample = FALSE, DownsampleResolution = 200,
#     CustomLabels = FALSE, CustomLabelsText = "A10_B000497_B009023_S10.mm10-plus-0-0",
#     FontSize = 1, LegendPointSize = 1, LegendPosition = "Bottom",
#     HoverInfo = TRUE, LabelCenters = FALSE, LabelCentersBy = "FACS.selection",
#     LabelCentersColor = "#000000", VersionInfo = list(iSEE = structure(list(
#         c(2L, 5L, 1L)), class = c("package_version", "numeric_version"
#     ))), PanelId = c(FeatureAssayPlot = 1L), PanelHeight = 500L,
#     PanelWidth = 4L, SelectionBoxOpen = FALSE, RowSelectionSource = "---",
#     ColumnSelectionSource = "---", DataBoxOpen = FALSE, RowSelectionDynamicSource = FALSE,
#     ColumnSelectionDynamicSource = FALSE, RowSelectionRestrict = FALSE,
#     ColumnSelectionRestrict = FALSE, SelectionHistory = list())
# 
# initial

## ----eval=FALSE---------------------------------------------------------------
# iSEE(sce_all_facs, initial = initial)

## ----echo=FALSE, fig.cap="Screenshot of the iSEE app running on the FACS single cell dataset", out.width='100%'----
knitr::include_graphics("ss_iSEE_facsdataset.jpg")

## -----------------------------------------------------------------------------
sessionInfo()

