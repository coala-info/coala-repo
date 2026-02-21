# Code example from 'spatialDE' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("spatialDE")

## ----setup--------------------------------------------------------------------
library(spatialDE)
library(ggplot2)

## ----load-data----------------------------------------------------------------
# Expression file used in python SpatialDE. 
data("Rep11_MOB_0")

# Sample Info file used in python SpatialDE
data("MOB_sample_info")

## -----------------------------------------------------------------------------
Rep11_MOB_0[1:5, 1:5]
dim(Rep11_MOB_0)

## -----------------------------------------------------------------------------
head(MOB_sample_info)

## -----------------------------------------------------------------------------
Rep11_MOB_0 <- Rep11_MOB_0[rowSums(Rep11_MOB_0) >= 3, ]

## -----------------------------------------------------------------------------
Rep11_MOB_0 <- Rep11_MOB_0[, row.names(MOB_sample_info)]
MOB_sample_info$total_counts <- colSums(Rep11_MOB_0)
head(MOB_sample_info)

## -----------------------------------------------------------------------------
X <- MOB_sample_info[, c("x", "y")]
head(X)

## ----stabilize----------------------------------------------------------------
norm_expr <- stabilize(Rep11_MOB_0)
norm_expr[1:5, 1:5]

## ----regres_out---------------------------------------------------------------
resid_expr <- regress_out(norm_expr, sample_info = MOB_sample_info)
resid_expr[1:5, 1:5]

## ----run-spatialDE------------------------------------------------------------
# For this example, run spatialDE on the first 1000 genes
sample_resid_expr <- head(resid_expr, 1000)

results <- spatialDE::run(sample_resid_expr, coordinates = X)
head(results[order(results$qval), ])

## ----model_search-------------------------------------------------------------
de_results <- results[results$qval < 0.05, ]

ms_results <- model_search(
    sample_resid_expr,
    coordinates = X,
    de_results = de_results
)

# To show ms_results sorted on qvalue, uncomment the following line
# head(ms_results[order(ms_results$qval), ])

head(ms_results)

## ----spatial_patterns---------------------------------------------------------
sp <- spatial_patterns(
    sample_resid_expr,
    coordinates = X,
    de_results = de_results,
    n_patterns = 4L, length = 1.5
)
sp$pattern_results

## ----fig1---------------------------------------------------------------------
gene <- "Pcp4"

ggplot(data = MOB_sample_info, aes(x = x, y = y, color = norm_expr[gene, ])) +
    geom_point(size = 7) +
    ggtitle(gene) +
    scale_color_viridis_c() +
    labs(color = gene)

## ----fig2, fig.height = 10, fig.width = 10------------------------------------
ordered_de_results <- de_results[order(de_results$qval), ]

multiGenePlots(norm_expr,
    coordinates = X,
    ordered_de_results[1:6, ]$g,
    point_size = 4,
    viridis_option = "D",
    dark_theme = FALSE
)

## -----------------------------------------------------------------------------
FSV_sig(results, ms_results)

## ----message=FALSE------------------------------------------------------------
library(SpatialExperiment)

# For SpatialExperiment object, we neeed to transpose the counts matrix in order
# to have genes on rows and spot on columns. 
# For this example, run spatialDE on the first 1000 genes

partial_counts <- head(Rep11_MOB_0, 1000)

spe <- SpatialExperiment(
  assays = list(counts = partial_counts),
  spatialData = DataFrame(MOB_sample_info[, c("x", "y")]),
  spatialCoordsNames = c("x", "y")
)

out <- spatialDE(spe, assay_type = "counts", verbose = FALSE)
head(out[order(out$qval), ])

## ----fig3, fig.height = 10, fig.width = 10------------------------------------
spe_results <- out[out$qval < 0.05, ]

ordered_spe_results <- spe_results[order(spe_results$qval), ]

multiGenePlots(spe,
    assay_type = "counts",
    ordered_spe_results[1:6, ]$g,
    point_size = 4,
    viridis_option = "D",
    dark_theme = FALSE
)

## -----------------------------------------------------------------------------
msearch <- modelSearch(spe,
    de_results = out, qval_thresh = 0.05,
    verbose = FALSE
)

head(msearch)

## -----------------------------------------------------------------------------
spatterns <- spatialPatterns(spe,
    de_results = de_results, qval_thresh = 0.05,
    n_patterns = 4L, length = 1.5, verbose = FALSE
)

spatterns$pattern_results

## ----session_info, echo=FALSE, cache=FALSE------------------------------------
Sys.time()
sessionInfo()

