# Code example from 'plotting_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  echo = TRUE,
  message = FALSE,
  warning = FALSE,
  fig.cap = "",
  tidy = TRUE,
  global.device = TRUE
)
options(timeout = 300)

## ----setup, eval = TRUE-------------------------------------------------------
set.seed(42)
library(dominoSignal)
library(patchwork)

## ----load data----------------------------------------------------------------
# BiocFileCache helps with managing files across sessions
bfc <- BiocFileCache::BiocFileCache(ask = FALSE)
data_url <- "https://zenodo.org/records/10951634/files/pbmc_domino_built.rds"
tmp_path <- BiocFileCache::bfcrpath(bfc, data_url)
dom <- readRDS(tmp_path)

## ----corheatmap---------------------------------------------------------------
cor_heatmap(dom, title = "PBMC R-TF Correlations", column_names_gp = grid::gpar(fontsize = 8))

## ----corheatmap-options, fig.show="hold", out.width = "50%"-------------------
cor_heatmap(dom, bool = TRUE, bool_thresh = 0.25)
cor_heatmap(dom, bool = FALSE, mark_connections = TRUE)

## ----corheatmap-subset--------------------------------------------------------
receptors <- c("CSF1R", "CSF3R", "CCR7", "FCER2")
tfs <- c("PAX5", "JUNB", "FOXJ3", "FOSB")
cor_heatmap(dom, feats = tfs, recs = receptors)

## ----corheatmap-ComplexHeatmap-args-------------------------------------------
cor_heatmap(
    dom,
    cluster_rows = FALSE, cluster_columns = FALSE,
    column_title = "Heatmap Without Clustering", column_names_gp = grid::gpar(fontsize = 4)
)

## ----featheatmap--------------------------------------------------------------
feat_heatmap(dom, use_raster = FALSE, row_names_gp = grid::gpar(fontsize = 4))

## ----featheatmap-options, fig.show="hold", out.width = "50%"------------------
feat_heatmap(dom,
    min_thresh = 0.1, max_thresh = 0.6,
    norm = TRUE, bool = FALSE, use_raster = FALSE
)
feat_heatmap(dom, bool = TRUE, use_raster = FALSE)

## ----incoming-----------------------------------------------------------------
incoming_signaling_heatmap(dom, "CD8_T_cell")

## ----incoming-subset----------------------------------------------------------
incoming_signaling_heatmap(dom, "CD8_T_cell", clusts = c("CD14_monocyte", "CD16_monocyte"))

## ----signaling----------------------------------------------------------------
signaling_heatmap(dom)

## ----signaling-norm, fig.show="hold", out.width = "50%"-----------------------
signaling_heatmap(dom, scale = "sqrt")
signaling_heatmap(dom, normalize = "rec_norm")

## ----genenetwork--------------------------------------------------------------
gene_network(dom, clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte")

## ----genenetwork-options------------------------------------------------------
gene_network(dom,
    clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte",
    lig_scale = 25, layout = "sphere"
)

## ----genenetwork-cols---------------------------------------------------------
gene_network(dom,
    clust = "CD16_monocyte", OutgoingSignalingClust = "CD14_monocyte",
    cols = c("CD1D" = "violet", "LILRB2" = "violet", "FOSB" = "violet"), lig_scale = 10
)

## ----signalingnet-------------------------------------------------------------
signaling_network(dom)

## ----signalingnet-clusts------------------------------------------------------
signaling_network(dom,
    showOutgoingSignalingClusts = "CD14_monocyte", scale = "none",
    norm = "none", layout = "fr", scale_by = "none", edge_weight = 2, vert_scale = 10
)

## ----circos, fig.asp = 0.6, out.width = "90%"---------------------------------
circos_ligand_receptor(dom, receptor = "CD74")

## ----circos-opt, fig.asp = 0.6, out.width = "90%"-----------------------------
cols <- c(
    "red", "orange", "green", "blue", "pink", "purple",
    "slategrey", "firebrick", "hotpink"
)
names(cols) <- dom_clusters(dom, labels = FALSE)
circos_ligand_receptor(dom, receptor = "CD74", cell_colors = cols)

## ----corscatter---------------------------------------------------------------
cor_scatter(dom, "FOSB", "CD74")

## -----------------------------------------------------------------------------
Sys.Date()
sessionInfo()

