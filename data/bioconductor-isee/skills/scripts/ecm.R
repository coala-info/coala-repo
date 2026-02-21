# Code example from 'ecm' vignette. See references/ for full tutorial.

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
sce <- readRDS('sce.rds')

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x, dpi = NA)

## -----------------------------------------------------------------------------
# Coloring for log-counts:
logcounts_color_fun <- viridis::viridis

## -----------------------------------------------------------------------------
# Coloring for FPKMs:
fpkm_color_fun <- function(n){
    c("black","brown","red","orange","yellow")
}

## ----driver_color_fun---------------------------------------------------------
# Coloring for the 'driver' metadata variable.
driver_color_fun <- function(n){
    RColorBrewer::brewer.pal(n, "Set2")
}

## ----qc_color_fun-------------------------------------------------------------
# Coloring for the QC metadata variable:
qc_color_fun <- function(n){
    qc_colors <- c("forestgreen", "firebrick1")
    names(qc_colors) <- c("Y", "N")
    qc_colors
}

## ----ecm----------------------------------------------------------------------
library(iSEE)
ecm <- ExperimentColorMap(
    assays = list(
        counts = heat.colors,
        logcounts = logcounts_color_fun,
        cufflinks_fpkm = fpkm_color_fun
    ),
    colData = list(
        passes_qc_checks_s = qc_color_fun,
        driver_1_s = driver_color_fun
    ),
    all_continuous = list(
        assays = viridis::plasma
    )
)
ecm

## ----all_continuous-----------------------------------------------------------
ExperimentColorMap(
    all_continuous=list( # shared
        assays=viridis::plasma,
        colData=viridis::inferno
    ),
    global_continuous=viridis::magma # global
)

## ----allen-dataset-4----------------------------------------------------------
app <- iSEE(sce, colormap = ecm)

## ----runApp, eval=FALSE-------------------------------------------------------
# shiny::runApp(app)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/ecm-demo.png")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()
# devtools::session_info()

