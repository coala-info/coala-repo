# Code example from 'DSP' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy=FALSE, cache=TRUE,
                        dev="png", 
                        message=TRUE, error=FALSE, warning=TRUE)
library(utils)

## ----package, warning=FALSE---------------------------------------------------
suppressMessages({
    library(DESpace)
    library(ggplot2)
    library(SpatialExperiment)
    library(muSpaData)
    library(reshape2)
    library(tidyverse)
    library(patchwork)
    library(splines)
    library(edgeR)
})
set.seed(123)

## ----load-example-data, message = FALSE---------------------------------------
# Load the small example data
spe <- Wei22_example()
# The following columns from colData(spe) are specified:
coordinates <- c("sdimx", "sdimy") # coordinates of cells
spatial_cluster <- 'Banksy_smooth' # Banksy spatial clusters
condition_col <- 'condition'       # regeneration time phases
sample_col <- 'sample_id'          # tissue section id
colData(spe) |> head()

## ----view ARTISTA Banksy------------------------------------------------------
# View Banksy clusters 
# The spatial cluster assignments are available in the `colData(spe)`
CD <- colData(spe) |> as.data.frame()
ggplot(CD, aes(x = sdimx, y = sdimy, color = factor(Banksy_smooth))) +
    geom_point(size = 0.25) +
    facet_wrap(~sample_id, scales = 'free') +
    theme_void() +
    theme(legend.position = "bottom") +
    guides(color = guide_legend(override.aes = list(size = 3))) +
    labs(color = NULL, title = "Banksy Spatial Clusters")

## ----DESpace------------------------------------------------------------------
results <- dsp_test(spe = spe,
                    cluster_col = spatial_cluster,
                    sample_col = sample_col,
                    condition_col = condition_col,
                    test = 'QLF',
                    verbose = TRUE)

## -----------------------------------------------------------------------------
head(results$gene_results, 2)

## -----------------------------------------------------------------------------
class(results$estimated_y)
class(results$glmQLFit)    # or results$glmFit  depending on test
class(results$glmQLFTest)  # or results$glmLRT  depending on test

## -----------------------------------------------------------------------------
sample_ids <- levels(CD$sample_id)

# Identify the top DSP
(feature <- results$gene_results$gene_id[1])

# Extract the gene_name by matching the gene_id
(feature_name <- rowData(spe)$gene_id[
  rowData(spe)$gene_name %in% feature
])

## ----top DSPs expression plot-------------------------------------------------
# generate a list of plots
plots <- lapply(sample_ids, function(sample_id) {
  
  # Subset spe for each sample
  spe_j <- spe[, colData(spe)$sample_id == sample_id]
  
  # Create FeaturePlot for the sample
  plot <- FeaturePlot(spe_j, feature,
                      coordinates = coordinates,
                      platform = "Stereo-seq", ncol = 1,
                      diverging = TRUE,
                      point_size = 0.1, legend_exprs = TRUE) + 
    theme(legend.position = "right",
          legend.key.size = unit(0.5, 'cm')) +
    labs(color = "") + ggtitle(sample_id) 
  
  return(plot)
})

## -----------------------------------------------------------------------------
combined_plot <- wrap_plots(plots, ncol = 3) + 
    # common legend
    plot_layout(guides = 'collect')  
combined_plot

## ----individual cluster test, results = 'hide', message=FALSE-----------------
cluster_results <- individual_dsp(spe,
                                  cluster_col = spatial_cluster,
                                  sample_col = sample_col,
                                  condition_col = condition_col)

## ----visualize results cluster4-----------------------------------------------
class(cluster_results)
names(cluster_results)
cluster_results$`2` |> head(n = 4)

## ----expression plots high_low------------------------------------------------
# one of top DSPs for cluster 2
(feature <- rownames(cluster_results[["2"]])[4])

# Extract the gene_name by matching the gene_id
(feature_name <- rowData(spe)$gene_id[
  rowData(spe)$gene_name == feature
])

## -----------------------------------------------------------------------------
# calculate log cpm
cps <- cpm(results$estimated_y, log = TRUE)
cps_name <- colnames(cps)
mdata <- data.frame(
    log_cpm = cps[feature, ] ,
    Banksy_smooth = factor(sub(".*_", "", cps_name)),
    day = as.numeric(sub("([0-9]+)DPI.*", "\\1", cps_name)),
    sample_id = sub("(_[0-9]+)$", "", cps_name)
)
plt <- ggplot(mdata, aes(x = factor(day), y = log_cpm)) +
    geom_jitter(aes(color = Banksy_smooth), size = 2, width = 0.1) + 
    geom_boxplot(aes(fill = ifelse(Banksy_smooth == "2", 
                                   "cluster 2", "non-cluster 2")), 
                 position = position_dodge(width = 0.8), alpha = 0.5) +
    scale_x_discrete(breaks = c(2, 10, 20)) +  
    scale_fill_manual(values = c("#4DAF4A", "grey")) + 
    labs(title = feature_name, x = "Days post injury", 
         y = "log-2 counts per million (logCPM)", fill = "",
         color = "Banksy cluster") +
     theme(legend.position = "right")

## -----------------------------------------------------------------------------
# figure
plt

## ----echo=TRUE, results='hide', message=FALSE, warning=FALSE------------------
# generate a list of FeaturePlots
plots <- lapply(sample_ids, function(sample_id) {
    # Subset spe for each sample
    spe_j <- spe[, colData(spe)$sample_id == sample_id]
    # Create FeaturePlot for the sample
    plot <- FeaturePlot(spe_j, feature, 
                        cluster_col = spatial_cluster,
                        coordinates = coordinates, cluster = '2',
                        platform = "Stereo-seq",
                        diverging = TRUE,
                        point_size = 0.1,
                        linewidth = 0.6) +
        theme(legend.position = "right",
              legend.key.size = unit(0.5, 'cm')) +
        labs(color = "") + ggtitle(sample_id) 
  
    return(plot)
})
combined_plot <- wrap_plots(plots, ncol = 3) + 
    # common legend
    plot_layout(guides = 'collect')  

## -----------------------------------------------------------------------------
# figure
combined_plot 

## ----smooth spline------------------------------------------------------------
# all combinations of sample and cluster
metadata <- expand.grid(sample_id = levels(spe$sample_id),
                        cluster = levels(spe$Banksy_smooth)
                        ) |>
    # extract time point as 'day' from sample_id 
    mutate(
      day = as.numeric(sub("DPI.*", "", sample_id)),
      rep = as.numeric(sub(".*_", "", sample_id)) 
      )
metadata |> head(n = 3)

## -----------------------------------------------------------------------------
design_model <- model.matrix(~ cluster * ns(day, df = 2), 
                             data = metadata)
rownames(design_model) <- paste0(metadata$sample_id, "_",
                                 metadata$cluster)
dim(design_model)
design_model |> head(n = 3)

## ----DESpace spline global, message=FALSE, results='hide'---------------------
results <- dsp_test(spe,
                    design = design_model,
                    cluster_col = spatial_cluster,
                    sample_col = sample_col,
                    condition_col = condition_col,
                    verbose = TRUE)

## ----res-global---------------------------------------------------------------
# count significant DSP genes (at 5% FDR significance level)
res_global <- results$gene_results
table(res_global$FDR <= 0.05)

## ----DESpace spline individual------------------------------------------------
# example: testing for cluster 2
# convert 5 Banksy clusters into 2 groups: cluster 2 vs. all other clusters
new_cluster <- factor(ifelse(spe$Banksy_smooth %in% '2', '2', 'Other'))
metadata2 <- expand.grid(sample_id = levels(spe$sample_id),
                         cluster = levels(new_cluster)) |>
    # extract time point as 'day' from sample_id 
    mutate(
        day = as.numeric(sub("DPI.*", "", sample_id)),
        rep = as.numeric(sub(".*_", "", sample_id)) 
      )

## -----------------------------------------------------------------------------
# design model for testing the cluster 2
design_model2 <- model.matrix(~ cluster * ns(day, df = 2),
                              data = metadata2)
rownames(design_model2) <- paste0(metadata2$sample_id, "_",
                                  metadata2$cluster)
design_model2 |> head(n = 3)

## ----message=FALSE, results='hide'--------------------------------------------
spe$cluster2 <- new_cluster
results2 <- dsp_test(spe,
                    design = design_model2,
                    cluster_col = "cluster2",
                    sample_col = sample_col,
                    condition_col = condition_col,
                    verbose = TRUE)

## -----------------------------------------------------------------------------
# count significant DSP genes (at 5% FDR significance level)
res_global2 <- results2$gene_results
table(res_global2$FDR <= 0.05)

## -----------------------------------------------------------------------------
# identify the top DSP for cluster 2
(feature <- results2$gene_results$gene_id[5])

# extract the gene_name by matching the gene_id
(feature_name <- rowData(spe)$gene_id[
  rowData(spe)$gene_name %in% feature
])

## -----------------------------------------------------------------------------
fitted_values <- results2[["glmQLFit"]][["fitted.values"]]
m <- melt(fitted_values[feature,]) |>
    rownames_to_column("row_name_column") |>
    setNames(c("sample_id", "fitted")) |>
    mutate(
        day = as.numeric(sub("DPI.*", "", sample_id)),
        cluster = as.factor(sub(".*_", "", sample_id)) 
      )
m |> head(n = 3)


## -----------------------------------------------------------------------------
plt <- ggplot(m, aes(x=day, y=fitted, group=cluster, colour = cluster)) +
    geom_jitter(size = 3, width = 0.2, height = 0) +
    scale_y_sqrt() + 
    labs(title = feature_name) +
    scale_x_continuous(breaks = c(2, 10, 20)) + 
    xlab("Days post injury")

## -----------------------------------------------------------------------------
# figure
plt

## -----------------------------------------------------------------------------
plots <- lapply(sample_ids, function(sample_id) {
    # Subset spe for each sample
    spe_j <- spe[, colData(spe)$sample_id == sample_id]
    # Create FeaturePlot for the sample
    plot <- FeaturePlot(spe_j, feature = feature, 
                        cluster_col = spatial_cluster,
                        coordinates = coordinates, 
                        platform = "Stereo-seq",
                        point_size = 0.001,
                        diverging = TRUE,
                        annotation_cluster = TRUE,
                        annotation_title = sample_id)
  
    return(plot)
})
combined_plot <- wrap_plots(plots, ncol = 2) + 
    # common legend
    plot_layout(guides = 'collect')  

## -----------------------------------------------------------------------------
combined_plot

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

