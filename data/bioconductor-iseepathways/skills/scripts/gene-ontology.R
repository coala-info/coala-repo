# Code example from 'gene-ontology' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE----------------
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
    iSEEpathways = citation("iSEEpathways")[1]
)

## ----"start", message=FALSE, warning=FALSE------------------------------------
library("org.Hs.eg.db")
library("fgsea")

# Example data ----

## Pathways
pathways <- select(org.Hs.eg.db, keys(org.Hs.eg.db, "SYMBOL"), c("GOALL"), keytype = "SYMBOL")
pathways <- subset(pathways, ONTOLOGYALL == "BP")
pathways <- unique(pathways[, c("SYMBOL", "GOALL")])
pathways <- split(pathways$SYMBOL, pathways$GOALL)
len_pathways <- lengths(pathways)
pathways <- pathways[len_pathways > 15 & len_pathways < 500]

## Features
set.seed(1)
# simulate a score for all genes found across all pathways
feature_stats <- rnorm(length(unique(unlist(pathways))))
names(feature_stats) <- unique(unlist(pathways))
# arbitrarily select a pathway to simulate enrichment
pathway_id <- "GO:0046324"
pathway_genes <- pathways[[pathway_id]]
# increase score of genes in the selected pathway to simulate enrichment
feature_stats[pathway_genes] <- feature_stats[pathway_genes] + 1

# fgsea ----

set.seed(42)
fgseaRes <- fgsea(pathways = pathways, 
                  stats    = feature_stats,
                  minSize  = 15,
                  maxSize  = 500)
head(fgseaRes[order(pval), ])

## ----message=FALSE, warning=FALSE---------------------------------------------
library("SummarizedExperiment")
library("iSEEpathways")
se <- SummarizedExperiment()
fgseaRes <- fgseaRes[order(pval), ]
se <- embedPathwaysResults(fgseaRes, se, name = "fgsea", class = "fgsea", pathwayType = "GO")

## ----message=FALSE, warning=FALSE---------------------------------------------
library("iSEE")
library("GO.db")
library("shiny")
go_details <- function(x) {
    info <- select(GO.db, x, c("TERM", "ONTOLOGY", "DEFINITION"), "GOID")
    html <- list(p(strong(info$GOID), ":", info$TERM, paste0("(", info$ONTOLOGY, ")")))
    if (!is.na(info$DEFINITION)) {
        html <- append(html, list(p(info$DEFINITION)))
    }
    tagList(html)
}
se <- registerAppOptions(se, PathwaysTable.select.details = go_details)

## ----message=FALSE------------------------------------------------------------
app <- iSEE(se, initial = list(
  PathwaysTable(ResultName="fgsea", Selected = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"---------------------------------------------
SCREENSHOT("screenshots/gene_ontology.png", delay=20)

## ----createVignette, eval=FALSE-----------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("gene-ontology.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("gene-ontology.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE---------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE---------------------------------------------------
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

