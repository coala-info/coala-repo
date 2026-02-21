# Code example from 'sechm' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("sechm")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(SummarizedExperiment)
  library(sechm)
})
data("Chen2017", package="sechm")
SE <- Chen2017

## -----------------------------------------------------------------------------
g <- c("Egr1", "Nr4a1", "Fos", "Egr2", "Sgk1", "Arc", "Dusp1", "Fosb", "Sik1")
sechm(SE, features=g)
# with row scaling:
sechm(SE, features=g, do.scale=TRUE)

## -----------------------------------------------------------------------------
rowData(SE)$meanLogCPM <- rowMeans(assays(SE)$logcpm)
sechm(SE, features=g, assayName="logFC", top_annotation=c("Condition","Time"), left_annotation=c("meanLogCPM"))

## -----------------------------------------------------------------------------
sechm(SE, features=g, do.scale=TRUE, show_colnames=TRUE)

## -----------------------------------------------------------------------------
sechm(SE, features=g, do.scale=TRUE, row_title="My genes")

## -----------------------------------------------------------------------------
sechm(SE, features=row.names(SE), mark=g, do.scale=TRUE, top_annotation=c("Condition","Time"))

## -----------------------------------------------------------------------------
sechm(SE, features=g, do.scale=TRUE, top_annotation="Time", gaps_at="Condition")

## -----------------------------------------------------------------------------
# reverts to clustering:
sechm(SE, features=row.names(SE), do.scale=TRUE, sortRowsOn=NULL)
# no reordering:
sechm(SE, features=row.names(SE), do.scale=TRUE, sortRowsOn=NULL, 
      cluster_rows=FALSE)

## -----------------------------------------------------------------------------
# we first cluster rows, and save the clusters in the rowData:
rowData(SE)$cluster <- as.character(kmeans(t(scale(t(assay(SE)))),5)$cluster)
sechm(SE, features=1:30, do.scale=TRUE, toporder="cluster", 
      left_annotation="cluster", show_rownames=FALSE)
sechm(SE, features=1:30, do.scale=TRUE, gaps_row="cluster",
      show_rownames=FALSE)

## ----fig.width=9--------------------------------------------------------------
library(ComplexHeatmap)
g2 <- c(g,"Gm14288",tail(row.names(SE)))
draw(
    sechm(SE, features=g2, assayName="logFC", breaks=1, column_title="breaks=1") + 
    sechm(SE, features=g2, assayName="logFC", breaks=0.995, 
          column_title="breaks=0.995", name="logFC(2)") + 
    sechm(SE, features=g2, assayName="logFC", breaks=0.985, 
          column_title="breaks=0.985", name="logFC(3)"),
    merge_legends=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # not run
# sechm(SE, features=g2, hmcols=viridisLite::cividis(10))

## -----------------------------------------------------------------------------
metadata(SE)$anno_colors
metadata(SE)$anno_colors$Condition <- c(Control="white", Forskolin="black")
sechm(SE, features=g2, top_annotation="Condition")

## ----colors_in_object---------------------------------------------------------
metadata(SE)$hmcols <- c("darkred","white","darkblue")
sechm(SE, g, do.scale = TRUE)

## ----anno_in_object-----------------------------------------------------------
metadata(SE)$default_view <- list(
  assay="logFC",
  top_annotation="Condition"
)

## ----colors_in_options--------------------------------------------------------
setSechmOption("hmcols", value=c("white","grey","black"))
sechm(SE, g, do.scale = TRUE)

## -----------------------------------------------------------------------------
resetAllSechmOptions()
metadata(SE)$hmcols <- NULL
metadata(SE)$anno_colors <- NULL

## ----two_heatmaps-------------------------------------------------------------
sechm(SE, features=g) + sechm(SE, features=g)

## ----crossHm------------------------------------------------------------------
# we build another SE object and introduce some variation in it:
SE2 <- SE
assays(SE2)$logcpm <- jitter(assays(SE2)$logcpm, factor=1000)
crossHm(list(SE1=SE, SE2=SE2), g, do.scale = TRUE, 
        top_annotation=c("Condition","Time"))

## ----crosshm2-----------------------------------------------------------------
crossHm(list(SE1=SE, SE2=SE2), g, do.scale = TRUE, 
        top_annotation=c("Condition","Time"), uniqueScale = TRUE)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

