# Code example from 'bigdata' vignette. See references/ for full tutorial.

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
unlink("assay.h5")

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x, dpi = NA)

## -----------------------------------------------------------------------------
library(TENxPBMCData)
sce.pbmc <- TENxPBMCData("pbmc68k")
sce.pbmc$Library <- factor(sce.pbmc$Library)
sce.pbmc

## -----------------------------------------------------------------------------
library(scRNAseq)
sce.allen <- ReprocessedAllenData("tophat_counts")
class(assay(sce.allen, "tophat_counts"))

## -----------------------------------------------------------------------------
counts(sce.pbmc, withDimnames=FALSE)

## -----------------------------------------------------------------------------
object.size(counts(sce.pbmc, withDimnames=FALSE))

## -----------------------------------------------------------------------------
first.gene <- counts(sce.pbmc)[1,]
head(first.gene)

## -----------------------------------------------------------------------------
library(iSEE)
app <- iSEE(sce.pbmc, initial=
    list(RowDataTable(Selected="ENSG00000251562", Search="MALAT1"), 
        FeatureAssayPlot(XAxis="Column data", XAxisColumnData="Library",
            YAxisFeatureSource="RowDataTable1")
    )
)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/bigdata-hdf5.png")

## -----------------------------------------------------------------------------
sce.h5 <- sce.allen
library(HDF5Array)
assay(sce.h5, "tophat_counts", withDimnames=FALSE)  <- 
    writeHDF5Array(assay(sce.h5, "tophat_counts"), file="assay.h5", name="counts")
class(assay(sce.h5, "tophat_counts", withDimnames=FALSE))
list.files("assay.h5")

## ----echo=FALSE---------------------------------------------------------------
unlink("assay.h5")

## -----------------------------------------------------------------------------
library(iSEE)
app <- iSEE(sce.pbmc, initial=
    list(RowDataTable(Selected="ENSG00000251562", Search="MALAT1"), 
        FeatureAssayPlot(XAxis="Column data", XAxisColumnData="Library",
            YAxisFeatureSource="RowDataTable1", 
            VisualChoices="Point", Downsample=TRUE,
            VisualBoxOpen=TRUE
        )
    )
)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/bigdata-downsample.png")

## ----eval=FALSE---------------------------------------------------------------
# panelDefaults(Downsample=TRUE)

## ----echo=FALSE---------------------------------------------------------------
brushed <- list(xmin = 0.4, xmax = 1.6672635882221, ymin = 21.106156820944, ymax = 62.899238475283, 
        coords_css = list(xmin = 41.5274754930861, xmax = 102.504791259766, ymin = 200.009613037109, 
            ymax = 365.009613037109), coords_img = list(xmin = 53.986301369863, xmax = 133.25766825691, 
            ymin = 260.012487411041, ymax = 474.512479543227), img_css_ratio = list(x = 1.30001404440901, 
            y = 1.29999995231628), mapping = list(x = "X", y = "Y", group = "GroupBy"), 
        domain = list(left = 0.4, right = 8.6, bottom = -5.1, top = 107.1, discrete_limits = list(
            x = list("1", "2", "3", "4", "5", "6", "7", "8"))), range = list(left = 53.986301369863, 
            right = 566.922374429224, bottom = 609.013698630137, top = 33.1552511415525), 
        log = list(x = NULL, y = NULL), direction = "xy", brushId = "FeatureAssayPlot1_Brush", 
        outputId = "FeatureAssayPlot1")

library(iSEE)
app <- iSEE(sce.pbmc, initial=
    list(RowDataTable(Selected="ENSG00000251562", Search="MALAT1"), 
        FeatureAssayPlot(XAxis="Column data", XAxisColumnData="Library",
            YAxisFeatureSource="RowDataTable1", 
            YAxisFeatureName="ENSG00000251562",
            VisualChoices="Point", Downsample=TRUE,
            VisualBoxOpen=TRUE, BrushData=brushed 
        )
    )
)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/bigdata-downsample2.png")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()
# devtools::session_info()

