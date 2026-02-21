# Code example from 'qmtools' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE,
  fig.height = 10,
  fig.width = 10
)

## ----setup--------------------------------------------------------------------
library(qmtools)
library(SummarizedExperiment)
library(vsn)
library(pls)
library(ggplot2)
library(patchwork)
set.seed(1e8)

data(faahko_se)

## Only keep the first assay for the vignette
assays(faahko_se)[2:4] <- NULL
faahko_se

## ----filtering----------------------------------------------------------------
dim(faahko_se) # 206 features
table(colData(faahko_se)$sample_group)

## Missing value filter based on 2 groups.
dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   cut = 0.80)) # nothing removed

dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   cut = 0.85)) # removed 65 features

## based on "WT" only
dim(removeFeatures(faahko_se, i = "raw",
                   group = colData(faahko_se)$sample_group,
                   levels = "WT", cut = 0.85))


## ----plotMiss, fig.wide = TRUE, fig.height = 5--------------------------------
## Sample group information
g <- factor(colData(faahko_se)$sample_group, levels = c("WT", "KO"))

## Visualization of missing values
plotMiss(faahko_se, i = "raw", group = g)

## ----knn, fig.wide = TRUE, fig.height = 5-------------------------------------
se <- imputeIntensity(faahko_se, i = "raw", name = "knn", method = "knn")
se # The result was stored in assays slot: "knn"

## Standardization of input does not influence the result
m <- assay(faahko_se, "raw")
knn_scaled <- as.data.frame(
    imputeIntensity(scale(m), method = "knn") # Can accept matrix as an input
)

knn_unscaled <- as.data.frame(assay(se, "knn"))

idx <- which(is.na(m[, 1]) | is.na(m[, 2])) # indices for missing values
p1 <- ggplot(knn_unscaled[idx, ], aes(x = ko15.CDF, y = ko16.CDF)) +
    geom_point() + theme_bw()
p2 <- ggplot(knn_scaled[idx, ], aes(x = ko15.CDF, y = ko16.CDF)) +
    geom_point() + theme_bw()
p1 + p2 + plot_annotation(title = "Imputed values: unscaled vs scaled")

## ----vsn, fig.wide = TRUE, fig.height = 5-------------------------------------
se <- normalizeIntensity(se, i = "knn", name = "knn_vsn", method = "vsn")
se # The result was stored in assays slot: "knn_vsn"

p1 <- plotBox(se, i = "knn", group = g, log2 = TRUE) # before normalization
p2 <- plotBox(se, i = "knn_vsn", group = g) # after normalization
p1 + p2 + plot_annotation(title = "Before vs After normalization")

## ----PCA----------------------------------------------------------------------
## PCA
m_pca <- reduceFeatures(se, i = "knn_vsn", method = "pca", ncomp = 2)
summary(m_pca)

## ----PLSDA--------------------------------------------------------------------
## PLS-DA (requires information about each sample's group)
m_plsda <- reduceFeatures(se, i = "knn_vsn", method = "plsda", ncomp = 2, y = g)
summary(m_plsda)

## ----plotReduced, fig.wide = TRUE, fig.height = 5-----------------------------
p_pca <- plotReduced(m_pca, group = g)
p_plsda <- plotReduced(m_plsda, label = TRUE, ellipse = TRUE)
p_pca + p_plsda + plot_annotation(title = "PCA and PLS-DA")

## ----clusterFeatures----------------------------------------------------------
se <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                      rt_cut = 10, cor_cut = 0.7)
rowData(se)[, c("rtmed", "rtime_group", "feature_group")]

## ----rtime hclust, fig.wide = TRUE, fig.height = 5----------------------------
rts <- rowData(se)$rtmed
rt_cut <- 10
fit <- hclust(dist(rts, "manhattan"))
plot(as.dendrogram(fit), leaflab = "none")
rect.hclust(fit, h = rt_cut)


## ----connected, fig.small = TRUE----------------------------------------------
se_connected <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                                rt_cut = 10, cor_cut = 0.7,
                                cor_grouping = "connected")
plotRTgroup(se_connected, i = "knn_vsn", group = "FG.22")

## ----louvain, fig.small = TRUE------------------------------------------------
se_louvain <- clusterFeatures(se, i = "knn_vsn", rtime_var = "rtmed",
                              rt_cut = 10, cor_cut = 0.7,
                              cor_grouping = "louvain")
plotRTgroup(se_louvain, i = "knn_vsn", group = "FG.22")

## ----pairs, fig.wide = FALSE--------------------------------------------------
plotRTgroup(se_louvain, i = "knn_vsn", group = "FG.22", type = "pairs")

## ----compareSamples-----------------------------------------------------------
## Compute statisticis for the contrast: KO - WT
fit <- compareSamples(se, i = "knn_vsn", group = "sample_group",
                      class1 = "WT", class2 = "KO")

## List top 5 features
head(fit, 5)

## ----compareSamples covariates------------------------------------------------
## Include covariates
colData(se)$covar <- c(rep(c("A", "B"), 6))
compareSamples(se, i = "knn_vsn", group = "sample_group",
               covariates = "covar", class1 = "WT", class2 = "KO",
               number = 5)

## ----session info-------------------------------------------------------------
sessionInfo()

