# Code example from 'pw_sc' vignette. See references/ for full tutorial.

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

## ----"progeny", message=FALSE-----------------------------------------------------------------------------------------
net <- get_progeny(organism = 'human', top = 500)
net

## ----"mlm", message=FALSE---------------------------------------------------------------------------------------------
# Extract the normalized log-transformed counts
mat <- as.matrix(data@assays$RNA@data)

# Run mlm
acts <- run_mlm(mat=mat, net=net, .source='source', .target='target',
                .mor='weight', minsize = 5)
acts

## ----"new_assay", message=FALSE---------------------------------------------------------------------------------------
# Extract mlm and store it in pathwaysmlm in data
data[['pathwaysmlm']] <- acts %>%
  pivot_wider(id_cols = 'source', names_from = 'condition',
              values_from = 'score') %>%
  column_to_rownames('source') %>%
  Seurat::CreateAssayObject(.)

# Change assay
DefaultAssay(object = data) <- "pathwaysmlm"

# Scale the data
data <- ScaleData(data)
data@assays$pathwaysmlm@data <- data@assays$pathwaysmlm@scale.data

## ----"projected_acts", message = FALSE, warning = FALSE, fig.width = 8, fig.height = 4--------------------------------
p1 <- DimPlot(data, reduction = "umap", label = TRUE, pt.size = 0.5) + 
  NoLegend() + ggtitle('Cell types')
p2 <- (FeaturePlot(data, features = c("Trail")) & 
  scale_colour_gradient2(low = 'blue', mid = 'white', high = 'red')) +
  ggtitle('Trail activity')
p1 | p2

## ----"mean_acts", message = FALSE, warning = FALSE--------------------------------------------------------------------
# Extract activities from object as a long dataframe
df <- t(as.matrix(data@assays$pathwaysmlm@data)) %>%
  as.data.frame() %>%
  mutate(cluster = Idents(data)) %>%
  pivot_longer(cols = -cluster, names_to = "source", values_to = "score") %>%
  group_by(cluster, source) %>%
  summarise(mean = mean(score))

# Transform to wide matrix
top_acts_mat <- df %>%
  pivot_wider(id_cols = 'cluster', names_from = 'source',
              values_from = 'mean') %>%
  column_to_rownames('cluster') %>%
  as.matrix()

# Choose color palette
palette_length = 100
my_color = colorRampPalette(c("Darkblue", "white","red"))(palette_length)

my_breaks <- c(seq(-2, 0, length.out=ceiling(palette_length/2) + 1),
               seq(0.05, 2, length.out=floor(palette_length/2)))

# Plot
pheatmap(top_acts_mat, border_color = NA, color=my_color, breaks = my_breaks) 

## ----session_info, echo=FALSE-----------------------------------------------------------------------------------------
options(width = 120)
sessioninfo::session_info()

