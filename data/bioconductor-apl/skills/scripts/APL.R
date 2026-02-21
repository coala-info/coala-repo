# Code example from 'APL' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE, comment = "#>", results = "hold")

## ----bioc_install, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# BiocManager::install("APL")

## ----git_install, eval=FALSE--------------------------------------------------
# library(devtools)
# install_github("VingronLab/APL")

## ----git_vignette, eval=FALSE-------------------------------------------------
# install_github("VingronLab/APL", build_vignettes = TRUE, dependencies = TRUE)

## ----setup, message=FALSE, warning=FALSE--------------------------------------
library(APL)
library(scRNAseq)
library(SingleCellExperiment)
library(scran)
library(scater)
set.seed(1234)

## ----load_data----------------------------------------------------------------
darmanis <- DarmanisBrainData()
darmanis

## ----preprocess---------------------------------------------------------------
set.seed(100)
clust <- quickCluster(darmanis)
darmanis <- computeSumFactors(darmanis, cluster = clust, min.mean = 0.1)
darmanis <- logNormCounts(darmanis)

dec <- modelGeneVar(darmanis)
top_darmanis <- getTopHVGs(dec, n = 5000)
darmanis <- fixedPCA(darmanis, subset.row = top_darmanis)
darmanis <- runUMAP(darmanis, dimred = "PCA")

plotReducedDim(darmanis, dimred = "UMAP", colour_by = "cell.type")

## ----runAPL-------------------------------------------------------------------
runAPL(
  darmanis,
  assay = "logcounts",
  top = 5000,
  group = which(darmanis$cell.type == "oligodendrocytes"),
  type = "ggplot"
)

## ----cacomp-------------------------------------------------------------------
# Computing CA on logcounts
logcounts <- logcounts(darmanis)
ca <- cacomp(
  obj = logcounts,
  top = 5000
)

# The above is equivalent to:
# ca <- cacomp(obj = darmanis,
#              assay = "logcounts",
#              top = 5000)

## ----print_cacomp-------------------------------------------------------------
ca

## ----std_coords---------------------------------------------------------------
cacomp_slot(ca, "std_coords_cols")[1:5, 1:5]

## ----ca_pbmc------------------------------------------------------------------
darmanis <- cacomp(
  obj = darmanis,
  assay = "logcounts",
  top = 5000,
  return_input = TRUE
)

plotReducedDim(darmanis,
  dimred = "CA",
  ncomponents = c(1, 2),
  colour_by = "cell.type"
)
plotReducedDim(darmanis,
  dimred = "CA",
  ncomponents = c(3, 4),
  colour_by = "cell.type"
)

## ----convert------------------------------------------------------------------
# Converting the object darmanis to cacomp
ca <- as.cacomp(darmanis)

## ----scree_plot---------------------------------------------------------------
pick_dims(ca, method = "scree_plot") +
  xlim(c(0, 20))

## ----pick_dims, results = "hide"----------------------------------------------
pd <- pick_dims(
  ca,
  mat = logcounts(darmanis),
  method = "elbow_rule",
  reps = 3
)

## ----show_dims, message=FALSE-------------------------------------------------
pd

## ----expl_inert---------------------------------------------------------------
# Compute the amount of inertia explained by each of the dimensions
D <- cacomp_slot(ca, "D")
expl_inertia <- (D^2 / sum(D^2)) * 100

# Compute the amount of intertia explained
# by the number of dimensions defined by elbow rule
sum(expl_inertia[seq_len(pd)])

## ----subset_dims--------------------------------------------------------------
ca <- subset_dims(ca, dims = pd)

## ----apl_platelets------------------------------------------------------------
# Specifying a cell cluster of interest
endo <- which(darmanis$cell.type == "endothelial")

# Calculate Association Plot coordinates for endothelial cells
ca <- apl_coords(ca, group = endo)

## ----apl_platelets_plot, fig.wide = TRUE--------------------------------------
# endothelial marker genes
marker_genes <- c("APOLD1", "TM4SF1", "SULT1B1", "ESM1", "SELE")

# Plot APL
apl(ca,
  row_labs = TRUE,
  rows_idx = marker_genes,
  type = "ggplot"
) # type = "plotly" for an interactive plot

## ----apl_score, results = "hide"----------------------------------------------
# Compute S-alpha score
# For the calculation the input matrix is also required.
ca <- apl_score(ca,
  mat = logcounts(darmanis),
  reps = 5
)

## ----apl_plot_platelets, fig.wide = TRUE--------------------------------------
apl(ca,
  show_score = TRUE,
  type = "ggplot"
)

## ----print_score--------------------------------------------------------------
head(cacomp_slot(ca, "APL_score"))

## ----seurat_apl, fig.wide = TRUE----------------------------------------------
scores <- cacomp_slot(ca, "APL_score")

plotExpression(darmanis,
  features = head(scores$Rowname, 3),
  x = "cell.type",
  colour_by = "cell.type"
)

plotReducedDim(darmanis,
  dimred = "UMAP",
  colour_by = scores$Rowname[1]
)

## ----biplot, fig.wide = TRUE--------------------------------------------------
# Specifying a cell cluster of interest
endo <- which(darmanis$cell.type == "endothelial")

# Creating a static plot
ca_biplot(ca, col_labels = endo, type = "ggplot")

# Creating an interactive plot
# ca_biplot(ca, type = "plotly", col_labels = platelets)

# 3D plot
# ca_3Dplot(ca, col_labels = platelets)

## ----cluster_three, results="hide"--------------------------------------------
# Get indices of microglia cells
microglia <- which(darmanis$cell.type == "microglia")

# Calculate Association Plot coordinates of the genes and the $S_\alpha$-scores
ca <- apl_coords(ca, group = microglia)

ca <- apl_score(ca,
  mat = logcounts(darmanis),
  reps = 5
)

## ----topGO, message=FALSE-----------------------------------------------------
enr <- apl_topGO(ca,
  ontology = "BP",
  organism = "hs",
  score_cutoff = 1
)
head(enr)

## ----topGO_plot, message=FALSE------------------------------------------------
plot_enrichment(enr)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

