# Code example from 'integration' vignette. See references/ for full tutorial.

## ----setup, include = FALSE-------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL ## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
)

## ----eval=!exists("SCREENSHOT"), include=FALSE------------------------------------------------------------------------
# SCREENSHOT <- function(x, ...) knitr::include_graphics(x)

## ----vignetteSetup, echo=FALSE, message=FALSE, warning = FALSE--------------------------------------------------------
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

## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------
library("airway")
data("airway")
airway$dex <- relevel(airway$dex, "untrt")

## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------
library("org.Hs.eg.db")
library("scater")
rowData(airway)[["ENSEMBL"]] <- rownames(airway)
rowData(airway)[["SYMBOL"]] <- mapIds(org.Hs.eg.db, rownames(airway), "SYMBOL", "ENSEMBL")
rowData(airway)[["uniquifyFeatureNames"]] <- uniquifyFeatureNames(
  ID = rowData(airway)[["ENSEMBL"]],
  names = rowData(airway)[["SYMBOL"]]
)
rownames(airway) <- rowData(airway)[["uniquifyFeatureNames"]]

## ---------------------------------------------------------------------------------------------------------------------
library("scuttle")
airway <- logNormCounts(airway)

## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------
library("edgeR")

counts <- assay(airway, "counts")
design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

keep <- filterByExpr(counts, design)
v <- voom(counts[keep,], design, plot=FALSE)
fit <- lmFit(v, design)
contr <- makeContrasts("dextrt - dexuntrt", levels = colnames(coef(fit)))
tmp <- contrasts.fit(fit, contr)
tmp <- eBayes(tmp)
res_limma <- topTable(tmp, sort.by = "P", n = Inf)
head(res_limma)

## ---------------------------------------------------------------------------------------------------------------------
library("iSEEde")
airway <- iSEEde::embedContrastResults(res_limma, airway, name = "Limma-Voom", class = "limma")
rowData(airway)

## ---------------------------------------------------------------------------------------------------------------------
library("org.Hs.eg.db")
pathways <- select(org.Hs.eg.db, keys(org.Hs.eg.db, "ENSEMBL"), c("GOALL"), keytype = "ENSEMBL")
pathways <- subset(pathways, ONTOLOGYALL == "BP")
pathways <- unique(pathways[, c("ENSEMBL", "GOALL")])
pathways <- merge(pathways, rowData(airway)[, c("ENSEMBL", "uniquifyFeatureNames")])
pathways <- split(pathways$uniquifyFeatureNames, pathways$GOALL)

## ---------------------------------------------------------------------------------------------------------------------
map_GO <- function(pathway_id, se) {
    pathway_ensembl <- mapIds(org.Hs.eg.db, pathway_id, "ENSEMBL", keytype = "GOALL", multiVals = "CharacterList")[[pathway_id]]
    pathway_rownames <- rownames(se)[rowData(se)[["gene_id"]] %in% pathway_ensembl]
    pathway_rownames
}
airway <- registerAppOptions(airway, Pathways.map.functions = list(GO = map_GO))

## ---------------------------------------------------------------------------------------------------------------------
library("fgsea")
set.seed(42)
stats <- na.omit(log2FoldChange(contrastResults(airway, "Limma-Voom")))
fgseaRes <- fgsea(pathways = pathways, 
                  stats    = stats,
                  minSize  = 15,
                  maxSize  = 500)
head(fgseaRes[order(pval), ])

## ---------------------------------------------------------------------------------------------------------------------
library("iSEEpathways")
fgseaRes <- fgseaRes[order(pval), ]
airway <- embedPathwaysResults(
  fgseaRes, airway, name = "fgsea (p-value)", class = "fgsea",
  pathwayType = "GO", pathwaysList = pathways, featuresStats = stats)
airway

## ----warning=FALSE----------------------------------------------------------------------------------------------------
stats <- na.omit(
  log2FoldChange(contrastResults(airway, "Limma-Voom")) *
  -log10(pValue(contrastResults(airway, "Limma-Voom")))
)
set.seed(42)
fgseaRes <- fgsea(pathways = pathways, 
                  stats    = na.omit(stats),
                  minSize  = 15,
                  maxSize  = 500)
fgseaRes <- fgseaRes[order(pval), ]
airway <- embedPathwaysResults(
  fgseaRes, airway, name = "fgsea (p-value & fold-change)", class = "fgsea",
  pathwayType = "GO", pathwaysList = pathways, featuresStats = stats)
airway

## ----warning=FALSE----------------------------------------------------------------------------------------------------
library("GO.db")
library("shiny")
library("iSEE")
go_details <- function(x) {
    info <- select(GO.db, x, c("TERM", "ONTOLOGY", "DEFINITION"), "GOID")
    html <- list(p(strong(info$GOID), ":", info$TERM, paste0("(", info$ONTOLOGY, ")")))
    if (!is.na(info$DEFINITION)) {
        html <- append(html, list(p(info$DEFINITION)))
    }
    tagList(html)
}
airway <- registerAppOptions(airway, PathwaysTable.select.details = go_details)

## ----"start", message=FALSE, warning=FALSE----------------------------------------------------------------------------
app <- iSEE(airway, initial = list(
  PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
  VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
  ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
      PanelWidth = 4L, PanelHeight = 700L,
      CustomRows = FALSE, ColumnData = "dex",
      ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
  FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-------------------------------------------------------------------------------------
SCREENSHOT("screenshots/integration.png", delay=30)

## ---------------------------------------------------------------------------------------------------------------------
metadata(airway)[["pathways"]] <- list(GO = pathways)

## ---------------------------------------------------------------------------------------------------------------------
map_GO_v2 <- function(pathway_id, se) {
    pathway_list <- metadata(se)[["pathways"]][["GO"]]
    if (!pathway_id %in% names(pathway_list)) {
        warning("Pathway identifier %s not found.", sQuote(pathway_id))
        return(character(0))
    }
    pathway_list[[pathway_id]]
}
airway <- registerAppOptions(airway, Pathways.map.functions = list(GO = map_GO_v2))

## ----"faster", message=FALSE, warning=FALSE---------------------------------------------------------------------------
app <- iSEE(airway, initial = list(
  PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
  VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
  ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
      PanelWidth = 4L, PanelHeight = 700L,
      CustomRows = FALSE, ColumnData = "dex",
      ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
  FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}

## ----echo=FALSE, out.width="100%"-------------------------------------------------------------------------------------
SCREENSHOT("screenshots/integration-faster.png", delay=20)

## ----createVignette, eval=FALSE---------------------------------------------------------------------------------------
# ## Create the vignette
# library("rmarkdown")
# system.time(render("integration.Rmd", "BiocStyle::html_document"))
# 
# ## Extract the R code
# library("knitr")
# knit("integration.Rmd", tangle = TRUE)

## ----reproduce1, echo=FALSE-------------------------------------------------------------------------------------------
## Date the vignette was generated
Sys.time()

## ----reproduce2, echo=FALSE-------------------------------------------------------------------------------------------
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

