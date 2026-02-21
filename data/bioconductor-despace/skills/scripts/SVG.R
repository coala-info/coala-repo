# Code example from 'SVG' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE,
                        dev="png", python.reticulate = FALSE,
                        message=TRUE, error=FALSE, warning=TRUE)
library(utils)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("DESpace")
# 
# ## Check that you have a valid Bioconductor installation
# BiocManager::valid()

## ----vignettes, eval=FALSE----------------------------------------------------
# browseVignettes("DESpace")

## ----citation, eval=FALSE-----------------------------------------------------
# citation("DESpace")

## ----package------------------------------------------------------------------
suppressMessages({
    library(DESpace)
    library(ggplot2)
    library(ggforce)
    library(SpatialExperiment)
})

## ----load-example-data, message = FALSE---------------------------------------
# Connect to ExperimentHub
ehub <- ExperimentHub::ExperimentHub()
# Download the full real data (about 2.1 GB in RAM) use:
spe_all <- spatialLIBD::fetch_data(type = "spe", eh = ehub)
# Specify column names of spatial coordinates in colData(spe) 
coordinates <- c("array_row", "array_col")
# Specify column names of spatial clusters in colData(spe) 
cluster_col <- 'layer_guess_reordered'
# Remove spots missing annotations
spe_all <- spe_all[, !is.na(spe_all[[cluster_col]])]
# Create three spe objects, one per sample:
spe1 <- spe_all[, colData(spe_all)$sample_id == '151507']
spe2 <- spe_all[, colData(spe_all)$sample_id == '151669']
spe3 <- spe_all[, colData(spe_all)$sample_id == '151673']
rm(spe_all)
# Select small set of random genes for faster runtime in this example
set.seed(123)
sel_genes <- sample(dim(spe1)[1],2000)
spe1 <- spe1[sel_genes,]
spe2 <- spe2[sel_genes,]
spe3 <- spe3[sel_genes,]
# For covenience, we use “gene names” instead of “gene ids”:
rownames(spe1) <- rowData(spe1)$gene_name
rownames(spe2) <- rowData(spe2)$gene_name
rownames(spe3) <- rowData(spe3)$gene_name

## ----visualize colData--------------------------------------------------------
# We select a subset of columns
keep_col <- c(coordinates,cluster_col,"expr_chrM_ratio","cell_count")
head(colData(spe3)[keep_col])

## ----QC spots-----------------------------------------------------------------
# Sample 1:
# Calculate per-spot QC metrics and store in colData
spe1 <- scuttle::addPerCellQC(spe1,)
# Remove combined set of low-quality spots
spe1 <- spe1[, !(colData(spe1)$sum < 10 |             # library size
                colData(spe1)$detected < 10 |         # number of expressed genes
                colData(spe1)$expr_chrM_ratio > 0.30| # mitochondrial expression ratio
                colData(spe1)$cell_count > 10)]       # number of cells per spot
# Sample 2:
# Calculate per-spot QC metrics and store in colData
spe2 <- scuttle::addPerCellQC(spe2,)
# Remove combined set of low-quality spots
spe2 <- spe2[, !(colData(spe2)$sum < 20 |
                colData(spe2)$detected < 15 |
                colData(spe2)$expr_chrM_ratio > 0.35|
                colData(spe2)$cell_count > 8)]
# Sample 3:
spe3 <- scuttle::addPerCellQC(spe3,)
# Remove combined set of low-quality spots
spe3 <- spe3[, !(colData(spe3)$sum < 25 |
                colData(spe3)$detected < 25 |
                colData(spe3)$expr_chrM_ratio > 0.3|
                colData(spe3)$cell_count > 15)]

## ----QC genes-----------------------------------------------------------------
# For each sample i:
for(i in seq_len(3)){
    spe_i <- eval(parse(text = paste0("spe", i)))
    # Select QC threshold for lowly expressed genes: at least 20 non-zero spots:
    qc_low_gene <- rowSums(assays(spe_i)$counts > 0) >= 20
    # Remove lowly abundant genes
    spe_i <- spe_i[qc_low_gene,]
    assign(paste0("spe", i), spe_i)
    message("Dimension of spe", i, ": ", dim(spe_i)[1], ", ", dim(spe_i)[2])
}

## ----view LIBD layers, fig.width=5,fig.height=6-------------------------------
# View LIBD layers for one sample
CD <- as.data.frame(colData(spe3))
ggplot(CD, 
    aes(x=array_col,y=array_row, 
    color=factor(layer_guess_reordered))) +
    geom_point() + 
    theme_void() + scale_y_reverse() + 
    theme(legend.position="bottom") + 
    labs(color = "", title = paste0("Manually annotated spatial clusters"))

## ----free memory, include=FALSE-----------------------------------------------
# To reduce memory usage, we can remove the ehub object, which typically requires a large amount of memory. If needed, the spe_i object can be removed as well, as neither is needed for SV testing.
rm(ehub)
rm(spe_i)
gc()

## ----stLearn[r multi-sample], eval = FALSE------------------------------------
# stLearn_results <- read.csv("stLearn_clusters.csv", sep = ',',
#                             header = TRUE)
# # Match colData(spe) and stLearn results
# stLearn_results <- stLearn_results[match(rownames(colData(spe3)),
#                                     rownames(stLearn_results)), ]
# colData(spe3)$stLearn_clusters <- stLearn_results$stLearn_pca_kmeans

## ----DESpace------------------------------------------------------------------
set.seed(123)
results <- svg_test(spe = spe3,
                        cluster_col = cluster_col, 
                        verbose = TRUE)

## -----------------------------------------------------------------------------
head(results$gene_results, 3)

## -----------------------------------------------------------------------------
class(results$estimated_y); class(results$glmLrt); class(results$glmFit)

## ----top SVGs expression plot-------------------------------------------------
(feature <- results$gene_results$gene_id[seq_len(3)])
FeaturePlot(spe3, feature, 
            coordinates = coordinates, 
            ncol = 3, title = TRUE)

## ----expression plots all cluster---------------------------------------------
FeaturePlot(spe3, feature, 
            coordinates = coordinates, 
            annotation_cluster = TRUE,
            cluster_col = cluster_col, 
            cluster = 'all', title = TRUE)

## ----individual cluster test--------------------------------------------------
set.seed(123)
cluster_results <- individual_svg(spe3, 
                                    edgeR_y = results$estimated_y,
                                    cluster_col = cluster_col)

## ----visualize results WM-----------------------------------------------------
class(cluster_results)
names(cluster_results)

## ----top results all----------------------------------------------------------
merge_res <- top_results(results$gene_results, cluster_results)
head(merge_res,3)
merge_res <- top_results(results$gene_results, cluster_results, 
                        select = "FDR")
head(merge_res,3)

## ----top results WM-----------------------------------------------------------
# Check top genes for WM
results_WM <- top_results(cluster_results = cluster_results, 
                        cluster = "WM")
head(results_WM, 3)

## ----top results high_low-----------------------------------------------------
results_WM_both <- top_results(cluster_results = cluster_results, 
                                cluster = "WM", 
                                high_low = "both")

## ----show top results high----------------------------------------------------
head(results_WM_both$high_genes, 3)

## ----show top results low-----------------------------------------------------
head(results_WM_both$low_genes, 3)

## ----expression plots high_low------------------------------------------------
# SVGs with higher than average abundance in WM
feature <- rownames(results_WM_both$high_genes)[seq_len(3)]
FeaturePlot(spe3, feature, cluster_col = cluster_col, 
            coordinates = coordinates, cluster = 'WM', 
            legend_cluster = TRUE, annotation_cluster = TRUE, 
            linewidth = 0.6, title = TRUE)

# SVGs with lower than average abundance in WM
feature <- rownames(results_WM_both$low_genes)[seq_len(3)]
FeaturePlot(spe3, feature, cluster_col = cluster_col, 
            coordinates = coordinates, cluster = 'WM', 
            legend_cluster = TRUE, annotation_cluster = TRUE, 
            linewidth = 0.6,title = TRUE)

## ----view LIBD layers [multi]-------------------------------------------------
set.seed(123)
# Use common genes
a <- rownames(counts(spe1)); 
b <- rownames(counts(spe2)); 
c <- rownames(counts(spe3))
# find vector of common genes across all samples:
CommonGene <- Reduce(intersect, list(a,b,c))
spe1 <- spe1[CommonGene,]
spe2 <- spe2[CommonGene,]
spe3 <- spe3[CommonGene,]

# Combine three samples
spe.combined <- cbind(spe1, spe2, spe3, deparse.level = 1)
ggplot(as.data.frame(colData(spe.combined)), 
    aes(x=array_col, y=array_row,
    color=factor(layer_guess_reordered))) +
    geom_point() + 
    facet_wrap(~sample_id) +
    theme_void() + scale_y_reverse() +
    theme(legend.position="bottom") + 
    labs(color = "", title = "Manually annotated spatial clusters")

## ----DESpace [multi]----------------------------------------------------------
set.seed(123)
multi_results <- svg_test(spe = spe.combined,
                                cluster_col = cluster_col,
                                sample_col = 'sample_id',
                                replicates = TRUE)

## -----------------------------------------------------------------------------
head(multi_results$gene_results,3)

## -----------------------------------------------------------------------------
class(multi_results$estimated_y)

## ----top SVGs expression plot [multi]-----------------------------------------
## Top three spatially variable genes
feature <- multi_results$gene_results$gene_id[seq_len(3)]; feature
## Sample names
samples <- unique(colData(spe.combined)$sample_id); samples
## Use purrr::map to combine multiple figures
spot_plots <- purrr::map(seq_along(samples), function(j) {
    ## Subset spe for each sample j
    spe_j <- spe.combined[, colData(spe.combined)$sample_id == samples[j] ]
    ## Store three gene expression plots with gene names in `feature` for spe_j
    spot_plots <- FeaturePlot(spe_j, feature, 
                            coordinates = coordinates,
                            cluster_col = cluster_col, title = TRUE,
                            annotation_cluster = TRUE, legend_cluster = TRUE)
    return(spot_plots)
})
patchwork::wrap_plots(spot_plots, ncol=1)

## ----individual cluster test [multiple-sample]--------------------------------
set.seed(123)
cluster_results <- individual_svg(spe.combined, 
                                edgeR_y = multi_results$estimated_y,
                                replicates = TRUE, 
                                cluster_col = cluster_col)

## -----------------------------------------------------------------------------
class(cluster_results)
names(cluster_results)

## -----------------------------------------------------------------------------
merge_res <- top_results(multi_results$gene_results, cluster_results, 
                        select = "FDR")
head(merge_res,3)

## -----------------------------------------------------------------------------
# Check top genes for WM
results_WM <- top_results(cluster_results = cluster_results, 
                        cluster = "WM")
# For each gene, adjusted p-values for each cluster
head(results_WM,3)

## -----------------------------------------------------------------------------
results_WM_both <- top_results(cluster_results = cluster_results, 
                            cluster = "WM", high_low = "both")

## -----------------------------------------------------------------------------
head(results_WM_both$high_genes,3)

## -----------------------------------------------------------------------------
head(results_WM_both$low_genes,3)

## ----fig.width=10, fig.height=15----------------------------------------------
# SVGs with higher abundance in WM, than in non-WM tissue
feature_high <- rownames(results_WM_both$high_genes)[seq_len(3)]
# SVGs with lower abundance in WM, than in non-WM tissue
feature_low <- rownames(results_WM_both$low_genes)[seq_len(3)]
plot_list_high <- list(); plot_list_low <- list()
## Sample names
samples <- unique(colData(spe.combined)$sample_id)
for(j in seq_along(samples)){
    ## Subset spe for each sample j
    spe_j <- spe.combined[, colData(spe.combined)$sample_id == samples[j]]
    ## Gene expression plots with top highly abundant cluster SVGs for spe_j
    plot_list_high[[j]] <- FeaturePlot(spe_j, feature_high, 
                                coordinates = coordinates,
                                cluster_col = cluster_col, 
                                linewidth = 0.6,
                                cluster = 'WM', annotation_cluster = TRUE,
                                legend_cluster = TRUE, title = TRUE)
    ## Gene expression plots with top lowly abundant cluster SVGs for spe_j
    plot_list_low[[j]] <- FeaturePlot(spe_j, feature_low, 
                                coordinates = coordinates,
                                cluster_col = cluster_col, 
                                linewidth = 0.6,
                                cluster = 'WM', annotation_cluster = TRUE,
                                legend_cluster = TRUE, title = TRUE)
}
# Expression plots for SVGs with higher abundance in WM, than in non-WM tissue
patchwork::wrap_plots(plot_list_high, ncol=1)
# Expression plots for SVGs with lower abundance in WM, than in non-WM tissue
patchwork::wrap_plots(plot_list_low, ncol=1)

## ----DESpace [add batch]------------------------------------------------------
spe.combined$batch_id = ifelse(spe.combined$sample_id == "151507", "batch_1", "batch_2")

table(spe.combined$batch_id, spe.combined$sample_id)

## ----DESpace [batch test], eval = FALSE---------------------------------------
# set.seed(123)
# batch_results <- svg_test(spe = spe.combined,
#                                 cluster_col = cluster_col,
#                                 sample_col = 'batch_id',
#                                 replicates = TRUE)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

