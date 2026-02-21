# Code example from 'Quick_start' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache = FALSE, eval = FALSE,
                      warning = FALSE, message = TRUE)

## ----eval = FALSE, fig.width = 6, fig.height = 5------------------------------
#  
#  # Loading packages
#  suppressMessages({
#  library(ggplot2)
#  library(flowSpy)
#  library(flowCore)
#  library(stringr)
#  })
#  
#  
#  # Read fcs files
#  fcs.path <- system.file("extdata", package = "flowSpy")
#  fcs.files <- list.files(fcs.path, pattern = '.FCS$', full = TRUE)
#  
#  fcs.data <- runExprsMerge(fcs.files, comp = FALSE, transformMethod = "none")
#  
#  # Refine colnames of fcs data
#  recol <- c(`FITC-A<CD43>` = "CD43", `APC-A<CD34>` = "CD34",
#             `BV421-A<CD90>` = "CD90", `BV510-A<CD45RA>` = "CD45RA",
#             `BV605-A<CD31>` = "CD31", `BV650-A<CD49f>` = "CD49f",
#             `BV 735-A<CD73>` = "CD73", `BV786-A<CD45>` = "CD45",
#             `PE-A<FLK1>` = "FLK1", `PE-Cy7-A<CD38>` = "CD38")
#  colnames(fcs.data)[match(names(recol), colnames(fcs.data))] = recol
#  fcs.data <- fcs.data[, recol]
#  
#  day.list <- c("D0", "D2", "D4", "D6", "D8", "D10")
#  meta.data <- data.frame(cell = rownames(fcs.data),
#                          stage = str_replace(rownames(fcs.data), regex(".FCS.+"), "") )
#  meta.data$stage <- factor(as.character(meta.data$stage), levels = day.list)
#  
#  markers <- c("CD43","CD34","CD90","CD45RA","CD31","CD49f","CD73","CD45","FLK1","CD38")
#  
#  # Build the FSPY object
#  fspy <- createFSPY(raw.data = fcs.data, markers = markers,
#                     meta.data = meta.data,
#                     normalization.method = "log",
#                     verbose = TRUE)
#  
#  # See information
#  fspy

## ----eval = FALSE, fig.width = 6, fig.height = 5------------------------------
#  # Cluster cells by SOM algorithm
#  # Set random seed to make results reproducible
#  set.seed(1)
#  fspy <- runCluster(fspy, cluster.method = "som")
#  
#  # Do not perform downsampling
#  set.seed(1)
#  fspy <- processingCluster(fspy)
#  
#  # run Principal Component Analysis (PCA)
#  fspy <- runFastPCA(fspy)
#  
#  # run t-Distributed Stochastic Neighbor Embedding (tSNE)
#  fspy <- runTSNE(fspy)
#  
#  # run Diffusion map
#  fspy <- runDiffusionMap(fspy)
#  
#  # run Uniform Manifold Approximation and Projection (UMAP)
#  fspy <- runUMAP(fspy)
#  
#  # build minimum spanning tree based on tsne
#  fspy <- buildTree(fspy, dim.type = "tsne", dim.use = 1:2)
#  
#  # DEGs of different branch
#  diff.list <- runDiff(fspy)
#  
#  # define root cells
#  fspy <- defRootCells(fspy, root.cells = c(28,26))
#  
#  # run pseudotime
#  fspy <- runPseudotime(fspy, verbose = TRUE, dim.type = "raw")
#  
#  # define leaf cells
#  fspy <- defLeafCells(fspy, leaf.cells = c(27, 13), verbose = TRUE)
#  
#  # run walk between root cells and leaf cells
#  fspy <- runWalk(fspy, verbose = TRUE)
#  
#  # Save object
#  if (FALSE) {
#    save(fspy, file = "Path to you output directory")
#  }
#  
#  ######################## Visualization
#  
#  # Plot 2D tSNE. And cells are colored by cluster id
#  plot2D(fspy, item.use = c("tSNE_1", "tSNE_2"), color.by = "cluster.id",
#         alpha = 1, main = "tSNE", category = "categorical", show.cluser.id = TRUE)
#  
#  # Plot 2D UMAP. And cells are colored by cluster id
#  plot2D(fspy, item.use = c("UMAP_1", "UMAP_2"), color.by = "cluster.id",
#         alpha = 1, main = "UMAP", category = "categorical", show.cluser.id = TRUE)
#  
#  # Plot 2D tSNE. And cells are colored by cluster id
#  plot2D(fspy, item.use = c("tSNE_1", "tSNE_2"), color.by = "branch.id",
#         alpha = 1, main = "tSNE", category = "categorical", show.cluser.id = TRUE)
#  
#  # Plot 2D UMAP. And cells are colored by cluster id
#  plot2D(fspy, item.use = c("UMAP_1", "UMAP_2"), color.by = "branch.id",
#         alpha = 1, main = "UMAP", category = "categorical", show.cluser.id = TRUE)
#  
#  
#  # Plot 2D tSNE. And cells are colored by stage
#  plot2D(fspy, item.use = c("tSNE_1", "tSNE_2"), color.by = "stage",
#         alpha = 1, main = "UMAP", category = "categorical") +
#     scale_color_manual(values = c("#00599F","#009900","#FF9933",
#                                   "#FF99FF","#7A06A0","#FF3222"))
#  
#  # Plot 2D UMAP. And cells are colored by stage
#  plot2D(fspy, item.use = c("UMAP_1", "UMAP_2"), color.by = "stage",
#         alpha = 1, main = "UMAP", category = "categorical") +
#     scale_color_manual(values = c("#00599F","#009900","#FF9933",
#                                   "#FF99FF","#7A06A0","#FF3222"))
#  
#  # Tree plot
#  plotTree(fspy, color.by = "D0.percent", show.node.name = TRUE, cex.size = 1) +
#    scale_colour_gradientn(colors = c("#00599F", "#EEEEEE", "#FF3222"))
#  
#  plotTree(fspy, color.by = "CD43", show.node.name = TRUE, cex.size = 1) +
#    scale_colour_gradientn(colors = c("#00599F", "#EEEEEE", "#FF3222"))
#  
#  
#  # plot clusters
#  plotCluster(fspy, item.use = c("tSNE_1", "tSNE_2"), category = "numeric",
#              size = 100, color.by = "CD45RA") +
#    scale_colour_gradientn(colors = c("#00599F", "#EEEEEE", "#FF3222"))
#  
#  # plot pie tree
#  plotPieTree(fspy, cex.size = 3, size.by.cell.number = TRUE) +
#    scale_fill_manual(values = c("#00599F","#FF3222","#009900",
#                                 "#FF9933","#FF99FF","#7A06A0"))
#  
#  # plot pie cluster
#  plotPieCluster(fspy, item.use = c("tSNE_1", "tSNE_2"), cex.size = 40) +
#    scale_fill_manual(values = c("#00599F","#FF3222","#009900",
#                                 "#FF9933","#FF99FF","#7A06A0"))
#  
#  # plot heatmap of cluster
#  plotClusterHeatmap(fspy)
#  plotBranchHeatmap(fspy)
#  
#  # Violin plot
#  plotViolin(fspy, color.by = "cluster.id", marker = "CD45RA", text.angle = 90)
#  plotViolin(fspy, color.by = "branch.id", marker = "CD45RA", text.angle = 90)
#  
#  # UMAP plot colored by pseudotime
#  plot2D(fspy, item.use = c("UMAP_1", "UMAP_2"), category = "numeric",
#              size = 1, color.by = "pseudotime") +
#    scale_colour_gradientn(colors = c("#F4D31D", "#FF3222","#7A06A0"))
#  
#  # tSNE plot colored by pseudotime
#  plot2D(fspy, item.use = c("tSNE_1", "tSNE_2"), category = "numeric",
#              size = 1, color.by = "pseudotime") +
#   scale_colour_gradientn(colors = c("#F4D31D", "#FF3222","#7A06A0"))
#  
#  # denisty plot by different stage
#  plotPseudotimeDensity(fspy, adjust = 1) +
#    scale_color_manual(values = c("#00599F","#009900","#FF9933",
#                                  "#FF99FF","#7A06A0","#FF3222"))
#  # Tree plot
#  plotTree(fspy, color.by = "pseudotime", cex.size = 1.5) +
#   scale_colour_gradientn(colors = c("#F4D31D", "#FF3222","#7A06A0"))
#  
#  plotViolin(fspy, color.by = "cluster.id", order.by = "pseudotime",
#             marker = "CD49f", text.angle = 90)
#  
#  # trajectory value
#  plotPseudotimeTraj(fspy, var.cols = TRUE) +
#   scale_colour_gradientn(colors = c("#F4D31D", "#FF3222","#7A06A0"))
#  
#  plotPseudotimeTraj(fspy, cutoff = 0.05, var.cols = TRUE) +
#   scale_colour_gradientn(colors = c("#F4D31D", "#FF3222","#7A06A0"))
#  
#  plotHeatmap(fspy, downsize = 1000, cluster_rows = TRUE, clustering_method = "ward.D",
#              color = colorRampPalette(c("#00599F","#EEEEEE","#FF3222"))(100))
#  
#  # plot cluster
#  plotCluster(fspy, item.use = c("tSNE_1", "tSNE_2"), color.by = "traj.value.log",
#              size = 10, show.cluser.id = TRUE, category = "numeric") +
#   scale_colour_gradientn(colors = c("#EEEEEE", "#FF3222", "#CC0000", "#CC0000"))
#  
#  # Show session information
#  sessionInfo()
#  

