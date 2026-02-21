# Code example from 'iSEEu' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE)
library(BiocStyle)

## ----eval=!exists("SCREENSHOT"), include=FALSE--------------------------------
SCREENSHOT <- function(x, ...) knitr::include_graphics(x, dpi = NA)

## -----------------------------------------------------------------------------
library(iSEEu)

## -----------------------------------------------------------------------------
library(airway)
data(airway)

library(edgeR)
y <- DGEList(assay(airway), samples=colData(airway))
y <- y[filterByExpr(y, group=y$samples$dex),]
y <- calcNormFactors(y)

design <- model.matrix(~dex, y$samples)
y <- estimateDisp(y, design)
fit <- glmQLFit(y, design)
res <- glmQLFTest(fit, coef=2)

tab <- topTags(res, n=Inf)$table
rowData(airway) <- cbind(rowData(airway), tab[rownames(airway),])

## -----------------------------------------------------------------------------
ma.panel <- MAPlot(PanelWidth=6L)
app <- iSEE(airway, initial=list(ma.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/ma.png")

## -----------------------------------------------------------------------------
vol.panel <- VolcanoPlot(PanelWidth=6L)
app <- iSEE(airway, initial=list(vol.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/volcano.png")

## -----------------------------------------------------------------------------
# Creating another comparison, this time by blocking on the cell line
design.alt <- model.matrix(~cell + dex, y$samples)
y.alt <- estimateDisp(y, design.alt)
fit.alt <- glmQLFit(y.alt, design.alt)
res.alt <- glmQLFTest(fit.alt, coef=2)

tab.alt <- topTags(res.alt, n=Inf)$table
rowData(airway) <- cbind(rowData(airway), alt=tab.alt[rownames(airway),])

lfc.panel <- LogFCLogFCPlot(PanelWidth=6L, YAxis="alt.logFC", 
    YPValueField="alt.PValue")
app <- iSEE(airway, initial=list(lfc.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/logfclogfc.png")

## -----------------------------------------------------------------------------
library(scRNAseq)
sce <- ReprocessedAllenData(assays="tophat_counts")

library(scater)
sce <- logNormCounts(sce, exprs_values="tophat_counts")
sce <- runPCA(sce, ncomponents=4)
sce <- runTSNE(sce)

## -----------------------------------------------------------------------------
# Receives a selection from a reduced dimension plot.
dyn.panel <- DynamicReducedDimensionPlot(Type="UMAP", Assay="logcounts",
    ColumnSelectionSource="ReducedDimensionPlot1", PanelWidth=6L)

# NOTE: users do not have to manually create this, just 
# copy it from the "Panel Settings" of an already open app.
red.panel <- ReducedDimensionPlot(PanelId=1L, PanelWidth=6L,
    BrushData = list(
        xmin = -45.943, xmax = -15.399, ymin = -58.560, 
        ymax = 49.701, coords_css = list(xmin = 51.009, 
            xmax = 165.009, ymin = 39.009, 
            ymax = 422.009), coords_img = list(xmin = 66.313, 
            xmax = 214.514, ymin = 50.712, 
            ymax = 548.612), img_css_ratio = list(x = 1.300, 
            y = 1.299), mapping = list(x = "X", y = "Y"), 
        domain = list(left = -49.101, right = 57.228, 
            bottom = -70.389, top = 53.519), 
        range = list(left = 50.986, right = 566.922, 
            bottom = 603.013, top = 33.155), 
        log = list(x = NULL, y = NULL), direction = "xy", 
        brushId = "ReducedDimensionPlot1_Brush", 
        outputId = "ReducedDimensionPlot1"
    )
)

app <- iSEE(sce, initial=list(red.panel, dyn.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/dynreddim.png")

## -----------------------------------------------------------------------------
diff.panel <- DynamicMarkerTable(PanelWidth=8L, Assay="logcounts",
    ColumnSelectionSource="ReducedDimensionPlot1",)

# Recycling the reduced dimension panel above, adding a saved selection to
# compare to the active selection.
red.panel[["SelectionHistory"]] <- list(
    BrushData = list(
        xmin = 15.143, xmax = 57.228, ymin = -40.752, 
        ymax = 25.674, coords_css = list(xmin = 279.009, 
            xmax = 436.089, ymin = 124.009, 
            ymax = 359.009), coords_img = list(xmin = 362.716, 
            xmax = 566.922, ymin = 161.212, 
            ymax = 466.712), img_css_ratio = list(x = 1.300, 
            y = 1.299), mapping = list(x = "X", y = "Y"), 
        domain = list(left = -49.101, right = 57.228, 
            bottom = -70.389, top = 53.519), 
        range = list(left = 50.986, right = 566.922, 
            bottom = 603.013, top = 33.155), 
        log = list(x = NULL, y = NULL), direction = "xy", 
        brushId = "ReducedDimensionPlot1_Brush", 
        outputId = "ReducedDimensionPlot1"
    )
)
red.panel[["PanelWidth"]] <- 4L # To fit onto one line.

app <- iSEE(sce, initial=list(red.panel, diff.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/diffstat.png")

## -----------------------------------------------------------------------------
setFeatureSetCommands(createGeneSetCommands(identifier="ENSEMBL"))

gset.tab <- FeatureSetTable(Selected="GO:0002576", 
    Search="platelet", PanelWidth=6L)

# This volcano plot will highlight the genes in the selected gene set.
vol.panel <- VolcanoPlot(RowSelectionSource="FeatureSetTable1",
    ColorBy="Row selection", PanelWidth=6L)

app <- iSEE(airway, initial=list(gset.tab, vol.panel))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/geneset.png", delay=30)

## -----------------------------------------------------------------------------
app <- iSEE(
    sce,
    initial = list(
        AggregatedDotPlot(
            ColumnDataLabel="Primary.Type",
            CustomRowsText = "Rorb\nSnap25\nFoxp2",
            PanelHeight = 500L, 
            PanelWidth = 8L
        )  
    )
)

## To be later run as...
# app
## ... or
# shiny::runApp(app)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/aggrodotplot.png", delay=30)

## -----------------------------------------------------------------------------
app <- iSEE(
    sce, 
    initial = list(
        MarkdownBoard(
            Content = "# `iSEE` notepad\n\nYou can enter anything here.\n\nA list of marker genes you might be interested into:\n\n- Snap25\n- Rorb\n- Foxp2\n\nThis makes it easier to copy-paste while staying inside `iSEE`.  \nAs you can notice, the full power of markdown is at your service.\n\nHave fun exploring your data, in an even more efficient manner!\n", 
            PanelWidth = 8L,
            DataBoxOpen = TRUE
        )
    )
)

## To be later run as...
# app
## ... or
# shiny::runApp(app)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/markdownboard.png", delay=30)

## -----------------------------------------------------------------------------
sessionInfo()

