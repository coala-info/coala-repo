# Code example from 'methods' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)
options(width = 100)

## ----eval=!exists("SCREENSHOT"), include=FALSE----------------------------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE------------------------------------
## Track time spent on making the vignette
startTime <- Sys.time()

## Bib setup
library("RefManageR")

## Write bibliography information
bib <- c(
    R = citation(),
    BiocStyle = citation("BiocStyle")[1],
    knitr = citation("knitr")[1],
    RefManageR = citation("RefManageR")[1],
    rmarkdown = citation("rmarkdown")[1],
    sessioninfo = citation("sessioninfo")[1],
    testthat = citation("testthat")[1],
    iSEEde = citation("iSEEde")[1]
)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("airway")
data("airway")
airway$dex <- relevel(airway$dex, "untrt")

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("edgeR")

design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

keep <- filterByExpr(airway, design)
fit <- voomLmFit(airway[keep, ], design, plot = FALSE)
contr <- makeContrasts("dextrt - dexuntrt", levels = design)
fit <- contrasts.fit(fit, contr)
fit <- eBayes(fit)
res_limma <- topTable(fit, sort.by = "P", n = Inf)
head(res_limma)

## ----message=FALSE--------------------------------------------------------------------------------
library(iSEEde)
embedContrastResultsMethods

## -------------------------------------------------------------------------------------------------
airway <- embedContrastResults(res_limma, airway, name = "Limma-Voom", class = "limma")
contrastResults(airway)
contrastResults(airway, "Limma-Voom")

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("DESeq2")

dds <- DESeqDataSet(airway, ~ 0 + dex + cell)

dds <- DESeq(dds)
res_deseq2 <- results(dds, contrast = list("dextrt", "dexuntrt"))
head(res_deseq2)

## -------------------------------------------------------------------------------------------------
airway <- embedContrastResults(res_deseq2, airway, name = "DESeq2")
contrastResults(airway)
contrastResults(airway, "DESeq2")

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("edgeR")

design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

fit <- glmFit(airway, design, dispersion = 0.1)
lrt <- glmLRT(fit, contrast = c(-1, 1, 0, 0, 0))
res_edger <- topTags(lrt, n = Inf)
head(res_edger)

## -------------------------------------------------------------------------------------------------
airway <- embedContrastResults(res_edger, airway, name = "edgeR")
contrastResults(airway)
contrastResults(airway, "edgeR")

## ----message=FALSE--------------------------------------------------------------------------------
library(iSEE)
app <- iSEE(airway, initial = list(
  DETable(ContrastName="Limma-Voom", HiddenColumns = c("AveExpr", 
    "t", "B"), PanelWidth = 4L),
  VolcanoPlot(ContrastName = "Limma-Voom", PanelWidth = 4L),
  MAPlot(ContrastName = "Limma-Voom", PanelWidth = 4L),
  DETable(ContrastName="DESeq2", HiddenColumns = c("baseMean", 
    "lfcSE", "stat"), PanelWidth = 4L),
  VolcanoPlot(ContrastName = "DESeq2", PanelWidth = 4L),
  MAPlot(ContrastName = "DESeq2", PanelWidth = 4L),
  DETable(ContrastName="edgeR", HiddenColumns = c("logCPM", 
    "LR"), PanelWidth = 4L),
  VolcanoPlot(ContrastName = "edgeR", PanelWidth = 4L),
  MAPlot(ContrastName = "edgeR", PanelWidth = 4L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/methods_side_by_side.png", delay = 20)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(iSEE)
app <- iSEE(airway, initial = list(
    VolcanoPlot(ContrastName="Limma-Voom",
        RowSelectionSource = "LogFCLogFCPlot1", ColorBy = "Row selection",
        PanelWidth = 4L),
    LogFCLogFCPlot(ContrastNameX="Limma-Voom", ContrastNameY="DESeq2",
        BrushData = list(
        xmin = 3.6, xmax = 8.2, ymin = 3.8, ymax = 9.8,
        mapping = list(x = "X", y = "Y"),
        direction = "xy", brushId = "LogFCLogFCPlot1_Brush", 
        outputId = "LogFCLogFCPlot1"),
        PanelWidth = 4L),
    VolcanoPlot(ContrastName="DESeq2",
        RowSelectionSource = "LogFCLogFCPlot1", ColorBy = "Row selection",
        PanelWidth = 4L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/logfc_logfc_plot.png", delay = 20)

## ----createVignette, eval=FALSE-------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("methods.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("methods.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-----------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-----------------------------------------------------------------------
## Processing time in seconds
totalTime <- diff(c(startTime, Sys.time()))
round(totalTime, digits = 3)

## ----reproduce3, echo=FALSE-------------------------------------------------------------------------------------------
## Session info
library("sessioninfo")
options(width = 120)
session_info()

## ----vignetteBiblio, results = "asis", echo = FALSE, warning = FALSE, message = FALSE---------------------------------
## Print bibliography
PrintBibliography(bib, .opts = list(hyperlink = "to.doc", style = "html"))

