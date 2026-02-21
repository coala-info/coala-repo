# Code example from 'airpart' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
library(airpart)
suppressPackageStartupMessages(library(SingleCellExperiment))
p.vec <- rep(c(0.2, 0.8, 0.5, 0.5, 0.7, 0.9), each = 2)
set.seed(2021)
sce <- makeSimulatedData(
  mu1 = 2, mu2 = 10, nct = 4, n = 20,
  ngenecl = 25, theta = 20, ncl = 3,
  p.vec = p.vec
)

## -----------------------------------------------------------------------------
unique(rowData(sce)) # the true underlying allelic ratios
table(sce$x) # counts of each cell type
assays(sce)[["a1"]][1:5, 1:5] # allelic counts for the effect allele

## -----------------------------------------------------------------------------
assayNames(sce)
sce$x

## -----------------------------------------------------------------------------
sce <- preprocess(sce)
makeHeatmap(sce)

## -----------------------------------------------------------------------------
cellQCmetrics <- cellQC(sce, mad_detected = 4)
cellQCmetrics

## -----------------------------------------------------------------------------
keep_cell <- (
  cellQCmetrics$filter_sum | # sufficient features (genes)
    cellQCmetrics$filter_detected | # sufficient molecules counted
    # sufficient features expressed compared to spike genes,
    # high quality cells
    cellQCmetrics$filter_spike
)
sce <- sce[, keep_cell]

## ----eval=FALSE---------------------------------------------------------------
# featureQCmetric <- featureQC(sce)
# keep_feature <- (featureQCmetric$filter_celltype &
#   featureQCmetric$filter_sd &
#   featureQCmetric$filter_spike)
# sce <- sce[keep_feature, ]

## -----------------------------------------------------------------------------
sce <- geneCluster(sce, G = 1:4)
metadata(sce)$geneCluster

## -----------------------------------------------------------------------------
sce.hc <- geneCluster(sce, method = "hierarchical")
metadata(sce.hc)$geneCluster

## -----------------------------------------------------------------------------
summary <- summaryAllelicRatio(sce)
summary

## -----------------------------------------------------------------------------
sapply(1:length(summary), function(i) {
  inst <- summary[[i]]
  inst_order <- inst[order(inst$weighted.mean), ]
  max(diff(inst_order$weighted.mean)) > 0.05
})

## -----------------------------------------------------------------------------
estDisp(sce, genecluster = 1)

## -----------------------------------------------------------------------------
sce_sub <- fusedLasso(sce,
  model = "binomial",
  genecluster = 1, ncores = 1,
  niter = 2
)

## ----results="asis"-----------------------------------------------------------
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)

## -----------------------------------------------------------------------------
metadata(sce_sub)$lambda

## ----results='asis', collapse=TRUE--------------------------------------------
sce_sub <- consensusPart(sce_sub)
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)

## -----------------------------------------------------------------------------
thrs <- 10^seq(from = -2, to = -0.4, by = 0.2)
sce_sub_w <- wilcoxExt(sce, genecluster = 1, threshold = thrs)
knitr::kable(metadata(sce_sub_w)$partition, row.names = FALSE)
metadata(sce_sub_w)$threshold

## ----warning=FALSE, fig.width=12----------------------------------------------
sce_sub <- allelicRatio(sce_sub, DAItest = TRUE)
makeForest(sce_sub, showtext = TRUE)

## ----results="asis"-----------------------------------------------------------
genepoi <- paste0("gene", seq_len(5))
ar <- extractResult(sce_sub)
knitr::kable(ar[genepoi,])
makeStep(sce_sub[genepoi,])

## -----------------------------------------------------------------------------
s <- extractResult(sce_sub, "svalue")
apply(s[genepoi,],2, function(s){s<0.005})

## -----------------------------------------------------------------------------
adj.p <- mcols(sce_sub)$adj.p.value
adj.p < 0.05

## -----------------------------------------------------------------------------
nct <- 8
p.vec <- (rep(c(
  -3, 0, -3, 3,
  rep(0, nct / 2),
  2, 3, 4, 2
), each = 2) + 5) / 10
sce <- makeSimulatedData(
  mu1 = 2, mu2 = 10, nct = nct, n = 30,
  ngenecl = 50, theta = 20, ncl = 3, p.vec = p.vec
)
sce <- preprocess(sce)

cellQCmetrics <- cellQC(sce, mad_detected = 4)
keep_cell <- (
  cellQCmetrics$filter_sum | # sufficient features (genes)
    cellQCmetrics$filter_detected | # sufficient molecules counted
    # sufficient features expressed compared to spike genes,
    # high quality cells
    cellQCmetrics$filter_spike
)
sce <- sce[, keep_cell]

featureQCmetric <- featureQC(sce)
keep_feature <- (featureQCmetric$filter_celltype &
  featureQCmetric$filter_sd &
  featureQCmetric$filter_spike)
sce <- sce[keep_feature, ]

makeHeatmap(sce)

## -----------------------------------------------------------------------------
sce <- geneCluster(sce, G = 1:4)
table(mcols(sce)$cluster)

## -----------------------------------------------------------------------------
estDisp(sce, genecluster = 1)

## -----------------------------------------------------------------------------
sce_sub <- fusedLasso(sce,
  model = "binomial",
  genecluster = 1, ncores = 1
)

## ----results="asis"-----------------------------------------------------------
knitr::kable(metadata(sce_sub)$partition, row.names = FALSE)

## -----------------------------------------------------------------------------
sce_sub2 <- sce_sub[1:10, ]
sce_sub2 <- allelicRatio(sce_sub2)

## -----------------------------------------------------------------------------
makeForest(sce_sub2)
ar <- extractResult(sce_sub2)
knitr::kable(ar)

## -----------------------------------------------------------------------------
makeViolin(sce_sub2)

## -----------------------------------------------------------------------------
makeHeatmap(sce_sub2)

## -----------------------------------------------------------------------------
makeHeatmap(sce_sub2, order_by_group = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

