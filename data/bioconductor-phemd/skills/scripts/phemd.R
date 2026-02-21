# Code example from 'phemd' vignette. See references/ for full tutorial.

## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo=T, results = 'hide',message=F, warning=F, eval=F-----------------
#  library(devtools)
#  install_github("wschen/phemd")

## ----echo=T, results = 'hide',message=F, warning=F, eval=F-----------------
#  BiocManager::install("phemd")

## ----echo=T, results = 'hide', message=F, warning=F------------------------
library('phemd')
library('monocle')

## ----echo=T, results = 'hide', message=F, warning=F------------------------
load('melanomaData.RData')
myobj <- createDataObj(all_expn_data, all_genes, as.character(snames))

## ----echo=T----------------------------------------------------------------
myobj <- removeTinySamples(myobj, min_sz = 20)

## ----echo=T, results = 'hide'----------------------------------------------
myobj <- aggregateSamples(myobj, max_cells=12000)

## ----echo=T, results = 'hide'----------------------------------------------
myobj <- selectFeatures(myobj, selected_genes)

## ----echo=T, results = 'hide', message=F, warning=F------------------------
# generate 2D cell embedding and cell subtype assignments
myobj <- embedCells(myobj, data_model = 'gaussianff', pseudo_expr=0, sigma=0.02)
# generate pseudotime ordering of cells
myobj <- orderCellsMonocle(myobj)

## ----echo=T, results = 'hide', fig.width=8, fig.height=4-------------------
cmap <- plotEmbeddings(myobj, cell_model='monocle2')

## ----echo=T, results = 'hide', fig.width=8, fig.height=6-------------------
plotHeatmaps(myobj, cell_model='monocle2', selected_genes=heatmap_genes)

## ----echo=T, results = 'hide'----------------------------------------------
# Determine cell subtype breakdown of each sample
myobj <- clusterIndividualSamples(myobj)

## ----echo=T, results = 'hide'----------------------------------------------
# Determine (dis)similarity of different cell subtypes
myobj <- generateGDM(myobj)

## ----echo=T, results = 'hide'----------------------------------------------
# Perform inter-sample comparisons using EMD
my_distmat <- compareSamples(myobj)

## ----echo=T, results = 'hide'----------------------------------------------
## Identify similar groups of inhibitors
group_assignments <- groupSamples(my_distmat, distfun = 'hclust', ncluster=5)

## ----echo=T, results = 'hide', fig.width=8, fig.height=7, fig.keep='none'----
dmap_obj <- plotGroupedSamplesDmap(my_distmat, group_assignments, pt_sz = 1.5)

## ----echo=F, results = 'hide', fig.keep='none'-----------------------------
plotGroupedSamplesDmap(my_distmat, group_assignments, pt_sz = 1.5)

## ----echo=F, results = 'hide', fig.width=8, fig.height=7-------------------
plotGroupedSamplesDmap(my_distmat, group_assignments, pt_sz = 1.5)

## ----echo=T, results = 'hide'----------------------------------------------
# Plot cell subtype distribution (histogram) for each sample
sample.cellfreqs <- getSampleHistsByCluster(myobj, group_assignments, cell_model='monocle2')

## ----echo=T, results = 'hide', fig.width=10, fig.height=2.5----------------
# Plot representative cell subtype distribution for each group of samples
plotSummaryHistograms(myobj, group_assignments, cell_model='monocle2', cmap, 
                      ncol.plot = 5, ax.lab.sz=1.3, title.sz=2)

## ----echo=T, results='hide', fig.width=8, fig.height=5.5-------------------
# Plot cell yield of each experimental condition
plotCellYield(myobj, group_assignments, font_sz = 0.7, w=8, h=5)

## ----echo=T----------------------------------------------------------------
sessionInfo()

