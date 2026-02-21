# Code example from 'V5_slam_seq' vignette. See references/ for full tutorial.

## ----echo=F-------------------------------------------------------------------
# To examine objects:
# devtools::load_all(export_all=F) ; qwraps2::lazyload_cache_dir("vignettes/V5_slam_seq_cache/html")

knitr::opts_chunk$set(cache=TRUE, autodep=TRUE)

## ----setup, cache=FALSE, warning=FALSE, message=FALSE-------------------------
library(tidyverse)
library(ComplexHeatmap)
library(weitrix)

# BiocParallel supports multiple backends. 
# If the default hangs or errors, try others.
# The most reliable backed is to use serial processing
BiocParallel::register( BiocParallel::SerialParam() )

## ----load, message=FALSE------------------------------------------------------
coverage <- system.file("GSE99970", "GSE99970_T_coverage.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("gene") %>%
    as.matrix()

conversions <- system.file("GSE99970", "GSE99970_T_C_conversions.csv.gz", package="weitrix") %>%
    read.csv(check.names=FALSE) %>%
    column_to_rownames("gene") %>%
    as.matrix()

# Calculate proportions, create weitrix
wei <- as_weitrix( conversions/coverage, coverage )
dim(wei)

# We will only use genes where at least 30 conversions were observed
good <- rowSums(conversions) >= 30
wei <- wei[good,]

# Add some column data from the names
parts <- str_match(colnames(wei), "(.*)_(Rep_.*)")
colData(wei)$group <- fct_inorder(parts[,2])
colData(wei)$rep <- fct_inorder(paste0("Rep_",parts[,3]))
rowData(wei)$mean_coverage <- rowMeans(weitrix_weights(wei))

wei

colMeans(weitrix_x(wei), na.rm=TRUE)

## ----calibrate----------------------------------------------------------------
# Compute an initial fit to provide residuals
fit <- weitrix_components(wei, design=~group)

cal <- weitrix_calibrate_all(wei, 
    design = fit,
    trend_formula = 
        ~ log(weight) + offset(log(mu*(1-mu))), 
    mu_min=0.001, mu_max=0.999)

metadata(cal)$weitrix$all_coef

## ----calplot_mu, fig.height=8-------------------------------------------------
weitrix_calplot(wei, fit, cat=group, covar=mu, guides=FALSE) + 
    coord_cartesian(xlim=c(0,0.1)) + labs(title="Before calibration")
weitrix_calplot(cal, fit, cat=group, covar=mu) + 
    coord_cartesian(xlim=c(0,0.1)) + labs(title="After calibration")

## ----calplot_weight, fig.height=8---------------------------------------------
weitrix_calplot(wei, fit, cat=group, covar=log(weitrix_weights(wei)), guides=FALSE) + 
    labs(title="Before calibration")
weitrix_calplot(cal, fit, cat=group, covar=log(weitrix_weights(wei))) + 
    labs(title="After calibration")

## ----comp, message=FALSE------------------------------------------------------
comp <- weitrix_components(cal, 2, n_restarts=1)

## ----showcomp-----------------------------------------------------------------
matrix_long(comp$col[,-1], row_info=colData(cal)) %>% 
    ggplot(aes(x=group,y=value)) + 
    geom_jitter(width=0.2,height=0) + 
    facet_grid(col~.)

## ----comp1--------------------------------------------------------------------
fast <- weitrix_confects(cal, comp$col, "C1")
fast

Heatmap(
    weitrix_x(cal)[ head(fast$table$name, 10) ,], 
    name="Proportion converted", 
    cluster_columns=FALSE, cluster_rows=FALSE)

## ----comp2--------------------------------------------------------------------
slow <- weitrix_confects(cal, comp$col, "C2")
slow

Heatmap(
    weitrix_x(cal)[ head(slow$table$name, 10) ,], 
    name="Proportion converted", 
    cluster_columns=FALSE, cluster_rows=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# library(tidyverse)
# 
# download.file("https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE99970&format=file", "GSE99970_RAW.tar")
# untar("GSE99970_RAW.tar", exdir="GSE99970_RAW")
# 
# filenames <- list.files("GSE99970_RAW", full.names=TRUE)
# samples <- str_match(filenames,"mESC_(.*)\\.tsv\\.gz")[,2]
# dfs <- map(filenames, read_tsv, comment="#")
# coverage <- do.call(cbind, map(dfs, "CoverageOnTs")) %>%
#     rowsum(dfs[[1]]$Name)
# conversions <- do.call(cbind, map(dfs, "ConversionsOnTs")) %>%
#     rowsum(dfs[[1]]$Name)
# colnames(conversions) <- colnames(coverage) <- samples
# 
# reorder <- c(1:3, 25:27, 4:24)
# 
# coverage[,reorder] %>%
#     as.data.frame() %>%
#     rownames_to_column("gene") %>%
#     write_csv("GSE99970_T_coverage.csv.gz")
# 
# conversions[,reorder] %>%
#     as.data.frame() %>%
#     rownames_to_column("gene") %>%
#     write_csv("GSE99970_T_C_conversions.csv.gz")

