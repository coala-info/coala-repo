# Code example from 'vissE' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  warning = FALSE,
  message = FALSE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("vissE")

## -----------------------------------------------------------------------------
library(msigdb)
library(GSEABase)

#load the MSigDB from the msigdb package
msigdb_hs = getMsigdb()
#append KEGG gene-sets - comment out to run
# msigdb_hs = appendKEGG(msigdb_hs)
#select h, c2, and c5 collections (recommended)
msigdb_hs = subsetCollection(msigdb_hs, c('h', 'c2', 'c5'))

#randomly sample gene-sets to simulate the results of an enrichment analysis
set.seed(360)
geneset_res = sample(sapply(msigdb_hs, setName), 2500)

#create a GeneSetCollection using the gene-set analysis results
geneset_gsc = msigdb_hs[geneset_res]
geneset_gsc

## -----------------------------------------------------------------------------
library(vissE)

#compute gene-set overlap
gs_ovlap = computeMsigOverlap(geneset_gsc, thresh = 0.25)
#create an overlap network
gs_ovnet = computeMsigNetwork(gs_ovlap, msigdb_hs)
#plot the network
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet)

## -----------------------------------------------------------------------------
#simulate gene-set statistics
geneset_stats = rnorm(2500)
names(geneset_stats) = geneset_res
head(geneset_stats)

#plot the network and overlay gene-set statistics
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet, genesetStat = geneset_stats)

## -----------------------------------------------------------------------------
library(igraph)

#identify clusters - order based on cluster size and avg gene-set stats
grps = findMsigClusters(gs_ovnet,
                        genesetStat = geneset_stats,
                        alg = cluster_walktrap,
                        minSize = 5)
#plot the top 12 clusters
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(gs_ovnet, markGroups = grps[1:6], genesetStat = geneset_stats)

## -----------------------------------------------------------------------------
set.seed(36) #set seed for reproducible layout
plotMsigNetwork(
  gs_ovnet,
  markGroups = grps[1:6],
  genesetStat = geneset_stats,
  rmUnmarkedGroups = TRUE
)

## -----------------------------------------------------------------------------
#compute and plot the results of text-mining
#using gene-set Names
plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Name')
#using gene-set Short descriptions
plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Short')

## -----------------------------------------------------------------------------
library(ggplot2)

#simulate gene statistics
set.seed(36)
genes = unique(unlist(geneIds(geneset_gsc)))
gene_stats = rnorm(length(genes))
names(gene_stats) = genes
head(gene_stats)

#plot the gene-level statistics
plotGeneStats(gene_stats, msigdb_hs, grps[1:6]) +
  geom_hline(yintercept = 0, colour = 2, lty = 2)

## -----------------------------------------------------------------------------
#load PPI from the msigdb package
ppi = getIMEX('hs', inferred = TRUE)
#create the PPI plot
set.seed(36)
plotMsigPPI(
  ppi,
  msigdb_hs,
  grps[1:6],
  geneStat = gene_stats,
  threshStatistic = 0.2,
  threshConfidence = 0.2
)

## ----fig.width=12, fig.height=10----------------------------------------------
library(patchwork)

#create independent plots
set.seed(36) #set seed for reproducible layout
p1 = plotMsigWordcloud(msigdb_hs, grps[1:6], type = 'Name')
p2 = plotMsigNetwork(gs_ovnet, markGroups = grps[1:6], genesetStat = geneset_stats)
p3 = plotGeneStats(gene_stats, msigdb_hs, grps[1:6]) +
  geom_hline(yintercept = 0, colour = 2, lty = 2)
p4 = plotMsigPPI(
  ppi,
  msigdb_hs,
  grps[1:6],
  geneStat = gene_stats,
  threshStatistic = 0.2,
  threshConfidence = 0.2
)

#combine using functions from ggpubr
p1 + p2 + p3 + p4 + plot_layout(2, 2)

## -----------------------------------------------------------------------------
sessionInfo()

