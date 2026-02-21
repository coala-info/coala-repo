# Code example from 'Examples_and_use_cases' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(HDCytoData))
suppressPackageStartupMessages(library(SummarizedExperiment))
suppressPackageStartupMessages(library(Rtsne))
suppressPackageStartupMessages(library(umap))
suppressPackageStartupMessages(library(ggplot2))

## -----------------------------------------------------------------------------
# ---------
# Load data
# ---------

d_SE <- Levine_32dim_SE()

## -----------------------------------------------------------------------------
# -------------
# Preprocessing
# -------------

# select 'cell type' marker columns for defining clusters
d_sub <- assay(d_SE[, colData(d_SE)$marker_class == "type"])

# extract cell population labels
population <- rowData(d_SE)$population_id

dim(d_sub)
stopifnot(nrow(d_sub) == length(population))

# transform data using asinh with cofactor 5
cofactor <- 5
d_sub <- asinh(d_sub / cofactor)

summary(d_sub)

# subsample cells for faster runtimes in vignette
n <- 2000

set.seed(123)
ix <- sample(seq_len(nrow(d_sub)), n)

d_sub <- d_sub[ix, ]
population <- population[ix]

dim(d_sub)
stopifnot(nrow(d_sub) == length(population))

# remove any near-duplicate rows (required by Rtsne)
dups <- duplicated(d_sub)
d_sub <- d_sub[!dups, ]
population <- population[!dups]

dim(d_sub)
stopifnot(nrow(d_sub) == length(population))

## ----fig.width = 6------------------------------------------------------------
# ------------------------
# Dimension reduction: PCA
# ------------------------

n_dims <- 2

# run PCA
# (note: no scaling, since asinh-transformed dimensions are already comparable)
out_PCA <- prcomp(d_sub, center = TRUE, scale. = FALSE)
dims_PCA <- out_PCA$x[, seq_len(n_dims)]
colnames(dims_PCA) <- c("PC_1", "PC_2")
head(dims_PCA)

stopifnot(nrow(dims_PCA) == length(population))

colnames(dims_PCA) <- c("dimension_x", "dimension_y")
dims_PCA <- cbind(as.data.frame(dims_PCA), population, type = "PCA")

head(dims_PCA)
str(dims_PCA)


# generate plot
d_plot <- dims_PCA
str(d_plot)

colors <- c(rainbow(14), "gray75")

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) + 
  facet_wrap(~ type, scales = "free") + 
  geom_point(size = 0.7, alpha = 0.5) + 
  scale_color_manual(values = colors) + 
  labs(x = "dimension x", y = "dimension y") + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        legend.key.height = unit(4, "mm"))

## ----fig.width = 6------------------------------------------------------------
# -------------------------
# Dimension reduction: tSNE
# -------------------------

# run Rtsne
set.seed(123)
out_Rtsne <- Rtsne(as.matrix(d_sub), dims = n_dims)
dims_Rtsne <- out_Rtsne$Y
colnames(dims_Rtsne) <- c("tSNE_1", "tSNE_2")
head(dims_Rtsne)

stopifnot(nrow(dims_Rtsne) == length(population))

colnames(dims_Rtsne) <- c("dimension_x", "dimension_y")
dims_Rtsne <- cbind(as.data.frame(dims_Rtsne), population, type = "tSNE")

head(dims_Rtsne)
str(dims_Rtsne)


# generate plot
d_plot <- dims_Rtsne

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) + 
  facet_wrap(~ type, scales = "free") + 
  geom_point(size = 0.7, alpha = 0.5) + 
  scale_color_manual(values = colors) + 
  labs(x = "dimension x", y = "dimension y") + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        legend.key.height = unit(4, "mm"))

## ----fig.width = 6------------------------------------------------------------
# -------------------------
# Dimension reduction: UMAP
# -------------------------

# run umap
set.seed(123)
out_umap <- umap(d_sub)
dims_umap <- out_umap$layout
colnames(dims_umap) <- c("UMAP_1", "UMAP_2")
head(dims_umap)

stopifnot(nrow(dims_umap) == length(population))

colnames(dims_umap) <- c("dimension_x", "dimension_y")
dims_umap <- cbind(as.data.frame(dims_umap), population, type = "UMAP")

head(dims_umap)
str(dims_umap)


# generate plot
d_plot <- dims_umap

ggplot(d_plot, aes(x = dimension_x, y = dimension_y, color = population)) + 
  facet_wrap(~ type, scales = "free") + 
  geom_point(size = 0.7, alpha = 0.5) + 
  scale_color_manual(values = colors) + 
  labs(x = "dimension x", y = "dimension y") + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        legend.key.height = unit(4, "mm"))

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(HDCytoData))
suppressPackageStartupMessages(library(FlowSOM))
suppressPackageStartupMessages(library(flowCore))
suppressPackageStartupMessages(library(mclust))
suppressPackageStartupMessages(library(umap))
suppressPackageStartupMessages(library(ggplot2))

## -----------------------------------------------------------------------------
# ---------
# Load data
# ---------

d_SE <- Samusik_01_SE()

dim(d_SE)

## -----------------------------------------------------------------------------
# -------------
# Preprocessing
# -------------

# select 'cell type' marker columns for defining clusters
d_sub <- assay(d_SE[, colData(d_SE)$marker_class == "type"])

# extract cell population labels
population <- rowData(d_SE)$population_id

dim(d_sub)
stopifnot(nrow(d_sub) == length(population))

# transform data using asinh with cofactor 5
cofactor <- 5
d_sub <- asinh(d_sub / cofactor)

# create flowFrame object (required input format for FlowSOM)
d_FlowSOM <- flowFrame(d_sub)

## -----------------------------------------------------------------------------
# -----------
# Run FlowSOM
# -----------

# set seed for reproducibility
set.seed(123)

# run FlowSOM (initial steps prior to meta-clustering)
out <- ReadInput(d_FlowSOM, transform = FALSE, scale = FALSE)
out <- BuildSOM(out)
out <- BuildMST(out)

# optional FlowSOM visualization
#PlotStars(out)

# extract cluster labels (pre meta-clustering) from output object
labels_pre <- out$map$mapping[, 1]

# specify final number of clusters for meta-clustering
k <- 40

# run meta-clustering
seed <- 123
out <- metaClustering_consensus(out$map$codes, k = k, seed = seed)

# extract cluster labels from output object
labels <- out[labels_pre]

# summary of cluster sizes and number of clusters
table(labels)
length(table(labels))

## -----------------------------------------------------------------------------
# -------------------------------
# Evaluate clustering performance
# -------------------------------

# calculate adjusted Rand index
# note: this calculation weights all cells equally, which may not be 
# appropriate for some datasets (see above)

stopifnot(nrow(d_sub) == length(labels))
stopifnot(length(population) == length(labels))

# remove "unassigned" cells from cluster evaluation (but note these were
# included for clustering)
ix_unassigned <- population == "unassigned"
d_sub_eval <- d_sub[!ix_unassigned, ]
population_eval <- population[!ix_unassigned]
labels_eval <- labels[!ix_unassigned]

stopifnot(nrow(d_sub_eval) == length(labels_eval))
stopifnot(length(population_eval) == length(labels_eval))

# calculate adjusted Rand index
adjustedRandIndex(population_eval, labels_eval)

## ----fig.width = 7------------------------------------------------------------
# ------------
# Plot results
# ------------

# subsample cells for faster runtimes in vignette
n <- 4000

set.seed(1004)
ix <- sample(seq_len(nrow(d_sub)), n)

d_sub <- d_sub[ix, ]
population <- population[ix]
labels <- labels[ix]

dim(d_sub)
stopifnot(nrow(d_sub) == length(population))
stopifnot(nrow(population) == length(labels))


# run umap
set.seed(1234)
out_umap <- umap(d_sub)
dims_umap <- out_umap$layout
colnames(dims_umap) <- c("UMAP_1", "UMAP_2")

stopifnot(nrow(dims_umap) == length(population))
stopifnot(nrow(population) == length(labels))

d_plot <- cbind(
  as.data.frame(dims_umap), 
  population, 
  labels = as.factor(labels), 
  type = "UMAP"
)


# generate plots
colors <- c(rainbow(24), "gray75")

ggplot(d_plot, aes(x = UMAP_1, y = UMAP_2, color = population)) + 
  geom_point(size = 0.7, alpha = 0.5) + 
  scale_color_manual(values = colors) + 
  ggtitle("Ground truth population labels") + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        legend.key.height = unit(4, "mm"))

ggplot(d_plot, aes(x = UMAP_1, y = UMAP_2, color = labels)) + 
  geom_point(size = 0.7, alpha = 0.5) + 
  ggtitle("FlowSOM cluster labels") + 
  theme_bw() + 
  theme(aspect.ratio = 1, 
        legend.key.height = unit(4, "mm"))

## -----------------------------------------------------------------------------
# suppressPackageStartupMessages(library(diffcyt))
suppressPackageStartupMessages(library(SummarizedExperiment))

## -----------------------------------------------------------------------------
# ---------
# Load data
# ---------

d_SE <- Weber_AML_sim_main_5pc_SE()

## -----------------------------------------------------------------------------
# ---------------
# Set up metadata
# ---------------

# set column names
colnames(d_SE) <- colData(d_SE)$marker_name

# split input data into one matrix per sample
d_input <- split(as.data.frame(assay(d_SE)), rowData(d_SE)$sample_id)

# extract sample information
experiment_info <- metadata(d_SE)$experiment_info
experiment_info

# extract marker information
marker_info <- colData(d_SE)
marker_info

## -----------------------------------------------------------------------------
# # -----------------------------------
# # Differential abundance (DA) testing
# # -----------------------------------
# 
# # create design matrix
# design <- createDesignMatrix(
#   experiment_info, cols_design = c("group_id", "patient_id")
# )
# design
# 
# # create contrast matrix
# # note: testing condition CN vs. healthy
# contrast <- createContrast(c(0, 1, 0, 0, 0, 0, 0))
# contrast
# 
# # test for differential abundance (DA) of clusters
# out_DA <- diffcyt(
#   d_input, 
#   experiment_info, 
#   marker_info, 
#   design = design, 
#   contrast = contrast, 
#   analysis_type = "DA", 
#   seed_clustering = 1234
# )
# 
# # display results for top DA clusters
# topTable(out_DA, format_vals = TRUE)

## -----------------------------------------------------------------------------
# ---------
# Load data
# ---------

d_SE <- Weber_BCR_XL_sim_main_SE()

## -----------------------------------------------------------------------------
# ---------------
# Set up metadata
# ---------------

# set column names
colnames(d_SE) <- colData(d_SE)$marker_name

# split input data into one matrix per sample
d_input <- split(as.data.frame(assay(d_SE)), rowData(d_SE)$sample_id)

# extract sample information
experiment_info <- metadata(d_SE)$experiment_info
experiment_info

# extract marker information
marker_info <- colData(d_SE)
marker_info

## -----------------------------------------------------------------------------
# # -------------------------------
# # Differential state (DS) testing
# # -------------------------------
# 
# # create design matrix
# design <- createDesignMatrix(
#   experiment_info, cols_design = c("group_id", "patient_id")
# )
# design
# 
# # create contrast matrix
# # note: testing condition spike vs. base
# contrast <- createContrast(c(0, 1, 0, 0, 0, 0, 0, 0, 0))
# contrast
# 
# # test for differential abundance (DA) of clusters
# out_DS <- diffcyt(
#   d_input, 
#   experiment_info, 
#   marker_info, 
#   design = design, 
#   contrast = contrast, 
#   analysis_type = "DS", 
#   seed_clustering = 1234
# )
# 
# # display results for top DA clusters
# topTable(out_DS, format_vals = TRUE)

