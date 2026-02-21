# Code example from 'compartmap_vignette' vignette. See references/ for full tutorial.

## ----loadData--------------------------------------------------------------

library(compartmap)
library(GenomicRanges)
library(Homo.sapiens)

#Load in some example methylation array data
#This data is derived from https://f1000research.com/articles/5-1281/v3
#data(meth_array_450k_chr14, package = "compartmap")

#Load in some example ATAC-seq data
data(bulkATAC_raw_filtered_chr14, package = "compartmap")


## ----processData-----------------------------------------------------------

#Process chr14 of the example array data
#Note: running this in parallel is memory hungry!

#array_compartments <- getCompartments(array.data.chr14, type = "array", parallel = FALSE, chrs = "chr14")

#Process chr14 of the example ATAC-seq data
atac_compartments <- getCompartments(filtered.data.chr14, type = "atac", parallel = FALSE, chrs = "chr14")


## ----clustering, eval = FALSE----------------------------------------------
#  
#  #Plotting individual samples
#  #For 7 samples
#  #Adjust ylim as necessary
#  par(mar=c(1,1,1,1))
#  par(mfrow=c(7,1))
#  plotAB(array_compartments[,1], ylim = c(-0.2, 0.2), unitarize = TRUE)
#  plotAB(array_compartments[,2], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "goldenrod")
#  plotAB(array_compartments[,3], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "darkblue")
#  plotAB(array_compartments[,4], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "red")
#  plotAB(array_compartments[,5], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "black")
#  plotAB(array_compartments[,6], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "cyan")
#  plotAB(array_compartments[,7], ylim = c(-0.2, 0.2), unitarize = TRUE, top.col = "seagreen")
#  
#  #Embed with UMAP for unsupervised clustering
#  library(uwot)
#  embed_compartments <- umap(t(array_compartments), n_neighbors = 3, metric = "manhattan", n_components = 5, n_trees = 100)
#  
#  #Visualize embedding
#  library(vizier)
#  library(plotly)
#  embed_plotly(embed_compartments, tooltip = colnames(embed_compartments), show_legend = FALSE)
#  

