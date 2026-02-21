# Code example from 'spillR-vignette' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
    echo = TRUE, warning = FALSE, message = FALSE,
    fig.retina = 2, dpi = 96,
    fig.width = 7.2916667, fig.asp = 0.6178571
)

## ----install-package, eval=FALSE----------------------------------------------
# if (!require("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# 
# BiocManager::install("spillR")

## ----load-data, warning=FALSE-------------------------------------------------
library(spillR)
library(CATALYST)
library(dplyr)
library(ggplot2)
library(cowplot)

bc_key <- c(139, 141:156, 158:176)
sce_bead <- prepData(ss_exp)
sce_bead <- assignPrelim(sce_bead, bc_key, verbose = FALSE)
sce_bead <- applyCutoffs(estCutoffs(sce_bead))
sce_bead <- computeSpillmat(sce_bead)

# --------- experiment with real cells ---------
data(mp_cells, package = "CATALYST")
sce <- prepData(mp_cells)

## ----compensation-workflow, warning=FALSE-------------------------------------
# --------- table for mapping markers and barcode ---------
marker_to_barc <-
    rowData(sce_bead)[, c("channel_name", "is_bc")] |>
    as_tibble() |>
    dplyr::filter(is_bc == TRUE) |>
    mutate(barcode = bc_key) |>
    select(marker = channel_name, barcode)

# --------- compensate function from spillR package ---------
sce_spillr <-
    spillR::compCytof(sce, sce_bead, marker_to_barc, impute_value = NA, 
                      overwrite = FALSE)

# --------- 2d histogram from CATALYST package -------
as <- c("counts", "exprs", "compcounts", "compexprs")
chs <- c("Yb171Di", "Yb173Di")
ps <- lapply(as, function(a) plotScatter(sce_spillr, chs, assay = a))
plot_grid(plotlist = ps, nrow = 2)

## ----plotting, warning=FALSE--------------------------------------------------
ps <- spillR::plotDiagnostics(sce_spillr, "Yb173Di")
x_lim <- c(0, 7)
plot_grid(ps[[1]] + xlim(x_lim),
    ps[[2]] + xlim(x_lim),
    ncol = 1, align = "v"
)

## ----session_info-------------------------------------------------------------
sessionInfo()

