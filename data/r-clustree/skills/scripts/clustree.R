# Code example from 'clustree' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----load-nba-----------------------------------------------------------------
library(clustree)
data("nba_clusts")

head(nba_clusts)

## ----nba-plot-----------------------------------------------------------------
clustree(nba_clusts, prefix = "K")

## ----nba-aes-static-----------------------------------------------------------
clustree(nba_clusts, prefix = "K", node_colour = "purple", node_size = 10,
         node_alpha = 0.8)

## ----nba-aes------------------------------------------------------------------
clustree(nba_clusts, prefix = "K", node_colour = "ReboundPct",
         node_colour_aggr = "mean")

## ----nba-stability------------------------------------------------------------
clustree(nba_clusts, prefix = "K", node_colour = "sc3_stability")

## ----nba-layout---------------------------------------------------------------
clustree(nba_clusts, prefix = "K", layout = "sugiyama")

## ----nba-layout-nocore--------------------------------------------------------
clustree(nba_clusts, prefix = "K", layout = "sugiyama", use_core_edges = FALSE)

## ----nba-labels---------------------------------------------------------------
clustree(nba_clusts, prefix = "K", node_label = "AssistPct",
         node_label_aggr = "max")

## ----nba-labels-custom--------------------------------------------------------
label_position <- function(labels) {
    if (length(unique(labels)) == 1) {
        position <- as.character(unique(labels))
    } else {
        position <- "mixed"
    }
    return(position)
}

clustree(nba_clusts, prefix = "K", node_label = "Position",
         node_label_aggr = "label_position")

## ----sc-example---------------------------------------------------------------
data("sc_example")
names(sc_example)

## ----sce-present, echo = FALSE------------------------------------------------
sce_present <- requireNamespace("SingleCellExperiment", quietly = TRUE)

## ----sce-not, echo = FALSE, results = "asis", eval = !sce_present-------------
#  cat("> **NOTE:** This section requires the SingleCellExperiment package.",
#      "This package isn't installed so the results won't be shown.")

## ----sce, eval = sce_present--------------------------------------------------
suppressPackageStartupMessages(library("SingleCellExperiment"))

sce <- SingleCellExperiment(assays = list(counts = sc_example$counts,
                                          logcounts = sc_example$logcounts),
                            colData = sc_example$sc3_clusters,
                            reducedDims = SimpleList(TSNE = sc_example$tsne))

## ----sce-colData, eval = sce_present------------------------------------------
head(colData(sce))

## ----sce-plot, eval = sce_present---------------------------------------------
clustree(sce, prefix = "sc3_", suffix = "_clusters")

## ----seurat-present, echo = FALSE---------------------------------------------
seurat_present <- requireNamespace("Seurat", quietly = TRUE) &&
    packageVersion("Seurat") >= package_version(x = "5.0.0")

## ----seurat-not, echo = FALSE, results = 'asis', eval = !seurat_present-------
#  cat("> **NOTE:** This section requires the Seurat package (>= 5.0.0).",
#      "This package isn't installed so the results won't be shown.")

## ----seurat, eval = seurat_present--------------------------------------------
suppressPackageStartupMessages(library("Seurat"))

# Create the Seurat object, Seurat >= expects a sparse matrix
seurat <- CreateSeuratObject(counts = as(sc_example$counts, "sparseMatrix"),
                             data = as(sc_example$logcounts, "sparseMatrix"),
                             meta.data = sc_example$seurat_clusters)

# Add the t-SNE embedding
seurat[['TSNE']] <- CreateDimReducObject(embeddings = sc_example$tsne,
                                         key = "tSNE_")

## ----seurat-meta, eval = seurat_present---------------------------------------
head(seurat[[]])

## ----seurat-plot, eval = seurat_present---------------------------------------
clustree(seurat, prefix = "res.")

## ----plot-gene, eval = seurat_present-----------------------------------------
clustree(seurat, prefix = "res.",
         node_colour = "Gene730", node_colour_aggr = "median")

## ----nba-overlay--------------------------------------------------------------
clustree_overlay(nba_clusts, prefix = "K", x_value = "PC1", y_value = "PC2")

## ----nba-overlay-colour-------------------------------------------------------
clustree_overlay(nba_clusts, prefix = "K", x_value = "PC1", y_value = "PC2",
                 use_colour = "points", alt_colour = "blue")

## ----nba-overlay-labels-------------------------------------------------------
clustree_overlay(nba_clusts, prefix = "K", x_value = "PC1", y_value = "PC2",
                 label_nodes = TRUE)

## ----nba-overlay-sides--------------------------------------------------------
overlay_list <- clustree_overlay(nba_clusts, prefix = "K", x_value = "PC1",
                                 y_value = "PC2", plot_sides = TRUE)

names(overlay_list)

overlay_list$x_side
overlay_list$y_side

## ----modify-------------------------------------------------------------------
clustree(nba_clusts, prefix = "K") +
    scale_color_brewer(palette = "Set1") +
    scale_edge_color_continuous(low = "blue", high = "red")

## ----legends------------------------------------------------------------------
clustree(nba_clusts, prefix = "K") +
    guides(edge_colour = FALSE, edge_alpha = FALSE) +
    theme(legend.position = "bottom")

## ----citation-----------------------------------------------------------------
citation("clustree")

