# Code example from 'sketching_workflows' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = TRUE,
  crop = NULL
)
library(BiocStyle)

## ----load-pkg-----------------------------------------------------------------
suppressPackageStartupMessages({
    library(sketchR)
    library(TENxPBMCData)
    library(scuttle)
    library(scran)
    library(scater)
    library(SingleR)
    library(celldex)
    library(cowplot)
    library(SummarizedExperiment)
    library(SingleCellExperiment)
    library(beachmat.hdf5)
    library(snifter)
    library(uwot)
    library(bluster)
    library(class)
})

## ----process-data-------------------------------------------------------------
# load data
pbmc3k <- TENxPBMCData(dataset = "pbmc3k")

# set row and column names
colnames(pbmc3k) <- paste0("Cell", seq_len(ncol(pbmc3k)))
rownames(pbmc3k) <- uniquifyFeatureNames(
    ID = rowData(pbmc3k)$ENSEMBL_ID,
    names = rowData(pbmc3k)$Symbol_TENx
)

# normalize and log-transform counts
pbmc3k <- logNormCounts(pbmc3k)

# find highly variable genes
dec <- modelGeneVar(pbmc3k)
top_hvgs <- getTopHVGs(dec, n = 2000)

# perform dimensionality reduction
set.seed(100)
pbmc3k <- runPCA(pbmc3k, subset_row = top_hvgs)
reducedDim(pbmc3k, "TSNE") <- fitsne(
    reducedDim(pbmc3k, "PCA"), 
    n_jobs = 2L, random_state = 123L,
    perplexity = 30, n_components = 2L, 
    pca = FALSE)
reducedDim(pbmc3k, "UMAP") <- umap(
    X = reducedDim(pbmc3k, "PCA"), 
    n_components = 2, n_neighbors = 50,
    pca = NULL, scale = FALSE, 
    ret_model = TRUE, n_threads = 2L)$embedding

# predict cell type labels
ref_monaco <- MonacoImmuneData()
pred_monaco_main <- SingleR(test = pbmc3k, ref = ref_monaco, 
                            labels = ref_monaco$label.main)
pbmc3k$labels_main <- pred_monaco_main$labels

## ----sketch-------------------------------------------------------------------
idx800gs <- geosketch(reducedDim(pbmc3k, "PCA"), 
                      N = 800, seed = 123)
pbmc3k$sketched <- seq_len(ncol(pbmc3k)) %in% idx800gs
table(pbmc3k$sketched)

## ----hvgs---------------------------------------------------------------------
## Find highly variable genes
dec_sketched <- modelGeneVar(pbmc3k[, pbmc3k$sketched])
top_hvgs_sketched <- getTopHVGs(dec_sketched, n = 2000)

## ----pca----------------------------------------------------------------------
set.seed(123)

# don't scale features before PCA
doscale <- FALSE

# subset to sketched cells and run PCA, using the HVGs from the sketched subset
pbmc3k_sketched <- pbmc3k[, pbmc3k$sketched]
pca <- calculatePCA(pbmc3k_sketched, ncomponents = 30, 
                    subset_row = top_hvgs_sketched, 
                    scale = doscale)

# store the PCA projection for the sketched cells as well as the weights for 
# the HVGs and the mean value for each HVG across the sketched cells
projection <- pca
rotation <- attr(pca, "rotation")
centers <- rowMeans(assay(pbmc3k_sketched[top_hvgs_sketched, ],
                          "logcounts"))

# center the full data set using the mean values from the sketched subset and 
# project all cells onto the extracted principal components
# note that if doscale = TRUE, we also need to calculate the standard 
# deviations across the sketched cells and use them here
pca <- scale(t(assay(pbmc3k[names(centers), ], "logcounts")), center = centers, 
             scale = doscale) %*% rotation

# add the PCA coordinates to pbmc3k
stopifnot(all(rownames(pca) == colnames(pbmc3k)))
reducedDim(pbmc3k, "PCA_sketch") <- as.matrix(pca)

# check that the "re-projections" of the sketched cells are the same as the 
# original coordinates obtained from applying PCA to the sketched cells
# ... via correlations
vapply(seq_len(ncol(projection)), function(i) {
    cor(projection[, i],
        reducedDim(pbmc3k, "PCA_sketch")[rownames(projection), i]
    )
}, NA_real_)

# ... via plotting
plot_grid(plotlist = lapply(seq_len(ncol(projection))[1:2], function(i) {
    ggplot(data.frame(
        Original = projection[, i],
        Reprojected = reducedDim(pbmc3k, "PCA_sketch")[pbmc3k$sketched, i]),
        aes(x = Original, y = Reprojected)) + 
        geom_point() +
        labs(title = paste0("PCA dimension ", i)) + 
        theme_bw()
}))

## ----plot-pca-----------------------------------------------------------------
plot_grid(plotlist = list(
    plotReducedDim(pbmc3k, dimred = "PCA", colour_by = "labels_main", 
                   ncomponents = c(1, 2)) + 
        ggtitle("PCA"),
    plotReducedDim(pbmc3k, dimred = "PCA_sketch", colour_by = "labels_main",
                   ncomponents = c(1, 2)) + 
        ggtitle("PCA (sketch)")
))

## ----plot-pca-sketched--------------------------------------------------------
plotReducedDim(pbmc3k, dimred = "PCA_sketch", colour_by = "sketched",
               ncomponents = c(1, 2))

## ----tsne---------------------------------------------------------------------
set.seed(123)

# extract tSNE embedding from sketched cells
tsne <- fitsne(
    reducedDim(pbmc3k[, pbmc3k$sketched], "PCA_sketch"), 
    n_jobs = 2L, random_state = 123L,
    perplexity = 30, n_components = 2L, 
    pca = FALSE)

# project all cells
proj <- project(
    x = tsne, 
    new = reducedDim(pbmc3k, "PCA_sketch"), 
    old = reducedDim(pbmc3k[, pbmc3k$sketched], "PCA_sketch"),
    perplexity = 30, k = 1L)
rownames(proj) <- colnames(pbmc3k)
reducedDim(pbmc3k, "TSNE_sketch") <- proj

# representations of sketched cells are approximately retained
# ... correlations
vapply(seq_len(ncol(tsne)), function(i) {
    cor(tsne[, i],
        reducedDim(pbmc3k, "TSNE_sketch")[pbmc3k$sketched, i]
    )
}, NA_real_)

# ... plotting
plot_grid(plotlist = lapply(seq_len(ncol(tsne)), function(i) {
    ggplot(data.frame(
        Original = tsne[, i],
        Reprojected = reducedDim(pbmc3k, "TSNE_sketch")[pbmc3k$sketched, i]),
        aes(x = Original, y = Reprojected)) + 
        geom_point() +
        labs(title = paste0("tSNE dimension ", i)) + 
        theme_bw()
}))

## ----plot-tsne----------------------------------------------------------------
plot_grid(plotlist = list(
    plotReducedDim(pbmc3k, dimred = "TSNE", colour_by = "labels_main", 
                   ncomponents = c(1, 2)) + 
        ggtitle("t-SNE"),
    plotReducedDim(pbmc3k, dimred = "TSNE_sketch", colour_by = "labels_main",
                   ncomponents = c(1, 2)) + 
        ggtitle("t-SNE (sketch)")
))

## ----plot-tsne-sketched-------------------------------------------------------
plotReducedDim(pbmc3k, dimred = "TSNE_sketch", colour_by = "sketched",
               ncomponents = c(1, 2))

## ----umap---------------------------------------------------------------------
set.seed(123)

# extract UMAP embedding from sketched cells
umap <- umap(
    X = reducedDim(pbmc3k[, pbmc3k$sketched], "PCA_sketch"), 
    n_components = 2, n_neighbors = 50,
    pca = NULL, scale = FALSE, 
    ret_model = TRUE, n_threads = 2L)

# project all cells
proj <- umap_transform(
    X = reducedDim(pbmc3k, "PCA_sketch"), 
    model = umap, 
    n_threads = 2L)
rownames(proj) <- colnames(pbmc3k)
reducedDim(pbmc3k, "UMAP_sketch") <- proj

# representations of sketched cells are approximately retained
# ... correlations
vapply(seq_len(ncol(umap$embedding)), function(i) {
    cor(umap$embedding[, i],
        reducedDim(pbmc3k, "UMAP_sketch")[pbmc3k$sketched, i]
    )
}, NA_real_)

# ... plotting
plot_grid(plotlist = lapply(seq_len(ncol(umap$embedding)), function(i) {
    ggplot(data.frame(
        Original = umap$embedding[, i],
        Reprojected = reducedDim(pbmc3k, "UMAP_sketch")[pbmc3k$sketched, i]),
        aes(x = Original, y = Reprojected)) + 
        geom_point() +
        labs(title = paste0("UMAP dimension ", i)) + 
        theme_bw()
}))

## ----plot-umap----------------------------------------------------------------
plot_grid(plotlist = list(
    plotReducedDim(pbmc3k, dimred = "UMAP", colour_by = "labels_main", 
                   ncomponents = c(1, 2)) + 
        ggtitle("UMAP"),
    plotReducedDim(pbmc3k, dimred = "UMAP_sketch", colour_by = "labels_main",
                   ncomponents = c(1, 2)) + 
        ggtitle("UMAP (sketch)")
))

## ----plot-umap-sketched-------------------------------------------------------
plotReducedDim(pbmc3k, dimred = "UMAP_sketch", colour_by = "sketched",
               ncomponents = c(1, 2))

## ----clustering---------------------------------------------------------------
# subset to only the sketched cells
# note that since the PCA_sketch embedding was obtained by applying PCA to the 
# sketched cells only, subsetting like this is equivalent to applying PCA 
# again to the sketched cells only (see above for an illustration)
pca_sketch <- reducedDim(pbmc3k[, pbmc3k$sketched], "PCA_sketch")

set.seed(123)

# run clustering on the sketched cells
clst <- as.character(clusterRows(
    pca_sketch,  
    BLUSPARAM = SNNGraphParam(
        k = 10, type = "rank", 
        num.threads = 2L, 
        cluster.fun = "leiden", 
        cluster.args = list(resolution = 0.15))))

# predict labels of all cells using 1-nearest neighbors and add cluster labels
# to pbmc3k
preds <- knn(train = pca_sketch, 
             test = reducedDim(pbmc3k, "PCA_sketch"), 
             cl = clst, k = 1) |> as.character()
pbmc3k$clusters <- preds

# check that labels are retained for sketched cells
all(clst == pbmc3k$clusters[pbmc3k$sketched])

## ----session-info-------------------------------------------------------------
sessionInfo()

