# Code example from 'detection' vignette. See references/ for full tutorial.

## ----cache, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache=TRUE)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(BiocStyle)

## ----load-libs, message=FALSE,  warning=FALSE---------------------------------
library(dplyr)
library(purrr)
library(tidyr)
library(scater)
library(muscat)
library(ggplot2)
library(patchwork)

## ----load-data, message=FALSE-------------------------------------------------
library(ExperimentHub)
eh <- ExperimentHub()
query(eh, "Kang")
(sce <- eh[["EH2259"]])

## ----prep-data----------------------------------------------------------------
sce <- sce[rowSums(counts(sce) > 0) > 0, ]
qc <- perCellQCMetrics(sce)
sce <- sce[, !isOutlier(qc$detected, nmads=2, log=TRUE)]
sce <- sce[rowSums(counts(sce) > 1) >= 10, ]
sce$id <- paste0(sce$stim, sce$ind)
sce <- prepSCE(sce, "cell", "id", "stim")
table(sce$cluster_id, sce$group_id)
table(sce$sample_id)

## ----pbs-det------------------------------------------------------------------
pb_sum <- aggregateData(sce,
    assay="counts", fun="sum",
    by=c("cluster_id", "sample_id"))
pb_det <- aggregateData(sce,
    assay="counts", fun="num.detected",
    by=c("cluster_id", "sample_id"))
t(head(assay(pb_det)))

## ----pbs-mds, fig.width=8, fig.height=4, fig.cap="Pseudobulk-level multidimensional scaling (MDS) plot based on (A) sum of counts and (B) sum of binarized counts (i.e., counting the number of detected features) in each cluster-sample."----
pbMDS(pb_sum) + ggtitle("Σ counts") +
pbMDS(pb_det) + ggtitle("# detected") +
plot_layout(guides="collect") +
plot_annotation(tag_levels="A") &
theme(legend.key.size=unit(0.5, "lines"))

## ----pbDD---------------------------------------------------------------------
res_DD <- pbDD(pb_det, min_cells=0, filter="none", verbose=FALSE)

## -----------------------------------------------------------------------------
tbl <- res_DD$table[[1]]
# one data.frame per cluster
names(tbl)

## -----------------------------------------------------------------------------
# view results for 1st cluster
k1 <- tbl[[1]]
head(format(k1[, -ncol(k1)], digits = 2))

## -----------------------------------------------------------------------------
# filter FDR < 5%, |logFC| > 1 & sort by adj. p-value
tbl_fil <- lapply(tbl, \(u)
    filter(u, 
        p_adj.loc < 0.05, 
        abs(logFC) > 1) |>
        arrange(p_adj.loc))

# nb. of DS genes & % of total by cluster
n_de <- vapply(tbl_fil, nrow, numeric(1))
p_de <- format(n_de / nrow(sce) * 100, digits = 3)
data.frame("#DD" = n_de, "%DD" = p_de, check.names = FALSE)

## -----------------------------------------------------------------------------
library(UpSetR)
de_gs_by_k <- map(tbl_fil, "gene")
upset(fromList(de_gs_by_k))

## ----pbDS---------------------------------------------------------------------
res_DS <- pbDS(pb_sum, min_cells=0, filter="none", verbose=FALSE)

## -----------------------------------------------------------------------------
res <- stagewise_DS_DD(res_DS, res_DD, verbose=FALSE)
head(res[[1]][[1]]) # results for 1st cluster

## -----------------------------------------------------------------------------
# for each approach, get adjusted p-values across clusters
ps <- map_depth(res, 2, \(df) {
    data.frame(
        df[, c("gene", "cluster_id")],
        p_adj.stagewise=df$p_adj,
        p_adj.DS=df$res_DS$p_adj.loc,
        p_adj.DD=df$res_DD$p_adj.loc)
}) |> 
    lapply(do.call, what=rbind) |>
    do.call(what=rbind) |>
    data.frame(row.names=NULL)
head(ps)

## ----fig.width=12, fig.height=4-----------------------------------------------
# for each approach & cluster, count number 
# of genes falling below 5% FDR threshold
ns <- lapply(seq(0, 0.2, 0.005), \(th) {
    ps |>
        mutate(th=th) |>
        group_by(cluster_id, th) |>
        summarise(
            .groups="drop",
            across(starts_with("p_"), 
            \(.) sum(. < th, na.rm=TRUE)))
}) |> 
    do.call(what=rbind) |>
    pivot_longer(starts_with("p_"))
ggplot(ns, aes(th, value, col=name)) + 
    geom_line(linewidth=0.8, key_glyph="point") +
    geom_vline(xintercept=0.05, lty=2, linewidth=0.4) +
    guides(col=guide_legend(NULL, override.aes=list(size=3))) +
    labs(x="FDR threshold", y="number of significantly\ndifferential genes") +
    facet_wrap(~cluster_id, scales="free_y", nrow=2) + 
    theme_bw() + theme(
        panel.grid.minor=element_blank(),
        legend.key.size=unit(0.5, "lines"))

## ----upset, fig.width = 5, fig.height = 3, fig.cap = "Upset plot of differential findings (FDR < 0.05) across DS, DD, and stagewise analysis for an exemplary cluster; shown are the 50 most frequent interactions."----
# subset adjuster p-values for cluster of interest
qs <- ps[grep("CD4", ps$cluster_id), grep("p_", names(ps))]
# for each approach, extract genes at 5% FDR threshold
gs <- apply(qs, 2, \(.) ps$gene[. < 0.05])
# visualize set intersections between approaches
UpSetR::upset(UpSetR::fromList(gs), order.by="freq")

## -----------------------------------------------------------------------------
# extract genes unique to stagewise testing
sw <- grep("stagewise", names(gs))
setdiff(gs[[sw]], unlist(gs[-sw]))

## ----session-info-------------------------------------------------------------
sessionInfo()

