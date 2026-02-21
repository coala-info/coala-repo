# Code example from 'scAlign' vignette. See references/ for full tutorial.

## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- message=FALSE------------------------------------------------------
library(scAlign)
library(SingleCellExperiment)
library(ggplot2)

## Load in cellbench data
data("cellbench", package = "scAlign", envir = environment())

## Extract RNA mixture cell types
mix.types = unlist(lapply(strsplit(colnames(cellbench), "-"), "[[", 2))

## Extract Platform
batch = c(rep("CEL", length(which(!grepl("sortseq", colnames(cellbench)) == TRUE))),
          rep("SORT", length(which(grepl("sortseq", colnames(cellbench)) == TRUE))))

## ------------------------------------------------------------------------
## Create SCE objects to pass into scAlignCreateObject
youngMouseSCE <- SingleCellExperiment(
    assays = list(scale.data = cellbench[,batch=='CEL'])
)

oldMouseSCE <- SingleCellExperiment(
    assays = list(scale.data = cellbench[,batch=='SORT'])
)

## Build the scAlign class object and compute PCs
scAlignCB = scAlignCreateObject(sce.objects = list("CEL"=youngMouseSCE,
                                                   "SORT"=oldMouseSCE),
                                 labels = list(mix.types[batch=='CEL'],
                                               mix.types[batch=='SORT']),
                                 data.use="scale.data",
                                 pca.reduce = FALSE,
                                 cca.reduce = TRUE,
                                 ccs.compute = 5,
                                 project.name = "scAlign_cellbench")

## ------------------------------------------------------------------------
## Run scAlign with all_genes
scAlignCB = scAlign(scAlignCB,
                    options=scAlignOptions(steps=1000,
                                           log.every=1000,
                                           norm=TRUE,
                                           early.stop=TRUE),
                    encoder.data="scale.data",
                    supervised='none',
                    run.encoder=TRUE,
                    run.decoder=FALSE,
                    log.dir=file.path('~/models_temp','gene_input'),
                    device="CPU")

# ## Additional run of scAlign with CCA
# scAlignCB = scAlign(scAlignCB,
#                     options=scAlignOptions(steps=1000,
#                                            log.every=1000,
#                                            norm=TRUE,
#                                            early.stop=TRUE),
#                     encoder.data="CCA",
#                     supervised='none',
#                     run.encoder=TRUE,
#                     run.decoder=FALSE,
#                     log.dir=file.path('~/models','cca_input'),
#                     device="CPU")

## Plot aligned data in tSNE space, when the data was processed in three different ways:
##   1) either using the original gene inputs,
##   2) after CCA dimensionality reduction for preprocessing.
##   Cells here are colored by input labels

set.seed(5678)
gene_plot = PlotTSNE(scAlignCB,
                     "ALIGNED-GENE",
                     title="scAlign-Gene",
                     perplexity=30)
## Show plot
gene_plot
# cca_plot = PlotTSNE(scAlignCB,
#                     "ALIGNED-CCA",
#                     title="scAlign-CCA",
#                     perplexity=30)
#
# multi_plot_labels = grid.arrange(gene_plot, cca_plot, nrow = 1)

## ------------------------------------------------------------------------
sessionInfo()

