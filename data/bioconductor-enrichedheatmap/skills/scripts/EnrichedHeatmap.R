# Code example from 'EnrichedHeatmap' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE----------------------------------------------------------------
library(markdown)

library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    fig.align = "center")

options(width = 100)
suppressPackageStartupMessages(library(circlize))

## ----echo = FALSE, message = FALSE----------------------------------------------------------------
suppressWarnings(suppressPackageStartupMessages(library(EnrichedHeatmap)))

## ----eval = FALSE---------------------------------------------------------------------------------
# library(EnrichedHeatmap)

## -------------------------------------------------------------------------------------------------
set.seed(123)
load(system.file("extdata", "chr21_test_data.RData", package = "EnrichedHeatmap"))
ls()

## -------------------------------------------------------------------------------------------------
tss = promoters(genes, upstream = 0, downstream = 1)
tss[1:5]
H3K4me3[1:5]

## -------------------------------------------------------------------------------------------------
mat1 = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = 5000, mean_mode = "w0", w = 50)
mat1
class(mat1)

## ----fig.width = 3--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, name = "H3K4me3")

## ----fig.width = 3--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, col = c("white", "red"), name = "H3K4me3")

## -------------------------------------------------------------------------------------------------
quantile(H3K4me3$coverage, c(0, 0.25, 0.5, 0.75, 0.99, 1))
quantile(mat1, c(0, 0.25, 0.5, 0.75, 0.99, 1))

## ----fig.width = 3--------------------------------------------------------------------------------
mat1_trim = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = 5000, mean_mode = "w0", w = 50, keep = c(0, 0.99))
EnrichedHeatmap(mat1_trim, col = c("white", "red"), name = "H3K4me3")

## ----fig.width = 3--------------------------------------------------------------------------------
library(circlize)
col_fun = colorRamp2(quantile(mat1, c(0, 0.99)), c("white", "red"))
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3")

## -------------------------------------------------------------------------------------------------
mat1 = mat1_trim

## ----fig.width = 3--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", 
    row_split = sample(c("A", "B"), length(genes), replace = TRUE),
    column_title = "Enrichment of H3K4me3") 

## ----fig.width = 4--------------------------------------------------------------------------------
set.seed(123)
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", row_km = 3,
    column_title = "Enrichment of H3K4me3", row_title_rot = 0)

## ----fig.width = 4--------------------------------------------------------------------------------
set.seed(123)
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", row_km = 3,
    top_annotation = HeatmapAnnotation(enriched = anno_enriched(gp = gpar(col = 2:4, lty = 1:3))),
    column_title = "Enrichment of H3K4me3", row_title_rot = 0)

## ----fig.width = 3--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", 
    cluster_rows = TRUE, column_title = "Enrichment of H3K4me3")     

## ----fig.width = 3--------------------------------------------------------------------------------
# upstream 1kb, downstream 2kb
mat12 = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = c(1000, 2000), mean_mode = "w0", w = 50)
EnrichedHeatmap(mat12, name = "H3K4me3", col = col_fun)

## ----fig.width = 3--------------------------------------------------------------------------------
mat12 = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = c(0, 2000), mean_mode = "w0", w = 50)
EnrichedHeatmap(mat12, name = "H3K4me3", col = col_fun)
mat12 = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = c(1000, 0), mean_mode = "w0", w = 50)
EnrichedHeatmap(mat12, name = "H3K4me3", col = col_fun)

## ----fig.width = 3--------------------------------------------------------------------------------
mat_f = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = 5000, mean_mode = "w0", w = 50, flip_upstream = TRUE)
mat_f
EnrichedHeatmap(mat_f, name = "H3K4me3", col = col_fun)

## ----fig.width = 3--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", 
    top_annotation = HeatmapAnnotation(
        enriched = anno_enriched(
            ylim = c(0, 10),
            axis_param = list(
                at = c(0, 5, 10),
                labels = c("zero", "five", "ten"),
                side = "left",
                facing = "outside"
    )))
)     

## ----fig.height = 3, echo = FALSE-----------------------------------------------------------------
library(grid)
grid.lines(c(0.1, 0.9), c(0.3, 0.3), gp = gpar(col = "red", lwd = 4))
grid.text("window", 0.5, 0.25, just = "top", gp = gpar(col = "red"))
grid.lines(c(0, 0.2), c(0.6, 0.6))
grid.lines(c(0.3, 0.5), c(0.6, 0.6))
grid.lines(c(0.7, 1), c(0.6, 0.6))
grid.lines(c(0.1, 0.2), c(0.6, 0.6), gp = gpar(lwd = 4))
grid.lines(c(0.3, 0.5), c(0.6, 0.6), gp = gpar(lwd = 4))
grid.lines(c(0.7, 0.9), c(0.6, 0.6), gp = gpar(lwd = 4))
grid.lines(c(0.15, 0.35), c(0.45, 0.45), gp = gpar(lwd = 4))
grid.lines(c(0.6, 0.75), c(0.45, 0.45), gp = gpar(lwd = 4))
grid.lines(c(0.1, 0.1), c(0, 1), gp = gpar(lty = 2, col = "grey"))
grid.lines(c(0.9, 0.9), c(0, 1), gp = gpar(lty = 2, col = "grey"))
grid.text("genomic signal regions", 0.5, 0.7, just = "bottom")

## ----smooth, fig.width = 6------------------------------------------------------------------------
mat1_smoothed = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = 5000, mean_mode = "w0", w = 50, background = 0, smooth = TRUE)
EnrichedHeatmap(mat1_smoothed, col = col_fun, name = "H3K4me3_smoothed",
    column_title = "smoothed") +
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3", column_title = "unsmoothed")

## ----fig.width = 3--------------------------------------------------------------------------------
meth[1:5]
mat2 = normalizeToMatrix(meth, tss, value_column = "meth", mean_mode = "absolute",
    extend = 5000, w = 50, background = NA)
meth_col_fun = colorRamp2(c(0, 0.5, 1), c("blue", "white", "red"))
EnrichedHeatmap(mat2, col = meth_col_fun, name = "methylation", column_title = "methylation near TSS")

## ----fig.width = 3--------------------------------------------------------------------------------
mat2 = normalizeToMatrix(meth, tss, value_column = "meth", mean_mode = "absolute",
    extend = 5000, w = 50, background = NA, smooth = TRUE)
EnrichedHeatmap(mat2, col = meth_col_fun, name = "methylation", column_title = "methylation near TSS")

## ----fig.width = 3--------------------------------------------------------------------------------
mat3 = normalizeToMatrix(meth, cgi, value_column = "meth", mean_mode = "absolute",
    extend = 5000, w = 50, background = NA, smooth = TRUE, target_ratio = 0.3)
EnrichedHeatmap(mat3, col = meth_col_fun, name = "methylation", axis_name_rot = 90,
    column_title = "methylation near CGI")

## ----extension, fig.width = 3---------------------------------------------------------------------
mat3 = normalizeToMatrix(meth, cgi, value_column = "meth", mean_mode = "absolute",
    extend = c(0, 5000), w = 50, background = NA, smooth = TRUE, target_ratio = 0.5)
EnrichedHeatmap(mat3, col = meth_col_fun, name = "methylation", 
    column_title = "methylation near CGI")
mat3 = normalizeToMatrix(meth, cgi, value_column = "meth", mean_mode = "absolute",
    extend = c(5000, 0), w = 50, background = NA, smooth = TRUE, target_ratio = 0.5)
EnrichedHeatmap(mat3, col = meth_col_fun, name = "methylation", 
    column_title = "methylation near CGI")

## ----fig.width = 3--------------------------------------------------------------------------------
mat3 = normalizeToMatrix(meth, cgi, value_column = "meth", mean_mode = "absolute",
    extend = 0, k = 20, background = NA, smooth = TRUE, target_ratio = 1)
EnrichedHeatmap(mat3, col = meth_col_fun, name = "methylation",
    column_title = "methylation near CGI")

## -------------------------------------------------------------------------------------------------
failed_rows(mat3)

## ----fig.width = 6--------------------------------------------------------------------------------
EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3",
    top_annotation = HeatmapAnnotation(enrich = anno_enriched(axis_param = list(side = "left")))) + 
EnrichedHeatmap(mat2, col = meth_col_fun, name = "methylation") +
Heatmap(log2(rpkm+1), col = c("white", "orange"), name = "log2(rpkm+1)", 
    show_row_names = FALSE, width = unit(5, "mm"))

## ----fig.width = 7, fig.height = 8----------------------------------------------------------------
partition = paste0("cluster", kmeans(mat1, centers = 3)$cluster)
lgd = Legend(at = c("cluster1", "cluster2", "cluster3"), title = "Clusters", 
    type = "lines", legend_gp = gpar(col = 2:4))
ht_list = Heatmap(partition, col = structure(2:4, names = paste0("cluster", 1:3)), name = "partition",
              show_row_names = FALSE, width = unit(3, "mm")) +
          EnrichedHeatmap(mat1, col = col_fun, name = "H3K4me3",
              top_annotation = HeatmapAnnotation(lines = anno_enriched(gp = gpar(col = 2:4))), 
              column_title = "H3K4me3") + 
          EnrichedHeatmap(mat2, col = meth_col_fun, name = "methylation",
              top_annotation = HeatmapAnnotation(lines = anno_enriched(gp = gpar(col = 2:4))), 
              column_title = "Methylation") +
          Heatmap(log2(rpkm+1), col = c("white", "orange"), name = "log2(rpkm+1)", 
              show_row_names = FALSE, width = unit(15, "mm"),
              top_annotation = HeatmapAnnotation(summary = anno_summary(gp = gpar(fill = 2:4),
                outline = FALSE, axis_param = list(side = "right"))))
draw(ht_list, split = partition, annotation_legend_list = list(lgd), 
    ht_gap = unit(c(2, 8, 8), "mm"))

## -------------------------------------------------------------------------------------------------
load(system.file("extdata", "H3K4me1_corr_normalize_to_tss.RData", package = "EnrichedHeatmap"))
mat_H3K4me1

## ----fig.width = 5--------------------------------------------------------------------------------
corr_col_fun = colorRamp2(c(-1, 0, 1), c("darkgreen", "white", "red"))
EnrichedHeatmap(mat_H3K4me1, col = corr_col_fun, name = "corr_H3K4me1",
    top_annotation = HeatmapAnnotation(
        enrich = anno_enriched(gp = gpar(neg_col = "darkgreen", pos_col = "red"),
            axis_param = list(side = "left"))
    ), column_title = "separate neg and pos") +
EnrichedHeatmap(mat_H3K4me1, col = corr_col_fun, show_heatmap_legend = FALSE,
    top_annotation = HeatmapAnnotation(enrich = anno_enriched(value = "abs_mean")),
    column_title = "pool neg and pos")

## -------------------------------------------------------------------------------------------------
load(system.file("extdata", "neg_cr.RData", package = "EnrichedHeatmap"))
all_tss = promoters(all_genes, upstream = 0, downstream = 1)
all_tss = all_tss[unique(neg_cr$gene)]
neg_cr[1:2]
all_tss[1:2]

## ----fig.width = 3--------------------------------------------------------------------------------
mat_neg_cr = normalizeToMatrix(neg_cr, all_tss, mapping_column = "gene", w = 50, mean_mode = "w0")
EnrichedHeatmap(mat_neg_cr, col = c("white", "darkgreen"), name = "neg_cr", cluster_rows = TRUE,
    top_annotation = HeatmapAnnotation(lines = anno_enriched(gp = gpar(col = "darkgreen"))))

## ----fig.width = 3--------------------------------------------------------------------------------
mat_tx = normalizeToMatrix(tx, all_tss, mapping_column="gene", extend = c(5000, 10000), w = 50, 
    mean_mode = "coverage", keep = c(0, 0.99))
EnrichedHeatmap(mat_tx, col = c("white", "black"), name = "tx_coverage", cluster_rows = TRUE,
    top_annotation = HeatmapAnnotation(lines2 = anno_enriched(gp = gpar(col = "black"))))

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# ht_list = draw(ht_list)
# row_order(ht_list)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# EnrichedHeatmap(..., column_title_gp = ...)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# EnrichedHeatmap(..., heatmap_legend_param = ...)
# # or set is globally
# ht_opt(...)
# EnrichedHeatmap(...)
# ht_opt(RESET = TRUE)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# EnrichedHeatmap(..., width = ...) + EnrichedHeatmap(...)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# mat_list = NULL
# for(i in seq_along(hm_gr_list)) {
#     mat_list[[i]] = normalizeToMatrix(hm_gr_list[[i]], tss, value_column = ...)
# }

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# mat_mean = getSignalsFromList(mat_list)
# EnrichedHeatmap(mat_mean)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# mat_corr = getSignalsFromList(mat_list, fun = function(x, i) cor(x, expr[i, ], method = "spearman"))

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# EnrichedHeatmap(mat_corr)

## ----eval = FALSE---------------------------------------------------------------------------------
# attr(mat, "upstream_index")
# attr(mat, "target_index")
# attr(mat, "downstream_index")
# attr(mat, "extend")

## -------------------------------------------------------------------------------------------------
mat1 = normalizeToMatrix(H3K4me3, tss, value_column = "coverage", 
    extend = 5000, mean_mode = "w0", w = 50)
mat2 = mat1
attributes(mat2) = NULL
dim(mat2) = dim(mat1)
mat2[1:4, 1:4]

## -------------------------------------------------------------------------------------------------
attr(mat2, "upstream_index") = 1:100
attr(mat2, "target_index") = integer(0)
attr(mat2, "downstream_index") = 101:200
attr(mat2, "extend") = c(5000, 5000)  # it must be a vector of length two

## -------------------------------------------------------------------------------------------------
class(mat2) = c("normalizedMatrix", "matrix")
mat2

## -------------------------------------------------------------------------------------------------
attr(mat2, "signal_name") = "H3K4me3"
attr(mat2, "target_name") = "TSS"
mat2

## -------------------------------------------------------------------------------------------------
attributes(mat2) = NULL
dim(mat2) = dim(mat1)
as.normalizedMatrix(mat2, 
    k_upstream = 100, 
    k_downstream = 100, 
    k_target = 0,
    extend = c(5000, 5000), 
    signal_name = "H3K4me3", 
    target_name = "TSS"
)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# EnrichedHeatmap(mat, use_raster = TRUE, raster_device = ..., raster_device_param = ...)

## ----eval = FALSE---------------------------------------------------------------------------------
# # code not run
# mat = normalizeToMatrix(..., smooth = FALSE)
# # the percent of NA values in each row
# apply(mat, 1, function(x) sum(is.na(x)/length(x)))

## -------------------------------------------------------------------------------------------------
sessionInfo()

