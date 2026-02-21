# Code example from 'row_odering' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE----------------------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    warning = FALSE,
    message = FALSE)

## -------------------------------------------------------------------------------------------------
library(EnrichedHeatmap)
load(system.file("extdata", "neg_cr.RData", package = "EnrichedHeatmap"))
all_genes = all_genes[unique(neg_cr$gene)]
all_tss = promoters(all_genes, upstream = 0, downstream = 1)
mat_neg_cr = normalizeToMatrix(neg_cr, all_tss, mapping_column = "gene", w = 50, mean_mode = "w0")

## ----eval = FALSE---------------------------------------------------------------------------------
# EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
#     top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
#     row_title = "by default enriched scores")
# 
# EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
#     top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
#     cluster_rows = TRUE,
#     row_title = "by hierarchcal clustering + Euclidean distance\ndendrogram reordered by enriched scores")
# 
# EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
#     top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
#     cluster_rows = TRUE, clustering_distance_rows = dist_by_closeness,
#     row_title = "by hierarchcal clustering + closeness distance\ndendrogram reordered by enriched scores")

## ----echo = FALSE, fig.width = 8, fig.height = 6--------------------------------------------------
gb1 = grid.grabExpr(draw(EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
    top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
    row_title = "\nby default enriched scores")))
gb2 = grid.grabExpr(draw(EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
    top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
    cluster_rows = TRUE, row_title = "by hierarchcal clustering + Euclidean distance\ndendrogram reordered by enriched scores")))
load(system.file("extdata", "neg_cr_order_by_dist_closeness.RData", package = "EnrichedHeatmap"))
gb3 = grid.grabExpr(draw(EnrichedHeatmap(mat_neg_cr, name = "neg_cr", col = c("white", "darkgreen"),
    top_annotation = HeatmapAnnotation(enrich = anno_enriched(gp = gpar(col = "darkgreen"))),
    cluster_rows = FALSE, row_order = row_order, 
    row_title = "by hierarchcal clustering + closeness distance\ndendrogram reordered by enriched scores")))
grid.newpage()
pushViewport(viewport(x = 0, width = 1/3, just = "left"))
grid.draw(gb1)
popViewport()
pushViewport(viewport(x = 1/3, width = 1/3, just = "left"))
grid.draw(gb2)
popViewport()
pushViewport(viewport(x = 2/3, width = 1/3, just = "left"))
grid.draw(gb3)
popViewport()

