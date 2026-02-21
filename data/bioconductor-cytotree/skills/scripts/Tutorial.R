# Code example from 'Tutorial' vignette. See references/ for full tutorial.

## ----echo = TRUE--------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, eval = TRUE,
                      warning = TRUE, message = TRUE,
                      fig.width = 6, fig.height = 5)

## ----eval = FALSE-------------------------------------------------------------
#  
#  # If not already installed
#  install.packages("devtools")
#  devtools::install_github("JhuangLab/CytoTree")
#  
#  library(CytoTree)
#  

## ----eval = FALSE-------------------------------------------------------------
#  
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  
#  BiocManager::install("CytoTree")
#  

## ----eval = TRUE--------------------------------------------------------------

# Loading packages
suppressMessages({
library(CytoTree)
})

# Read fcs files
fcs.path <- system.file("extdata", package = "CytoTree")
fcs.files <- list.files(fcs.path, pattern = '.FCS$', full = TRUE)

# Using runExprsMerge for multip FCS files
# Or using runExprsExtract for one single FCS file
fcs.data <- runExprsMerge(fcs.files, comp = FALSE, transformMethod = "none")

# Build the CYT object
cyt <- createCYT(raw.data = fcs.data, normalization.method = "log")

# See information
cyt

################################################
##### Running CytoTree in one line code
################################################

# Run without dimensionality reduction steps
# Run CytoTree as pipeline and visualize as tree
cyt <- cyt %>% runCluster() %>% processingCluster() %>% buildTree()
plotTree(cyt)

# Or you can run with dimensionality reduction steps
# Run CytoTree as pipeline and visualize as tree
cyt <- cyt %>% runCluster() %>% processingCluster() %>% 
  runFastPCA() %>% runTSNE() %>%  runDiffusionMap() %>% runUMAP() %>% 
  buildTree()
plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"))


## ----eval = TRUE--------------------------------------------------------------

# Cluster cells by SOM algorithm
set.seed(1)
cyt <- runCluster(cyt)

# Processing Clusters
cyt <- processingCluster(cyt)

# This is an optional step
# run Principal Component Analysis (PCA)
cyt <- runFastPCA(cyt)

# This is an optional step
# run t-Distributed Stochastic Neighbor Embedding (tSNE)
cyt <- runTSNE(cyt)

# This is an optional step
# run Diffusion map
cyt <- runDiffusionMap(cyt)

# This is an optional step
# run Uniform Manifold Approximation and Projection (UMAP)
cyt <- runUMAP(cyt)

# build minimum spanning tree
cyt <- buildTree(cyt)

# DEGs of different branch
diff.list <- runDiff(cyt)

# define root cells
cyt <- defRootCells(cyt, root.cells = c(32,26))

# run pseudotime
cyt <- runPseudotime(cyt)

# define leaf cells
cyt <- defLeafCells(cyt, leaf.cells = c(30))

# run walk between root cells and leaf cells
cyt <- runWalk(cyt)

# Save object
if (FALSE) {
  saveRDS(cyt, file = "Path to you output directory")
}


## ----eval = TRUE, out.width='50%', fig.asp=.75, fig.align='center'------------


# Plot 2D tSNE. And cells are colored by cluster id
plot2D(cyt, item.use = c("tSNE_1", "tSNE_2"), color.by = "cluster.id", 
       alpha = 1, main = "tSNE", category = "categorical", show.cluser.id = TRUE)

# Plot 2D UMAP. And cells are colored by cluster id
plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"), color.by = "cluster.id", 
       alpha = 1, main = "UMAP", category = "categorical", show.cluser.id = TRUE)

# Plot 2D tSNE. And cells are colored by cluster id
plot2D(cyt, item.use = c("tSNE_1", "tSNE_2"), color.by = "branch.id", 
       alpha = 1, main = "tSNE", category = "categorical", show.cluser.id = TRUE)

# Plot 2D UMAP. And cells are colored by cluster id
plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"), color.by = "branch.id", 
       alpha = 1, main = "UMAP", category = "categorical", show.cluser.id = TRUE)

# Plot 2D tSNE. And cells are colored by stage
plot2D(cyt, item.use = c("tSNE_1", "tSNE_2"), color.by = "stage", 
       alpha = 1, main = "UMAP", category = "categorical")

# Plot 2D UMAP. And cells are colored by stage
plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"), color.by = "stage", 
       alpha = 1, main = "UMAP", category = "categorical")

# Tree plot
plotTree(cyt, color.by = "D0.percent", show.node.name = TRUE, cex.size = 1)

# Tree plot
plotTree(cyt, color.by = "FITC-A<CD43>", show.node.name = TRUE, cex.size = 1) 


# plot clusters
plotCluster(cyt, item.use = c("tSNE_1", "tSNE_2"), category = "numeric",
            size = 100, color.by = "BV510-A<CD45RA>") 

# plot pie tree
plotPieTree(cyt, cex.size = 3, size.by.cell.number = TRUE)

# plot pie cluster
plotPieCluster(cyt, item.use = c("tSNE_1", "tSNE_2"), cex.size = 40) 

# plot heatmap of clusters
plotClusterHeatmap(cyt)

# plot heatmap of branches
plotBranchHeatmap(cyt)

# Violin plot
plotViolin(cyt, color.by = "cluster.id", marker = "BV510-A<CD45RA>", text.angle = 90)

# Violin plot
plotViolin(cyt, color.by = "branch.id", marker = "BV510-A<CD45RA>", text.angle = 90)

# UMAP plot colored by pseudotime
plot2D(cyt, item.use = c("UMAP_1", "UMAP_2"), category = "numeric",
            size = 1, color.by = "pseudotime")

# tSNE plot colored by pseudotime
plot2D(cyt, item.use = c("tSNE_1", "tSNE_2"), category = "numeric",
            size = 1, color.by = "pseudotime") 

# denisty plot by different stage
plotPseudotimeDensity(cyt, adjust = 1) 
# Tree plot
plotTree(cyt, color.by = "pseudotime", cex.size = 1.5) 

# Violin plot
plotViolin(cyt, color.by = "cluster.id", order.by = "pseudotime",
           marker = "BV650-A<CD49f>", text.angle = 90)

# trajectory value
plotPseudotimeTraj(cyt, var.cols = TRUE)

# Heatmap plot
plotHeatmap(cyt, downsize = 1000, cluster_rows = TRUE, clustering_method = "ward.D",
            color = colorRampPalette(c("#00599F","#EEEEEE","#FF3222"))(100))

# plot cluster
plotCluster(cyt, item.use = c("tSNE_1", "tSNE_2"), color.by = "traj.value.log", 
            size = 10, show.cluser.id = TRUE, category = "numeric") 



