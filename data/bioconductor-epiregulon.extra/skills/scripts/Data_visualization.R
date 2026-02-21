# Code example from 'Data_visualization' vignette. See references/ for full tutorial.

## ----results='hide', message=FALSE, eval=FALSE--------------------------------
#  if (!require("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
# 
#  BiocManager::install("epiregulon.extra")
# 

## -----------------------------------------------------------------------------
# load the MAE object
library(scMultiome)

mae <- scMultiome::reprogramSeq()

# expression matrix
GeneExpressionMatrix <- mae[["GeneExpressionMatrix"]]
rownames(GeneExpressionMatrix) <- rowData(GeneExpressionMatrix)$name

reducedDim(GeneExpressionMatrix, "UMAP_Combined") <- 
  reducedDim(mae[["TileMatrix500"]], "UMAP_Combined")

# arrange hash_assignment
GeneExpressionMatrix$hash_assignment <- factor(as.character(
  GeneExpressionMatrix$hash_assignment),
  levels = c("HTO10_GATA6_UTR", "HTO2_GATA6_v2", "HTO8_NKX2.1_UTR", "HTO3_NKX2.1_v2",
    "HTO1_FOXA2_v2", "HTO4_mFOXA1_v2", "HTO6_hFOXA1_UTR", "HTO5_NeonG_v2"
  )
)

## ----calculateActivity, results = "hide"--------------------------------------
library(epiregulon)
library(epiregulon.extra)

data(regulon)

score.combine <- calculateActivity(
  expMatrix = GeneExpressionMatrix,
  regulon = regulon,
  mode = "weight",
  method = "weightedMean",
  exp_assay = "normalizedCounts",
  normalize = FALSE
)

## ----differential-------------------------------------------------------------
library(epiregulon.extra)
markers <- findDifferentialActivity(
  activity_matrix = score.combine,
  clusters = GeneExpressionMatrix$hash_assignment,
  pval.type = "some",
  direction = "up",
  test.type = "t",
  logvalue = FALSE
)

## -----------------------------------------------------------------------------
markers.sig <- getSigGenes(markers, topgenes = 5)

## ----visualization------------------------------------------------------------
plotBubble(
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2"),
  clusters = GeneExpressionMatrix$hash_assignment
)

## -----------------------------------------------------------------------------
plotBubble(
  activity_matrix = score.combine,
  tf = markers.sig$tf,
  clusters = GeneExpressionMatrix$hash_assignment
)

## -----------------------------------------------------------------------------
plotActivityViolin(
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  clusters = GeneExpressionMatrix$hash_assignment
)

## ----fig.height = 6, fig.width = 9--------------------------------------------

options(ggrastr.default.dpi=100)

ActivityPlot <- plotActivityDim(
  sce = GeneExpressionMatrix,
  activity_matrix = score.combine,
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  dimtype = "UMAP_Combined",
  label = "Clusters",
  point_size = 0.3,
  ncol = 3,
  rasterise = TRUE
)


ActivityPlot

## ----fig.height = 6, fig.width = 9--------------------------------------------

options(ggrastr.default.dpi=100)

ActivityPlot <- plotActivityDim(
  sce = GeneExpressionMatrix,
  activity_matrix = counts(GeneExpressionMatrix),
  tf = c("NKX2-1", "GATA6", "FOXA1", "FOXA2", "AR"),
  dimtype = "UMAP_Combined",
  label = "Clusters",
  point_size = 0.3,
  ncol = 3,
  limit = c(0, 2),
  colors = c("grey", "blue"),
  legend.label = "GEX",
  rasterise = TRUE
)
ActivityPlot

## ----eval=FALSE---------------------------------------------------------------
# plotHeatmapRegulon(
#   sce = GeneExpressionMatrix,
#   tfs = c("GATA6", "NKX2-1"),
#   regulon = regulon,
#   regulon_cutoff = 0,
#   downsample = 1000,
#   cell_attributes = "hash_assignment",
#   col_gap = "hash_assignment",
#   exprs_values = "normalizedCounts",
#   name = "regulon heatmap",
#   column_title_rot = 45,
#   raster_quality=4
# )
# 
# 
# plotHeatmapActivity(
#   activity = score.combine,
#   sce = GeneExpressionMatrix,
#   tfs = c("GATA6", "NKX2-1", "FOXA1", "FOXA2"),
#   downsample = 5000,
#   cell_attributes = "hash_assignment",
#   col_gap = "hash_assignment",
#   name = "Activity",
#   column_title_rot = 45,
#   raster_quality=3
# )

## ----enrichment, fig.height = 8, fig.width = 14-------------------------------
# retrieve genesets
msigdb.hs = msigdb::getMsigdb(org = 'hs', id = 'SYM', version = '7.4')
msigdb.hs <- msigdb.hs[unlist(lapply(msigdb.hs, function(x) {GSEABase::bcCategory(GSEABase::collectionType(x)) %in% c("c6", "h")}))]

# convert genesets to be compatible with enricher
gs.list <- do.call(rbind, lapply(names(msigdb.hs), function(x) {
  data.frame(gs = x, genes = GSEABase::geneIds(msigdb.hs[x][[1]]))
}))

enrichresults <- regulonEnrich(
  TF = c("GATA6", "NKX2-1"),
  regulon = regulon,
  weight = "weight",
  weight_cutoff = 0.1,
  genesets = gs.list
)

# plot results
enrichPlot(results = enrichresults)

## ----plot gsea network--------------------------------------------------------
plotGseaNetwork(
  tf = names(enrichresults),
  enrichresults = enrichresults,
  p.adj_cutoff = 0.1,
  ntop_pathways = 10
)

## ----differential networks----------------------------------------------------
plotDiffNetwork(regulon,
  cutoff = 0.1,
  tf = c("GATA6"),
  weight = "weight",
  clusters = c("C1", "C5"),
  layout = "stress"
)

plotDiffNetwork(regulon,
  cutoff = 0.1,
  tf = c("NKX2-1"),
  weight = "weight",
  clusters = c("C3", "C5"),
  layout = "stress"
)

## -----------------------------------------------------------------------------
selected <- which(regulon$weight[, "C1"] > 0 &
  regulon$tf %in% c("GATA6", "FOXA1", "AR"))

C1_network <- buildGraph(regulon[selected, ],
  weights = "weight",
  cluster = "C1"
  )

plotEpiregulonNetwork(C1_network,
  layout = "sugiyama",
  tfs_to_highlight = c("GATA6", "FOXA1", "AR")) + 
  ggplot2::ggtitle("C1")

## -----------------------------------------------------------------------------
# rank by differential centrality
C1_network <- buildGraph(regulon, weights = "weight", cluster = "C1")
C5_network <- buildGraph(regulon, weights = "weight", cluster = "C5")

diff_graph <- buildDiffGraph(C1_network, C5_network, abs_diff = FALSE)
diff_graph <- addCentrality(diff_graph)
diff_graph <- normalizeCentrality(diff_graph)
rank_table <- rankTfs(diff_graph)

library(ggplot2)
ggplot(rank_table, aes(x = rank, y = centrality)) +
  geom_point() +
  ggrepel::geom_text_repel(data = rank_table, aes(label = tf)) +
  theme_classic()

## -----------------------------------------------------------------------------
sessionInfo()

