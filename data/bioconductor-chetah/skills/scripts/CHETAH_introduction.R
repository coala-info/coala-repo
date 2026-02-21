# Code example from 'CHETAH_introduction' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE
)
knitr::opts_knit$set(
  root.dir = system.file('data', package = 'CHETAH')
)
library(Matrix)
library(CHETAH)

## ----glance, echo=TRUE, eval=FALSE--------------------------------------------
# ## Make SingleCellExperiments
# reference <- SingleCellExperiment(assays = list(counts = ref_counts),
#                                      colData = DataFrame(celltypes = ref_ct))
# 
# input <- SingleCellExperiment(assays = list(counts = input_counts),
#                               reducedDims = SimpleList(TSNE = input_tsne))
# 
# ## Run CHETAH
# input <- CHETAHclassifier(input = input, ref_cells = reference)
# 
# ## Plot the classification
# PlotCHETAH(input)
# 
# ## Extract celltypes:
# celltypes <- input$celltype_CHETAH

## ----bioconductor_inst, echo=TRUE, eval=FALSE---------------------------------
# ## Install BiocManager is necessary
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install('CHETAH')
# 
# # Load the package
# library(CHETAH)

## ----github _inst, echo=TRUE, eval=FALSE--------------------------------------
# ## Install BiocManager is necessary
# if (!require("BiocManager")) {
#     install.packages("BiocManager")
# }
# BiocManager::install('CHETAH', version = "devel")
# 
# # Load the package
# library(CHETAH)

## ----prepare_examp, echo=TRUE, eval=TRUE--------------------------------------
## load CHETAH's datasets
data('headneck_ref')
data('input_mel')

## To prepare the data from the package's internal data, run:
celltypes_hn <- headneck_ref$celltypes
counts_hn <- assay(headneck_ref)
counts_melanoma <- assay(input_mel)
tsne_melanoma <- reducedDim(input_mel)

## The input data: a Matrix
class(counts_melanoma)
counts_melanoma[1:5, 1:5]

## The reduced dimensions of the input cells: 2 column matrix
tsne_melanoma[1:5, ]
all.equal(rownames(tsne_melanoma), colnames(counts_melanoma))

## The reference data: a Matrix
class(counts_hn)
counts_hn[1:5, 1:5]

## The cell types of the reference: a named character vector
str(celltypes_hn)
    
## The names of the cell types correspond with the colnames of the reference counts:
all.equal(names(celltypes_hn), colnames(counts_melanoma)) 

## ----make_sce, echo=TRUE, eval=TRUE-------------------------------------------
## For the reference we define a "counts" assay and "celltypes" metadata
headneck_ref <- SingleCellExperiment(assays = list(counts = counts_hn),
                                     colData = DataFrame(celltypes = celltypes_hn))

## For the input we define a "counts" assay and "TSNE" reduced dimensions
input_mel <- SingleCellExperiment(assays = list(counts = counts_melanoma),
                                  reducedDims = SimpleList(TSNE = tsne_melanoma))

## ----run_chetah, echo=TRUE, eval=TRUE-----------------------------------------
input_mel <- CHETAHclassifier(input = input_mel,
                              ref_cells = headneck_ref)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
PlotCHETAH(input = input_mel)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
PlotCHETAH(input = input_mel, interm = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# colors <- PlotCHETAH(input = input_mel, return_col = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# CHETAHshiny(input = input_mel)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
input_mel <- Classify(input = input_mel, 0.8)
PlotCHETAH(input = input_mel, tree = FALSE)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
input_mel <- Classify(input_mel, 0)
PlotCHETAH(input = input_mel, tree = FALSE)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
input_mel <- RenameBelowNode(input_mel, whichnode = 6, replacement = "T cell")
PlotCHETAH(input = input_mel, tree = FALSE)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
input_mel <- Classify(input_mel) ## the same as Classify(input_mel, 0.1)
PlotCHETAH(input = input_mel, tree = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# cell_selection <- unlist(lapply(unique(ref$celltypes), function(type) {
#     type_cells <- which(ref$celltypes == type)
#     if (length(type_cells) > 200) {
#         type_cells[sample(length(type_cells), 200)]
#     } else type_cells
# }))
# ref_new <- ref[ ,cell_selection]

## ----eval = FALSE-------------------------------------------------------------
# assay(headneck_ref, "counts") <- apply(assay(headneck_ref, "counts"), 2, function(column) log2((column/sum(column) * 100000) + 1))

## ----eval = FALSE-------------------------------------------------------------
# ribo <- read.table("~/ribosomal.txt", header = FALSE, sep = '\t')
# headneck_ref <- headneck_ref[!rownames(headneck_ref) %in% ribo[,1], ]

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12---------------
CorrelateReference(ref_cells = headneck_ref)

## ----out.width="100%", dpi = 50, fig.height = 6, fig.width = 12, fig.cap = "In this plot, the rows are the original cell type labels, the columns the labels that were assigned during classification. The colors and sizes of the squares indicate which part of the cells of the row name type are classified to the column type. E.g. 4th row, 2th column shows that 5-10% of CD4 T cells are classified as regulatory T cells."----
ClassifyReference(ref_cells = headneck_ref)

## -----------------------------------------------------------------------------
sessionInfo()

