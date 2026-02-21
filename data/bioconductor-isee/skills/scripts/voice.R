# Code example from 'voice' vignette. See references/ for full tutorial.

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

## -----------------------------------------------------------------------------
library(iSEE)
app <- iSEE(sce, voice=TRUE)

## -----------------------------------------------------------------------------
if (interactive()) {
    shiny::runApp(app, port=1234, launch.browser=FALSE)
}

## ----sessioninfo--------------------------------------------------------------
sessionInfo()
# devtools::session_info()

