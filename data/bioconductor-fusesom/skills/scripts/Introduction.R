# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----knitr-options, echo=FALSE, message=FALSE, warning=FALSE------------------
library(knitr)
opts_chunk$set(fig.align = 'center', fig.width = 6, fig.height = 5, dev = 'png')

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("FuseSOM")

## ----message=FALSE, warning=FALSE---------------------------------------------
# load FuseSOM
library(FuseSOM)


## -----------------------------------------------------------------------------
# load in the data
data("risom_dat")

# define the markers of interest
risomMarkers <- c('CD45','SMA','CK7','CK5','VIM','CD31','PanKRT','ECAD',
                   'Tryptase','MPO','CD20','CD3','CD8','CD4','CD14','CD68','FAP',
                   'CD36','CD11c','HLADRDPDQ','P63','CD44')

# we will be using the manual_gating_phenotype as the true cell type to gauge 
# performance
names(risom_dat)[names(risom_dat) == 'manual_gating_phenotype'] <- 'CellType'


## -----------------------------------------------------------------------------
risomRes <- runFuseSOM(data = risom_dat, markers = risomMarkers, 
                        numClusters = 23)

## -----------------------------------------------------------------------------
# get the distribution of the clusters
table(risomRes$clusters)/sum(table(risomRes$clusters))


## -----------------------------------------------------------------------------
risomHeat <- FuseSOM::markerHeatmap(data = risom_dat, markers = risomMarkers,
                            clusters = risomRes$clusters, clusterMarkers = TRUE)

## -----------------------------------------------------------------------------
# lets estimate the number of clusters using all the methods
# original clustering has 23 clusters so we will set kseq from 2:25
# we pass it the som model generated in the previous step
risomKest <- estimateNumCluster(data = risomRes$model, kSeq = 2:25, 
                                  method = c("Discriminant", "Distance"))


## -----------------------------------------------------------------------------
# what is the best number of clusters determined by the discriminant method?
# optimal number of clusters according to the discriminant method is 7
risomKest$Discriminant 

# we can plot the results using the optiplot function
pSlope <- optiPlot(risomKest, method = 'slope')
pSlope
pJump <- optiPlot(risomKest, method = 'jump')
pJump
pWcd <- optiPlot(risomKest, method = 'wcd')
pWcd
pGap <- optiPlot(risomKest, method = 'gap')
pGap
pSil <- optiPlot(risomKest, method = 'silhouette')
pSil


## ----message=FALSE, warning=FALSE---------------------------------------------
library(SingleCellExperiment)

# create a singelcellexperiment object
colDat <- risom_dat[, setdiff(colnames(risom_dat), risomMarkers)]
sce <- SingleCellExperiment(assays = list(counts = t(risom_dat)),
                                 colData = colDat)

sce

## -----------------------------------------------------------------------------
risomRessce <- runFuseSOM(sce, markers = risomMarkers, assay = 'counts', 
                      numClusters = 23, verbose = FALSE)

colnames(colData(risomRessce))
names(metadata(risomRessce))

## -----------------------------------------------------------------------------
data <- risom_dat[, risomMarkers] # get the original data used
clusters <- colData(risomRessce)$clusters # extract the clusters from the sce object
# generate the heatmap
risomHeatsce <- markerHeatmap(data = risom_dat, markers = risomMarkers,
                            clusters = clusters, clusterMarkers = TRUE)

## -----------------------------------------------------------------------------
# lets estimate the number of clusters using all the methods
# original clustering has 23 clusters so we will set kseq from 2:25
# now we pass it a singlecellexperiment object instead of the som model as before
# this will return a singelcellexperiment object where the metatdata contains the
# cluster estimation information
risomRessce <- estimateNumCluster(data = risomRessce, kSeq = 2:25, 
                                  method = c("Discriminant", "Distance"))

names(metadata(risomRessce))

## -----------------------------------------------------------------------------
# what is the best number of clusters determined by the discriminant method?
# optimal number of clusters according to the discriminant method is 8
metadata(risomRessce)$clusterEstimation$Discriminant 

# we can plot the results using the optiplot function
pSlope <- optiPlot(risomRessce, method = 'slope')
pSlope
pJump <- optiPlot(risomRessce, method = 'jump')
pJump
pWcd <- optiPlot(risomRessce, method = 'wcd')
pWcd
pGap <- optiPlot(risomRessce, method = 'gap')
pGap
pSil <- optiPlot(risomRessce, method = 'silhouette')
pSil


## -----------------------------------------------------------------------------
sessionInfo()

