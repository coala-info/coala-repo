# Code example from 'classifying-cells' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
options(rmarkdown.html_vignette.check_title = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# if (!require(scAnnotatR))
#   BiocManager::install("scAnnotatR")

## -----------------------------------------------------------------------------
# load scAnnotatR into working space
library(scAnnotatR)

## -----------------------------------------------------------------------------
default_models <- load_models("default")
names(default_models)

## -----------------------------------------------------------------------------
default_models[['B cells']]

## -----------------------------------------------------------------------------
# load the example dataset
data("tirosh_mel80_example")
tirosh_mel80_example

## -----------------------------------------------------------------------------
head(tirosh_mel80_example[[]])

## -----------------------------------------------------------------------------
seurat.obj <- classify_cells(classify_obj = tirosh_mel80_example, 
                             assay = 'RNA', layer = 'counts',
                             cell_types = c('B cells', 'NK', 'T cells'), 
                             path_to_models = 'default')

## -----------------------------------------------------------------------------
# display the additional metadata fields
seurat.obj[[]][c(50:60), c(8:ncol(seurat.obj[[]]))]

## ----fig.width = 4, fig.height = 2.5------------------------------------------
# Visualize the cell types
Seurat::DimPlot(seurat.obj, group.by = "most_probable_cell_type")

## ----fig.width = 4, fig.height = 2.5------------------------------------------
# Visualize the cell types
Seurat::FeaturePlot(seurat.obj, features = "B_cells_p")

## ----fig.width = 7.25, fig.height = 2.5---------------------------------------
# Visualize the cell types
Seurat::FeaturePlot(seurat.obj, features = c("CD19", "MS4A1"), ncol = 2)

## -----------------------------------------------------------------------------
sessionInfo()

