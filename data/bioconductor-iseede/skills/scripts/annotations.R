# Code example from 'annotations' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-----------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)
options(width = 100)

## ----eval=!exists("SCREENSHOT"), include=FALSE----------------------------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

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

## -------------------------------------------------------------------------------------------------
rowData(airway)[["ENSEMBL"]] <- rownames(airway)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("org.Hs.eg.db")
rowData(airway)[["SYMBOL"]] <- mapIds(
    org.Hs.eg.db, rownames(airway),
    "SYMBOL", "ENSEMBL"
)

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library("scuttle")
rownames(airway) <- uniquifyFeatureNames(
    ID = rowData(airway)[["ENSEMBL"]],
    names = rowData(airway)[["SYMBOL"]]
)
airway

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

## -------------------------------------------------------------------------------------------------
library(iSEEde)
airway <- embedContrastResults(res_limma, airway,
    name = "dextrt - dexuntrt",
    class = "limma"
)
contrastResults(airway)
contrastResults(airway, "dextrt - dexuntrt")

## ----message=FALSE, warning=FALSE-----------------------------------------------------------------
library(iSEE)

panelDefaults(
    TooltipRowData = c("SYMBOL", "ENSEMBL")
)

app <- iSEE(airway, initial = list(
    VolcanoPlot(ContrastName = "dextrt - dexuntrt", PanelWidth = 6L),
    MAPlot(ContrastName = "dextrt - dexuntrt", PanelWidth = 6L)
))

if (interactive()) {
    shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-----------------------------------------------------------------
SCREENSHOT("screenshots/using_annotations.png", delay = 20)

## ----createVignette, eval=FALSE-------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("annotations.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("annotations.Rmd", tangle = TRUE)

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

