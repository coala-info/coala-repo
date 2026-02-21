# Code example from 'scDotPlot' vignette. See references/ for full tutorial.

## ----Setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      message = FALSE,
                      warning = FALSE,
                      crop = NULL)

## ----Install, eval = FALSE----------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("scDotPlot")

## ----Install GitHub, eval = FALSE---------------------------------------------
# if (!requireNamespace("remotes", quietly = TRUE)) {
#     install.packages("remotes")
# }
# 
# remotes::install_github("ben-laufer/scDotPlot")

## ----Prepare SingleCellExperiment---------------------------------------------
library(scRNAseq)
library(scuttle)

sce <- ZeiselBrainData()

sce <- sce |> 
    logNormCounts() |>  
    subset(x = _, , level2class != "(none)")

## ----Get features SingleCellExperiment----------------------------------------
library(scran)
library(purrr)
library(dplyr)
library(AnnotationDbi)

features <- sce |>
    scoreMarkers(sce$level1class) |>
    map(~ .x |>
            as.data.frame() |>
            arrange(desc(mean.AUC))|>
            dplyr::slice(1:6) |>
            rownames()) |> 
    unlist2()

rowData(sce)$Marker <- features[match(rownames(sce), features)] |>
    names()

## ----scePlot1, fig.cap = "scDotPlot of SingleCellExperiment logcounts", fig.width=12, fig.height=12, dpi=50----
library(scDotPlot)
library(ggsci)

sce |>
    scDotPlot(features = features,
              group = "level2class",
              groupAnno = "level1class",
              featureAnno = "Marker",
              groupLegends = FALSE,
              annoColors = list("level1class" = pal_d3()(7),
                                "Marker" = pal_d3()(7)),
              annoWidth = 0.02)

## ----scePlot2, fig.cap = "scDotPlot of SingleCellExperiment Z-scores", fig.width=12, fig.height=12, dpi=50----
sce |>
    scDotPlot(scale = TRUE,
              features = features,
              group = "level2class",
              groupAnno = "level1class",
              featureAnno = "Marker",
              groupLegends = FALSE,
              annoColors = list("level1class" = pal_d3()(7),
                                "Marker" = pal_d3()(7)),
              annoWidth = 0.02)

## ----Get features Seurat------------------------------------------------------
library(Seurat)
library(SeuratObject)
library(tibble)

data("pbmc_small")

features <- pbmc_small |>
    FindAllMarkers(only.pos = TRUE, verbose = FALSE) |>
    group_by(cluster) |>
    dplyr::slice(1:6) |>
    dplyr::select(cluster, gene)

pbmc_small[[DefaultAssay(pbmc_small)]][[]] <- pbmc_small[[DefaultAssay(pbmc_small)]][[]] |>
    rownames_to_column("gene") |> 
    left_join(features, by = "gene") |> 
    column_to_rownames("gene")

features <- features |> 
    deframe()

## ----SeuratPlot1, fig.cap = "scDotPlot of Seurat logcounts", fig.width=4, fig.height=5, out.width="75%", out.height="75%", dpi=50----
pbmc_small |>
    scDotPlot(features = features,
              group = "RNA_snn_res.1",
              groupAnno = "RNA_snn_res.1",
              featureAnno = "cluster",
              annoColors = list("RNA_snn_res.1" = pal_d3()(7),
                                "cluster" = pal_d3()(7)),
              groupLegends = FALSE,
              annoWidth = 0.075)

## ----SeuratPlot2, fig.cap = "scDotPlot of Seurat Z-scores", fig.width=4, fig.height=5, out.width="75%", out.height="75%", dpi=50----
pbmc_small |>
    scDotPlot(scale = TRUE,
              features = features,
              group = "RNA_snn_res.1",
              groupAnno = "RNA_snn_res.1",
              featureAnno = "cluster",
              annoColors = list("RNA_snn_res.1" = pal_d3()(7),
                                "cluster" = pal_d3()(7)),
              groupLegends = FALSE,
              annoWidth = 0.075)

## ----Session info, echo=FALSE-------------------------------------------------
sessionInfo()

