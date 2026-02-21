# Code example from 'imcRtools' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
knitr::opts_chunk$set(error=FALSE, warning=FALSE, message=FALSE, crop = NULL)
library(BiocStyle)
library(data.table)

## ----library, echo=FALSE------------------------------------------------------
library(imcRtools)

## ----access-spillover-files---------------------------------------------------
path <- system.file("extdata/spillover", package = "imcRtools")

list.files(path, recursive = TRUE)

## ----access-txt-files---------------------------------------------------------
txt_files <- list.files(system.file("extdata/mockData/raw", 
                                    package = "imcRtools"))
txt_files

## ----imcsegmentationpipeline-data---------------------------------------------
path <- system.file("extdata/mockData/cpout", package = "imcRtools")

list.files(path, recursive = TRUE)

## ----steinbock-data-----------------------------------------------------------
path <- system.file("extdata/mockData/steinbock", package = "imcRtools")

list.files(path, recursive = TRUE)

## ----show_cpout_features------------------------------------------------------
path <- system.file("extdata/mockData/cpout", package = "imcRtools")

show_cpout_features(path)

## ----read_cpout---------------------------------------------------------------
cur_path <- system.file("extdata/mockData/cpout", package = "imcRtools")

# Read as SpatialExperiment
(spe <- read_cpout(cur_path, graph_file = "Object_relationships.csv"))

# Read as SingleCellExperiment
(sce <- read_cpout(cur_path, graph_file = "Object_relationships.csv", 
                   return_as = "sce"))

## ----read_steinbock-----------------------------------------------------------
cur_path <- system.file("extdata/mockData/steinbock", package = "imcRtools")

# Read as SpatialExperiment
(spe <- read_steinbock(cur_path))

# Read as SingleCellExperiment
(sce <- read_steinbock(cur_path, return_as = "sce"))

## ----read-txt-1---------------------------------------------------------------
path <- system.file("extdata/mockData/raw", package = "imcRtools")

cur_CytoImageList <- readImagefromTXT(path)
cur_CytoImageList

## ----read-single-metals txt---------------------------------------------------
path <- system.file("extdata/spillover", package = "imcRtools")
sce <- readSCEfromTXT(path) 
sce

## ----read-single-metals tiff--------------------------------------------------
path <- system.file("extdata/spillover_tiff/img", package = "imcRtools")
image_df_path <- system.file("extdata/spillover_tiff/images.csv", package = "imcRtools")
panel_df_path <- system.file("extdata/spillover_tiff/panel.csv", package = "imcRtools")
sce <- readSCEfromTIFF(path, image_df_path, panel_df_path)
sce

## ----plotSpotHeatmap, fig.width=5, fig.height=5-------------------------------
plotSpotHeatmap(sce)

## ----plotSpotHeatmap-2, fig.width=5, fig.height=5-----------------------------
plotSpotHeatmap(sce, log = FALSE, threshold = 200)

## ----pixel-binning, fig.width=5, fig.height=5---------------------------------
sce2 <- binAcrossPixels(sce, bin_size = 5)

plotSpotHeatmap(sce2, log = FALSE, threshold = 200)

## ----assign-pixels------------------------------------------------------------
library(CATALYST)

bc_key <- as.numeric(unique(sce$sample_mass))
assay(sce, "exprs") <- asinh(counts(sce)/5)
sce <- assignPrelim(sce, bc_key = bc_key)
sce <- estCutoffs(sce)
sce <- applyCutoffs(sce)

# Filter out mislabeled pixels
sce <- filterPixels(sce)

table(sce$bc_id, sce$sample_mass)

## ----estimate-spillover-------------------------------------------------------
sce <- computeSpillmat(sce)
metadata(sce)$spillover_matrix

## ----buildSpatialGraph, message=FALSE-----------------------------------------
library(cytomapper)
data("pancreasSCE")

pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "expansion",
                                 threshold = 20)
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "knn",
                                 k = 5)
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "delaunay")

colPairNames(pancreasSCE)

## ----plotSpatial--------------------------------------------------------------
library(ggplot2)
library(ggraph)

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_shape_by = "ImageNb",
            node_size_by = "Area",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            scales = "free")

# Colored by expression and with arrows
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "PIN",
            assay_type = "exprs",
            node_size_fix = 3,
            edge_width_fix = 0.2,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = TRUE,
            arrow = grid::arrow(length = grid::unit(0.1, "inch")),
            end_cap = ggraph::circle(0.05, "cm"),
            scales = "free")

# Subsetting the SingleCellExperiment
plotSpatial(pancreasSCE[,pancreasSCE$Pattern],
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = TRUE) 

## ----aggregateNeigbors--------------------------------------------------------
pancreasSCE <- aggregateNeighbors(pancreasSCE,
                                  colPairName = "knn_interaction_graph",
                                  aggregate_by = "metadata",
                                  count_by = "CellType")
head(pancreasSCE$aggregatedNeighbors)

pancreasSCE <- aggregateNeighbors(pancreasSCE,
                                  colPairName = "knn_interaction_graph",
                                  aggregate_by = "expression",
                                  assay_type =  "exprs")
head(pancreasSCE$mean_aggregatedExpression)

## ----aggregateNeigbors-clustering---------------------------------------------
set.seed(22)
cur_cluster <- kmeans(pancreasSCE$aggregatedNeighbors, centers = 3)
pancreasSCE$clustered_neighbors <- factor(cur_cluster$cluster)

# Visualize CellType and clustered_neighbors
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 4,
            edge_width_fix = 2,
            edge_color_by = "clustered_neighbors",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_brewer(palette = "Set2") +
    scale_edge_color_brewer(palette = "Set1")

# Visualize clustered_neighbors
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "clustered_neighbors",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")+
    scale_color_brewer(palette = "Set1")

## ----detectSpatialContext-----------------------------------------------------
# Generate k-nearest neighbor graph
pancreasSCE <- buildSpatialGraph(pancreasSCE, img_id = "ImageNb",
                                 type = "knn",
                                 name = "knn_spatialcontext_graph",
                                 k = 15)
colPairNames(pancreasSCE)

# Aggregate based on clustered_neighbors
pancreasSCE <- aggregateNeighbors(pancreasSCE, 
                                  colPairName = "knn_spatialcontext_graph",
                                  aggregate_by = "metadata",
                                  count_by = "clustered_neighbors",
                                  name = "aggregatedNeighborhood")

# Detect spatial contexts
pancreasSCE <- detectSpatialContext(pancreasSCE, 
                                    entry = "aggregatedNeighborhood",
                                    threshold = 0.9,
                                    name = "spatial_context")
# Define SC color scheme
col_SC <- setNames(c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#E31A1C", "#FDBF6F"), 
                   sort(unique(pancreasSCE$spatial_context)))

# Visualize spatial contexts on images
plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)

## ----filterSpatialContext-----------------------------------------------------
# Filter spatial contexts
# By number of group entries
pancreasSCE <- filterSpatialContext(pancreasSCE, 
                            entry = "spatial_context",
                            group_by = "ImageNb", 
                            group_threshold = 2,
                            name = "spatial_context_filtered_group")

metadata(pancreasSCE)$filterSpatialContext

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context_filtered_group",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)

# By total number of cells
pancreasSCE <- filterSpatialContext(pancreasSCE, 
                            entry = "spatial_context",
                            group_by = "ImageNb", 
                            cells_threshold = 15,
                            name = "spatial_context_filtered_cells")

metadata(pancreasSCE)$filterSpatialContext

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_context_filtered_cells",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "knn_spatialcontext_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_manual(values = col_SC)

## ----plotSpatialContext-------------------------------------------------------
## Plot spatial context graph 
# Default
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context", 
                   group_by = "ImageNb")

# Colored by name and size by n_cells
plotSpatialContext(pancreasSCE, 
                   entry = "spatial_context",
                   group_by = "ImageNb",
                   node_color_by = "name",
                   node_size_by = "n_cells",
                   node_label_color_by = "name")

# Colored by n_cells and size by n_group                   
plotSpatialContext(pancreasSCE, 
                   entry = "spatial_context",
                   group_by = "ImageNb",
                   node_color_by = "n_cells",
                   node_size_by = "n_group",
                   node_label_color_by = "n_cells")+
  scale_color_viridis()

## ----plotSpatialContext - return data-----------------------------------------
# Return data
plotSpatialContext(pancreasSCE,
                   entry = "spatial_context", 
                   group_by = "ImageNb",
                   return_data = TRUE)

## ----detectCommunity----------------------------------------------------------
## Detect spatial community 
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE, 
                               colPairName = "expansion_interaction_graph")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")

## Detect spatial community - specify size_threshold
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE, 
                               colPairName = "expansion_interaction_graph", 
                               size_threshold = 20)

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")

## ----detectCommunity-walktrap-------------------------------------------------
## Detect spatial community - walktrap community detection
set.seed(22)
pancreasSCE <- detectCommunity(pancreasSCE, 
                               colPairName = "expansion_interaction_graph", 
                               cluster_fun = "walktrap")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")

## ----detectCommunity-bygroup--------------------------------------------------
## Detect spatial community - specify group_by
pancreasSCE <- detectCommunity(pancreasSCE, 
                               colPairName = "expansion_interaction_graph", 
                               group_by = "CellType", 
                               size_threshold = 10,
                               BPPARAM = BiocParallel::SerialParam(RNGseed = 22)) 

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "spatial_community",
            node_size_fix = 4,
            edge_width_fix = 1,
            draw_edges = TRUE,
            colPairName = "expansion_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free")

## ----findBorderCells----------------------------------------------------------
pancreasSCE <- findBorderCells(pancreasSCE,
                               img_id = "ImageNb",
                               border_dist = 10)

plotSpatial(pancreasSCE[,!pancreasSCE$border_cells],
            img_id = "ImageNb",
            node_color_by = "CellType",
            node_size_fix = 4,
            edge_width_fix = 2,
            edge_color_by = "clustered_neighbors",
            draw_edges = TRUE,
            colPairName = "knn_interaction_graph",
            directed = FALSE,
            nodes_first = FALSE,
            scales = "free") +
    scale_color_brewer(palette = "Set2") +
    scale_edge_color_brewer(palette = "Set1")

## ----patchDetection-----------------------------------------------------------
pancreasSCE <- patchDetection(pancreasSCE, 
                              patch_cells = pancreasSCE$CellType == "celltype_B",
                              colPairName = "expansion_interaction_graph",
                              expand_by = 20, 
                              img_id = "ImageNb")
 
plotSpatial(pancreasSCE, 
            img_id = "ImageNb", 
            node_color_by = "patch_id",
            scales = "free")

## ----patchSize----------------------------------------------------------------
patchSize(pancreasSCE)

## ----distToCells--------------------------------------------------------------
pancreasSCE <- distToCells(pancreasSCE,
                              x_cells = pancreasSCE$CellType == "celltype_B",
                              coords = c("Pos_X","Pos_Y"),
                              statistics = "min",
                              name = "minDist",
                              img_id = "ImageNb")

pancreasSCE <- distToCells(pancreasSCE,
                              x_cells = pancreasSCE$CellType == "celltype_B",
                              coords = c("Pos_X","Pos_Y"),
                              statistics = "mean",
                              name = "meanDist",
                              img_id = "ImageNb")

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "minDist",
            scales = "free") +
    scale_color_viridis()

plotSpatial(pancreasSCE,
            img_id = "ImageNb",
            node_color_by = "meanDist",
            scales = "free") +
    scale_color_viridis()

## ----countInteractions--------------------------------------------------------
out <- countInteractions(pancreasSCE,
                         group_by = "ImageNb",
                         label = "CellType",
                         method = "classic",
                         colPairName = "knn_interaction_graph")
out

## ----testInteractions---------------------------------------------------------
out <- testInteractions(pancreasSCE,
                        group_by = "ImageNb",
                        label = "CellType",
                        method = "classic",
                        colPairName = "knn_interaction_graph",
                        BPPARAM = BiocParallel::SerialParam(RNGseed = 123))
out

## ----plotInteractions---------------------------------------------------------
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")

## ----plotInteractions-filter data---------------------------------------------
library(dplyr)

out <- out %>% as.data.frame() %>% mutate(pair_id = paste(from_label, to_label, sep = "__"),
                                          is_sig = !is.na(sig))
summary_df <- out %>%
  group_by(pair_id) %>%
  summarise(
    sum_sigval = sum(sigval, na.rm = TRUE),
    total_count = sum(is_sig),
    .groups = "drop"
  ) %>%
  mutate(
    fraction_sig = sum_sigval / total_count,
    int_type = case_when(
      fraction_sig > 0.75 ~ "attraction",
      fraction_sig < -0.75 ~ "repulsion",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(int_type))

subset_out <- out %>%
  semi_join(summary_df, by = "pair_id") %>%
  left_join(summary_df %>% select(pair_id, int_type), by = "pair_id")

# Now we can visualise only these filtered edges
plotInteractions(subset_out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")

## ----plotInteractions-edge aesthetics-----------------------------------------
library(ggraph)

edge_color <- setNames(c("blue", "red"),c("attraction", "repulsion"))

plotInteractions(subset_out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 edge_color_by = "int_type",
                 edge_width_by = "ct") +
                 scale_edge_colour_manual(values = edge_color)

## ----plotInteractions-node aesthetics-----------------------------------------
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 node_color_by = "name",
                 node_label_color_by = "name",
                 node_size_by = "n_cells")

# Define custom colors for node and node_label
node_color <- setNames(c("red", "blue", "green"), c("celltype_A", "celltype_B", "celltype_C"))
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 node_color_by = "name",
                 node_label_color_by = "name",
                 node_size_by = "n_cells")+
  scale_color_manual(values = node_color)

## ----plotInteractions-layout--------------------------------------------------
# Default is "circle"
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType")

# Chord diagram layout
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 graph_layout = "chord")

# Linear layout
plotInteractions(out,
                 pancreasSCE,
                 group_by = "ImageNb",
                 label = "CellType",
                 graph_layout = "linear")

## ----plotInteractions-return data---------------------------------------------
# return data
plotInteractions(out, pancreasSCE, "CellType", "ImageNb",
                return_data = TRUE)

## ----run-cozi-----------------------------------------------------------------
out <- testInteractions(pancreasSCE,
                        group_by = "ImageNb",
                        label = "CellType",
                        method = "conditional",
                        colPairName = "knn_interaction_graph",
                        BPPARAM = BiocParallel::SerialParam(RNGseed = 123))

## -----------------------------------------------------------------------------
cd <- as.data.table(colData(pancreasSCE))

cond_ratio_df <- as.data.table(colPair(pancreasSCE, "knn_interaction_graph"))[
  , .(from_label = cd$CellType[from],
      to_label   = cd$CellType[to],
      group_by   = cd$ImageNb[from],
      from)
][, .(N = uniqueN(from)), by = .(group_by, from_label, to_label)
][cd[, .(total_from_type = .N), by = .(group_by = ImageNb, from_label = CellType)], 
  on = .(group_by, from_label)
][, .(group_by, from_label, to_label, cond_ratio = N / total_from_type)]

out_cr <- merge(
  as.data.table(out)[, `:=`(
    group_by   = as.integer(group_by),
    from_label = as.character(from_label),
    to_label   = as.character(to_label)
  )],
  cond_ratio_df,
  by = c("group_by", "from_label", "to_label"),
  all.x = TRUE
)

## -----------------------------------------------------------------------------
library(RColorBrewer)

p <- out_cr %>%
  filter(!is.na(zscore), !is.na(cond_ratio), sig) %>%
  ggplot(aes(from_label, to_label, size = cond_ratio, color = zscore)) +
  geom_point() +
  theme_bw() +
  scale_size(range = c(1,10)) +
  scale_color_gradient2(low = brewer.pal(11,"RdBu")[10], mid = "white", high = brewer.pal(11,"RdBu")[2], midpoint = 0) +
  facet_wrap(~group_by)

p

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

