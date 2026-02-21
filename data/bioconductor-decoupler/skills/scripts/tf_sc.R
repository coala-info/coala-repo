# Code example from 'tf_sc' vignette. See references/ for full tutorial.

## ----setup, include=FALSE---------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----"load packages", message = FALSE---------------------------------------------------------------------------------
## We load the required packages
library(Seurat)
library(decoupleR)

# Only needed for data handling and plotting
library(dplyr)
library(tibble)
library(tidyr)
library(patchwork)
library(ggplot2)
library(pheatmap)

## ----"load data"------------------------------------------------------------------------------------------------------
inputs_dir <- system.file("extdata", package = "decoupleR")
data <- readRDS(file.path(inputs_dir, "sc_data.rds"))

## ----"umap", message = FALSE, warning = FALSE-------------------------------------------------------------------------
DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) + NoLegend()

## ----"collectri"------------------------------------------------------------------------------------------------------
net <- get_collectri(organism='human', split_complexes=FALSE)
net

## ----"ulm", message=FALSE---------------------------------------------------------------------------------------------
# Extract the normalized log-transformed counts
mat <- as.matrix(data@assays$RNA@data)

# Run ulm
acts <- run_ulm(mat=mat, net=net, .source='source', .target='target',
                .mor='mor', minsize = 5)
acts

## ----"new_assay", message=FALSE---------------------------------------------------------------------------------------
# Extract ulm and store it in tfsulm in pbmc
data[['tfsulm']] <- acts %>%
  pivot_wider(id_cols = 'source', names_from = 'condition',
              values_from = 'score') %>%
  column_to_rownames('source') %>%
  Seurat::CreateAssayObject(.)

# Change assay
DefaultAssay(object = data) <- "tfsulm"

# Scale the data
data <- ScaleData(data)
data@assays$tfsulm@data <- data@assays$tfsulm@scale.data

## ----"projected_acts", message = FALSE, warning = FALSE, fig.width = 12, fig.height = 4-------------------------------
p1 <- DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) + 
  NoLegend() + ggtitle('Cell types')
p2 <- (FeaturePlot(data, features = c("PAX5")) & 
  scale_colour_gradient2(low = 'blue', mid = 'white', high = 'red')) +
  ggtitle('PAX5 activity')
DefaultAssay(object = data) <- "RNA"
p3 <- FeaturePlot(data, features = c("PAX5")) + ggtitle('PAX5 expression')
DefaultAssay(object = data) <- "tfsulm"
p1 | p2 | p3

## ----"mean_acts", message = FALSE, warning = FALSE--------------------------------------------------------------------
n_tfs <- 25
# Extract activities from object as a long dataframe
df <- t(as.matrix(data@assays$tfsulm@data)) %>%
  as.data.frame() %>%
  mutate(cluster = Idents(data)) %>%
  pivot_longer(cols = -cluster, names_to = "source", values_to = "score") %>%
  group_by(cluster, source) %>%
  summarise(mean = mean(score))

# Get top tfs with more variable means across clusters
tfs <- df %>%
  group_by(source) %>%
  summarise(std = sd(mean)) %>%
  arrange(-abs(std)) %>%
  head(n_tfs) %>%
  pull(source)

# Subset long data frame to top tfs and transform to wide matrix
top_acts_mat <- df %>%
  filter(source %in% tfs) %>%
  pivot_wider(id_cols = 'cluster', names_from = 'source',
              values_from = 'mean') %>%
  column_to_rownames('cluster') %>%
  as.matrix()

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-3, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 3, length.out=floor(palette_length/2)))

# Plot
pheatmap(top_acts_mat, border_color = NA, color=my_color, breaks = my_breaks) 

## ----session_info, echo=FALSE-----------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

