# Code example from 'TreeAndLeaf' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----fig_overview, echo=FALSE, out.width = '100%'-----------------------------
knitr::include_graphics("overview.png")

## ----eval=TRUE, message=FALSE-------------------------------------------------
#-- Libraries required in this section:
#-- TreeAndLeaf(>=1.4.2), RedeR(>=1.40.4), Bioconductor >= 3.13 (R >= 4.0)
# BiocManager::install(c("TreeAndLeaf","RedeR"))
# install.packages(c("igraph","RColorBrewer"))

#-- Load packages
library(TreeAndLeaf)
library(RedeR)
library(igraph)
library(RColorBrewer)

## ----eval=TRUE, message=FALSE-------------------------------------------------
#-- Check data
dim(USArrests)
head(USArrests)

## ----eval=TRUE, message=FALSE-------------------------------------------------
hc <- hclust(dist(USArrests), "ave")
plot(hc, main="Dendrogram for the 'USArrests' dataset",
     xlab="", sub="")

## ----eval=FALSE---------------------------------------------------------------
# #-- Convert the 'hclust' object into a 'tree-and-leaf' object
# tal <- treeAndLeaf(hc)

## ----eval=FALSE---------------------------------------------------------------
# #--- Map attributes to the tree-and-leaf
# #Note: 'refcol = 0' indicates that 'dat' rownames will be used as mapping IDs
# tal <- att.mapv(g = tal, dat = USArrests, refcol = 0)

## ----eval=FALSE---------------------------------------------------------------
# #--- Set graph attributes using the 'att.setv' wrapper function
# pal <- brewer.pal(9, "Reds")
# tal <- att.setv(g = tal, from = "Murder", to = "nodeColor",
#                 cols = pal, nquant = 5)
# tal <- att.setv(g = tal, from = "UrbanPop", to = "nodeSize",
#                 xlim = c(10, 50, 5), nquant = 5)
# 
# #--- Set graph attributes using 'att.addv' and 'att.adde' functions
# tal <- att.addv(tal, "nodeLabelSize", value = 15, index = V(tal)$isLeaf)
# tal <- att.adde(tal, "edgeWidth", value = 3)

## ----eval=FALSE---------------------------------------------------------------
# #--- Call RedeR application
# startRedeR()
# resetRedeR()

## ----eval=FALSE---------------------------------------------------------------
# #--- Send the tree-and-leaf to the interactive R/Java interface
# addGraphToRedeR(g = tal, zoom=75)
# 
# #--- Call 'relax' to fine-tune the leaf nodes
# relaxRedeR(p1=25, p2=200, p3=5, p5=5)

## ----eval=FALSE---------------------------------------------------------------
# #--- Add legends
# addLegendToRedeR(tal, type = "nodecolor")
# addLegendToRedeR(tal, type = "nodesize")

## ----figUSAReds, echo=FALSE, out.width = '80%'--------------------------------
knitr::include_graphics("USAReds.png")

## ----eval=FALSE, message=FALSE------------------------------------------------
# #-- Libraries required in this section:
# # BiocManager::install(c("TreeAndLeaf","RedeR","ggtree))
# # install.packages(c("igraph","ape", "dendextend", "dplyr",
# #                    "ggplot2", "RColorBrewer"))
# 
# #-- Load packages
# library(TreeAndLeaf)
# library(RedeR)
# library(igraph)
# library(ape)
# library(ggtree)
# library(dendextend)
# library(dplyr)
# library(ggplot2)
# library(RColorBrewer)

## ----eval=FALSE---------------------------------------------------------------
# #--- Generate a random phylo tree
# phylo_tree <- rcoal(300)
# 
# #--- Set groups and node sizes
# group <- size <- dendextend::cutree(phylo_tree, 10)
# group[] <- LETTERS[1:10][group]
# size[] <- sample(size)
# group.df <- data.frame(label=names(group), group=group, size=size)
# phylo_tree <- dplyr::full_join(phylo_tree, group.df, by='label')
# 
# #--- Generate a ggtree with 'daylight' layout
# pal <- brewer.pal(10, "Set3")
# ggt <- ggtree(phylo_tree, layout = 'daylight', branch.length='none')
# 
# #--- Plot the ggtree
# ggt + geom_tippoint(aes(color=group, size=size)) +
#   scale_color_manual(values=pal) + scale_y_reverse()

## ----eval=FALSE---------------------------------------------------------------
# #-- Convert the 'ggtree' object into a 'tree-and-leaf' object
# tal <- treeAndLeaf(ggt)
# 
# #--- Map attributes to the tree-and-leaf
# #Note: 'refcol = 1' indicates that 'dat' col 1 will be used as mapping IDs
# tal <- att.mapv(g = tal, dat = group.df, refcol = 1)
# 
# #--- Set graph attributes using the 'att.setv' wrapper function
# tal <- att.setv(g = tal, from = "group", to = "nodeColor",
#                 cols = pal)
# tal <- att.setv(g = tal, from = "size", to = "nodeSize",
#                 xlim = c(10, 50, 5))
# 
# #--- Set graph attributes using 'att.addv' and 'att.adde' functions
# tal <- att.addv(tal, "nodeLabelSize", value = 1)
# tal <- att.addv(tal, "nodeLineWidth", value = 0)
# tal <- att.addv(tal, "nodeColor", value = "black", index=!V(tal)$isLeaf)
# tal <- att.adde(tal, "edgeWidth", value = 3)
# tal <- att.adde(tal, "edgeColor", value = "black")

## ----eval=FALSE---------------------------------------------------------------
# #--- Call RedeR application
# startRedeR()
# resetRedeR()

## ----eval=FALSE---------------------------------------------------------------
# #--- Send the tree-and-leaf to the interactive R/Java interface
# addGraphToRedeR(g = tal, zoom=50)
# 
# #--- Select inner nodes, preventing them from relaxing
# selectNodes(V(tal)$name[!V(tal)$isLeaf], anchor=TRUE)
# 
# #--- Call 'relax' to fine-tune the leaf nodes
# relaxRedeR(p1=25, p2=100, p3=5, p5=1, p8=5)
# 
# #--- Add legends
# addLegendToRedeR(tal, type = "nodecolor", title = "Group", stretch = 0.2)
# addLegendToRedeR(tal, type = "nodesize", title = "Size")

## ----fig_ggtree_tal, echo=FALSE, out.width = '100%'---------------------------
knitr::include_graphics("ggtree_tal.png")

## ----eval=FALSE, message=FALSE------------------------------------------------
# #-- Libraries required in this section:
# # BiocManager::install(c("TreeAndLeaf","RedeR"))
# # install.packages(c("igraph", "RColorBrewer"))
# 
# #-- Load packages
# library(TreeAndLeaf)
# library(RedeR)
# library(igraph)
# library(RColorBrewer)

## ----echo=TRUE----------------------------------------------------------------
#-- Check data
dim(quakes)
head(quakes)

## ----eval=TRUE, message=FALSE-------------------------------------------------
#-- Building a large dendrogram
hc <- hclust(dist(quakes), "ave")
plot(hc, main="Dendrogram for the 'quakes' dataset",
     xlab="", sub="")

## ----eval=FALSE---------------------------------------------------------------
# #-- Convert the 'hclust' object into a 'tree-and-leaf' object
# tal <- treeAndLeaf(hc)

## ----eval=FALSE---------------------------------------------------------------
# #--- Map attributes to the tree-and-leaf
# #Note: 'refcol = 0' indicates that 'dat' rownames will be used as mapping IDs
# tal <- att.mapv(tal, quakes, refcol = 0)
# 
# #--- Set graph attributes using the 'att.setv' wrapper function
# pal <- brewer.pal(9, "Greens")
# tal <- att.setv(g = tal, from = "mag", to = "nodeColor",
#                 cols = pal, nquant = 10)
# tal <- att.setv(g = tal, from = "depth", to = "nodeSize",
#                 xlim = c(40, 120, 20), nquant = 5)
# 
# #--- Set graph attributes using 'att.addv' and 'att.adde' functions
# tal <- att.addv(tal, "nodeLabelSize", value = 1)
# tal <- att.adde(tal, "edgeWidth", value = 10)

## ----eval=FALSE---------------------------------------------------------------
# #--- Call RedeR application
# startRedeR()
# resetRedeR()

## ----eval=FALSE---------------------------------------------------------------
# #--- Send the tree-and-leaf to the interactive R/Java interface
# addGraphToRedeR(g = tal, zoom=10)
# 
# #--- Call 'relax' to fine-tune the leaf nodes
# relaxRedeR(p1=25, p2=200, p3=10, p4=100, p5=10)

## ----eval=FALSE---------------------------------------------------------------
# #--- Add legends
# addLegendToRedeR(tal, type = "nodecolor", title = "Richter Magnitude")
# addLegendToRedeR(tal, type = "nodesize", title = "Depth (km)")

## ----fig_QuakesTree, echo=FALSE, out.width = '90%'----------------------------
knitr::include_graphics("QuakesTree.png")

## ----eval=FALSE---------------------------------------------------------------
# #-- Libraries required in this section:
# # BiocManager::install(c("TreeAndLeaf","RedeR"))
# # install.packages(c("igraph", "ape", "RColorBrewer"))
# 
# #-- Load packages
# library(TreeAndLeaf)
# library(RedeR)
# library(igraph)
# library(ape)
# library(RColorBrewer)

## ----eval=FALSE, message=FALSE------------------------------------------------
# #-- Load data
# data("spdata")
# data("phylo_tree")

## ----eval=FALSE, message=FALSE------------------------------------------------
# #--- Drop organisms not listed in the 'spdata' annotation
# tokeep <- phylo_tree$tip.label %in% spdata$tax_id
# phylo_tree <- drop.tip(phylo_tree, phylo_tree$tip.label[!tokeep])

## ----eval=FALSE---------------------------------------------------------------
# #-- Convert the phylogenetic tree into a 'tree-and-leaf' object
# tal <- treeAndLeaf(phylo_tree)

## ----eval=FALSE---------------------------------------------------------------
# #--- Map attributes to the tree-and-leaf using "%>%" operator
# tal <- tal %>%
#   att.mapv(dat = spdata, refcol = 1) %>%
#   att.setv(from = "genome_size_Mb", to = "nodeSize",
#            xlim = c(10, 50, 1), nquant = 5) %>%
#   att.setv(from = "proteins", to = "nodeColor", nquant = 5,
#            cols = brewer.pal(9, "Blues"), na.col = "black") %>%
#   att.setv(from = "sp_name", to = "nodeLabel") %>%
#   att.adde(to = "edgeWidth", value = 20) %>%
#   att.addv(to = "nodeLabelSize", value = 1) %>%
#   att.addv(to = "nodeLabelSize", value = 20,
#       filter = list("name" = sample(phylo_tree$tip.label, 30))) %>%
#   att.addv(to = "nodeLabelSize", value = 20,
#            filter = list("name" = "9606"))

## ----eval=FALSE---------------------------------------------------------------
# # Call RedeR
# startRedeR()
# resetRedeR()
# 
# #--- Send the tree-and-leaf to the interactive R/Java interface
# addGraphToRedeR(g = tal, zoom=50)
# 
# #--- Call 'relax' to fine-tune the leaf nodes
# relaxRedeR(p1=25, p2=200, p3=10, p4=100, p5=10)

## ----eval=FALSE---------------------------------------------------------------
# #--- Add legends
# addLegendToRedeR(tal, type = "nodecolor", title = "Proteome Size (n)", stretch = 0.5)
# addLegendToRedeR(tal, type = "nodesize", title = "Genome size (Mb)")

## ----fig_nBinPhylo, echo=FALSE, out.width = '100%'----------------------------
knitr::include_graphics("nBinPhylo.png")

## ----label='Session information', eval=TRUE, echo=FALSE-----------------------
sessionInfo()

