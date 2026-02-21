# Code example from 'custom' vignette. See references/ for full tutorial.

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

## ----CUSTOM_PCA---------------------------------------------------------------
library(scater)
CUSTOM_DIMRED <- function(se, rows, columns, ntop=500, scale=TRUE,
    mode=c("PCA", "TSNE", "UMAP"))
{
    print(columns)
    if (is.null(columns)) {
        return(
            ggplot() + theme_void() + geom_text(
                aes(x, y, label=label),
                data.frame(x=0, y=0, label="No column data selected."),
                size=5)
            )
    }

    mode <- match.arg(mode)
    if (mode=="PCA") {
        calcFUN <- runPCA
    } else if (mode=="TSNE") {
        calcFUN <- runTSNE
    } else if (mode=="UMAP") {
        calcFUN <- runUMAP
    }

    set.seed(1000)
    kept <- se[, unique(unlist(columns))]
    kept <- calcFUN(kept, ncomponents=2, ntop=ntop,
        scale=scale, subset_row=unique(unlist(rows)))
    plotReducedDim(kept, mode)
}

## -----------------------------------------------------------------------------
library(iSEE)
GENERATOR <- createCustomPlot(CUSTOM_DIMRED)
custom_panel <- GENERATOR()
class(custom_panel)

## -----------------------------------------------------------------------------
# NOTE: as mentioned before, you don't have to create 'BrushData' manually;
# just open an app, make a brush and copy it from the panel settings.
cdp <- ColumnDataPlot(
    XAxis="Column data", 
    XAxisColumnData="Primary.Type", 
    PanelId=1L,
    BrushData=list(
        xmin = 10.1, xmax = 15.0, ymin = 5106720.6, ymax = 28600906.0, 
        coords_css = list(xmin = 271.0, xmax = 380.0, ymin = 143.0, ymax = 363.0), 
        coords_img = list(xmin = 352.3, xmax = 494.0, ymin = 185.9, ymax = 471.9), 
        img_css_ratio = list(x = 1.3, y = 1.2), 
        mapping = list(x = "X", y = "Y", group = "GroupBy"),
        domain = list(
            left = 0.4, right = 17.6, bottom = -569772L, top = 41149532L, 
            discrete_limits = list(
                x = list("L4 Arf5", "L4 Ctxn3", "L4 Scnn1a", 
                    "L5 Ucma", "L5a Batf3", "L5a Hsd11b1", "L5a Pde1c", 
                    "L5a Tcerg1l", "L5b Cdh13", "L5b Chrna6", "L5b Tph2", 
                    "L6a Car12", "L6a Mgp", "L6a Sla", "L6a Syt17", 
                    "Pvalb Tacr3", "Sst Myh8")
            )
        ), 
        range = list(
            left = 68.986301369863, right = 566.922374429224, 
            bottom = 541.013698630137, top = 33.1552511415525
        ), 
        log = list(x = NULL, y = NULL), 
        direction = "xy", 
        brushId = "ColumnDataPlot1_Brush", 
        outputId = "ColumnDataPlot1"
    )
)

custom.p <- GENERATOR(mode="TSNE", ntop=1000, 
    ColumnSelectionSource="ColumnDataPlot1")

app <- iSEE(sce, initial=list(cdp, custom.p)) 

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/custom-plot.png")

## ----CUSTOM_SUMMARY-----------------------------------------------------------
CUSTOM_SUMMARY <- function(se, ri, ci, assay="logcounts", min_exprs=0) {
    if (is.null(ri)) {
        ri <- rownames(se)
    } else {
        ri <- unique(unlist(ri))
    }
    if (is.null(ci)) {
        ci <- colnames(se)
    } else {
        ci <- unique(unlist(ci))
    }
    
    assayMatrix <- assay(se, assay)[ri, ci, drop=FALSE]
    
    data.frame(
        Mean = rowMeans(assayMatrix),
        Var = rowVars(assayMatrix),
        Sum = rowSums(assayMatrix),
        n_detected = rowSums(assayMatrix > min_exprs),
        row.names = ri
    )
}

## -----------------------------------------------------------------------------
library(iSEE)
GENERATOR <- createCustomTable(CUSTOM_SUMMARY)
custom.t <- GENERATOR(PanelWidth=8L,
    ColumnSelectionSource="ReducedDimensionPlot1",
    SearchColumns=c("", "17.8 ... 10000", "", "") # filtering for HVGs.
) 
class(custom.t)

# Preselecting some points in the reduced dimension plot.
# Again, you don't have to manually create the 'BrushData'!
rdp <- ReducedDimensionPlot(
    PanelId=1L,
    BrushData = list(
        xmin = -44.8, xmax = -14.3, ymin = 7.5, ymax = 47.1, 
        coords_css = list(xmin = 55.0, xmax = 169.0, ymin = 48.0, ymax = 188.0),
        coords_img = list(xmin = 71.5, xmax = 219.7, ymin = 62.4, ymax = 244.4), 
        img_css_ratio = list(x = 1.3, y = 1.29), 
        mapping = list(x = "X", y = "Y"), 
        domain = list(left = -49.1, right = 57.2, bottom = -70.3, top = 53.5), 
        range = list(left = 50.9, right = 566.9, bottom = 603.0, top = 33.1), 
        log = list(x = NULL, y = NULL), 
        direction = "xy", 
        brushId = "ReducedDimensionPlot1_Brush", 
        outputId = "ReducedDimensionPlot1"
    )
)

app <- iSEE(sce, initial=list(rdp, custom.t))

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/custom-table.png")

## -----------------------------------------------------------------------------
CUSTOM_DIFFEXP <- function(se, ri, ci, assay="logcounts") {
    ri <- ri$active
    if (is.null(ri)) { 
        ri <- rownames(se)
    }
    assayMatrix <- assay(se, assay)[ri, , drop=FALSE]

    if (is.null(ci$active) || length(ci)<2L) {
        return(data.frame(row.names=character(0), LogFC=integer(0))) # dummy value.
    }
    active <- rowMeans(assayMatrix[,ci$active,drop=FALSE])

    all_saved <- ci[grep("saved", names(ci))]
    lfcs <- vector("list", length(all_saved))
    for (i in seq_along(lfcs)) {
        saved <- rowMeans(assayMatrix[,all_saved[[i]],drop=FALSE])
        lfcs[[i]] <- active - saved
    }

    names(lfcs) <- sprintf("LogFC/%i", seq_along(lfcs))
    do.call(data.frame, lfcs)
}

## -----------------------------------------------------------------------------
CUSTOM_HEAT <- function(se, ri, ci, assay="logcounts") {
    everything <- CUSTOM_DIFFEXP(se, ri, ci, assay=assay)
    if (nrow(everything) == 0L) {
        return(ggplot()) # empty ggplot if no genes reported.
    }

    everything <- as.matrix(everything)
    top <- head(order(rowMeans(abs(everything)), decreasing=TRUE), 50)
    topFC <- everything[top, , drop=FALSE]
    dfFC <- data.frame(
        gene=rep(rownames(topFC), ncol(topFC)),
        contrast=rep(colnames(topFC), each=nrow(topFC)),
        value=as.vector(topFC)
    )
    ggplot(dfFC, aes(contrast, gene)) + geom_raster(aes(fill = value))
}

## -----------------------------------------------------------------------------
TAB_GEN <- createCustomTable(CUSTOM_DIFFEXP)
HEAT_GEN <- createCustomPlot(CUSTOM_HEAT)

rdp[["SelectionHistory"]] <- list(
    list(lasso = NULL, closed = TRUE, panelvar1 = NULL, panelvar2 = NULL, 
        mapping = list(x = "X", y = "Y"), 
        coord = structure(c(-44.3, -23.7, -13.5, -19.6,
            -33.8, -48.6, -44.3, -33.9, -55.4, -43.0,
            -19.5, -4.0, -22.6, -33.9), .Dim = c(7L, 2L)
        )
    )
)

app <- iSEE(sce, initial=list(rdp,
    TAB_GEN(ColumnSelectionSource="ReducedDimensionPlot1"),
    HEAT_GEN(ColumnSelectionSource="ReducedDimensionPlot1"))
)

## ----echo=FALSE---------------------------------------------------------------
SCREENSHOT("screenshots/custom-heat.png")

## ----sessioninfo--------------------------------------------------------------
sessionInfo()
# devtools::session_info()

