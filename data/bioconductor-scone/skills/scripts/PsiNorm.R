# Code example from 'PsiNorm' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----message=FALSE, warning=FALSE---------------------------------------------
library(SingleCellExperiment)
library(splatter)
library(scater)
library(cluster)
library(scone)

## -----------------------------------------------------------------------------
set.seed(1234)
params <- newSplatParams()
N=2000
sce <- splatSimulateGroups(params, batchCells=N, lib.loc=12,
                           group.prob = rep(0.25,4),
                           de.prob = 0.2, de.facLoc = 0.06,
                           verbose = FALSE) 

## -----------------------------------------------------------------------------
set.seed(1234)
assay(sce, "lograwcounts") <- log1p(counts(sce))
sce <- runPCA(sce, exprs_values="lograwcounts", scale=TRUE, ncomponents = 2)
plotPCA(sce, colour_by="Group")

## -----------------------------------------------------------------------------
sce<-PsiNorm(sce)
sce<-logNormCounts(sce)
head(sizeFactors(sce))

## -----------------------------------------------------------------------------
set.seed(1234)
sce<-runPCA(sce, exprs_values="logcounts", scale=TRUE, name = "PsiNorm_PCA",
            ncomponents = 2)
plotReducedDim(sce, dimred = "PsiNorm_PCA", colour_by = "Group")

## -----------------------------------------------------------------------------
groups<-cluster::clara(reducedDim(sce, "PCA"), k=nlevels(sce$Group))
a<-paste("ARI from raw counts:", 
         round(mclust::adjustedRandIndex(groups$clustering, sce$Group), 
               digits = 3))

groups<-cluster::clara(reducedDim(sce, "PsiNorm_PCA"), k=nlevels(sce$Group))
b<-paste("ARI from PsiNorm normalized data:",
         round(mclust::adjustedRandIndex(groups$clustering, sce$Group), 
               digits = 3))

kableExtra::kable(rbind(a,b), row.names = FALSE)

## -----------------------------------------------------------------------------
dist<-daisy(reducedDim(sce, "PCA"))
dist<-as.matrix(dist)
a<-paste("Silhouette from raw counts:", round(summary(
    silhouette(x=as.numeric(as.factor(sce$Group)),
               dmatrix = dist))$avg.width, digits = 3))

dist<-daisy(reducedDim(sce, "PsiNorm_PCA"))
dist<-as.matrix(dist)
b<-paste("Silhouette from PsiNorm normalized data:", round(summary(
    silhouette(x=as.numeric(as.factor(sce$Group)),
               dmatrix = dist))$avg.width, digits = 3))
kableExtra::kable(rbind(a,b), row.names = FALSE)

## -----------------------------------------------------------------------------
set.seed(4444)
PCA<-reducedDim(sce, "PCA") 
PCAp<-reducedDim(sce, "PsiNorm_PCA")
depth<-apply(counts(sce), 2, sum)
a<-paste("The Correlation with the raw data is:",
            round(abs(max(cor(PCA[,1], depth), cor(PCA[,2], depth))), digits=3))
b<-paste("The Correlation with the PsiNorm normalized data is:",
            round(abs(max(cor(PCAp[,1], depth), cor(PCAp[,2], depth))), digits = 3))
kableExtra::kable(rbind(a,b), row.names = FALSE)

## ----seurat, eval=FALSE-------------------------------------------------------
# library(Seurat)
# sce <- PsiNorm(sce)
# sce <- logNormCounts(sce)
# seu <- as.Seurat(sce)

## ----pbmc, message=FALSE, warning=FALSE---------------------------------------
library(TENxPBMCData)

sce <- TENxPBMCData("pbmc4k")
sce

## ----seed---------------------------------------------------------------------
counts(sce)
seed(counts(sce))

## ----psinorm-hdf5-------------------------------------------------------------
sce<-PsiNorm(sce)
sce<-logNormCounts(sce)
sce

## ----check-seed---------------------------------------------------------------
seed(logcounts(sce))

## -----------------------------------------------------------------------------
sessionInfo()

