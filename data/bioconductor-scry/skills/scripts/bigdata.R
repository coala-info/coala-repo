# Code example from 'bigdata' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(TENxPBMCData))
require(scry)

## -----------------------------------------------------------------------------
sce<-TENxPBMCData(dataset="pbmc3k")
h5counts<-counts(sce)
seed(h5counts) #print information about object
h5counts<-h5counts[rowSums(h5counts)>0,]
system.time(h5devs<-devianceFeatureSelection(h5counts)) # 26 sec

## -----------------------------------------------------------------------------
denseCounts<-as.matrix(h5counts)
system.time(denseDevs<-devianceFeatureSelection(denseCounts)) # 5 sec
max(abs(denseDevs-h5devs)) #should be close to zero

## -----------------------------------------------------------------------------
mean(denseCounts>0) #shows that the data are mostly zeros so sparsity useful
sparseCounts<-Matrix::Matrix(denseCounts,sparse=TRUE)
system.time(sparseDevs<-devianceFeatureSelection(sparseCounts)) #1.6 sec
max(abs(sparseDevs-h5devs)) #should be close to zero

## ----eval=FALSE---------------------------------------------------------------
# sce <- nullResiduals(sce, assay="counts", type="deviance")
# str(sce)

