# Code example from 'ExploreModelMatrix' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
stopifnot(requireNamespace("htmltools"))
htmltools::tagList(rmarkdown::html_dependency_font_awesome())

## ----setup--------------------------------------------------------------------
library(ExploreModelMatrix)

## ----fig.width = 5------------------------------------------------------------
(sampleData <- data.frame(genotype = rep(c("A", "B"), each = 4),
                          treatment = rep(c("ctrl", "trt"), 4)))
vd <- VisualizeDesign(sampleData = sampleData, 
                      designFormula = ~ genotype + treatment, 
                      textSizeFitted = 4)
cowplot::plot_grid(plotlist = vd$plotlist)
app <- ExploreModelMatrix(sampleData = sampleData,
                          designFormula = ~ genotype + treatment)
if (interactive()) {
  shiny::runApp(app)
}

## ----fig.width = 5, fig.height = 12-------------------------------------------
(sampleData <- data.frame(
  Response = rep(c("Resistant", "Sensitive"), c(12, 18)),
  Patient = factor(rep(c(1:6, 8, 11:18), each = 2)),
  Treatment = factor(rep(c("pre","post"), 15)), 
  ind.n = factor(rep(c(1:6, 2, 5:12), each = 2))))
vd <- VisualizeDesign(
  sampleData = sampleData,
  designFormula = ~ Response + Response:ind.n + Response:Treatment,
  textSizeFitted = 3
)
cowplot::plot_grid(plotlist = vd$plotlist, ncol = 1)
app <- ExploreModelMatrix(
  sampleData = sampleData,
  designFormula = ~ Response + Response:ind.n + Response:Treatment
)
if (interactive()) {
  shiny::runApp(app)
}

## ----fig.width = 5------------------------------------------------------------
vd <- VisualizeDesign(sampleData = sampleData,
                      designFormula = ~ Treatment + Response, 
                      textSizeFitted = 4)
cowplot::plot_grid(plotlist = vd$plotlist, ncol = 1)

## ----fig.height = 4, fig.width = 6--------------------------------------------
(sampleData = data.frame(
  condition = factor(rep(c("ctrl_minus", "ctrl_plus", 
                           "ko_minus", "ko_plus"), 3)),
  batch = factor(rep(1:6, each = 2))))
vd <- VisualizeDesign(sampleData = sampleData,
                      designFormula = ~ 0 + batch + condition, 
                      textSizeFitted = 4, lineWidthFitted = 20, 
                      dropCols = "conditionko_minus")
cowplot::plot_grid(plotlist = vd$plotlist, ncol = 1)
app <- ExploreModelMatrix(sampleData = sampleData,
                          designFormula = ~ batch + condition)
if (interactive()) {
  shiny::runApp(app)
}

## -----------------------------------------------------------------------------
if (interactive()) {
  out <- shiny::runApp(app)
}

## -----------------------------------------------------------------------------
sessionInfo()

