# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("NewWave")

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(
  {library(SingleCellExperiment)
library(splatter)
library(irlba)
library(Rtsne)
library(ggplot2)
library(mclust)
library(NewWave)}
)

## -----------------------------------------------------------------------------
params <- newSplatParams()
N=500
set.seed(1234)
data <- splatSimulateGroups(params,batchCells=c(N/2,N/2),
                           group.prob = rep(0.1,10),
                           de.prob = 0.2,
                           verbose = FALSE) 

## -----------------------------------------------------------------------------
set.seed(12359)
hvg <- rowVars(counts(data))
names(hvg) <- rownames(counts(data))
data <- data[names(sort(hvg,decreasing=TRUE))[1:500],]

## -----------------------------------------------------------------------------
colData(data)

## -----------------------------------------------------------------------------
data$Batch <- as.factor(data$Batch)

## -----------------------------------------------------------------------------
pca <- prcomp_irlba(t(counts(data)),n=10)
plot_data <-data.frame(Rtsne(pca$x)$Y)

## -----------------------------------------------------------------------------
plot_data$batch <- data$Batch
plot_data$group <- data$Group

## -----------------------------------------------------------------------------
ggplot(plot_data, aes(x=X1,y=X2,col=group, shape=batch))+ geom_point()

## -----------------------------------------------------------------------------
res <- newWave(data,X = "~Batch", K=10, verbose = TRUE)

## -----------------------------------------------------------------------------
res2 <- newWave(data,X = "~Batch", K=10, verbose = TRUE, children=2)

## -----------------------------------------------------------------------------
res3 <- newWave(data,X = "~Batch", verbose = TRUE,K=10, children=2,
                n_gene_disp = 100, n_gene_par = 100, n_cell_par = 100)

## -----------------------------------------------------------------------------
res3 <- newWave(data,X = "~Batch", verbose = TRUE,K=10, children=2,
                n_gene_par = 100, n_cell_par = 100, commondispersion = FALSE)

## -----------------------------------------------------------------------------
latent <- reducedDim(res)

tsne_latent <- data.frame(Rtsne(latent)$Y)
tsne_latent$batch <- data$Batch
tsne_latent$group <- data$Group

## -----------------------------------------------------------------------------
ggplot(tsne_latent, aes(x=X1,y=X2,col=group, shape=batch))+ geom_point()

## -----------------------------------------------------------------------------
cluster <- kmeans(latent, 10)

adjustedRandIndex(cluster$cluster, data$Group)

## -----------------------------------------------------------------------------
sessionInfo()

