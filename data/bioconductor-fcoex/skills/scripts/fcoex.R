# Code example from 'fcoex' vignette. See references/ for full tutorial.

## ----Loading datasets, message=FALSE-------------------------------------
library(fcoex, quietly = TRUE)
library(SingleCellExperiment, quietly = TRUE)
data("mini_pbmc3k")

cat("This is the single cell object we will explore:")
mini_pbmc3k

## ----Creating fcoex object, message=FALSE--------------------------------
target <- colData(mini_pbmc3k)
target <- target$clusters
exprs <- as.data.frame(assay(mini_pbmc3k, 'logcounts'))

fc <- new_fcoex(data.frame(exprs),target)


## ----Discretizing dataset, message=FALSE---------------------------------

fc <- discretize(fc, number_of_bins = 8)

## ----Finding cbf modules, message=FALSE----------------------------------
fc <- find_cbf_modules(fc,n_genes = 200, verbose = FALSE, is_parallel = FALSE)

## ----Plotting module networks, message=FALSE-----------------------------
fc <- get_nets(fc)

# Taking a look at the first two networks: 
show_net(fc)[["CD79A"]]
show_net(fc)[["HLA-DRB1"]]

## ----Saving plots, eval= FALSE, message=FALSE, results='hide'------------
#  save_plots(name = "fcoex_vignette", fc,force = TRUE, , directory = "./Plots")

## ----Running ORA analysis, warning=FALSE---------------------------------
gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- pathwayPCA::read_gmt(gmt_fname)
fc <- mod_ora(fc, gmt_in)
fc <- plot_ora(fc)

## ----Saving plots again,  eval= FALSE, message=FALSE, results='hide'-----
#  save_plots(name = "fcoex_vignette", fc, force = TRUE, directory = "./Plots")

## ----Reclustering , message=FALSE----------------------------------------

fc <- recluster(fc)


## ----Visualizing---------------------------------------------------------

colData(mini_pbmc3k) <- cbind(colData(mini_pbmc3k), `mod_HLA-DRB1` = idents(fc)$`HLA-DRB1`)
colData(mini_pbmc3k) <- cbind(colData(mini_pbmc3k), mod_CD79A = idents(fc)$CD79A)

library(scater)
# Let's see the original clusters
plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="clusters")

library(gridExtra)
p1 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="mod_HLA-DRB1")
p2 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="HLA-DRB1")
p3 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="mod_CD79A")
p4 <- plotReducedDim(mini_pbmc3k, dimred="UMAP", colour_by="CD79A")

grid.arrange(p1, p2, p3, p4, nrow=2)

## ----Running Seurat pipeline, warning=FALSE------------------------------
library(Seurat)
library(fcoex)
library(ggplot2)
data(pbmc_small)

exprs <- data.frame(GetAssayData(pbmc_small))
target <- Idents(pbmc_small)

fc <- new_fcoex(data.frame(exprs),target)
fc <- discretize(fc)
fc <- find_cbf_modules(fc,n_genes = 70, verbose = FALSE, is_parallel = FALSE)
fc <- get_nets(fc)

gmt_fname <- system.file("extdata", "pathways.gmt", package = "CEMiTool")
gmt_in <- pathwayPCA::read_gmt(gmt_fname)
fc <- mod_ora(fc, gmt_in)

# In Seurat's sample data, pbmc small, no enrichments are found. 
# That is way plot_ora is commented out.

#fc <- plot_ora(fc)

## ----Saving Seurat plots, eval = FALSE-----------------------------------
#  save_plots(name = "fcoex_vignette_Seurat", fc, force = TRUE, directory = "./Plots")

## ----Plotting and saving reclusters,  eval = FALSE-----------------------
#  
#  fc <- recluster(fc)
#  
#  file_name <- "pbmc3k_recluster_plots.pdf"
#  directory <- "./Plots/"
#  
#  pbmc_small <- RunUMAP(pbmc_small, dims = 1:10)
#  
#  pdf(paste0(directory,file_name), width = 3, height = 3)
#  
#  print(DimPlot(pbmc_small))
#  
#  for (i in names(module_genes(fc))){
#    Idents(pbmc_small ) <-   idents(fc)[[i]]
#    mod_name <- paste0("M", which(names(idents(fc)) == i), " (", i,")")
#  
#    plot2 <- DimPlot(pbmc_small, reduction = 'umap', cols = c("darkgreen", "dodgerblue3")) +
#      ggtitle(mod_name)
#      print(plot2)
#  }
#  dev.off()
#  

