# Code example from 'GloScopeTutorial' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----install_bioc, eval=FALSE-------------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("GloScope")

## ----load-libs, message = FALSE,  warning = FALSE-----------------------------
library(GloScope)
data("example_SCE")

## -----------------------------------------------------------------------------
head(SingleCellExperiment::reducedDim(example_SCE,"PCA")[,1:10])
head(SingleCellExperiment::colData(example_SCE))

## -----------------------------------------------------------------------------
table(SingleCellExperiment::colData(example_SCE)$sample_id, SingleCellExperiment::colData(example_SCE)$phenotype)

## ----eval = F-----------------------------------------------------------------
# embedding_df <- seurat_object@reductions$pca@cell.embeddings
# sample_ids <- seurat_object@meta.data$sample_id

## -----------------------------------------------------------------------------
embedding_matrix <- SingleCellExperiment::reducedDim(example_SCE,"PCA")[,1:10]
sample_ids <- SingleCellExperiment::colData(example_SCE)$sample_id

## ----eval=FALSE---------------------------------------------------------------
# # Can take a couple of minutes to run:
# gmm_divergence <- gloscope(embedding_matrix, sample_ids)

## -----------------------------------------------------------------------------
knn_divergence <- gloscope(embedding_matrix, sample_ids, dens="KNN")
knn_divergence[1:5,1:5]

## ----eval=FALSE---------------------------------------------------------------
# # Can take a couple of minutes to run:
# gmm_divergence_alt<-gloscope(embedding_matrix, sample_ids, dens = "GMM",  num_components = c(2,4,6),r=20000)

## -----------------------------------------------------------------------------
knn_divergence_alt <- gloscope(embedding_matrix, sample_ids, 
    dens = "KNN", k = 25)

## -----------------------------------------------------------------------------
pat_info <- as.data.frame(unique(SingleCellExperiment::colData(example_SCE)[,-c(3)]))
head(pat_info)

## -----------------------------------------------------------------------------
mds_result <- plotMDS(dist_mat = knn_divergence, metadata = pat_info, "sample_id",color_by="phenotype", k = 2)
mds_result$plot

## -----------------------------------------------------------------------------
heatmap(knn_divergence)

## -----------------------------------------------------------------------------
plotHeatmap(knn_divergence, metadata = pat_info, "sample_id",color_by="phenotype")

## -----------------------------------------------------------------------------
permResults <- getMetrics(dist_mat = knn_divergence, metadata = pat_info, sample_id="sample_id", group_vars="phenotype", permuteTest = TRUE)
permResults

## -----------------------------------------------------------------------------
bootCIResults <- bootCI(dist_mat = list("KNN k=50"=knn_divergence, "KNN k=25"=knn_divergence_alt), metadata = pat_info, metrics=c("anosim","silhouette"), sample_id="sample_id", group_vars="phenotype")
bootCIResults

## -----------------------------------------------------------------------------
ppg<-plotCI(bootCIResults,color_by="distance",group_by="metric")
ppg

## ----eval = FALSE-------------------------------------------------------------
# gmm_divergence <- gloscope(embedding_matrix, sample_ids, dens = "GMM", dist_metric = "KL",
#     BPPARAM = BiocParallel::SerialParam(RNGseed = 2))

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

