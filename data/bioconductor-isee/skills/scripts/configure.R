# Code example from 'configure' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  error = FALSE,
  warning = FALSE,
  message = FALSE,
    crop = NULL
)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())
sce <- readRDS("sce.rds")

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x, dpi = NA)

## ----init---------------------------------------------------------------------
library(iSEE)
app <- iSEE(sce, initial=list(
    FeatureAssayPlot(PanelWidth=6L),
    FeatureAssayPlot(PanelWidth=6L)
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-FAP-basic.png")

## ----fexArg-------------------------------------------------------------------
app <- iSEE(sce, initial=list(
    FeatureAssayPlot(YAxisFeatureName="0610009L18Rik"),
    FeatureAssayPlot(YAxisFeatureName="0610009B22Rik")
)) 

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-FAP-preset-genes.png")

## ----yaxis--------------------------------------------------------------------
app <- iSEE(sce, initial=list(
    ColumnDataPlot(YAxis="NREADS", PanelWidth=6L, DataBoxOpen=TRUE),
    ColumnDataPlot(YAxis="TOTAL_DUP", PanelWidth=6L, DataBoxOpen=TRUE)
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-CDP-basic.png")

## ----xaxis--------------------------------------------------------------------
fex <- FeatureAssayPlot(DataBoxOpen=TRUE, PanelWidth=6L)

# Example 1
fex1 <- fex
fex1[["XAxis"]] <- "None"

# Example 2
fex2 <- fex
fex2[["XAxis"]] <- "Column data"
fex2[["XAxisColumnData"]] <- "Core.Type"

# Example 3a
fex3 <- fex
fex3[["XAxis"]] <- "Feature name"
fex3[["XAxisFeatureName"]] <- "Zyx"

# Example 4 (also requires a row statistic table)
fex4 <- fex
fex4[["XAxis"]] <- "Feature name"
fex4[["XAxisFeatureSource"]] <- "RowDataTable1"
rex <- RowDataTable(Selected="Ints2", Search="Ints", PanelWidth=12L)

# Initialisation
app <- iSEE(sce, initial=list(fex1, fex2, fex3, fex4, rex))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-FAP-xaxis.png")

## ----redDimPlotDefaults-type--------------------------------------------------
app <- iSEE(sce, initial=list(
    ReducedDimensionPlot(DataBoxOpen=TRUE, Type="TSNE", 
        XAxis=2L, YAxis=1L, PanelWidth=6L)
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-ReDP-basic.png")

## ----featAssayPlotDefaults-assay----------------------------------------------
app <- iSEE(sce, initial=list(
    FeatureAssayPlot(DataBoxOpen=TRUE, Assay="logcounts", PanelWidth=6L),
    FeatureAssayPlot(DataBoxOpen=TRUE, Assay="tophat_counts", PanelWidth=6L)
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-FAP-assay.png")

## ----ColorByDefaultColor------------------------------------------------------
cdp <- ColumnDataPlot(VisualBoxOpen=TRUE, 
    VisualChoices=c("Color", "Size", "Point", "Text"))

cdp2 <- cdp
cdp2[["ColorByDefaultColor"]] <- "chocolate3"
cdp2[["PointAlpha"]] <- 0.2
cdp2[["PointSize"]] <- 2
cdp2[["Downsample"]] <- TRUE
cdp2[["DownsampleResolution"]] <- 150
cdp2[["FontSize"]] <- 2

app <- iSEE(sce, initial=list(cdp, cdp2))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-CDP-visual.png")

## ----aesthetic-covariate------------------------------------------------------
cdp <- ColumnDataPlot(VisualBoxOpen=TRUE, VisualChoices=c("Color", "Shape"),
    ColorByColumnData="Core.Type", ShapeByColumnData="Core.Type",
    ColorBy="Column data", ShapeBy="Column data")

cdp2 <- cdp
cdp2[["ColorByColumnData"]] <- "TOTAL_DUP"
cdp2[["ShapeByColumnData"]] <- "driver_1_s"

app <- iSEE(sce, initial=list(cdp, cdp2))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-CDP-linked-visual.png")

## ----facet--------------------------------------------------------------------
cdp <- ColumnDataPlot(VisualBoxOpen=TRUE, VisualChoices=c("Facet"),
    FacetRowBy="Column data", FacetRowByColData="driver_1_s", 
    FacetColumnBy="Column data", FacetColumnByColData="Core.Type", PanelWidth=4L)

cdp2 <- cdp
cdp2[["FacetRowBy"]] <- "None"

cdp3 <- cdp
cdp3[["FacetColumnBy"]] <- "None" 

app <- iSEE(sce, initial=list(cdp, cdp2, cdp3))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-CDP-facets.png")

## ----select-brish-------------------------------------------------------------
# Preconfigure the receiver panel
cdArgs <- ColumnDataPlot(
    XAxis="Column data",
    XAxisColumnData="driver_1_s",

    # Configuring the selection parameters.
    SelectionBoxOpen=TRUE,
    ColumnSelectionSource="ReducedDimensionPlot1",
    ColorBy="Column selection", 

    # Throwing in some parameters for aesthetic reasons.
    ColorByDefaultColor="#BDB3B3", 
    PointSize=2,
    PanelWidth=6L)

# Preconfigure the sender panel, including the point selection.
# NOTE: You don't actually have to write this from scratch! Just
# open an iSEE instance, make a brush and then look at the 'BrushData'
# entry when you click on the 'Display panel settings' button.
rdArgs <- ReducedDimensionPlot(
    BrushData = list(
        xmin = 13.7, xmax = 53.5, ymin = -36.5, ymax = 37.2, 
        coords_css = list(xmin = 413.2, xmax = 650.2, ymin = 83.0, ymax = 344.0), 
        coords_img = list(xmin = 537.2, xmax = 845.3, ymin = 107.9, ymax = 447.2), 
        img_css_ratio = list(x = 1.3, y = 1.3), 
        mapping = list(x = "X", y = "Y"), 
        domain = list(left = -49.1, right = 57.2, bottom = -70.4, top = 53.5), 
        range = list(left = 50.9, right = 873.9, bottom = 603.0, top = 33.1), 
        log = list(x = NULL, y = NULL), 
        direction = "xy", 
        brushId = "ReducedDimensionPlot1_Brush", 
        outputId = "ReducedDimensionPlot1"
    ),
    PanelWidth=6L
)    

app <- iSEE(sce, initial=list(cdArgs, rdArgs))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-ReDP-select.png")

## ----select-lasso-------------------------------------------------------------
# Preconfigure the sender panel, including the point selection.
# NOTE: again, you shouldn't try writing this from scratch! Just
# make a lasso and then copy the panel settings in 'BrushData'.
rdArgs[["BrushData"]] <- list(
    lasso = NULL, closed = TRUE, panelvar1 = NULL, panelvar2 = NULL, 
    mapping = list(x = "X", y = "Y"), 
    coord = structure(c(18.4, 
        18.5, 26.1, 39.9, 
        55.2, 50.3, 54.3, 
        33.3, 18.4, 35.5, 
        -4.2, -21.2, -46.1, 
        -43.5, -18.1, 7.3, 
        19.7, 35.5), .Dim = c(9L, 2L)
    )
)

app <- iSEE(sce, initial=list(cdArgs, rdArgs))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/configure-ReDP-lasso.png")

## -----------------------------------------------------------------------------
introtour <- defaultTour()
head(introtour)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()
# devtools::session_info()

