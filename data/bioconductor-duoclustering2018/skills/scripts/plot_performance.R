# Code example from 'plot_performance' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
suppressPackageStartupMessages({
  library(ExperimentHub)
  library(SingleCellExperiment)
  library(DuoClustering2018)
  library(plyr)
})

## -----------------------------------------------------------------------------
eh <- ExperimentHub()
query(eh, "DuoClustering2018")

## -----------------------------------------------------------------------------
eh[["EH1500"]]

## -----------------------------------------------------------------------------
sce_filteredExpr10_Koh()

## -----------------------------------------------------------------------------
res <- plyr::rbind.fill(
  clustering_summary_filteredExpr10_Koh_v2(),
  clustering_summary_filteredHVG10_Koh_v2(),
  clustering_summary_filteredExpr10_Zhengmix4eq_v2(),
  clustering_summary_filteredHVG10_Zhengmix4eq_v2()
)
dim(res)

## -----------------------------------------------------------------------------
head(res)

## -----------------------------------------------------------------------------
method_colors <- c(CIDR = "#332288", FlowSOM = "#6699CC", PCAHC = "#88CCEE", 
            PCAKmeans = "#44AA99", pcaReduce = "#117733",
            RtsneKmeans = "#999933", Seurat = "#DDCC77", SC3svm = "#661100", 
            SC3 = "#CC6677", TSCAN = "grey34", ascend = "orange", SAFE = "black",
            monocle = "red", RaceID2 = "blue")

## -----------------------------------------------------------------------------
perf <- plot_performance(res, method_colors = method_colors)
names(perf)
perf$median_ari_vs_k
perf$median_ari_heatmap_truek

## -----------------------------------------------------------------------------
stab <- plot_stability(res, method_colors = method_colors)
names(stab)
stab$stability_vs_k
stab$stability_heatmap_truek

## ----fig.height = 8-----------------------------------------------------------
entr <- plot_entropy(res, method_colors = method_colors)
names(entr)
entr$entropy_vs_k
entr$normentropy

## ----fig.height = 8-----------------------------------------------------------
timing <- plot_timing(res, method_colors = method_colors, 
                      scaleMethod = "RtsneKmeans")
names(timing)
timing$time_normalized_by_ref

## ----fig.height = 8-----------------------------------------------------------
kdiff <- plot_k_diff(res, method_colors = method_colors)
names(kdiff)
kdiff$diff_kest_ktrue

## -----------------------------------------------------------------------------
sessionInfo()

