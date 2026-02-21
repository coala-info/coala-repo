# Code example from 'links' vignette. See references/ for full tutorial.

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

## -----------------------------------------------------------------------------
library(iSEE)
app <- iSEE(sce, initial=list(
    ReducedDimensionPlot(),
    ColumnDataPlot()
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-naive.png")

## ----echo=FALSE---------------------------------------------------------------
rdp <- ReducedDimensionPlot()
cdp <- ColumnDataPlot(
    YAxis="NREADS",
    XAxis="Column data",
    XAxisColumnData="dissection_s",
    ColumnSelectionSource="ReducedDimensionPlot1",
    SelectionBoxOpen=TRUE)

app <- iSEE(sce, initial=list(rdp, cdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-unselected.png")

## ----echo=FALSE---------------------------------------------------------------
brush <- list(xmin = -45.943219326064, xmax = -0.9320051164658, ymin = -70.389479254644, ymax = -5.1362394173266,
    coords_css = list(xmin = 51.009614944458, xmax = 219.009614944458, ymin = 233.009613037109,
        ymax = 463.856708268114), coords_img = list(xmin = 66.3132158276913, xmax = 284.715575288405,
        ymin = 302.912485837478, ymax = 603.013698630137), img_css_ratio = list(x = 1.30001404440901,
        y = 1.29999995231628), mapping = list(x = "X", y = "Y"), domain = list(left = -49.1019902822795,
        right = 57.2288623709446, bottom = -70.389479254644, top = 53.5190834641121),
    range = list(left = 50.986301369863, right = 566.922374429224, bottom = 603.013698630137,
        top = 33.1552511415525), log = list(x = NULL, y = NULL), direction = "xy",
    brushId = "ReducedDimensionPlot1_Brush", outputId = "ReducedDimensionPlot1")

rdp <- ReducedDimensionPlot(BrushData=brush)
app <- iSEE(sce, initial=list(rdp, cdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-brushed.png")

## ----echo=FALSE---------------------------------------------------------------
lasso <- list(lasso = NULL, closed = TRUE, panelvar1 = NULL, panelvar2 = NULL, mapping = list(
        x = "X", y = "Y"), coord = structure(c(24.7886887175902, 24.7886887175902, 43.0075135167132, 
    53.1886214926936, 53.4565453867984, 53.7244692809032, 39.2565789992467, 23.4490692470664, 
    24.7886887175902, -8.24559471370669, -26.3363891653729, -39.0564790142006, -45.5578582702682, 
    -23.5097025323, -3.44022743748286, 15.7812416674124, -0.896209467717313, -8.24559471370669
    ), .Dim = c(9L, 2L)))

app <- iSEE(sce, initial=list(ReducedDimensionPlot(BrushData=lasso), cdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-lasso.png")

## ----echo=FALSE---------------------------------------------------------------
cdp2 <- cdp
cdp2[["ColorBy"]] <- "Column selection"
app <- iSEE(sce, initial=list(rdp, cdp2))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-color.png")

## ----echo=FALSE---------------------------------------------------------------
cdp2 <- cdp
cdp2[["ColumnSelectionRestrict"]] <- TRUE
app <- iSEE(sce, initial=list(rdp, cdp2))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-restrict.png")

## ----echo=FALSE---------------------------------------------------------------
cdt <- ColumnDataTable(ColumnSelectionSource="ReducedDimensionPlot1",
    SelectionBoxOpen=TRUE, PanelWidth=8L)
app <- iSEE(sce, initial=list(rdp, cdt))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-table.png")

## ----echo=FALSE---------------------------------------------------------------
app <- iSEE(sce, initial=list(
    ColumnDataTable(PanelWidth=8L, Search="L6a"),
    ReducedDimensionPlot(ColumnSelectionSource="ColumnDataTable1")
))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-table2.png")

## ----echo=FALSE---------------------------------------------------------------
rdp <- ReducedDimensionPlot(SelectionBoxOpen=TRUE, 
    SelectionHistory=list(brush, lasso))
app <- iSEE(sce, initial=list(rdp, cdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-multi-saved.png")

## ----echo=FALSE---------------------------------------------------------------
rdp <- ReducedDimensionPlot(VisualBoxOpen=TRUE, 
    ColorByFeatureSource="RowDataTable1",
    ColorBy="Feature name")
rdt <- RowDataTable(Search="Neuro",
    Selected="Neurod1")
app <- iSEE(sce, initial=list(rdt, rdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-single-color.png")

## ----echo=FALSE---------------------------------------------------------------
fap <- FeatureAssayPlot(DataBoxOpen=TRUE,
    YAxisFeatureSource="RowDataTable1",
    XAxis="Column data", XAxisColumnData="dissection_s")
app <- iSEE(sce, initial=list(rdt, fap))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-single-yaxis.png")

## ----echo=FALSE---------------------------------------------------------------
cdt <- ColumnDataTable()
rdp <- ReducedDimensionPlot(VisualBoxOpen=TRUE,
    ColorBySampleSource="ColumnDataTable1",
    ColorBy="Sample name")
app <- iSEE(sce, initial=list(cdt, rdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-single-sample.png")

## ----echo=FALSE---------------------------------------------------------------
BB <- list(xmin = 7.9644610460621, xmax = 10.11596038509, ymin = 24.542997535857, ymax = 26.582843087131, 
    coords_css = list(xmin = 232.009614944458, xmax = 280.009614944458, ymin = 66.0096168518066, 
        ymax = 95.0096168518066), coords_img = list(xmin = 301.615757865723, xmax = 364.016431997355, 
        ymin = 85.8124987597648, ymax = 123.512497376937), img_css_ratio = list(x = 1.30001404440901, 
        y = 1.29999995231628), mapping = list(x = "X", y = "Y"), domain = list(left = -0.814852879170668, 
        right = 17.111910462584, bottom = -1.40152310296966, top = 29.4319851623629), 
    range = list(left = 46.986301369863, right = 566.922374429224, bottom = 603.013698630137, 
        top = 33.1552511415525), log = list(x = NULL, y = NULL), direction = "xy", 
    brushId = "RowDataPlot1_Brush", outputId = "RowDataPlot1")

rdpX <- RowDataPlot(YAxis="var_log", XAxis="Row data", 
    XAxisRowData="mean_log", BrushData=BB)
rdp <- ReducedDimensionPlot(VisualBoxOpen=TRUE,
    ColorByFeatureSource="RowDataPlot1",
    ColorBy="Feature name")
app <- iSEE(sce, initial=list(rdpX, rdp))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-single-plot2plot.png")

## ----echo=FALSE---------------------------------------------------------------
initial <- list(
    ReducedDimensionPlot(SelectionBoxOpen=TRUE,
        ColumnSelectionDynamicSource=TRUE
    ),
    FeatureAssayPlot(SelectionBoxOpen=TRUE,
        ColumnSelectionDynamicSource=TRUE,
        XAxis="Column data", XAxisColumnData="dissection_s"
    ),
    ColumnDataPlot(SelectionBoxOpen=TRUE, YAxis="NREADS",
        ColumnSelectionDynamicSource=TRUE,
        XAxis="Column data", XAxisColumnData="Core.Type"
    )
)

app <- iSEE(sce, initial=initial)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-dynamic-multi.png")

## ----echo=FALSE---------------------------------------------------------------
initial <- list(
    ReducedDimensionPlot(SelectionBoxOpen=TRUE,
        ColumnSelectionDynamicSource=TRUE,
        BrushData=brush
    ),
    FeatureAssayPlot(SelectionBoxOpen=TRUE,
        ColumnSelectionDynamicSource=TRUE,
        ColumnSelectionSource="ReducedDimensionPlot1",
        XAxis="Column data", XAxisColumnData="dissection_s"
    ),
    ColumnDataPlot(SelectionBoxOpen=TRUE, YAxis="NREADS",
        ColumnSelectionDynamicSource=TRUE,
        ColumnSelectionSource="ReducedDimensionPlot1",
        XAxis="Column data", XAxisColumnData="Core.Type"
    )
)

app <- iSEE(sce, initial=initial)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-dynamic-multi2.png")

## ----echo=FALSE---------------------------------------------------------------
initial <- list(
    RowDataTable(),
    RowDataPlot(YAxis="var_log", XAxis="Row data",
        XAxisRowData="mean_log", BrushData=BB),
    FeatureAssayPlot(DataBoxOpen=TRUE,
        YAxisFeatureDynamicSource=TRUE,
        YAxisFeatureSource="RowDataPlot1",
        XAxis="Column data", XAxisColumnData="dissection_s"
    )
)

app <- iSEE(sce, initial=initial)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/links-dynamic-single.png")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

