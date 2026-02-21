# Code example from 'clustifyr' vignette. See references/ for full tutorial.

## ----"knitr options", echo = FALSE, message = FALSE, warning = FALSE----------
knitr::opts_chunk$set(
    message = FALSE,
    warning = FALSE,
    collapse = TRUE,
    fig.align = "center",
    comment = "#>",
    crop = NULL
)

## ----"Installation", eval = FALSE---------------------------------------------
# install.packages("BiocManager")
# 
# BiocManager::install("clustifyr")

## ----"Load data"--------------------------------------------------------------
library(clustifyr)
library(ggplot2)
library(cowplot)

# Matrix of normalized single-cell RNA-seq counts
pbmc_matrix <- clustifyr::pbmc_matrix_small

# meta.data table containing cluster assignments for each cell
# The table that we are using also contains the known cell identities in the "classified" column
pbmc_meta <- clustifyr::pbmc_meta

## ----"Run clustifyr()"--------------------------------------------------------
# Calculate correlation coefficients for each cluster (spearman by default)
vargenes <- pbmc_vargenes[1:500]

res <- clustify(
    input = pbmc_matrix, # matrix of normalized scRNA-seq counts (or SCE/Seurat object)
    metadata = pbmc_meta, # meta.data table containing cell clusters
    cluster_col = "seurat_clusters", # name of column in meta.data containing cell clusters
    ref_mat = cbmc_ref, # matrix of RNA-seq expression data for each cell type
    query_genes = vargenes # list of highly varible genes identified with Seurat
)

# Peek at correlation matrix
res[1:5, 1:5]

# Call cell types
res2 <- cor_to_call(
    cor_mat = res, # matrix correlation coefficients
    cluster_col = "seurat_clusters" # name of column in meta.data containing cell clusters
)
res2[1:5, ]

# Insert into original metadata as "type" column
pbmc_meta2 <- call_to_metadata(
    res = res2, # data.frame of called cell type for each cluster
    metadata = pbmc_meta, # original meta.data table containing cell clusters
    cluster_col = "seurat_clusters" # name of column in meta.data containing cell clusters
)

## ----"Create correlation heatmap", fig.height = 5, fig.width = 7--------------
# Create heatmap of correlation coefficients using clustifyr() output
plot_cor_heatmap(cor_mat = res)

## ----"Overlay corr coefficients on UMAP", fig.height = 3.5, fig.width = 9-----
# Overlay correlation coefficients on UMAPs for the first two cell types
corr_umaps <- plot_cor(
    cor_mat = res, # matrix of correlation coefficients from clustifyr()
    metadata = pbmc_meta, # meta.data table containing UMAP or tSNE data
    data_to_plot = colnames(res)[1:2], # name of cell type(s) to plot correlation coefficients
    cluster_col = "seurat_clusters" # name of column in meta.data containing cell clusters
)

plot_grid(
    plotlist = corr_umaps,
    rel_widths = c(0.47, 0.53)
)

## ----"Label clusters", fig.height = 5.5, fig.width = 12-----------------------
# Label clusters with clustifyr cell identities
clustifyr_types <- plot_best_call(
    cor_mat = res, # matrix of correlation coefficients from clustifyr()
    metadata = pbmc_meta, # meta.data table containing UMAP or tSNE data
    do_label = TRUE, # should the feature label be shown on each cluster?
    do_legend = FALSE, # should the legend be shown?
    do_repel = FALSE, # use ggrepel to avoid overlapping labels
    cluster_col = "seurat_clusters"
) +
    ggtitle("clustifyr cell types")

# Compare clustifyr results with known cell identities
known_types <- plot_dims(
    data = pbmc_meta, # meta.data table containing UMAP or tSNE data
    feature = "classified", # name of column in meta.data to color clusters by
    do_label = TRUE, # should the feature label be shown on each cluster?
    do_legend = FALSE, # should the legend be shown?
    do_repel = FALSE
) +
    ggtitle("Known cell types")

plot_grid(known_types, clustifyr_types)

## ----"clustifyr with gene lists", fig.height = 4, fig.width = 6---------------
# Take a peek at marker gene table
cbmc_m

# Available metrics include: "hyper", "jaccard", "spearman", "gsea"
list_res <- clustify_lists(
    input = pbmc_matrix, # matrix of normalized single-cell RNA-seq counts
    metadata = pbmc_meta, # meta.data table containing cell clusters
    cluster_col = "seurat_clusters", # name of column in meta.data containing cell clusters
    marker = cbmc_m, # list of known marker genes
    metric = "pct" # test to use for assigning cell types
)

# View as heatmap, or plot_best_call
plot_cor_heatmap(
    cor_mat = list_res, # matrix of correlation coefficients from clustify_lists()
    cluster_rows = FALSE, # cluster by row?
    cluster_columns = FALSE, # cluster by column?
    legend_title = "% expressed" # title of heatmap legend
)

# Downstream functions same as clustify()
# Call cell types
list_res2 <- cor_to_call(
    cor_mat = list_res, # matrix correlation coefficients
    cluster_col = "seurat_clusters" # name of column in meta.data containing cell clusters
)

# Insert into original metadata as "list_type" column
pbmc_meta3 <- call_to_metadata(
    res = list_res2, # data.frame of called cell type for each cluster
    metadata = pbmc_meta, # original meta.data table containing cell clusters
    cluster_col = "seurat_clusters", # name of column in meta.data containing cell clusters
    rename_prefix = "list_" # set a prefix for the new column
)

## -----------------------------------------------------------------------------
library(SingleCellExperiment)
sce <- sce_pbmc()
res <- clustify(
    input = sce, # an SCE object
    ref_mat = cbmc_ref, # matrix of RNA-seq expression data for each cell type
    cluster_col = "clusters", # name of column in meta.data containing cell clusters
    obj_out = TRUE # output SCE object with cell type inserted as "type" column
)

colData(res)[1:10, c("type", "r")]

## -----------------------------------------------------------------------------
so <- so_pbmc()
res <- clustify(
    input = so, # a Seurat object
    ref_mat = cbmc_ref, # matrix of RNA-seq expression data for each cell type
    cluster_col = "seurat_clusters", # name of column in meta.data containing cell clusters
    obj_out = TRUE # output Seurat object with cell type inserted as "type" column
)

# type and r are stored in the meta.data
res[[c("type", "r")]][1:10, ]

## ----"average"----------------------------------------------------------------
new_ref_matrix <- average_clusters(
    mat = pbmc_matrix,
    metadata = pbmc_meta$classified, # or use metadata = pbmc_meta, cluster_col = "classified"
    if_log = TRUE # whether the expression matrix is already log transformed
)

head(new_ref_matrix)

# For further convenience, a shortcut function for generating reference matrix from `SingleCellExperiment` or `seurat` object is used.
new_ref_matrix_sce <- object_ref(
    input = sce, # SCE object
    cluster_col = "clusters" # name of column in colData containing cell identities
)

new_ref_matrix_so <- seurat_ref(
    seurat_object = so, # Seurat object
    cluster_col = "seurat_clusters" # name of column in meta.data containing cell identities
)

tail(new_ref_matrix_so)

## -----------------------------------------------------------------------------
sessionInfo()

